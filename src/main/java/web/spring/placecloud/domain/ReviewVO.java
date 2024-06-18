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
public class ReviewVO {
	private int reviewId; // 이용후기 번호 
	private int placeId; // 장소 번호
	private String reviewTitle; // 이용후기 제목
	private String reviewContent; // 이용후기 내용
	private String memberEmail; // 회원 이메일
	private Date reviewDateCreated; // 이용후기 생성 날짜
}
