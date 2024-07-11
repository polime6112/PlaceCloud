package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.MemberRole;
import web.spring.placecloud.domain.MemberVO;

@Mapper
public interface MemberMapper {
	int memberJoin(MemberVO memberVO); // 회원(게스트) 등록
	int insertMemberRole(String memberEmail); // 권한 정보 등록
	int insertMemberRoleHost(String memberEmail); // 권한 정보 호스트 등록
	MemberVO selectMember(String memberEmail); // 특정 회원(게스트) 조회
	MemberRole selectRoleByMemberEmail(String memberEmail); // 권한 정보 조회
	int update(MemberVO memberVO); // 특정 회원(게스트) 수정
	int delete(String memberEmail); // 특정 회원(게스트) 삭제
	int deleteMemberRole(String memberEmail); // 권한 정보 삭제
	int emailDoubleChk(String memberEmail); // 이메일 중복 체크
	int nameDoubleChk(String memberName); // 닉네임 중복 체크
	int profilePicture(MemberVO memberVO); // 프로필 사진 업데이트
	
}
