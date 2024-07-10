package web.spring.placecloud.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookingVO {
	private int bookingId;
	private String placeId;
	private String placeName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date bookingDate; // 예약 날짜
	private int bookingPerson;
	private String bookingUserName; // 생략가능 (외래키)
	private String bookingUserPhone; // 생략가능 (외래키)
	private String bookingUserEmail; // 생략가능 (외래키)
	private String bookingPerpose;
	private String bookingContent;
	private String bookingPrice; 
	private Date bookingSysdate; // 예약이 들어간 날짜

} // end BookingVO
