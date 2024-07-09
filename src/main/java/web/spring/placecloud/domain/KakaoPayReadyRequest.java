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
public class KakaoPayReadyRequest {
	private String cid; // 가맹점 코드(10자)
	private String partner_order_id; // 가맹점 주문번호(최대 100자)
	private String partner_user_id; // 가맹점 회원 id(최대 100자)
	private String item_name; // 상품명(최대 100자)
	private int quantity; // 상품 수량
	private String total_amount; // 상품 종액
	private int tax_free_amount; // 상품 비과세 금액
	private int vat_amount; // 상품 부과세 금액
	private String approval_url; // 결제 성공 시 redirect url(최대 255자)
	private String cancelUrl; // 결제 취소 시 redirect url(최대 255자)
	private String failUrl; // 결제 실패 시 redirect url(최대 255자)
}
