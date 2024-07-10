package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.persistence.MemberMapper;

@Service
@Log4j
public class MemberServiceImple implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	// 회원(게스트) 등록
	@Transactional(value = "transactionManager")
	// 트렌젝션을 어노테이션으로 명시적으로 제어
	// 데이터베이스 작업 중 오류가 발생할 경우 데이터 무결성을 유지
	@Override
	public int addMember(MemberVO memberVO) {
		log.info("addMember()");
		int result = memberMapper.memberJoin(memberVO);
		log.info(result + "회원가입");
		
		int insertRoleResult = memberMapper.insertMemberRole(memberVO.getMemberEmail());
		log.info(insertRoleResult + "행 권한 정보 등록");
		return 1;
	}
	
	// 특정 회원(게스트) 조회
	@Override
	public MemberVO getMemberByEmail(String memberEmail) {
		log.info("getMemberByEmail()");
		return memberMapper.selectMember(memberEmail);
	}
	
	// 특정 회원(게스트) 수정
	@Override
	public int updateMember(MemberVO memberVO) {
		log.info("updateMember()");
		return memberMapper.update(memberVO);
	}
	
	// 특정 회원(게스트) 삭제
	@Transactional(value = "transactionManager")
	@Override
	public int removeMember(String memberEmail) {
		log.info("deleteMember()");
		int result = memberMapper.delete(memberEmail);
		log.info(result + "회원 삭제");
		
		int deleteRoleResult = memberMapper.deleteMemberRole(memberEmail);
		log.info(deleteRoleResult + "행 권한 정보 삭제");
		return 1;
	}
	
	// 이메일 중복 체크
	@Override
	public int emailDoubleCheck(String memberEmail) {
		log.info("emailDoubleCheck()");
		int result = memberMapper.emailDoubleChk(memberEmail);
		return result;
	}
	
	// 닉네임 중복 체크
	@Override
	public int nameDoublceCheck(String memberName) {
		log.info("nameDoublceCheck()");
		int result = memberMapper.nameDoubleChk(memberName);
		return result;
	}
	
	// 프로필 사진 업데이트
	@Override
	public int updateProfilePicture(MemberVO memberVO) {
		log.info("updateProfilePicture()");
		return memberMapper.profilePicture(memberVO);
	}
	
}
