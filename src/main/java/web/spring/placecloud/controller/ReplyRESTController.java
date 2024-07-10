package web.spring.placecloud.controller;

import java.util.List;import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ReplyVO;
import web.spring.placecloud.service.ReplyService;

@RestController
@RequestMapping("/reply")
@Log4j
public class ReplyRESTController {
	
	@Autowired
	private ReplyService replyService;
	
	// 대댓글 목록 조회
	@PostMapping("replies")
	public List<ReplyVO> getReplies(@RequestBody Map<String, Integer> requestData, Model model) {
		log.info("getReplies()");
		
		int commentId = requestData.get("commentId");
		log.info("commentId = " + commentId);
		
		List<ReplyVO> reply = replyService.getReply(commentId);
		model.addAttribute("reply", reply);
		
		return reply;
	
	} // end getReplies()
	
	// 대댓글 등록
	@PostMapping("repliesInsert")
	public String repliesInsert(@RequestBody ReplyVO replyVO) {
		log.info("repliesInsert()");
		
		int result = replyService.createReply(replyVO);
		log.info(result + "성공");
			
		if (result > 0) {
			return "InsertSuccess";
		} else {
			return "InsertFail";
		}
		
	} // end repliesInsert()
	
	// 대댓글 수정
	@PostMapping("repliesUpdate")
	public String repliesUpdate(@RequestBody ReplyVO replyVO) {
		log.info("repliesUpdate()");
			
		int result = replyService.updateReply(replyVO);
		log.info(result + "성공");

		if (result > 0) {
			return "UpdateSuccess";
		} else {
			return "UpdateFail";
		}
		
	} // end repliesUpdate()
	
	// 대댓글 삭제
	@PostMapping("repliesDelete")
	public String repliesDelete(@RequestBody Map<String, Integer> requestData) {
		log.info("repliesDelete()");
		
		int replyId = requestData.get("replyId");

		int result = replyService.deleteReply(replyId);
		log.info(result + "성공");

		if (result > 0) {
			return "DeleteSuccess";
		} else {
			return "DeleteFail";
		}
		
	} // end repliesDelete()
	
	
} // end ReplyController()
