package web.spring.placecloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/kakaoPay")
@Log4j
public class PayResultController {
	
	@GetMapping("/success")
	public void success() {
		log.info("success()");
	}
	
	@GetMapping("/fail")
	public void fail() {
		log.info("fail()");
	}
	
	@GetMapping("/cancel")
	public void cancel() {
		log.info("cancel()");
	}
}
