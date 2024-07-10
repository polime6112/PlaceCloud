package web.spring.placecloud.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class LikeVO {
	private int likeId; // index
	private String memberEmail; // 회원 계정(이메일)
	private int placeId; // 장소 index
	private String placeName; // 장소 이름
} // end LikeVO
