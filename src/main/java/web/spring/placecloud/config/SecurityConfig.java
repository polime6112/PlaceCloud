package web.spring.placecloud.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.filter.CharacterEncodingFilter;

import web.spring.placecloud.service.CustomUserDetailsService;


//Spring Security의 설정을 정의하는 클래스

@Configuration // Spring Container에서 관리하는 설정 클래스
@EnableWebSecurity // 스프링 시큐리티 설정을 활성화
@EnableGlobalMethodSecurity(prePostEnabled = true) // @EnableGlobalMethodSecurity : 인증 및 접근 제어 어노테이션
// prePostEnabled = true : @PreAuthorize(메서드 접근제한 제어) 및 @PostAuthorize(메서드 실행된후 결과에 대한 접근 권한)
// 와 같은 표현식을 메서드 수준에서 사용할 수 있게 설정

//WebSecurityConfigurerAdapter를 상속하여 보안 기능을 구성
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	
	// HttpSecurity 객체를 통해 HTTP 보안 기능을 구성
	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		
		
		// antMatchers(pattern) : 특정 url 패턴에 맞는 경로 매핑
		// permitAll() : 모든 사용자 접근
		// access() : 특정 권한을 가진 사용자 접근
		// hasRole('ROLE_XXX') : XXX 등급으로 권한 설정
	
		// 접근 제한 발생 시 이동할 url경로 설정
		httpSecurity.exceptionHandling().accessDeniedPage("/auth/accessDenied");
		
		httpSecurity.formLogin().loginPage("/auth/login") // 커스텀 로그인 url 설정
			.defaultSuccessUrl("/place/main"); // 접근 제한 설정이 되어 있지 않은 url에서 로그인 성공 시 이동할 url 설정
		
		httpSecurity.logout().logoutUrl("/auth/logout") // logout url 설정
			.logoutSuccessUrl("/place/main") // 로그아웃 성공 시 이동할 url 설정
			.invalidateHttpSession(true); // 세션 무효화
		
		// header 정보에 xssProtection 기능 설정
		// httpSecurity.headers().xssProtection().block(true);
		// httpSecurity.headers().contentSecurityPolicy("script-src 'self' https://code.jquery.com 'unsafe-inline' 'unsafe-eval'");
		
	}
	
	// 비밀번호 암호화를 위한 BCryptPasswordEncoder를 빈으로 생성
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// AuthenticationMangerBuilder 객체를 통해 인증 기능을 구성
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService()); // CustomUserDetailsService 적용
	}
	
	// 사용자 정의 로그인 클래스인 CustomUserDetailsService를 빈으로 생성
	@Bean
	public UserDetailsService userDetailsService() {
		return new CustomUserDetailsService();
	}

	// CharacterEncodingFilter 빈 생성
	@Bean
	public CharacterEncodingFilter encodingFilter() {
		return new CharacterEncodingFilter("UTF-8");
	}
	
	
} // end SecurityConfig
