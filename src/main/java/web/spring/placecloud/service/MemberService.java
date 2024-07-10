package web.spring.placecloud.service;

import web.spring.placecloud.domain.MemberVO;

public interface MemberService {
	int addMember(MemberVO memberVO); // 회원(게스트) 가입
	MemberVO getMemberByEmail(String memberEmail); // 특정 회원(게스트) 조회
	int updateMember(MemberVO memberVO); // 회원(게스트) 수정
	int removeMember(String memberEmail); // 회원(게스트) 탈퇴
	int emailDoubleCheck(String memberEmail); // 이메일 중복 체크
	int nameDoublceCheck(String memberName); // 닉네임 중복 체크
	int updateProfilePicture(MemberVO memberVO); // 프로필 사진 업데이트
}
