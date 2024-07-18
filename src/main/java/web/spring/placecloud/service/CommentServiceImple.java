package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.CommentVO;
import web.spring.placecloud.persistence.CommentMapper;
import web.spring.placecloud.persistence.ReplyMapper;

@Service
@Log4j
public class CommentServiceImple implements CommentService {
	
	@Autowired
	public CommentMapper commentMapper;
	
	@Autowired
	public ReplyMapper replyMapper;
	
	// 댓글 등록
	@Override
	public int createComment(CommentVO commentVO) {
		log.info("createComment()");
		int insertResult = commentMapper.insert(commentVO);
		log.info(insertResult + "댓글 등록");
		
		return insertResult;
	}
	
	// 댓글 리스트 조회
	@Override
	public List<CommentVO> getAllComment(int reviewId) {
		log.info("getAllComment()");
		return commentMapper.selectListByReviewId(reviewId);
	}
	
	// 댓글 수정
	@Override
	public int updateComment(CommentVO commentVO) {
		log.info("updateComment()");
		int updateResult = commentMapper.update(commentVO);
		log.info(updateResult + "댓글 수정");
		
		return updateResult;
	}
	
	// 댓글 삭제
	@Transactional(value = "transactionManager") // transactionManager가 관리
	@Override
	public int deleteComment(int commentId) {
		log.info("deleteComment()");
		
		int deleteReplyResult = replyMapper.deleteByCommentId(commentId);
		log.info(deleteReplyResult + "대댓글 삭제");
		
		int deleteResult = commentMapper.delete(commentId);
		log.info(deleteResult + "댓글 삭제");
		
		return deleteResult;
	}

}
