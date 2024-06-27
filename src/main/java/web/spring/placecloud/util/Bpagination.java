package web.spring.placecloud.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 페이지 번호와 페이지 사이즈를 바탕으로 시작 번호와 끝 번호를 생성해주는 클래스
@Getter
@Setter
@ToString
public class Bpagination {
	private int pageNum; // 현재 페이지 번호
	private int pageSize; // 현재 페이지 사이즈
	private String type; // 검색 항목
	private String keyword; // 검색 키워드
	
	private String userEmail; // 로그인 계정
	private String startDate; // 시작 날짜
	private String endDate; // 끝 날짜

	public Bpagination() {
		this.pageNum = 1; // 기본 페이지 번호 설정
		this.pageSize = 6; // 기본 페이지 사이즈 설정
		this.startDate = ""; // 기본 시작 날짜 설정
		this.endDate = ""; // 기본 끝 날짜 설정
	}

	public Bpagination(int page, int pageSize, String userEmail, String startDate, String endDate) {
		this.pageNum = page;
		this.pageSize = pageSize;
		this.userEmail = userEmail;
		this.startDate = startDate;
		this.endDate = endDate;		
	}

	// 선택된 페이지의 시작 글 일련번호(rn) - #{start}
	public int getStart() {// 이게 룰 앞 소문자 Start
		return (this.pageNum - 1) * this.pageSize + 1;
	}

	// 선택된 페이지의 마지막 글 일련번호(rn) - #{end}
	public int getEnd() {
		return this.pageNum * this.pageSize;
	}

} // end Pagination
