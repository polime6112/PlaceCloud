package web.spring.placecloud.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class LikeListVO {
	private int likeId;
	private String userEmail;
	private int placeId;
	private String placeName;
} // end LikeListVO
