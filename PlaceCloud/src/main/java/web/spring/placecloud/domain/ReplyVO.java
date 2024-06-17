package web.spring.placecloud.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 매개변수 생성자
@Getter
@Setter
@ToString
public class ReplyVO {
	private int replyId; // 대댓글 번호
	private int feedbackId; // 댓글 번호
	private int reviewId; // 게시판 번호
	private String memberEmail; // 회원 이메일
	private String replyContent; // 대댓글 내용
	private Date replyDateCreated; // 대댓글 생성 날짜
}
