package web.spring.placecloud.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class PlaceVO {
	private int placeId;
	private String placeName;
	private String placeCategory;
	private String placeContext;
	private String placeAddress;
	private String placeWarning;
	private String placeInfo;
	private int placeMoneyTime;
	private String memberEmail;
	private Date placeCreateDate;

	private List<ImageVO> imageList;
	
	public List<ImageVO> getImageList() {
		if(imageList == null) {
			imageList = new ArrayList<ImageVO>();
		}
		return imageList;
	}
}
