package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.util.Bpagination;

@Mapper
public interface BookingMapper {
	int insert(BookingVO bookingVO); // 예약 등록
	List<BookingVO> selectList(); // 전체 예약 목록
	List<BookingVO> selectListByDate(@Param("startDate") String startDate, @Param("endDate") String endDate); // 일정 기간 내의 예약 정보
	BookingVO selectOne(int bookingId); // 특정 예약 정보 조회
	BookingVO selectOnebyDate(@Param("date") String bookingDate, @Param("email") String bookingUserEmail); // 예약된 정보를 날짜와 이메일로 조회
	int update(BookingVO bookingVO); // 예약 정보 수정
	int delete(int bookingId); // 예약 정보 삭제
	// 예약 정보 페이징 처리
	List<BookingVO> selectListByPagination(Bpagination bpagination);
	int selectTotalCount(Bpagination bpagination);
	
	
} // end BookingMapper
