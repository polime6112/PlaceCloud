package web.spring.placecloud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ReviewVO;
import web.spring.placecloud.service.ReviewService;
import web.spring.placecloud.util.PageMaker;
import web.spring.placecloud.util.Pagination;

@Controller
@RequestMapping(value = "/review")
@Log4j
public class ReviewController {
    
    @Autowired
    private ReviewService reviewService;
    
    // 게시판 메인 페이지 이동
    @GetMapping("list")
    public void review(Integer placeId, Model model, Pagination pagination) {
        log.info("review()");
        log.info("placeId = " + placeId);
           
		log.info("검색 조건 - 타입: " + pagination.getType() + ", 키워드: " + pagination.getKeyword());
		// 페이지네이션 정보를 이용하여 이용후기 목록
		List<ReviewVO> reviewList = reviewService.getSearchPaging(pagination);

		// 페이지네이션 정보를 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPagination(pagination);
		pageMaker.setTotalCount(reviewService.getSearchTotalCount(pagination));

		model.addAttribute("placeId", placeId);
		model.addAttribute("pagination", pagination);
		model.addAttribute("pageMaker", pageMaker); // 페이지네이션 정보를 모델에 추가
		model.addAttribute("reviewList", reviewList); // 이용후기 목록을 모델에 추가

    } // end review()
    
    // 게시판 작성 페이지 이동
    @GetMapping("register")
    public void registerGET(Integer placeId, Model model) {
        log.info("registerGET()");
        log.info("placeId = " + placeId);
        model.addAttribute("placeId", placeId);
		 
    } // end registerGET()
    
    // 게시판 작성
    @PostMapping("register")
    public String registerPOST(ReviewVO reviewVO, RedirectAttributes reAttr, Integer placeId, Model model) {
        log.info("registerPOST()");
        log.info("reviewVO = " + reviewVO.toString());

		int result = reviewService.createReview(reviewVO);
		log.info(result + "행 등록");
		// 리다이렉트 후 메시지를 전달하기 위해 RedirectAttributes 사용
		reAttr.addFlashAttribute("message", "이용후기가 성공적으로 등록되었습니다.");
		
		model.addAttribute("reviewVO", reviewVO);

		return "redirect:/review/list?placeId=" + placeId;
       
    } // end registerPOST()
    
    // 이용후기 제목 링크 선택
    @GetMapping("detail")
    public void detail(Model model, Integer reviewId) {
        log.info("detail()");

		ReviewVO reviewVO = reviewService.getReviewById(reviewId);
		log.info(reviewId);
		log.info(reviewVO);

		model.addAttribute("reviewVO", reviewVO);

    } // end detail()
    
    // 이용후기 수정 페이지 이동
    @GetMapping("edit")
    public String editGET(Model model, Integer reviewId) {
    	log.info("editGET()");

		ReviewVO reviewVO = reviewService.getReviewById(reviewId);
		log.info(reviewId);
		log.info(reviewVO);
		model.addAttribute("reviewVO", reviewVO);
		return "review/edit";
    
    } // end editGET()
    
    // 이용후기 수정
    @PostMapping("edit")
    public String editPOST(Model model, ReviewVO reviewVO) {
    	log.info("editPOST()");

		int result = reviewService.updateReview(reviewVO);
		log.info(result + "수정");
		return "redirect:/review/detail?reviewId=" + reviewVO.getReviewId();

    } // end editPOST()
    
    // 이용후기 삭제
    @PostMapping("deleteReview")
    public String delete(Integer reviewId, Integer placeId) {
    	log.info("delete()");
    	log.info("reviewId : " + reviewId);
    	log.info("placeId : " + placeId);

		int result = reviewService.deleteReview(reviewId);
		log.info(result + "삭제");
		return "redirect:/review/list?placeId=" + placeId;

    } // end delete()
    
} // end ReviewController
