package web.spring.placecloud.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
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
	public String kakaoPaySuccess(@RequestParam("pg_token")String pg_token, Model model, HttpSession session) throws IOException {
		log.info("kakaoPay Success get.............");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		
		BookingVO bookingVO = (BookingVO) session.getAttribute("bookingVO");
		log.info("bookingVO : " + bookingVO);
		
		int result = bookingService.createBoard(bookingVO);
		log.info(result + "행 추가");
		session.removeAttribute("bookingVO");
		log.info("세션 삭제");
		
		model.addAttribute("kakaoPayInfo", kakaoPayService.kakaoPayInfo(bookingVO ,pg_token));
		
		return "redirect:/booking/bookingSuccess";
	}
	
	@GetMapping("/kakaoPayFail")
	public String kakaoPayFail(Model model, HttpSession session) {
		log.info("kakaoPayFail()");
		
		BookingVO bookingVO = (BookingVO) session.getAttribute("bookingVO");
		log.info("bookingVO : " + bookingVO);
		model.addAttribute("placeId", bookingVO.getPlaceId());
		session.removeAttribute("bookingVO");
		log.info("세션 삭제");
		
		return "redirect:/booking/bookingFail";
	}
	
	@GetMapping("/kakaoPayCancel")
	public String kakaoPayCancel(Model model, HttpSession session) {
		log.info("kakaoPayFail()");
		
		BookingVO bookingVO = (BookingVO) session.getAttribute("bookingVO");
		log.info("bookingVO : " + bookingVO);
		model.addAttribute("bookingVO", bookingVO);
		session.removeAttribute("bookingVO");
		log.info("세션 삭제");
		
		return "redirect:/booking/bookingCancel";
	}
}
