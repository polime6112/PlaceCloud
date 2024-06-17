package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.FeedbackVO;

@Mapper
public interface FeedbackMapper {
	int insert(FeedbackVO feedbackVO); // 댓글 작성
	List<FeedbackVO> selectListByReviewId(int reviewId); // 댓글 목록 조회
	int update(FeedbackVO feedbackVO); // 댓글 수정
	int delete(int feedbackId); // 댓글 삭제	
}
