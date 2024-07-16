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
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.ProfileVO;
import web.spring.placecloud.service.MemberService;
import web.spring.placecloud.util.ImageUploadUtil;
import web.spring.placecloud.util.ProfileUploadUtil;

@RestController
@RequestMapping(value ="/profile")
@Log4j
public class ProfileController {
	
	@Autowired
	private String uploadPath;
	
	@Autowired
	private MemberService memberService;
	
	@PostMapping
	public ResponseEntity<ArrayList<ProfileVO>> uploadPOST(MultipartFile files) {
		log.info("uploadPost");
		ArrayList<ProfileVO> list = new ArrayList<>();
		
		// UUID 생성
		String profileName = UUID.randomUUID().toString();
		// 프로필 사진 저장
		ProfileUploadUtil.saveProfile(uploadPath, files, profileName);
		
		String path = ProfileUploadUtil.makePath();
		String extension = ProfileUploadUtil.subExtension(files.getOriginalFilename());
		
		ImageUploadUtil.createThumbnail(uploadPath, path, profileName, extension);
		
		ProfileVO profileVO = new ProfileVO();
		
		// 프로필 경로 설정
		profileVO.setProfilePath(ProfileUploadUtil.makePath());
		// 프로필 실제 이름 설정
		profileVO.setProfileRealName(ProfileUploadUtil.subName(files.getOriginalFilename()));
		// 프로필 변경 이름(UUID) 설정
		profileVO.setProfileChgName(profileName);
		// 프로필 확장자 설정
		profileVO.setProfileExtension(ProfileUploadUtil.subExtension(files.getOriginalFilename()));
		
		list.add(profileVO);
		log.info(list);
		return new ResponseEntity<ArrayList<ProfileVO>> (list, HttpStatus.OK);
	}
	
	@PostMapping("/delete") 
	public ResponseEntity<Integer> deletePOST(String profilePath, String profileChgName, String profileExtension) {
    	log.info("deletePost"); 
    	log.info(profileChgName);
	  	ImageUploadUtil.deleteImage(uploadPath, profilePath, profileChgName);
	  
	  	String thumbnailName = "t_" + profileChgName + "." + profileExtension;
	  	ImageUploadUtil.deleteImage(uploadPath, profilePath, thumbnailName);
	  
	  	return new ResponseEntity<Integer>(1, HttpStatus.OK); 
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String profilePath, String profileChgName,
			String profileExtension) {
		log.info("display()");
		log.info(profilePath);
		ResponseEntity<byte[]> entity = null;
		try {
			// 파일을 읽어와서 byte 배열로 변환
			String savedPath = uploadPath + File.separator 
					+ profilePath + File.separator + profileChgName;
			if (profileChgName.startsWith("t_")) { // 섬네일 파일에는 확장자 추가
				savedPath += "." + profileExtension;
			}
			Path path = Paths.get(savedPath);
			byte[] profileBytes = Files.readAllBytes(path);
			
			Path extensionPath = Paths.get("." + profileExtension);
			// 프로필 사진의 MIME 타입 확인하여 적절한 Content-Type 지정
			String contentType = Files.probeContentType(extensionPath);
			
			// HTTP 응답에 byte 배열과 Content-Type을 설정하여 전송
			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.setContentType(MediaType.parseMediaType(contentType));
			entity = new ResponseEntity<byte[]>(profileBytes, httpHeaders, HttpStatus.OK);
		} catch (IOException e) {
			// 파일을 읽는 중에 예외 발생 시 예외 처리
			e.printStackTrace();
			return ResponseEntity.notFound().build();
		}
		
		return entity;
	}
	
    @GetMapping("/get")
    public ResponseEntity<byte[]> getImage(String memberEmail, String profileExtension) {
    	log.info("getImage()");
    	
    	MemberVO memberVO = memberService.getMemberByEmail(memberEmail);
    	ResponseEntity<byte[]> entity = null;
    	try {
    		// 파일을 읽어와서 byte 배열로 변환
    		String savedPath = uploadPath + File.separator
    				+ memberVO.getProfilePath() + File.separator;
    		
    		if (profileExtension != null) {
    			savedPath += "t_" + memberVO.getProfileChgName() + "." + memberVO.getProfileExtension();
    		} else {
    			savedPath += memberVO.getProfileChgName();
    		}
    		
    		Path path = Paths.get(savedPath);
    		byte[] imageBytes = Files.readAllBytes(path);
    		
    		Path extensionPath = Paths.get("." + memberVO.getProfileExtension());
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
