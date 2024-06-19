package web.spring.placecloud.controller;

import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ReplyVO;
import web.spring.placecloud.service.ReplyService;

@Controller
@RequestMapping("/reply")
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	/*
	 * @PostMapping("/replies/{feedbackId}")
	 * 
	 * @ResponseBody public List<ReplyVO> getReplies(@PathVariable int feedbackId,
	 * HttpSession session, Model model) { log.info("getReplies()");
	 * 
	 * List<ReplyVO> replies = replyService.getReply(feedbackId);
	 * model.addAttribute("replies", replies);
	 * 
	 * return replies; }
	 */
}
