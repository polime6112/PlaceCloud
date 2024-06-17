package web.spring.placecloud.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value ="/place")
@Log4j
public class PlaceController {
	
    @Autowired
    private PlaceService placeService;
    
    @GetMapping("/registerPlace")
    public void registerGET() {
        log.info("registerPlaceGet");
    }
    
    @PostMapping("registerPlace")
    public String registerPOST(PlaceVO placeVO, HttpSession httpSession, @RequestParam("memberEmail") String memberEmail, Model model) {
        log.info("registerPlacePost");
        log.info(placeVO + "");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
	        if (placeVO.getPlaceCategory().contains("옵션")) {
	        	return "/place/registerPlace";
	        } else {
	            memberEmail = memberVO.getMemberEmail();
	            log.info(memberEmail);
	            placeVO.setMemberEmail(memberEmail);
	            int placeNum = placeService.createPlace(placeVO);
	            log.info(placeNum + "행 등록");
	            List<PlaceVO> list = placeService.getAllPlace(memberEmail);
	            log.info(list + "");
	            model.addAttribute("List", list);
	            return "/place/mainPlace";
	        }
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    @GetMapping("/updatePlace")
    public String updateGET(HttpSession httpSession, PlaceVO placeVO) {
    	log.info("updatePlaceGet");

        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        log.info("MemberVO : " + memberVO);

        if (memberVO != null) {
            String memberEmail = memberVO.getMemberEmail();
            log.info("Member Email : " + memberEmail);
            return "/place/updatePlace?placeId=" + placeVO.getPlaceId();
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
    }
    
    @PostMapping("/updatePlace")
    public String updatePOST(PlaceVO placeVO, HttpSession httpSession, Integer placeId) {
        log.info("updatePlacePost");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	if (placeVO.getPlaceCategory().contains("옵션")) {
                String memberEmail = memberVO.getMemberEmail();
                log.info(memberEmail);
            	return "redirect:/place/updatePlace?placeId=" + placeVO.getPlaceId();
            } else {
                String memberEmail = memberVO.getMemberEmail();
                log.info(memberEmail);
                log.info(placeVO.toString());
                int placeNum = placeService.updatePlace(placeVO);
                log.info(placeNum + "행 수정");
                placeVO = placeService.getPlaceById(placeId);
                return "redirect:/place/infoPlace?placeId=" + placeVO.getPlaceId();
            }
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/infoPlace")
    public String infoGET(@RequestParam("placeId") Integer placeId, HttpSession httpSession, Model model) {
        log.info("infoPlaceGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	String memberEmail = memberVO.getMemberEmail();
        	PlaceVO placeVO = placeService.getPlaceById(placeId);
        	log.info("Member Email: " + memberEmail);
        	log.info(placeVO + "");
        	model.addAttribute("placeVO", placeVO);
        	return "place/infoPlace";        	
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("mainPlace")
    public String mainGET(String memberEmail, Model model, HttpSession httpSession) {
        log.info("mainPlaceGet");
        log.info(memberEmail);
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	List<PlaceVO> list = placeService.getAllPlace(memberEmail);
        	log.info(list + "");
        	model.addAttribute("List", list);
        	return "place/mainPlace";
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
    }
    
    @GetMapping("/deletePlace")
    public String deleteGET(@RequestParam("placeId") Integer placeId, @RequestParam("memberEmail") String memberEmail, Model model, HttpSession httpSession) {
        log.info("deletePlaceGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	int placeDel = placeService.deletePlace(placeId);
        	log.info(placeDel + "행 삭제");
        	List<PlaceVO> list = placeService.getAllPlace(memberEmail);
        	log.info(list + "");
        	model.addAttribute("List", list);
        	return "redirect:/place/mainPlace?memberEmail=" + memberEmail;        	
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
    }
}
