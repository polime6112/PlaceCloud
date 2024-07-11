package web.spring.placecloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.service.MemberService;

@Controller
@RequestMapping(value = "/member")
@Log4j
public class MemberController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    // 회원 가입 화면 이동
    @GetMapping("join")
    public void joinGET() {
        log.info("joinGET()");
        
    } // end memberJoinGET()

    // 회원(게스트) 가입
    @PostMapping("join")
    public String joinPOST(MemberVO memberVO, RedirectAttributes reAttr) {
        log.info("joinPOST()");
        log.info("memberVO = " + memberVO.toString());
        
        memberVO.setMemberPw(passwordEncoder.encode(memberVO.getMemberPw())); // 비밀번호를 암호화하여 설정
        int result = memberService.addMember(memberVO);
        log.info(result + "회원 가입");
        
        return "redirect:/auth/login";
        
    } // memberJoinPOST()

    // 이메일 중복 체크
    @PostMapping("emailCheck")
    @ResponseBody
    public String emailDoubleCheck(String memberEmail) {
        log.info("emailDoubleCheck()");
        int result = memberService.emailDoubleCheck(memberEmail);
        log.info(result + "이메일 체크");

        if (result != 0) {
            return "fail"; // 중복 이메일이 존재
        } else {
            return "success"; // 중복 이메일 x
        }
        
    } // end emailDoubleCheck()

    // 닉네임 중복 체크
    @PostMapping("nameCheck")
    @ResponseBody
    public String nameDoubleCheck(String memberName) {
        log.info("nameDoubleCheck()");
        int result = memberService.nameDoublceCheck(memberName);
        log.info(result + "닉네임 체크");

        if (result != 0) {
            return "fail"; // 중복 닉네임이 존재
        } else {
            return "success"; // 중복 닉네임 x
        }
        
    } // end nameDoubleCheck()

    // 마이페이지 이동
    @GetMapping("myPage")
    public void myPage(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        log.info("myPage()");
        String memberEmail = userDetails.getUsername();
        MemberVO memberVO = memberService.getMemberByEmail(memberEmail);
        model.addAttribute("member", memberVO);
    
    } // end myPage()

    // 회원정보 수정 페이지 이동
    @GetMapping("updateInfo")
    public void updateInfoGET(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        log.info("updateInfoGET()");

        String memberEmail = userDetails.getUsername();
        MemberVO memberVO = memberService.getMemberByEmail(memberEmail);
        model.addAttribute("member", memberVO);
      
    } // end updateInfoGET()

    // 회원 정보 수정
    @PostMapping("updateInfo")
    public String updateInfoPOST(MemberVO memberVO) {
        log.info("updateInfoPOST()");

        String encPw = passwordEncoder.encode(memberVO.getMemberPw());
        memberVO.setMemberPw(encPw);
		int result = memberService.updateMember(memberVO);
		log.info(result + "행 수정 완료");
		
		return "redirect:/member/myPage";

    } // end updateInfoPOST()

    // 회원 탈퇴 페이지 이동
    @GetMapping("remove")
    public void removeGET() {
        log.info("removeGET()");

    } // end removeGET()

    // 회원 탈퇴
    @PostMapping("remove")
    public String removePOST(@AuthenticationPrincipal UserDetails userDetails) {
        log.info("removePOST()");
        
        String memberEmail = userDetails.getUsername();
        int result = memberService.removeMember(memberEmail);
        log.info(result + "행 삭제 완료");
        SecurityContextHolder.clearContext(); // 인증 정보 초기화
        
        return "redirect:/place/main";
        
    } // end removePOST()
    
} // end MemberController
