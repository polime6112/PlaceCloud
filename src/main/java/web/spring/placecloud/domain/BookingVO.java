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
	private Date bookingDate;
	private int bookingPerson;
	private String bookingUserName;
	private String bookingUserPhone;
	private String bookingUserEmail;
	private String bookingPerpose;
	private String bookingContent;
	private String bookingPrice;
	private Date bookingSysdate;

} // end BookingVO
