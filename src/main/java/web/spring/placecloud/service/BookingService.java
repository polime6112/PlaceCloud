package web.spring.placecloud.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.util.Bpagination;

public interface BookingService {
	int createBoard(BookingVO bookingVO);
	List<BookingVO> getAllBoards();
	List<BookingVO> getBoardsByDate(@Param("startDate") String startDate, @Param("endDate") String endDate);
	BookingVO getBoardById(int bookingId);
	BookingVO getBoardByDate(String date, String email);
	int updateBoard(BookingVO bookingVO);
	int deleteBoard(int bookingId);
	List<BookingVO> getPagingBoards(Bpagination bpagination);
	int getTotalCount(Bpagination bpagination);
}
