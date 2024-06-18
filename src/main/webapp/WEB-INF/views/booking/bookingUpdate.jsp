<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>BookingUpdate</title>
</head>
<body>
	<h1>공간 예약</h1>
		<div>
			<input type="hidden" name="placeId" value="1">
			<p>예약 공간</p>
			<input type="text" name="placeName" value="파티룸">
		</div>
	<form id="updateform" action="bookingUpdate" method="post">
		<input type="hidden" name="bookingId" value="${bookingVO.bookingId }">
		<div>
			<p>예약 날짜</p>
			<fmt:formatDate value="${bookingVO.bookingDate }"
			pattern="yyyy-MM-dd" var="bookingDate"/>
			<input type="date" name="bookingDate" value="${bookingDate }">
			<br>
			<p>예약 인원</p>
			<input type="text" name="bookingPerson" value="${bookingVO.bookingPerson }">
		</div>
		<div>
			<p>예약자</p>
			<input type="text" name="bookingUserName" value="${bookingVO.bookingUserName }"> 
		<br>
			<p>전화번호</p>
			<input type="text" name="bookingUserPhone" value="${bookingVO.bookingUserPhone }">
		<br>
			<p>이메일</p>
			<input type="email" name="bookingUserEmail" value="${bookingVO.bookingUserEmail }">
		<br>
			<p>사용 목적</p>
			<textarea cols="120" name="bookingPerpose" 
			placeholder="공간의 사용 목적을 입력 (최대 100자)" maxlength="100">${bookingVO.bookingPerpose }</textarea>
		<br>
			<p>요청 사항</p>
			<textarea rows="20" cols="120" name="bookingContent" 
			placeholder="남기고 싶은 말을 적어주세요.(최대 500자)" maxlength="500">${bookingVO.bookingContent }</textarea>
		</div>
	</form>
		<div>
			<p>결제 금액</p>
			<input type="text" name="bookingPrice" readonly value="${bookingVO.bookingPrice }">
			<br>
		</div>
	<button id="updateBooking">수정하기</button>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#updateBooking').click(function(){
				if(confirm('수정하시겠습니까?')){
					$('#updateform').submit(); // form 데이터 전송
				}
			})
		}) // end document
	
	
	</script>
	
</body>
</html>