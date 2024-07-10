package web.spring.placecloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value ="/host")
@Log4j
public class HostController {
	
	@Autowired
	private PlaceService placeService;
	
	@GetMapping("/myPlace")
	public String myPlaceGET(String memberEmail, Model model, ImageVO imageVO) {
		log.info("myPlaceGet");
		log.info(memberEmail);
		List<PlaceVO> list = placeService.getMyPlace(memberEmail);
		log.info("List : " + list);
		model.addAttribute("List", list);
		model.addAttribute("imageVO", imageVO);
		log.info(memberEmail);
		return "host/myPlace";
	}
	
	@GetMapping("/register")
	public void registerGET() {
		log.info("registerGet");
	}
	
	@PostMapping("/register")
	public String registerPOST(PlaceVO placeVO, HttpSession httpSession, Model model) {
		log.info(placeVO);
		MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
		if (memberVO == null) {
			return "redirect:/member/login";
		}
		
		if (placeVO.getPlaceCategory().contains("옵션")) {
			return "host/register";
		}
		
		String memberEmail = memberVO.getMemberEmail();
		placeVO.setMemberEmail(memberEmail);
		
		int placeNum = placeService.createPlace(placeVO);
		
		if (placeNum > 0) {
			return "redirect:/host/myPlace?memberEmail=" + memberVO.getMemberEmail();
		} else {
			model.addAttribute("errorMessage", "장소 등록에 실패했습니다.");
			return "host/register";
		}
	}

	@GetMapping("/detail")
	public String hostDetailGET(Integer placeId, Model model) {
		log.info("detailGet");

		PlaceVO placeVO = placeService.getPlaceById(placeId);
		log.info("PlaceVO : " + placeVO);
		model.addAttribute("placeVO", placeVO);
		return "host/detail";
	}
	
	@GetMapping("/update")
	public String updateGET(PlaceVO placeVO, Model model) {
		log.info("updateGet");
		model.addAttribute("placeVO", placeVO);
		return "host/update";
	}

	@PostMapping("/update")
	public String updatePOST(PlaceVO placeVO, HttpSession httpSession, Model model, Integer placeId) {
		log.info("updatePost");
		MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");

		if (memberVO != null) {
			String memberEmail = memberVO.getMemberEmail();
			log.info(memberEmail);
			log.info(placeVO.toString());
			int placeNum = placeService.updatePlace(placeVO);
			log.info(placeNum + "행 수정");
			placeId = placeVO.getPlaceId();
			placeVO = placeService.getPlaceById(placeId);
			return "redirect:/host/myPlace?memberEmail=" + memberEmail;
		} else {
			log.error("세션이 존재하지 않습니다.");
			return "redirect:/member/login";
		}
	}
	
	@GetMapping("/delete")
	public String deleteGET(Integer placeId, String memberEmail, Model model) {
		log.info("deleteGet");
		int placeDel = placeService.deletePlace(placeId);
		log.info(placeDel + "행 삭제");
		List<PlaceVO> list = placeService.getMyPlace(memberEmail);
		log.info("List : " + list);
		model.addAttribute("List", list);
		return "host/myPlace";
	}
}
