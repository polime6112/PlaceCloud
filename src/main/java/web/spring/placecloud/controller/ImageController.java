package web.spring.placecloud.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
        
        if (image.isEmpty()) {
            log.error("이미지가 비어있습니다.");
            return "image/upload";
        }
        
        // UUID 생성
        String imageName = UUID.randomUUID().toString();
        // 이미지 저장
        ImageUploadUtil.saveImage(uploadPath, image, imageName, placeId);
        
        // 이미지 경로 설정
        imageVO.setImagePath(ImageUploadUtil.makePath(placeId));
        // 이미지 실제 이름 설정
        imageVO.setImageName(ImageUploadUtil.subName(image.getOriginalFilename()));
        // 이미지 변경 이름(UUID) 설정
        imageVO.setImageName(imageName);
        // 이미지 확장자 설정
        imageVO.setImageExtension(ImageUploadUtil.subExtension(image.getOriginalFilename()));
        // 이미지가 들어가는 장소 번호 
        imageVO.setPlaceId(placeId);
        log.info(imageService.upload(imageVO) + "행 등록");
        PlaceVO placeVO = placeService.getPlaceById(placeId);
        
        log.info("PlaceVO : " + placeVO);
    	model.addAttribute("placeVO", placeVO);
    	model.addAttribute("uploadPath", uploadPath);
        return "place/infoPlace";
    }
}
