package web.spring.placecloud.domain;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class PlaceVO {
	private Integer placeId;
	private String placeName;
	private String placeCategory;
	private String placeContext;
	private String placeAddress;
	private String placeWarning;
	private String placeInfo;
	private int placeMoneyTime;
	private int placeMoneyPackage;
	private String memberEmail;
	private Date placeCreateDate;
}
