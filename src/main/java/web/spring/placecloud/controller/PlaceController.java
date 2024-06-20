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
import web.spring.placecloud.service.ImageService;
import web.spring.placecloud.service.PlaceService;

@Controller
@RequestMapping(value ="/place")
@Log4j
public class PlaceController {
	
    @Autowired
    // ServletConfig에 @Bean으로 설정된 uploadPath() 객체 사용
    private String uploadPath;
	
    @Autowired
    private PlaceService placeService;
    
    @Autowired
    private ImageService imageService;
    
    @GetMapping("/mainPlace")
    public String mainPlaceGET(HttpSession httpSession, Model model) {
    	log.info("mainPlaceGet");
    	MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
    	if (memberVO != null) {
    		List<PlaceVO> list = placeService.getAllPlace();
    		log.info("List : " + list);
    		model.addAttribute("List", list);
    		log.info(memberVO.getMemberEmail());
    		return "place/mainPlace";
    	} else {
    		log.error("세션이 존재하지 않습니다.");
    		return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/myPlace")
    public String myGET(String memberEmail, Model model, HttpSession httpSession) {
    	log.info("myPlaceGet");
    	log.info(memberEmail);
    	MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
    	if (memberVO != null) {
    		List<PlaceVO> list = placeService.getMyPlace(memberEmail);
    		log.info("List : " + list);
    		model.addAttribute("List", list);
    		log.info(memberEmail);
    		return "place/myPlace";
    	} else {
    		log.error("세션이 존재하지 않습니다.");
    		return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/registerPlace")
    public String registerGET(HttpSession httpSession) {
        log.info("registerPlaceGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO == null) {
            return "redirect:/member/memberLogin";
        }
        return "place/registerPlace";
    }
    
    @PostMapping("/registerPlace")
    public String registerPOST(PlaceVO placeVO, HttpSession httpSession, Model model) {
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO == null) {
            return "redirect:/member/memberLogin";
        }

        if (placeVO.getPlaceCategory().contains("옵션")) {
            return "place/registerPlace";
        }

        String memberEmail = memberVO.getMemberEmail();
        placeVO.setMemberEmail(memberEmail);

        int placeNum = placeService.createPlace(placeVO);

        if (placeNum > 0) {
            return "redirect:/place/myPlace?memberEmail=" + memberVO.getMemberEmail();
        } else {
            model.addAttribute("errorMessage", "장소 등록에 실패했습니다.");
            return "place/registerPlace";
        }
    }
    
    @GetMapping("/updatePlace")
    public String updateGET(HttpSession httpSession, PlaceVO placeVO, Model model) {
    	log.info("updatePlaceGet");

        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        log.info("MemberVO : " + memberVO);

        if (memberVO != null) {
            String memberEmail = memberVO.getMemberEmail();
            log.info("Member Email : " + memberEmail);
            model.addAttribute("placeVO", placeVO);
            return "place/updatePlace";
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
    }
    
    @PostMapping("/updatePlace")
    public String updatePOST(PlaceVO placeVO, HttpSession httpSession, Model model, Integer placeId) {
        log.info("updatePlacePost");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	String memberEmail = memberVO.getMemberEmail();
        	log.info(memberEmail);
        	log.info(placeVO.toString());
        	int placeNum = placeService.updatePlace(placeVO);
        	log.info(placeNum + "행 수정");
        	placeId = placeVO.getPlaceId();
        	placeVO = placeService.getPlaceById(placeId);
        	return "redirect:/place/myPlace?memberEmail=" + memberEmail;
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/infoPlace")
    public String infoGET(Integer placeId, Integer imageId, HttpSession httpSession, Model model) {
        log.info("infoPlaceGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	String memberEmail = memberVO.getMemberEmail();
        	PlaceVO placeVO = placeService.getPlaceById(placeId);
        	ImageVO imageVO = imageService.getImageById(placeId); // placeId를 매개변수로 imageVO 값 불러오기
        	log.info("Member Email: " + memberEmail);
        	log.info("PlaceVO : " + placeVO);
        	log.info("ImageVO : " + imageVO);
        	model.addAttribute("placeVO", placeVO);
        	model.addAttribute("imageVO", imageVO);
        	model.addAttribute("uploadPath", uploadPath);
        	return "place/infoPlace";        	
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    
    @GetMapping("/deletePlace")
    public String deleteGET(Integer placeId, String memberEmail, Model model, HttpSession httpSession) {
        log.info("deletePlaceGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO != null) {
        	int placeDel = placeService.deletePlace(placeId);
        	int imageDel = imageService.delete(placeId);
        	log.info(placeDel + "행 삭제");
        	log.info(imageDel + "행 삭제");
        	List<PlaceVO> list = placeService.getMyPlace(memberEmail);
        	log.info("List : " + list);
        	model.addAttribute("List", list);
        	return "place/myPlace";
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
    }
}
