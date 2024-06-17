package web.spring.placecloud.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoPayReadyVO {
	private String tid; // 고유 결제 번호
	private String next_redirect_mobile_url; // 요청한 클라이언트가 모바일 웹
	private String next_redirect_pc_url; // 요청한 클라이언트가 PC 웹
	private Date created_at; // 결제 준비 요청 시간
}
