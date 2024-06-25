package web.spring.placecloud.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.MemberVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.service.BookingService;
import web.spring.placecloud.service.ImageService;
import web.spring.placecloud.service.PlaceService;
import web.spring.placecloud.util.BpageMaker;
import web.spring.placecloud.util.Bpagination;

@Controller
@RequestMapping(value = "/booking")
@Log4j
public class BookingController {

	@Autowired
	private BookingService bookingService;
	@Autowired
	private PlaceService placeService;
	@Autowired
	private ImageService imageService;
	
	// 모든 예약 정보를 bookingList.jsp 페이지로 전송
	@GetMapping("/list")
	public String bookingList(Model model, Bpagination bpagination, HttpSession session) {
		log.info("bookingList()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String userEmail = member.getMemberEmail();
			log.info("userEmail = " + userEmail);
			bpagination.setUserEmail(userEmail);
			log.info("Bpagination = " + bpagination);
			List<BookingVO> bookingList = bookingService.getPagingBoards(bpagination);
			log.info("bookingList() = " + bookingList);
			
			BpageMaker bpageMaker = new BpageMaker();
			bpageMaker.setBpagination(bpagination);
			bpageMaker.setTotalCount(bookingService.getTotalCount(bpagination));
			
			model.addAttribute("bpagination", bpagination);
			model.addAttribute("bookingList", bookingList);
			model.addAttribute("bpageMaker", bpageMaker);
			return "booking/list";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}

	}

	// bookingInsert.jsp 페이지 호출
	@GetMapping("/insert")
	public String bookingInsertGET(Integer placeId, Model model, HttpSession session) {
		log.info("bookingInsertGET()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			log.info("placeId : " + placeId);
			PlaceVO placeVO = placeService.getPlaceById(placeId);
			ImageVO imageVO = imageService.getImageById(placeId);
			log.info("placeVO : " + placeVO);
			log.info("imageVO : " + imageVO);
			model.addAttribute("PlaceVO", placeVO);
			model.addAttribute("ImageVO", imageVO);
			return "booking/insert";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}

	// bookingInsert.jsp에서 전송받은 예약 정보를 저장
	@PostMapping("/insert")
	public String bookingInsertPOST(BookingVO bookingVO, RedirectAttributes reAttr, HttpSession session) {
		log.info("bookingInsertPOST()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			log.info("bookingVO = " + bookingVO.toString());
			int result = bookingService.createBoard(bookingVO);
			log.info(result + "행 등록");
			return "redirect:/booking/list";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}

	// bookingList.jsp에서 선택된 예약 정보 번호를 저장
	// 전송된 데이터로 booking 데이터를 조회하고 bookingDetail.jsp 페이지로 전송
	@GetMapping("/detail")
	public String bookingDetail(Model model, Integer bookingId, HttpSession session) {
		log.info("bookingDetail()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			log.info("bookingId = " + bookingId);
			BookingVO bookingVO = bookingService.getBoardById(bookingId);
			log.info(bookingVO);
			model.addAttribute("bookingVO", bookingVO);
			return "booking/detail";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}

	// 예약 정보 번호를 전송받아 저장
	// 예약 정보 데이터를 bookingUpdate.jsp로 전송
	@GetMapping("/update")
	public String bookingUpdateGET(Model model, Integer bookingId, HttpSession session) {
		log.info("bookingUpdateGET()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			BookingVO bookingVO = bookingService.getBoardById(bookingId);
			model.addAttribute("bookingVO", bookingVO);
			return "booking/update";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}

	// bookingUpdate.jsp에서 수정한 데이터를 전송하여 예약 정보 데이터 수정
	@PostMapping("/update")
	public String bookingUpdatePOST(BookingVO bookingVO, RedirectAttributes reAttr, HttpSession session) {
		log.info("bookingUpdatePOST()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			int result = bookingService.updateBoard(bookingVO);
			log.info(result + "행 수정");
			return "redirect:/booking/detail?bookingId=" + bookingVO.getBookingId();
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}

	// bookingDetail.jsp에서 예약 정보 번호를 전송 받아 예약 정보 삭제
	@PostMapping("/delete")
	public String bookingDelete(Integer bookingId, RedirectAttributes reAttr, HttpSession session) {
		log.info("bookingDelete()");
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			int result = bookingService.deleteBoard(bookingId);
			log.info(result + "행 삭제");
			return "redirect:/booking/list";
		} else {
			log.error("로그인 필요");
			return "redirect:/event/needLogin";
		}
	}
	
}
