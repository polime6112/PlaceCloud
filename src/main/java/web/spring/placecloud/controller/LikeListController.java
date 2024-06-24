package web.spring.placecloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeListVO;
import web.spring.placecloud.service.LikeListService;

@Controller
@RequestMapping(value = "/like")
@Log4j
public class LikeListController {
	
	@Autowired
	private LikeListService likeListService;
	
	@GetMapping("/list")
	public void likeList() {
		
	}
	
	@PostMapping("/insert")
	public String likeInsert(LikeListVO likeListVO) {
		return null;
	}
	
	
}
