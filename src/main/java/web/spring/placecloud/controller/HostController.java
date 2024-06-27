package web.spring.placecloud.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.ImageService;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value ="/host")
@Log4j
public class HostController {
	
	@Autowired
	private PlaceService placeService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private String uploadPath;
	
	@GetMapping("/detail")
	public String hostDetailGET(Integer placeId, Integer imageId, HttpSession httpSession, Model model) {
		log.info("detailGet");

		PlaceVO placeVO = placeService.getPlaceById(placeId);
		ImageVO imageVO = imageService.getImageById(placeId); // placeId를 매개변수로 imageVO 값 불러오기
		log.info("PlaceVO : " + placeVO);
		log.info("ImageVO : " + imageVO);
		model.addAttribute("placeVO", placeVO);
		model.addAttribute("imageVO", imageVO);
		model.addAttribute("uploadPath", uploadPath);
		return "host/detail";

	}
}
