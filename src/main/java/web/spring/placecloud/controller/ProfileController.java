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
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.ProfileVO;
import web.spring.placecloud.service.MemberService;
import web.spring.placecloud.service.ProfileService;
import web.spring.placecloud.util.ProfileUploadUtil;

@Controller
@RequestMapping(value ="/profile")
@Log4j
public class ProfileController {
	
	@Autowired
	private String uploadPath;
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/upload")
	public String uploadGET(HttpSession httpSession, Model model) {
		log.info("uploadGet");
		MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
		log.info("MemberVO : " + memberVO);
		
		if (memberVO != null) {
			String memberEmail = memberVO.getMemberEmail();
			log.info("MemberEmail : " + memberEmail);
			model.addAttribute("memberVO", memberVO);
			return "profile/upload";
		} else {
			log.error("세션이 존재하지 않습니다.");
			return "redirect:/member/memberLogin";			
		}
	}
	
	@PostMapping("/upload")
	public String uploadPOST(ProfileVO profileVO, String memberEmail, Model model) {
		log.info("uploadPost");
		log.info("ProfileVO : " + profileVO);
		MultipartFile profile = profileVO.getProfile();
		
		// UUID 생성
		String profileName = UUID.randomUUID().toString();
		// 프로필 사진 저장
		ProfileUploadUtil.saveProfile(uploadPath, profile, profileName, memberEmail);
		
		// 프로필 경로 설정
		profileVO.setProfilePath(ProfileUploadUtil.makePath(memberEmail));
		// 프로필 실제 이름 설정
		profileVO.setProfileRealName(ProfileUploadUtil.subName(profile.getOriginalFilename()));
		// 프로필 변경 이름(UUID) 설정
		profileVO.setProfileChgName(profileName);
		// 프로필 확장자 설정
		profileVO.setProfileExtension(ProfileUploadUtil.subExtension(profile.getOriginalFilename()));
		// 프로필이 들어가는 사용자 이메일
		profileVO.setMemberEmail(memberEmail);
		log.info(profileService.upload(profileVO) + "행 등록");
		MemberVO memberVO = memberService.getMemberByEmail(memberEmail);
		log.info("MemberVO : " + memberVO);
		model.addAttribute("member", memberVO);
		model.addAttribute("profileVO", profileVO);
		return "member/myPage";
	}
	
	@GetMapping("/delete")
	public String deleteGET(String memberEmail, Model model) {
		log.info("deleteGet");
		log.info(memberEmail);
		ProfileVO profileVO = profileService.getProfileByEmail(memberEmail);
		String profilePath = profileVO.getProfilePath();
		String profileChgName = profileVO.getProfileChgName();
		
		ProfileUploadUtil.deleteProfile(uploadPath, profilePath, profileChgName);
		int profileDelete = profileService.delete(memberEmail);
		log.info(profileDelete + "행 삭제");
		MemberVO memberVO = memberService.getMemberByEmail(memberEmail);
		model.addAttribute("member", memberVO);
		return "member/myPage";
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
}
