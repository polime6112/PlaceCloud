package web.spring.placecloud.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.ProfileVO;
import web.spring.placecloud.service.MemberService;
import web.spring.placecloud.service.ProfileService;

@Controller
@RequestMapping(value = "/member")
@Log4j
public class MemberController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private ProfileService profileService;

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
        log.info(memberVO.getMemberStatus());
        int result = memberService.addMember(memberVO);
        log.info(result + "회원 가입");
        return "redirect:/member/login";
    } // memberJoinPOST()

    // 로그인 화면 이동
    @GetMapping("login")
    public void loginGET() {
        log.info("loginGET()");
    } // memberLoginGET()

    // 로그인 체크
    @PostMapping("memberLogin")
    public String loginCheck(MemberVO memberVO, HttpSession session, RedirectAttributes reAttr) {
        log.info("loginCheck()");
        MemberVO login = memberService.loginCheck(memberVO);
       
        if (login != null) {
            log.info("로그인 성공");
            session.setAttribute("login", login);
            session.setMaxInactiveInterval(6000); // 100분
            return "redirect:/place/main";
        } else {
            log.info("로그인 실패");
            session.setAttribute("login", null);
            reAttr.addFlashAttribute("loginFailMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "redirect:/member/login"; 
        }
    } // end loginCheck()

    // 로그아웃
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        log.info("logout()");
        session.invalidate();
        return "redirect:/place/main";
    } // end logout()

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
    public String myPage(HttpSession session, Model model) {
        log.info("myPage()");
        MemberVO member = (MemberVO) session.getAttribute("login");

        if (member != null) { // 사용자 정보가 null이 아닌지 확인
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + "이메일");
            log.info("세션 o");
            MemberVO vo = memberService.getMemberByEmail(memberEmail);
            ProfileVO profileVO = profileService.getProfileByEmail(memberEmail);
            log.info(vo.toString());
            model.addAttribute("member", vo);
            model.addAttribute("profileVO", profileVO);
            return "/member/myPage";
        } else {
            log.info("세션 x");
            return "redirect:/member/login";
        }
    } // end myPage()

    // 회원정보 수정 페이지 이동
    @GetMapping("updateInfo")
    public String updateInfoGET(HttpSession session, Model model) {
        log.info("updateInfoGET()");

        MemberVO member = (MemberVO) session.getAttribute("login");

        if (member != null) { // 사용자 정보가 null이 아닌지 확인
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + "이메일");
            MemberVO vo = memberService.getMemberByEmail(memberEmail);
            log.info(vo.toString());
            model.addAttribute("member", vo);
            return "/member/updateInfo";
        } else {
            log.info("세션 x");
            return "redirect:/member/login";
        }
    } // end updateInfoGET()

    // 회원 정보 수정
    @PostMapping("updateInfo")
    public String updateInfoPOST(HttpSession session, MemberVO memberVO, Model model) {
        log.info("updateInfoPOST()");

        MemberVO member = (MemberVO) session.getAttribute("login");

        if (member != null) { // 사용자 정보가 null이 아닌지 확인
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + "이메일");
            int result = memberService.updateMember(memberVO);
            log.info(result + "수정 완료");
            MemberVO vo = memberService.getMemberByEmail(memberEmail);
            log.info(vo.toString());
            model.addAttribute("member", vo);
            return "/member/myPage";
        } else {
            log.info("세션 x");
            return "redirect:/member/login";
        }
    }

    // 회원 탈퇴 페이지 이동
    @GetMapping("remove")
    public String removeGET(HttpSession session) {
        log.info("removeGET()");
        MemberVO member = (MemberVO) session.getAttribute("login");

        if (member != null) { // 사용자 정보가 null이 아닌지 확인
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + "이메일");
            return "/member/remove";
        } else {
            log.info("세션 x");
            return "redirect:/member/login";
        }
    }

    // 회원 탈퇴
    @PostMapping("remove")
    public String removePOST(HttpSession session) {
        log.info("removePOST()");
        MemberVO member = (MemberVO) session.getAttribute("login");

        if (member != null) { // 사용자 정보가 null이 아닌지 확인
            String memberEmail = member.getMemberEmail();
            log.info(memberEmail + "이메일");
            int result = memberService.removeMember(memberEmail);
            log.info(result + "회원 탈퇴");
            session.invalidate();
            return "redirect:/place/main";
        } else {
            log.info("세션 x");
            return "redirect:/member/login";
        }
    }
} // end MemberController
