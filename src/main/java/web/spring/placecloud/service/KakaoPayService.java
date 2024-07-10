package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.domain.KakaoPayApproveRequest;
import web.spring.placecloud.domain.KakaoPayReadyRequest;
import web.spring.placecloud.domain.KakaoPayReadyResponse;


@Service
@Log4j
public class KakaoPayService {
	@Value("DEV16677CAB65B1E512F556CB8FB6DDCA6C8C84D")
	private String kakaopaySecretKey;
	
	@Value("TC0ONETIME")
	private String cid;
	
	@Value("http://localhost:8080/placecloud")
	private String sampleHost;
	
	private String tid;
	
	// 결제에 필요한 정보를 api양식에 맞게 호출하여 결제 준비(ready) 후 사용자에게 결제 승인 요청
	public KakaoPayReadyResponse ready(BookingVO bookingVO) {
		log.info("bookingVO : " + bookingVO);
		
		// Request header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "DEV_SECRET_KEY " + kakaopaySecretKey);
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		// Request param
		KakaoPayReadyRequest readyRequest = KakaoPayReadyRequest.builder()
				.cid(cid)
				.partner_order_id(bookingVO.getPlaceId())
				.partner_user_id(bookingVO.getBookingUserEmail())
				.item_name(bookingVO.getPlaceName())
				.quantity(1)
				.total_amount(bookingVO.getBookingPrice())
				.tax_free_amount(0)
				.vat_amount(0)
				.approval_url(sampleHost + "/approve")
				.cancelUrl(sampleHost + "/cancel")
				.failUrl(sampleHost + "/fail")
				.build();
		
		// Send Request(파라미터 + 해더)
		HttpEntity<KakaoPayReadyRequest> entityMap = new HttpEntity<>(readyRequest, headers);
		ResponseEntity<KakaoPayReadyResponse> response = new RestTemplate().postForEntity(
				"https://open-api.kakaopay.com/online/v1/payment/ready",
				entityMap,
				KakaoPayReadyResponse.class);
		KakaoPayReadyResponse readyResponse = response.getBody();
		
		log.info("readyResponse : " + readyResponse);
		
		// 주문번호와 TID를 매핑해서 저장
		this.tid = readyResponse.getTid();
		return readyResponse;
	} // end ready()
	
<<<<<<< HEAD
		params.put("cid", cid); // 가맹점 코드
		params.put("partner_order_id", bookingVO.getPlaceId()); // 주문 번호 
		params.put("partner_user_id", bookingVO.getBookingUserEmail()); // 회원 아이디
		params.put("item_name", bookingVO.getPlaceName()); // 상품 명
		params.put("quantity", "1"); // 상품 수량
		params.put("total_amount", bookingVO.getBookingPrice()); // 총 금액
		params.put("tax_free_amount", "1"); // 비과세 금액
		params.put("approval_url", "http://192.168.0.127:8080/placecloud/kakaoPaySuccess"); // 성공시 url (최대 255자)
		params.put("cancel_url", "http://192.168.0.127:8080/placecloud/kakaoPayCancel"); // 취소시 url (최대 255자)
		params.put("fail_url", "http://192.168.0.127:8080/placecloud/kakaoPayFail"); // 실패시 url (최대 255자)
=======
	// 사용자에게 결제 요청을 승인 하면 결제한 정보를 바탕으로 결제 완료 후 알림톡 송신
	public String approve(BookingVO bookingVO, String pgToKen) {
		// ready()를 진행할 때 저장해 놓은 TID로 승인 요청
>>>>>>> branch 'master' of https://github.com/polime6112/PlaceCloud.git
		
		// Request header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "DEV_SECRET_KEY " + kakaopaySecretKey);
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		// Request param
		KakaoPayApproveRequest approveRequest = KakaoPayApproveRequest.builder()
				.cid(cid)
				.tid(tid)
				.partner_order_id(bookingVO.getPlaceId())
				.partner_user_id(bookingVO.getBookingUserEmail())
				.pg_token(pgToKen)
				.build();
		
		// Send Request
		HttpEntity<KakaoPayApproveRequest> entityMap = new HttpEntity<>(approveRequest ,headers);
		try {
			ResponseEntity<String> response = new RestTemplate().postForEntity(
					"https://open-api.kakaopay.com/online/v1/payment/approve",
					entityMap,
					String.class);
			
			// 승인 결과를 저장
			String approveResponse = response.getBody();
			log.info("approve()end");
			return approveResponse;
		} catch (HttpStatusCodeException ex) {
			log.info("approve()end");
			return ex.getResponseBodyAsString();
		}
	}
	
	
}
