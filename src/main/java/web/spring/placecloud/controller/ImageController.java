package web.spring.placecloud.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.ImageService;
import web.spring.placecloud.service.PlaceService;
import web.spring.placecloud.util.ImageUploadUtil;

@Controller
@RequestMapping(value ="/image")
@Log4j
public class ImageController {
    
    @Autowired
    // ServletConfig에 @Bean으로 설정된 uploadPath() 객체 사용
    private String uploadPath;
    
    @Autowired
    private PlaceService placeService;
    
    @Autowired
    private ImageService imageService; 
    
    @GetMapping("/upload")
    public String uploadGET(Model model, HttpSession httpSession, PlaceVO placeVO) {
        log.info("uploadGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        log.info("MemberVO : " + memberVO);

        if (memberVO != null) {
            String memberEmail = memberVO.getMemberEmail();
            log.info("Member Email : " + memberEmail);
            model.addAttribute("placeVO", placeVO);
            return "image/upload";
        } else {
            log.error("세션이 존재하지 않습니다.");
            return "redirect:/member/memberLogin";
        }
    }
    
    @PostMapping("/upload")
    public String uploadPOST(ImageVO imageVO, Integer placeId, Model model) {
        log.info("uploadPost");
        log.info("ImageVO : " + imageVO);
        MultipartFile image = imageVO.getImage();
        log.info(uploadPath);
        // UUID 생성
        String imageName = UUID.randomUUID().toString();
        // 이미지 저장
        ImageUploadUtil.saveImage(uploadPath, image, imageName, placeId);
        
        // 이미지 경로 설정
        imageVO.setImagePath(ImageUploadUtil.makePath(placeId));
        // 이미지 실제 이름 설정
        imageVO.setImageRealName(ImageUploadUtil.subName(image.getOriginalFilename()));
        // 이미지 변경 이름(UUID) 설정
        imageVO.setImageChgName(imageName);
        // 이미지 확장자 설정
        imageVO.setImageExtension(ImageUploadUtil.subExtension(image.getOriginalFilename()));
        // 이미지가 들어가는 장소 번호 
        imageVO.setPlaceId(placeId);
        log.info(imageService.upload(imageVO) + "행 등록");
        PlaceVO placeVO = placeService.getPlaceById(placeId);
        
        log.info("PlaceVO : " + placeVO);
        model.addAttribute("imageVO", imageVO);
    	model.addAttribute("placeVO", placeVO);
    	model.addAttribute("uploadPath", uploadPath);
        return "place/infoPlace";
    }
    
    // 첨부 파일 다운로드(GET)
    // 링크를 클릭하면 사용자가 다운로드하는 방식
    // 파일 리소스를 비동기로 전송하여 파일 다운로드
    @GetMapping(value ="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> download(int placeId) throws IOException {
    	log.info("download()");
    	
    	// imageId로 상세 정보 조회
    	ImageVO imageVO = imageService.getImageById(placeId);
    	String imagePath = imageVO.getImagePath();
    	String imageChgName = imageVO.getImageChgName();
    	String imageExtension = imageVO.getImageExtension();
    	String imageRealName = imageVO.getImageRealName();
    	
    	// 서버에 저장된 파일 정보 생성
    	String resourcePath = uploadPath + File.separator + imagePath + File.separator
    			+ imageChgName;
    	// 파일 리소스 생성
    	Resource resource = new FileSystemResource(resourcePath);
    	// 다운로드할 파일 이름을 헤더에 설정
    	HttpHeaders headers = new HttpHeaders();
    	String imageName = new String(imageRealName.getBytes("UTF-8"), "ISO-8859-1");
    	log.info("imageName : " + imageName);
    	log.info("imageExtension : " + imageExtension);
    	headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + imageName + "." + imageExtension);
    	
    	return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }
}
