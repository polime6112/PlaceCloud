package web.spring.placecloud.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.PlaceImageVO;
import web.spring.placecloud.service.PlaceImageService;
import web.spring.placecloud.util.ImageUploadUtil;

@Controller
@RequestMapping(value ="/placeImage")
@Log4j
public class PlaceImageController {
	
	@Autowired
	private String uploadPath;
	
	@Autowired
	private PlaceImageService placeImageService;
	
//	@PostMapping("/imageInsert")
//	public ResponseEntity<?> imageInsertGET(@RequestBody PlaceImageVO placeImageVO, HttpSession httpSession) {
//		log.info("imageInsertGet");
//		MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
//		log.info(memberVO);
//		
//		if (placeImageVO != null) {
//			try {
//				MultipartFile image = placeImageVO.getImage();
//				
//				
//				String imageName = UUID.randomUUID().toString();
//				
//				ImageUploadUtil.saveImage(uploadPath, image, imageName);
//				
//
//				placeImageVO.setImagePath(ImageUploadUtil.makeDatePath());
//
//				placeImageVO.setImageName(ImageUploadUtil.subName(image.getOriginalFilename()));
//
//				placeImageVO.setImageName(imageName);
//
//				placeImageVO.setImageExtension(ImageUploadUtil.subExtension(image.getOriginalFilename()));
//				log.info(placeImageVO.getImageName());
//				placeImageService.insertImage(placeImageVO);	
//				return ResponseEntity.ok().body("이미지 업로드 성공");
//			} catch (Exception e) {
//				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Image upload failed: " + e.getMessage());
//			}
//		}
//		return ResponseEntity.badRequest().body("Invalid image data");
//	}
	@PostMapping("/imageInsert")
    public ResponseEntity<String> imageInsert(@RequestParam("image") MultipartFile image, HttpSession httpSession) {
        log.info("imageInsert");

        if (image.isEmpty()) {
            return ResponseEntity.badRequest().body("Invalid image data");
        }

        try {
        	// UUID 생성
            String imageName = UUID.randomUUID().toString();
            // 이미지 저장
            ImageUploadUtil.saveImage(uploadPath, image, imageName);

            PlaceImageVO placeImageVO = new PlaceImageVO();
			// 이미지 경로 설정
            placeImageVO.setImagePath(ImageUploadUtil.makeDatePath());
			// 이미지 실제 이름 설정
            placeImageVO.setImageName(ImageUploadUtil.subName(image.getOriginalFilename()));
			// 이미지 변경 이름(UUID) 설정
            placeImageVO.setImageName(imageName);
			// 이미지 확장자 설정
            placeImageVO.setImageExtension(ImageUploadUtil.subExtension(image.getOriginalFilename()));

            placeImageService.insertImage(placeImageVO);
            return ResponseEntity.ok().body("Image upload success");

        } catch (Exception e) {
            log.error("Image upload failed: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Image upload failed: " + e.getMessage());
        }
    }
	
	@PostMapping("/imageDelete")
	public void imageDeletePOST(int imageId) {
		log.info("imageDeletePost");
		placeImageService.deleteImage(imageId);
	}
}
