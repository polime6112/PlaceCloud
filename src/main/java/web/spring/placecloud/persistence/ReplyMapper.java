package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ReplyVO;

@Mapper
public interface ReplyMapper {
	int insert(ReplyVO replyVO); // 대댓글 작성
	List<ReplyVO> selectListByFeedbackId(int feedbackId); // 특정 댓글에 대한 대댓글 조회
	int update(ReplyVO replyVO); // 대댓글 수정
	int delete(int replyId); // 대댓글 삭제
	int deleteByFeedbackId(int feedbackId); // 댓글 삭제에 따른 대댓글 삭제
}
