package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.persistence.MemberMapper;

@Service
@Log4j
public class MemberServiceImple implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	// 회원(게스트) 등록
	@Override
	public int addMember(MemberVO memberVO) {
		log.info("addMember()");
		int result = memberMapper.memberJoin(memberVO);
		log.info(result + "회원가입");
		return result;
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
	@Override
	public int removeMember(String memberEmail) {
		log.info("deleteMember()");
		int result = memberMapper.delete(memberEmail);
		log.info(result + "회원 삭제");
		return 1;
	}
	
	// 로그인 체크
	@Override
	public MemberVO loginCheck(MemberVO memberVO) {
		log.info("loginCheck()");
		return memberMapper.loginChk(memberVO);
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
