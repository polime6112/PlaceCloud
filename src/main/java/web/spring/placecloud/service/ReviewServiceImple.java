package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ReviewVO;
import web.spring.placecloud.persistence.ReviewMapper;
import web.spring.placecloud.util.Pagination;

@Service
@Log4j
public class ReviewServiceImple implements ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	// 이용후기 등록
	@Override
	public int createReview(ReviewVO reviewVO) {
		log.info("createReview()");
		return reviewMapper.insert(reviewVO);
	}
	
	// 전체 이용후기 조회
	@Override
	public List<ReviewVO> getAllReview() {
		log.info("getAllReview()");
		return reviewMapper.selectList();
	}
	
	// 특정 회원 조회
	@Override
	public ReviewVO getReviewById(int reviewId) {
		log.info("getReviewById()");
		return reviewMapper.selectOne(reviewId);
	}
		
	// 특정 이용후기 수정
	@Override
	public int updateReview(ReviewVO reviewVO) {
		log.info("updateReview()");
		return reviewMapper.update(reviewVO);
	}
	
	// 특정 이용후기 삭제
	@Override
	public int deleteReview(int reviewId) {
		log.info("deleteReview()");
		return reviewMapper.delete(reviewId);
	}
	
	// 이용후기 페이지 처리
	@Override
	public List<ReviewVO> getSearchPaging(Pagination pagination) {
		log.info("getSearchPaging()");
		return reviewMapper.searchListByPagination(pagination);
	}
	
	// 이용후기 전체 수
	@Override
	public int getSearchTotalCount() {
		log.info("getSearchTotalCount()");
		return reviewMapper.searchTotalCount();
	}


}
