package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.ReplyVO;

public interface ReplyService {
	int createReply(ReplyVO replyVO); // 대댓글 등록
	List<ReplyVO> getReply(int feedbackId); // 댓글 목록 조회
	int updateReply(ReplyVO replyVO); // 대댓글 수정
	int deleteReply(int replyId); // 대댓글 삭제
}
