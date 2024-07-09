package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.CommentVO;

@Mapper
public interface CommentMapper {
	int insert(CommentVO commentVO); // 댓글 작성
	List<CommentVO> selectListByReviewId(int reviewId); // 댓글 목록 조회
	int update(CommentVO commentVO); // 댓글 수정
	int delete(int commentId); // 댓글 삭제	
}
