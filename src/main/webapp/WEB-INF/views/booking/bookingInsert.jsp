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
			<input type="hidden" name="placeId" value="1">
			<p>예약 공간</p>
			<input type="text" name="placeName" value="파티룸">
		</div>
		<div>
			<p>예약 날짜</p>
			<input type="date" name="bookingDate">
			<br>
			<p>예약 인원</p>
			<input type="text" name="bookingPerson">
		</div>
		<div>
			<p>예약자</p>
			<input type="text" name="bookingUserName"> 
		<br>
			<p>전화번호</p>
			<input type="text" name="bookingUserPhone" value="${sessionScope.login.memberPhone }">
		<br>
			<p>이메일</p>
			<input type="email" name="bookingUserEmail" value="${sessionScope.login.memberEmail }">
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
			<input type="text" name="bookingPrice" value="1000">
			<br>
			
			<input type="submit" value="결제하기">
		</div>
	</form>
	
	
	
</body>
</html>