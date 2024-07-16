package web.spring.placecloud.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.PlaceService;
import web.spring.placecloud.util.ImageUploadUtil;

@RestController
@RequestMapping(value ="/image")
@Log4j
public class ImageController {
    
    @Autowired
    // ServletConfig에 @Bean으로 설정된 uploadPath() 객체 사용
    private String uploadPath; 
    
    @Autowired
    private PlaceService placeService;
    
    @PostMapping
    public ResponseEntity<ArrayList<ImageVO>> uploadPOST(MultipartFile files) {
    	log.info("uploadPost");
    	ArrayList<ImageVO> list = new ArrayList<>();
    	
    	// UUID 생성
		String chgName = UUID.randomUUID().toString();
    	// 이미지 저장
    	ImageUploadUtil.saveImage(uploadPath, files, chgName);
    	log.info(uploadPath);
    	log.info(files);
    	log.info(chgName);
    	
    	String path = ImageUploadUtil.makePath();
    	String extension = ImageUploadUtil.subExtension(files.getOriginalFilename());
    	
    	ImageUploadUtil.createThumbnail(uploadPath, path, chgName, extension);
    	
    	ImageVO imageVO = new ImageVO();
    	// 파일 경로 설정
    	imageVO.setImagePath(path);
    	// 파일 실제 이름 설정
    	imageVO.setImageRealName(ImageUploadUtil.subName(files.getOriginalFilename()));
    	// 파일 변경 이름(UUID) 설정
    	imageVO.setImageChgName(chgName);
    	// 파일 확장자 설정
    	imageVO.setImageExtension(extension);
    	
    	list.add(imageVO);
    	log.info(list);
    	return new ResponseEntity<ArrayList<ImageVO>> (list, HttpStatus.OK);
    }
	
    @PostMapping("/delete") 
	public ResponseEntity<Integer> deletePOST(String imagePath, String imageChgName, String imageExtension) {
    	log.info("deletePost"); 
    	log.info(imageChgName);
	  	ImageUploadUtil.deleteImage(uploadPath, imagePath, imageChgName);
	  
	  	String thumbnailName = "t_" + imageChgName + "." + imageExtension;
	  	ImageUploadUtil.deleteImage(uploadPath, imagePath, thumbnailName);
	  
	  	return new ResponseEntity<Integer>(1, HttpStatus.OK); 
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
    
    @GetMapping("/get")
    public ResponseEntity<byte[]> getImage(int placeId, String imageExtension) {
    	log.info("getImage()");
    	
    	PlaceVO placeVO = placeService.getPlaceById(placeId);
    	ResponseEntity<byte[]> entity = null;
    	try {
    		// 파일을 읽어와서 byte 배열로 변환
    		String savedPath = uploadPath + File.separator
    				+ placeVO.getImagePath() + File.separator;
    		
    		if (imageExtension != null) {
    			savedPath += "t_" + placeVO.getImageChgName() + "." + placeVO.getImageExtension();
    		} else {
    			savedPath += placeVO.getImageChgName();
    		}
    		
    		Path path = Paths.get(savedPath);
    		byte[] imageBytes = Files.readAllBytes(path);
    		
    		Path extensionPath = Paths.get("." + placeVO.getImageExtension());
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
