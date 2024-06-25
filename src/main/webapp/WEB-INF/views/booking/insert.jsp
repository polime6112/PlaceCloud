<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>booking Insert</title>
</head>
<body>
	<h1>공간 예약</h1>
	<form action="../kakaoPay" method="post">
		<div>
			<input type="hidden" name="placeId" value="${PlaceVO.placeId }">
			<p>예약 공간</p>
			<input type="text" name="placeName" readonly value="${PlaceVO.placeName }">
			<br><br>
			<c:if test="${not empty ImageVO }">
				<img class="image" src="../image/display?imagePath=${ImageVO.imagePath }&imageChgName=${ImageVO.imageChgName}
									&imageExtension=${ImageVO.imageExtension}" alt="이미지 로딩 실패">
			</c:if>
			<br>
			<p>카테고리 : ${PlaceVO.placeCategory }</p>
			<p>주소 : ${PlaceVO.placeAddress }</p>
			<p>장소 설비 : ${PlaceVO.placeInfo }</p>
			<p>주의 사항 : ${PlaceVO.placeWarning }</p>
		</div>
		<div>
			<p>예약 날짜</p>
			<input type="date" name="bookingDate" required>
			<br>
			<p>예약 인원</p>
			<input type="text" name="bookingPerson" required>
			<span id="personValidMsg"></span>
		</div>
		<div>
			<p>예약자</p>
			<input type="text" name="bookingUserName" required> 
		<br>
			<p>전화번호</p>
			<input type="text" name="bookingUserPhone" required value="${sessionScope.login.memberPhone }">
		<br>
			<p>이메일</p>
			<input type="email" name="bookingUserEmail" readonly value="${sessionScope.login.memberEmail }">
		<br>
			<p>사용 목적</p>
			<textarea cols="120" name="bookingPerpose" 
			placeholder="공간의 사용 목적을 입력 (최대 100자)" maxlength="100"></textarea>
		<br>
			<p>요청 사항</p>
			<textarea rows="20" cols="120" name="bookingContent" 
			placeholder="남기고 싶은 말을 적어주세요.(최대 500자)" maxlength="500"></textarea>
		</div>
		<div>
			<p>결제 금액</p>
			<input type="text" name="bookingPrice" readonly value="${PlaceVO.placeMoneyTime }">
			<br>
			
			<button id="booking" type="submit" >결제하기</button>
		</div>
	</form>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			let personFlag = false; // 인원수 유효성 검사
			
			$('#booking').click(function(event){
				event.preventDefault(); // 기본 동작 취소
			})
			
		})
		
		
		
	</script>
	
	
</body>
</html>