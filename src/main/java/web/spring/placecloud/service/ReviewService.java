package web.spring.placecloud.service;

import java.util.List;
import web.spring.placecloud.domain.ReviewVO;
import web.spring.placecloud.util.Pagination;

public interface ReviewService {
	int createReview(ReviewVO reviewVO); // 이용후기 등록
	List<ReviewVO> getAllReview(); // 전체 이용후기 조회
	ReviewVO getReviewById(int reviewId); // 특정 이용후기 조회
	int updateReview(ReviewVO reviewVO); // 특정 이용후기 수정
	int deleteReview(int reviewId); // 특정 이용후기 삭제
	List<ReviewVO> getSearchPaging(Pagination pagination); // 이용후기 페이지 처리
	int getSearchTotalCount(Pagination pagination); // 이용후기 전체 수
}
