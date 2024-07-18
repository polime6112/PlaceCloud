package web.spring.placecloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value = "/place")
@Log4j
public class PlaceController {

	@Autowired
	private PlaceService placeService;

	@GetMapping("/main")
	public void mainGET(Model model) {
		log.info("mainGet");
		List<PlaceVO> list = placeService.getAllPlace();
		log.info("List : " + list);
		model.addAttribute("list", list);
	}

	@GetMapping("/detail")
	public String detailGET(Integer placeId, Model model) {
		log.info("detailGet");
		PlaceVO placeVO = placeService.getPlaceById(placeId);
		log.info("PlaceVO : " + placeVO);
		model.addAttribute("placeVO", placeVO);
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
