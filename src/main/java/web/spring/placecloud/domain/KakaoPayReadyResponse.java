package web.spring.placecloud.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoPayReadyResponse {
	private String tid; // 고유 결제 번호
	private Date created_at; // 결제 준비 요청 시간
	private String next_redirect_pc_url; // 요청한 클라이언트가 PC 웹
	private String next_redirect_mobile_url; // 요청한 클라이언트가 모바일 웹
	private String next_redirect_app_url; // 요청한 클라이언트가 모바일 앱일 경우
	private String android_app_scheme; // 카카오페이 결제 화면으로 이동하는 Android 앱 스킴 - 내부 서비스
	private String ios_app_scheme; // 카카오 페이 결제화면으로 이동하는 iOS 앱 스킴 - 내부 서비스
}
