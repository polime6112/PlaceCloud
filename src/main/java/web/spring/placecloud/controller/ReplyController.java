package web.spring.placecloud.controller;

import java.util.List;import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.ReplyVO;
import web.spring.placecloud.service.ReplyService;

@Controller
@RequestMapping("/reply")
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	// 대댓글 목록 조회
	@PostMapping("replies")
	@ResponseBody
	public List<ReplyVO> getReplies(@RequestBody Map<String, Integer> requestData, HttpSession session, Model model) {
		log.info("getReplies()");
		
		int feedbackId = requestData.get("feedbackId");
		log.info("feedbackId = " + feedbackId);
		
		List<ReplyVO> reply = replyService.getReply(feedbackId);
		model.addAttribute("reply", reply);
		
		return reply;
	
	} // end getReplies()
	
	// 대댓글 등록
	@PostMapping("repliesInsert")
	@ResponseBody
	public String repliesInsert(@RequestBody ReplyVO replyVO, HttpSession session) {
		log.info("repliesInsert()");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			String memberEmail = member.getMemberEmail();
			replyVO.setMemberEmail(memberEmail);
			
			int result = replyService.createReply(replyVO);
			log.info(result + "성공");
			
			if (result > 0) {
				return "InsertSuccess";
			} else {
				return "InsertFail";
			}
		} else {
			return "redirect:/place/main";
		}
	} // end repliesInsert()
	
	// 대댓글 수정
	@PostMapping("repliesUpdate")
	@ResponseBody
	public String repliesUpdate(@RequestBody ReplyVO replyVO, HttpSession session) {
		log.info("repliesUpdate()");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String memberEmail = member.getMemberEmail();
			replyVO.setMemberEmail(memberEmail);
			
			int result = replyService.updateReply(replyVO);
			log.info(result + "성공");
			
			if(result > 0) {
				return "UpdateSuccess";
			} else {
				return "UpdateFail";
			}
		} else {
			return "redirect:/member/memberMain";
		}
		
	} // end repliesUpdate()
	
	// 대댓글 삭제
	@PostMapping("repliesDelete")
	@ResponseBody
	public String repliesDelete(@RequestBody Map<String, Integer> requestData, HttpSession session) {
		log.info("repliesDelete()");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		int replyId = requestData.get("replyId");
		
		if(member != null) {
			String memberEmail = member.getMemberEmail();
			ReplyVO replyVO = new ReplyVO();
			replyVO.setMemberEmail(memberEmail);
			
			int result = replyService.deleteReply(replyId);
			log.info(result + "성공");
			
			if(result > 0) {
				return "DeleteSuccess";
			} else {
				return "DeleteFail";
			}
		} else {
			log.info("세션 x");
			return "redirect:/member/memberMain";
		}
		
	} // end repliesDelete()
	
	
} // end ReplyController()
