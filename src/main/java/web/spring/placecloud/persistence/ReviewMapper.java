package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import web.spring.placecloud.domain.ReviewVO;
import web.spring.placecloud.util.Pagination;

@Mapper
public interface ReviewMapper {
	int insert(ReviewVO reviewVO); // 이용후기 등록
	List<ReviewVO> selectList(); // 이용후기 전체 조회
	ReviewVO selectOne(int reviewId); // 특정 이용후기 조회
	int update(ReviewVO reviewVO); // 특정 이용후기 수정
	int delete(int reviewId); // 특정 이용후기 삭제
	List<ReviewVO> searchListByPagination(Pagination pagination); // 페이지네이션된 이용후기 목록 조회
	int searchTotalCount(); // 총 이용후기 수 조회
}
