package web.spring.placecloud.domain;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@ToString
public class KakaoPayApproveRequest {
	private String cid; // 가맹점 코드(10자)
	private String tid; // 결제 고유번호(결제 준비 API응답에 포함)
	private String partner_order_id; // 가맹점 주문번호(결제 준비 API요청과 일치해야 함)
	private String partner_user_id; // 가맹점 회원 id(결제 준비 API요청과 일치해야 함)
	private String pg_token; // 결제승인 요청을 인증하는 토큰(사용자 결제 수단 선택 완료시, apprval_url로 redirection 해줄 때 pg_token을 query string으로 전달)
}
