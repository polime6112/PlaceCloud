package web.spring.placecloud.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.FeedbackVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.service.FeedbackService;

@Controller
@RequestMapping(value = "/feedback")
@Log4j
public class FeedbackController {
    
    @Autowired
    private FeedbackService feedbackService;
    
    @PostMapping("feedbackInsert")
    @ResponseBody
    public String feedbackInsert(FeedbackVO feedbackVO, HttpSession session) {
        log.info("feedbackInsert()");
        MemberVO member = (MemberVO) session.getAttribute("login");
        
        if (member != null) {
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + " 이메일");
            feedbackVO.setMemberEmail(memberEmail); // 세션의 이메일을 피드백에 설정
            log.info("세션 o");
            log.info(feedbackVO);
            int result = feedbackService.createFeedback(feedbackVO);
            log.info(result + " 성공");
            if (result > 0) {
                return "InsertSuccess";
            } else {
                return "InsertFail";
            }
        } else {
            log.info("세션 x");
            return "redirect:/member/memberMain";
        }
    } // end feedbackInsert()
    
    @PostMapping("feedbackAllList")
    @ResponseBody
    public List<FeedbackVO> feedbackAllList(@RequestBody Map<String, Integer> requestData, HttpSession session, Model model) {
        int reviewId = requestData.get("reviewId");
        log.info("feedbackAllList()");
        log.info("reviewId = " + reviewId);
        
        List<FeedbackVO> feedback = feedbackService.getAllFeedback(reviewId);
        model.addAttribute("feedback", feedback);
        return feedback;
    } // end feedbackAllList()
    
    
    
} // end FeedbackController
