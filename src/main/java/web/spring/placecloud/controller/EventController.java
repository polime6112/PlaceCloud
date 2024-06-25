package web.spring.placecloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/event")
@Log4j
public class EventController {
	
	@GetMapping("/error")
	public void errorGET() {
		log.info("errorGET()");
	}
	
	@GetMapping("/needLogin")
	public void needLoginGET() {
		log.info("needLoginGET()");
	}
	
}
