package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.FeedbackVO;
import web.spring.placecloud.persistence.FeedbackMapper;

@Service
@Log4j
public class FeedbackServiceImple implements FeedbackService {
	
	@Autowired
	public FeedbackMapper feedbackMapper;
	
	// 댓글 등록
	@Override
	public int createFeedback(FeedbackVO feedbackVO) {
		log.info("createFeedback()");
		int insertResult = feedbackMapper.insert(feedbackVO);
		log.info(insertResult + "댓글 등록");
		
		return insertResult;
	}
	
	// 댓글 리스트 조회
	@Override
	public List<FeedbackVO> getAllFeedback(int reviewId) {
		log.info("getAllFeedback()");
		return feedbackMapper.selectListByReviewId(reviewId);
	}
	
	// 댓글 수정
	@Override
	public int updateFeedback(FeedbackVO feedbackVO) {
		log.info("updateFeedbakc()");
		int updateResult = feedbackMapper.update(feedbackVO);
		log.info(updateResult + "댓글 수정");
		
		return updateResult;
	}
	
	// 댓글 삭제
	@Override
	public int deleteFeedback(int feedbackId) {
		log.info("deleteFeedback()");
		int deleteResult = feedbackMapper.delete(feedbackId);
		log.info(deleteResult + "댓글 삭제");
		
		return deleteResult;
	}

}
