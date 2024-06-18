package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.ReplyVO;

public interface ReplyService {
	int createReply(ReplyVO replyVO); // 대댓글 등록
	List<ReplyVO> getReply(int feedbackId); // 특정 댓글에 대한 대댓글 조회
	int updateReply(ReplyVO replyVO); // 대댓글 수정
	int deleteReply(int replyId); // 대댓글 삭제
	int deleteReplyByFeedback(int feedbackId); // 댓글 삭제에 따른 대댓글 삭제
}
