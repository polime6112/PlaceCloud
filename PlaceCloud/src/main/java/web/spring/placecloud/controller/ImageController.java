package web.spring.placecloud.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.ImageService;
import web.spring.placecloud.util.ImageUploadUtil;

@Controller
@RequestMapping(value ="/image")
@Log4j
public class ImageController {
    
    @Autowired
    private String uploadPath;
    
    @Autowired
    private ImageService imageService;
    
    @GetMapping("/imageInsert")
    public String imageInsertGET(Model model, HttpSession httpSession, PlaceVO placeVO) {
        log.info("imageInsertGET");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        log.info("MemberVO : " + memberVO);

        if (memberVO != null) {
            String memberEmail = memberVO.getMemberEmail();
            log.info("Member Email : " + memberEmail);
            model.addAttribute("placeVO", placeVO);
            return "image/imageInsert";
        } else {
            log.error("세션이 존재하지 않습니다.");
            return "redirect:/member/memberLogin";
        }
    }
    
    @PostMapping("/imageInsert/{placeId}")
    public ResponseEntity<String> imageInsert(@RequestParam("image") MultipartFile image, HttpSession httpSession, @PathVariable("placeId") Integer placeId) {
        log.info("imageInsert");
        
        if (image.isEmpty()) {
            return ResponseEntity.badRequest().body("No Image File.");
        }
        
        // UUID 생성
        String imageName = UUID.randomUUID().toString();
        // 이미지 저장
        ImageUploadUtil.saveImage(uploadPath, image, imageName);
            
        ImageVO imageVO = new ImageVO();
        // 이미지 경로 설정
        imageVO.setImagePath(ImageUploadUtil.makeDatePath());
        // 이미지 실제 이름 설정
        imageVO.setImageName(ImageUploadUtil.subName(image.getOriginalFilename()));
        // 이미지 변경 이름(UUID) 설정
        imageVO.setImageName(imageName);
        // 이미지 확장자 설정
        imageVO.setImageExtension(ImageUploadUtil.subExtension(image.getOriginalFilename()));
        // 이미지가 들어가는 장소 번호 
        imageVO.setPlaceId(placeId);
        log.info(imageVO);
        imageService.insertImage(imageVO);
        return ResponseEntity.ok().body("Image Upload Success.");
    }
}
