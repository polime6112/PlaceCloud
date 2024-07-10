package web.spring.placecloud.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter 
@Setter
@ToString
public class MemberRole {
	private int roleId; // 권한번호
	private String memberEmail; // 회원 이메일
	private String roleName; // 권한이름
}
