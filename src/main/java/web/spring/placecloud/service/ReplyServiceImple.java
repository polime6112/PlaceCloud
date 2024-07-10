package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ReplyVO;
import web.spring.placecloud.persistence.ReplyMapper;

@Service
@Log4j
public class ReplyServiceImple implements ReplyService {
	
	@Autowired
	public ReplyMapper replyMapper;
	
	// 대댓글 등록
	@Override
	public int createReply(ReplyVO replyVO) {
		log.info("createReply()");
		int result = replyMapper.insert(replyVO);
		log.info(result + "대댓글 등록");
		return result;
	}
	
	// 특정 댓글에 대한 대댓글 조회
	@Override
	public List<ReplyVO> getReply(int commentId) {
		log.info("getReply()");
		return replyMapper.selectListByCommentId(commentId);
	}
	
	// 대댓글 수정
	@Override
	public int updateReply(ReplyVO replyVO) {
		log.info("updateReply()");
		int result = replyMapper.update(replyVO);
		log.info(result + "대댓글 수정");
		return result;
	}
	
	// 대댓글 삭제
	@Override
	public int deleteReply(int replyId) {
		log.info("deleteReply()");
		int result = replyMapper.delete(replyId);
		log.info(result + "대댓글 삭제");
		return result;
	}
	
	// 댓글 삭제에 따른 대댓글 삭제
	@Override
	public int deleteReplyByComment(int commentId) {
		log.info("deleteReplyByFeedback()");
		return replyMapper.deleteByCommentId(commentId);
	}

}
