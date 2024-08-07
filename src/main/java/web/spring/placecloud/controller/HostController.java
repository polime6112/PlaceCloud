package web.spring.placecloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value ="/host")
@Log4j
public class HostController {
	
	@Autowired
	private PlaceService placeService;
	
	@GetMapping("/myPlace")
	public String myPlaceGET(Model model, @AuthenticationPrincipal UserDetails userDetails) {
		log.info("myPlaceGet");
		if(userDetails != null ) {
			String memberEmail = userDetails.getUsername();
			List<PlaceVO> list = placeService.getMyPlace(memberEmail);
			log.info("List : " + list);
			model.addAttribute("List", list);
			log.info(memberEmail);
			return "host/myPlace";			
		} else {
			return "event/needLogin";
		}
	}
	
	@GetMapping("/register")
	public void registerGET() {
		log.info("registerGet");
	}
	
	@PostMapping("/register")
	public String registerPOST(PlaceVO placeVO, Model model, @AuthenticationPrincipal UserDetails userDetails) {
		log.info(placeVO);
		log.info(userDetails);
		if (userDetails != null) {
			if (placeVO.getPlaceCategory().contains("옵션")) {
				return "host/register";
			}
			int placeNum = placeService.createPlace(placeVO);
			if (placeNum > 0) {
				return "redirect:/host/myPlace";
			} else {
				model.addAttribute("errorMessage", "장소 등록에 실패했습니다.");
				return "host/register";
			}			
		} else {
			return "event/needLogin";
		}
	}

	@GetMapping("/detail")
	public String hostDetailGET(Integer placeId, Model model, @AuthenticationPrincipal UserDetails userDetails) {
		log.info("detailGet");
		if (userDetails != null) {
			PlaceVO placeVO = placeService.getPlaceById(placeId);
			log.info("PlaceVO : " + placeVO);
			log.info(placeVO.getImageList());
			model.addAttribute("placeVO", placeVO);
			return "host/detail";			
		} else {
			return "event/needLogin";
		}
	}
	
	@GetMapping("/update")
	public String updateGET(PlaceVO placeVO, Model model) {
		log.info("updateGet");
		model.addAttribute("placeVO", placeVO);
		return "host/update";
	}

	@PostMapping("/update")
	public String updatePOST(PlaceVO placeVO, Model model, Integer placeId, @AuthenticationPrincipal UserDetails userDetails) {
		log.info("updatePost");
		log.info(placeVO.toString());
		if (userDetails != null) {
			int placeNum = placeService.updatePlace(placeVO);
			log.info(placeNum + "행 수정");
			placeId = placeVO.getPlaceId();
			placeVO = placeService.getPlaceById(placeId);
			return "redirect:/host/myPlace";			
		} else {
			return "event/needLogin";
		}
	}
	
	@GetMapping("/delete")
	public String deleteGET(Integer placeId, Model model, @AuthenticationPrincipal UserDetails userDetails) {
		log.info("deleteGet");
		if (userDetails != null) {
			String memberEmail = userDetails.getUsername();
			int placeDel = placeService.deletePlace(placeId);
			log.info(placeDel + "행 삭제");
			List<PlaceVO> list = placeService.getMyPlace(memberEmail);
			log.info("List : " + list);
			model.addAttribute("List", list);
			return "host/myPlace";			
		} else {
			return "event/needLogin";
		}
	}
}
