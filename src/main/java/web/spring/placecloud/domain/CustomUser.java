package web.spring.placecloud.domain;

import lombok.Getter;

import java.util.Collection;


import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;


@Getter
public class CustomUser extends User { // User 클래스 상속
	
	private MemberVO member; // JSP에 정보 출력을 위한 필드
	
	private static final long serialVersionUID = 1L;
	
	// Collection<? extends GrantedAuthority> authorities : 권한 정보를 저장하는 Collection
	public CustomUser(MemberVO member, 
			 Collection<? extends GrantedAuthority> authorities) {
		
		// User 클래스 생성자에 username, password, authorities를 적용
		// 인증 및 권한 확인에 필요한 정보
		super(member.getMemberEmail(), member.getMemberPw(), authorities);
		
		// 전송된 member 객체 적용
		this.member = member;
	}
	
	
}
