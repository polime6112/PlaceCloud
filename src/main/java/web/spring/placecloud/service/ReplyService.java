package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.ReplyVO;

public interface ReplyService {
	int createReply(ReplyVO replyVO); // 대댓글 등록
	List<ReplyVO> getReply(int commentId); // 특정 댓글에 대한 대댓글 조회
	int updateReply(ReplyVO replyVO); // 대댓글 수정
	int deleteReply(int replyId); // 대댓글 삭제
	int deleteReplyByComment(int commentId); // 댓글 삭제에 따른 대댓글 삭제
}
