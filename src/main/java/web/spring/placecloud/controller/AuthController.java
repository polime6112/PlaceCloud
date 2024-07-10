package web.spring.placecloud.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/auth")
@Log4j
public class AuthController {
	
	@GetMapping("accessDenied")
	public void accessDenied(Authentication auth, Model model) {
		// Authentication : 현재 사용자의 인증 정보를 갖고 있음
	    log.info("accessDenied()");
	    log.info(auth);
	    
	    model.addAttribute("msg", "권한이 없습니다.");
	
	} // end accessDenied()
	
	// 로그인 화면 이동
    @GetMapping("login")
	public void loginGET(String error, String logout, Model model) {
        log.info("loginGET()");
        log.info("error : " + error); // error: 에러 발생시 정보 저장
        log.info("logout: " + logout); // logout : 로그아웃 정보 저장
        
		// 에러가 발생한 경우, 에러 메시지를 모델에 추가하여 전달
		if (error != null) {
			model.addAttribute("errorMsg", "로그인 에러! 아이디 비밀번호를 확인하세요.");
		}

		// 로그아웃이 발생한 경우, 로그아웃 메시지를 모델에 추가하여 전달
		if (logout != null) {
			model.addAttribute("logoutMsg", "로그아웃 되었습니다!");
		}
		 
    } // memberLoginGET()
	
} // end AuthController()
