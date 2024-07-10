package web.spring.placecloud.controller;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.CommentVO;
import web.spring.placecloud.service.CommentService;

@RestController
@RequestMapping(value = "/comment")
@Log4j
public class CommentRESTController {
    
    @Autowired
    private CommentService commentService;
    
    // 댓글 등록
    @PostMapping("commentInsert")
    public String commentInsert(@RequestBody CommentVO commentVO) {
        log.info("commentInsert()");
        
        int result = commentService.createComment(commentVO);
        log.info(result + "성공");
            
		if (result > 0) {
			return "InsertSuccess";
		} else {
			return "InsertFail";
		}
       
    } // end commentInsert()
    
    // 댓글 리스트
    @PostMapping("commentAllList")
    public List<CommentVO> commentAllList(@RequestBody Map<String, Integer> requestData, Model model) {
        log.info("commentAllList()");
        
        int reviewId = requestData.get("reviewId");
        log.info("reviewId = " + reviewId);
        
        List<CommentVO> comment = commentService.getAllComment(reviewId);
        model.addAttribute("comment", comment);
        return comment;
        
    } // end commentAllList()
    
    // 댓글 수정
    @PostMapping("commentUpdate")
    public String commentUpdate(@RequestBody CommentVO commentVO) {
    	log.info("coommentUpdate()");
    	
    	int result = commentService.updateComment(commentVO);
        log.info(result + " 성공");
            
		if (result > 0) {
			return "UpdateSuccess";
		} else {
			return "UpdateFail";
		}

    } // end commentUpdate()
    
    // 댓글 삭제
    @PostMapping("commentDelete")
    public String commentDelete(@RequestBody Map<String, Integer> requestData) {
    	log.info("commentDelete()");
   
    	Integer commentId = requestData.get("commentId");
    	
    	int result = commentService.deleteComment(commentId);
        log.info(result + "성공");
            
        if(result > 0) {
        	return "DeleteSuccess";
        } else {
        	return "DeleteFail";
            }
    	
    } // end commentDelete()
           
} // end CommentRESTController
