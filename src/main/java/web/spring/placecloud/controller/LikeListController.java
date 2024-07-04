package web.spring.placecloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.service.LikeService;

@Controller
@RequestMapping(value = "/like")
@Log4j
public class LikeListController {
	
	@Autowired
	private LikeService likeService;
	
	@GetMapping("/list")
	private String likeList(Model model, HttpSession session) {
		log.info("likeList()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String userEmail = member.getMemberEmail();
			log.info("userEmail = " + userEmail);
			List<LikeVO> likeList = likeService.getAllBoards();
			log.info("likeList() = " + likeList);
			
			model.addAttribute("likeList", likeList);
			return "like/list";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}
	
}
