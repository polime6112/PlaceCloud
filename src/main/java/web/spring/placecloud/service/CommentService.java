package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.CommentVO;

public interface CommentService {
	int createComment(CommentVO commentVO); // 댓글 등록
	List<CommentVO> getAllComment(int reviewId); // 댓글 목록 조회
	int updateComment(CommentVO commentVO); // 댓글 수정
	int deleteComment(int commentId); // 댓글 삭제
}
