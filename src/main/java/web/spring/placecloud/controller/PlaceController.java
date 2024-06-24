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
    
    @GetMapping("/main")
    public String mainGET(HttpSession httpSession, Model model) {
    	log.info("mainGet");
    	MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
    	
    	if (memberVO != null) {
    		List<PlaceVO> list = placeService.getAllPlace();
    		log.info("List : " + list);
    		model.addAttribute("list", list);
    		log.info(memberVO.getMemberEmail());
    		return "place/main";
    	} else {
    		log.error("세션이 존재하지 않습니다.");
    		return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/myPlace")
    public String myPlaceGET(String memberEmail, Model model, HttpSession httpSession, ImageVO imageVO) {
    	log.info("myPlaceGet");
    	log.info(memberEmail);
    	MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
    	
    	if (memberVO != null) {
    		List<PlaceVO> list = placeService.getMyPlace(memberEmail);
    		log.info("List : " + list);
    		model.addAttribute("List", list);
    		model.addAttribute("imageVO", imageVO);
    		log.info(memberEmail);
    		return "place/myPlace";
    	} else {
    		log.error("세션이 존재하지 않습니다.");
    		return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/register")
    public String registerGET(HttpSession httpSession) {
        log.info("registerGet");
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        
        if (memberVO == null) {
            return "redirect:/member/memberLogin";
        }
        return "place/register";
    }
    
    @PostMapping("/register")
    public String registerPOST(PlaceVO placeVO, HttpSession httpSession, Model model) {
        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        if (memberVO == null) {
            return "redirect:/member/memberLogin";
        }

        if (placeVO.getPlaceCategory().contains("옵션")) {
            return "place/register";
        }

        String memberEmail = memberVO.getMemberEmail();
        placeVO.setMemberEmail(memberEmail);

        int placeNum = placeService.createPlace(placeVO);

        if (placeNum > 0) {
            return "redirect:/place/myPlace?memberEmail=" + memberVO.getMemberEmail();
        } else {
            model.addAttribute("errorMessage", "장소 등록에 실패했습니다.");
            return "place/register";
        }
    }
    
    @GetMapping("/update")
    public String updateGET(HttpSession httpSession, PlaceVO placeVO, Model model) {
    	log.info("updateGet");

        MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
        log.info("MemberVO : " + memberVO);

        if (memberVO != null) {
            String memberEmail = memberVO.getMemberEmail();
            log.info("Member Email : " + memberEmail);
            model.addAttribute("placeVO", placeVO);
            return "place/update";
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
        }
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
        	return "redirect:/place/myPlace?memberEmail=" + memberEmail;
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    @GetMapping("/detail")
    public String detailGET(Integer placeId, Integer imageId, HttpSession httpSession, Model model) {
        log.info("detailGet");
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
        	return "place/detail";        	
        } else {
        	log.error("세션이 존재하지 않습니다.");
        	return "redirect:/member/memberLogin";
    	}
    }
    
    
    @GetMapping("/delete")
    public String deleteGET(Integer placeId, String memberEmail, Model model, HttpSession httpSession) {
        log.info("deleteGet");
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
    
    @GetMapping("/search")
    public void searchGET(String placeCategory, HttpSession httpSession, Model model) {
    	log.info("searchGet");
    	MemberVO memberVO = (MemberVO) httpSession.getAttribute("login");
    	
    	if (memberVO != null) {
    		List<PlaceVO> list = placeService.getPlaceByCategory(placeCategory);
    		log.info("List : " + list);
    		model.addAttribute("list", list);
    	}
    }
}
