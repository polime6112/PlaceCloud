package web.spring.placecloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.service.BookingService;

@RestController
@RequestMapping("/booking")
@Log4j
public class BookingRESTController {
	
	@Autowired
	private BookingService bookingService;
	
	@GetMapping("/selectDate/{date}/{email}") // 기존 예약된 정보를 조회
	public ResponseEntity<BookingVO> readBookingOne(@PathVariable("date") String bookingDate, @PathVariable("email") String bookingUserEmail) {
		log.info("readBookingOne()");
		log.info("bookingDate : " + bookingDate);
		log.info("bookingUserEmail : " + bookingUserEmail);
		BookingVO bookingVO = bookingService.getBoardByDate(bookingDate, bookingUserEmail);
		return new ResponseEntity<BookingVO>(bookingVO, HttpStatus.OK);
	}
	
}
