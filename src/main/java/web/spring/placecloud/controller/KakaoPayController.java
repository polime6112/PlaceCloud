package web.spring.placecloud.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.service.BookingService;
import web.spring.placecloud.service.KakaoPayService;

@Controller
@RequiredArgsConstructor
@Log4j
public class KakaoPayController {
	
	
	@Autowired
	private BookingService bookingService;
	
	@Setter(onMethod_ = @Autowired)
	private KakaoPayService kakaoPayService;
	
	@GetMapping("/kakaoPay")
	public void kakaoPayGet() {
		log.info("kakaoPayGet()");
		
	}
	
	@PostMapping("/kakaoPay")
	public String kakaoPay(BookingVO bookingVO, HttpSession session) {
		log.info("kakaoPay() post...............");
		log.info("bookingVO : " + bookingVO.toString());
		
		return "redirect:" + kakaoPayService.kakaoPayReady(bookingVO, session);
	
	}
	
	@GetMapping("/kakaoPaySuccess")
	public String kakaoPaySuccess(@RequestParam("pg_token")String pg_token, Model model, HttpSession session) {
		log.info("kakaoPay Success get.............");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		
		BookingVO bookingVO = (BookingVO) session.getAttribute("bookingVO");
		log.info("bookingVO : " + bookingVO);
		
		int result = bookingService.createBoard(bookingVO);
		log.info(result + "행 추가");
		session.removeAttribute("bookingVO");
		log.info("세션 삭제");
		
		model.addAttribute("kakaoPayInfo", kakaoPayService.kakaoPayInfo(bookingVO ,pg_token));
		
		return "redirect:/kakaoPay/success";
	}
	
	@GetMapping("/kakaoPayFail")
	public String kakaoPayFail() {
		log.info("kakaoPayFail()");
		
		return "redirect:/kakaoPay/fail";
	}
	
	@GetMapping("/kakaoPayCancel")
	public String kakaoPayCancel() {
		log.info("kakaoPayCancel()");
		
		return "redirect:/kakaoPay/cancel";
	}
	
}
