package web.spring.placecloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.service.LikeService;
import web.spring.placecloud.service.MemberService;

@Controller
@RequestMapping(value = "/like")
@Log4j
public class LikeListController {
	
	@Autowired
	private LikeService likeService;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/list")
	private String likeList(Model model, @AuthenticationPrincipal UserDetails userDetails) {
		if(userDetails != null) {	
			log.info("likeList()");
			String userEmail = userDetails.getUsername();
			log.info("userEmail = " + userEmail);
			List<LikeVO> likeList = likeService.getBoardsById(userEmail);
			log.info("likeList() = " + likeList);
			MemberVO memberVO = memberService.getMemberByEmail(userEmail);
			log.info("memberVO : " + memberVO);
			
			model.addAttribute("member", memberVO);	
			model.addAttribute("likeList", likeList);
			return "like/list";
		} else {
			return "event/needLogin";
		}
		
	}
	
}
