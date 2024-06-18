package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.FeedbackVO;

public interface FeedbackService {
	int createFeedback(FeedbackVO feedbackVO); // 댓글 등록
	List<FeedbackVO> getAllFeedback(int reviewId); // 댓글 목록 조회
	int updateFeedback(FeedbackVO feedbackVO); // 댓글 수정
	int deleteFeedback(int feedbackId); // 댓글 삭제
}
