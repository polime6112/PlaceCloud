package web.spring.placecloud.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
    	model.addAttribute("placeVO", placeVO);
        return "host/detail";
    }
    
    @GetMapping("/delete")
    public String deleteGET(Integer placeId, Model model) {
    	log.info("deleteGet");
    	log.info(placeId);
    	ImageVO imageVO = imageService.getImageById(placeId);
    	String imageChgName = imageVO.getImageChgName();
    	String imagePath = imageVO.getImagePath();
    	
    	ImageUploadUtil.deleteImage(uploadPath, imagePath, imageChgName);
    	int imageDelete = imageService.delete(placeId);
    	log.info(imageDelete + "행 삭제");
    	PlaceVO placeVO = placeService.getPlaceById(placeId);
    	model.addAttribute("placeVO", placeVO);
    	return "host/detail";
    }
    
    // 전송받은 파일 경로 및 파일 이름, 확장자로 
    // 이미지 파일을 호출
    @GetMapping("/display")
    public ResponseEntity<byte[]> display(String imagePath, String imageChgName, String imageExtension) {
       log.info("display()");
       log.info(imagePath);
       ResponseEntity<byte[]> entity = null;
       try {
          // 파일을 읽어와서 byte 배열로 변환
          String savedPath = uploadPath + File.separator 
                + imagePath + File.separator + imageChgName; 
          if(imageChgName.startsWith("t_")) { // 섬네일 파일에는 확장자 추가
             savedPath += "." + imageExtension;
          }
          Path path = Paths.get(savedPath);
          byte[] imageBytes = Files.readAllBytes(path);

          Path extensionPath = Paths.get("." + imageExtension);
          // 이미지의 MIME 타입 확인하여 적절한 Content-Type 지정
          String contentType = Files.probeContentType(extensionPath);

          // HTTP 응답에 byte 배열과 Content-Type을 설정하여 전송
          HttpHeaders httpHeaders = new HttpHeaders();
          httpHeaders.setContentType(MediaType.parseMediaType(contentType));
          entity = new ResponseEntity<byte[]>(imageBytes, httpHeaders, HttpStatus.OK);
       } catch (IOException e) {
          // 파일을 읽는 중에 예외 발생 시 예외 처리
          e.printStackTrace();
          return ResponseEntity.notFound().build(); // 파일을 찾을 수 없음을 클라이언트에게 알림
       }

       return entity;

    }
}
