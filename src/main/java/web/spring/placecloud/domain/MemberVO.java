package web.spring.placecloud.domain;

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
public class MemberVO {
	private String memberEmail; // MEMBER_EMAIL(이메일)
	private String memberPw; // MEMBER_PW(비밀번호)
	private String memberName; // MEMBER_NAME(닉네임)
	private String memberPhone; // MEMBER_PHONE(전화번호)
	private String memberStatus; // MEMBER_STATUS(상태)
	private int profileId;
	private String profilePath;
	private String profileRealName;
	private String profileChgName;
	private String profileExtension;
}
