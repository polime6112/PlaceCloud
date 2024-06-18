package web.spring.placecloud.service;



import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.BookingVO;
import web.spring.placecloud.domain.KakaoPayApprovalVO;
import web.spring.placecloud.domain.KakaoPayReadyVO;

@Service
@RequiredArgsConstructor
@Transactional
@Log4j
public class KakaoPayService {
	
	private static final String Host = "https://open-api.kakaopay.com";
	
	static final String cid = "TC0ONETIME"; // 가맹점 테스트 코드
	static final String secret_key = "DEV16677CAB65B1E512F556CB8FB6DDCA6C8C84D";
	
	private KakaoPayReadyVO kakaoPayReadyVO;
	private KakaoPayApprovalVO kakaoPayApprovalVO;
	
	public String kakaoPayReady(BookingVO bookingVO, HttpSession session) {
		log.info("kakaoPayReady()");
		log.info("bookingVO : " + bookingVO);
		
		session.setAttribute("bookingVO", bookingVO);
		
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory()); // 애러 파악을 위해 생성
		log.info("restTemplate : " + restTemplate);
		
		// 서버 요청 헤더
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.set("Authorization", "SECRET_KEY " + secret_key);
		httpHeaders.set("Content-type", "application/json;charset=UTF-8");
		log.info("httpHeaders : " + httpHeaders);
		
		// 카카오페이 요청 본문
		Map<String, String> params = new HashMap<String, String>();
	
		params.put("cid", cid); // 가맹점 코드
		params.put("partner_order_id", bookingVO.getPlaceId()); // 주문 번호 
		params.put("partner_user_id", bookingVO.getBookingUserEmail()); // 회원 아이디
		params.put("item_name", bookingVO.getPlaceName()); // 상품 명
		params.put("quantity", "1"); // 상품 수량
		params.put("total_amount", bookingVO.getBookingPrice()); // 총 금액
		params.put("tax_free_amount", "1"); // 비과세 금액
		params.put("approval_url", "http://localhost:8080/placecloud/kakaoPaySuccess"); // 성공시 url (최대 255자)
		params.put("cancel_url", "http://localhost:8080/placecloud/booking/bookingInsert"); // 취소시 url (최대 255자)
		params.put("fail_url", "http://localhost:8080/placecloud/booking/bookingInsert"); // 실패시 url (최대 255자)
		
		log.info("params : " + params);
		
		// 파라미터 + 해더
		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<Map<String,String>>(params, httpHeaders);
		
		log.info("requestEntity" + requestEntity);
		
		try {
			URI uri = new URI(Host + "/online/v1/payment/ready");
			log.info("URI : " + uri);
			
			kakaoPayReadyVO = restTemplate.postForObject(uri, requestEntity, KakaoPayReadyVO.class);
			
			log.info("kakaoReadyVO : " + kakaoPayReadyVO);
			
			return kakaoPayReadyVO.getNext_redirect_pc_url();
			
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} 
		
		return "/Pay";
	}
	
	public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
		log.info("kakaoPayInfo()");
		
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory()); // 애러 파악을 위해 생성
		log.info("reserTemplate : " + restTemplate);
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.set("Authorization", "SECRET_KEY " + secret_key);
		httpHeaders.set("Content-type", "application/json;charset=UTF-8");
		log.info("httpHeaters : " + httpHeaders);
		
		Map<String, String> params = new HashMap<String, String>();
		
		params.put("cid", cid); // 가맹점 코드
		params.put("tid", kakaoPayReadyVO.getTid()); // 결제 고유번호
		params.put("partner_order_id", "1"); // 주문 번호
		params.put("partner_user_id", "test@naver.com"); // 회원 아이디
		params.put("pg_token", pg_token); // 결제 승인 요청을 인증하는 토큰
		params.put("total_amount", "1000"); // 총 금액
		
		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<Map<String,String>>(params, httpHeaders);
		
		log.info("requestEntity" + requestEntity);
		
		try {
			URI uri = new URI(Host + "/online/v1/payment/approve");
			log.info("URI : " + uri);
			
			kakaoPayApprovalVO = restTemplate.postForObject(uri, requestEntity, KakaoPayApprovalVO.class);
			
			log.info("kakaoReadyVO : " + kakaoPayReadyVO);
			
			return kakaoPayApprovalVO;
			
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	
}
