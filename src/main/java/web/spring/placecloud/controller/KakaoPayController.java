package web.spring.placecloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.domain.KakaoPayReadyResponse;
import web.spring.placecloud.service.BookingService;
import web.spring.placecloud.service.KakaoPayService;

@Controller
@Log4j
public class KakaoPayController {
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private KakaoPayService payService;
	
	private BookingVO bookingVO;
	
	@GetMapping("/ready")
	public String ready(BookingVO bookingVO) {
		log.info("ready()");
		KakaoPayReadyResponse readyResponse = payService.ready(bookingVO);
		this.bookingVO = bookingVO;
		log.info("bookingVO : " + this.bookingVO);
		return "redirect:" + readyResponse.getNext_redirect_pc_url();
	}
	
	@GetMapping("/approve")
	public String approve(BookingVO bookingVO, @RequestParam("pg_token") String pgToken, Model model) {
		log.info("approve()");
		
		bookingVO = this.bookingVO;
		log.info("bookingVO : " + bookingVO);
		int result = bookingService.createBoard(bookingVO);
		log.info(result + "행 추가");
		
		String approveResponse = payService.approve(bookingVO, pgToken);
		model.addAttribute("response", approveResponse);
		return "redirect:/kakaoPay/success";
				
	}
	
	@GetMapping("/cancel")
	public String cancel() {
		log.info("kakaoPayCancel()");
		
		return "redirect:/kakaoPay/cancel";
	}
	
	@GetMapping("/fail")
	public String fail() {
		log.info("kakaoPayFail()");
		
		return "redirect:/kakaoPay/fail";
	}
	
	
}
