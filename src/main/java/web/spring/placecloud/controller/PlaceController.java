package web.spring.placecloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
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
@RequestMapping(value = "/place")
@Log4j
public class PlaceController {

	@Autowired
	// ServletConfig에 @Bean으로 설정된 uploadPath() 객체 사용
	private String uploadPath;

	@Autowired
	private PlaceService placeService;

	@Autowired
	private ImageService imageService;

	@GetMapping("/main")
	public void mainGET(Model model) {
		log.info("mainGet");
		List<PlaceVO> list = placeService.getAllPlace();
		log.info("List : " + list);
		model.addAttribute("list", list);
	}

	@GetMapping("/detail")
	public String detailGET(Integer placeId, Integer imageId, Model model) {
		log.info("detailGet");
		PlaceVO placeVO = placeService.getPlaceById(placeId);
		ImageVO imageVO = imageService.getImageById(placeId);// placeId를 매개변수로 imageVO 값 불러오기
		log.info("PlaceVO : " + placeVO);
		log.info("ImageVO : " + imageVO);
		model.addAttribute("placeVO", placeVO);
		model.addAttribute("imageVO", imageVO);
		model.addAttribute("uploadPath", uploadPath);
		return "place/detail";

	}

	@GetMapping("/search")
	public void searchGET(String placeCategory, Model model) {
		log.info("searchGet");
		
		List<PlaceVO> list = placeService.getPlaceByCategory(placeCategory);
		log.info("List : " + list);
		model.addAttribute("list", list);
		
	}
}
