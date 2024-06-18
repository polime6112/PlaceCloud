package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ReplyVO;

@Mapper
public interface ReplyMapper {
	int insert(ReplyVO replyVO); // 대댓글 작성
	List<ReplyVO> selectListByFeedbackId(int feedbackId); // 대댓글 조회
	int update(ReplyVO replyVO); // 대댓글 수정
	int delete(int replyId); // 대댓글 삭제
}
