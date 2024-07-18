package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.persistence.BookingMapper;
import web.spring.placecloud.util.Bpagination;

@Service
@Log4j
public class BookingServiceImple implements BookingService {
	
	@Autowired
	private BookingMapper bookingMapper;

	@Override
	public int createBoard(BookingVO bookingVO) {
		log.info("createBoard()");
		int result = bookingMapper.insert(bookingVO);
		return result;
	}

	@Override
	public List<BookingVO> getAllBoards() {
		log.info("getAllBoards()");
		return bookingMapper.selectList();
	}

	@Override
	public List<BookingVO> getBoardsByDate(String startDate, String endDate) {
		log.info("getBoardsByDate");
		return bookingMapper.selectListByDate(startDate, endDate);
	}

	@Override
	public BookingVO getBoardById(int bookingId) {
		log.info("getBoardById()");
		return bookingMapper.selectOne(bookingId);
	}
	
	@Override
	public BookingVO getBoardByDate(String bookingDate, String bookingUserEmail) {
		log.info("getBoardByDate()");
		return bookingMapper.selectOnebyDate(bookingDate, bookingUserEmail);
	}

	@Override
	public int updateBoard(BookingVO bookingVO) {
		log.info("updateBoard()");
		return bookingMapper.update(bookingVO);
	}

	@Override
	public int deleteBoard(int bookingId) {
		log.info("deleteBoard()");
		return bookingMapper.delete(bookingId);
	}

	@Override
	public List<BookingVO> getPagingBoards(Bpagination bpagination) {
		log.info("getBpagingBoards()");
		return bookingMapper.selectListByPagination(bpagination);
	}

	@Override
	public int getTotalCount(Bpagination bpagination) {
		log.info("selectTotalCound()");
		return bookingMapper.selectTotalCount(bpagination);
	}


}
