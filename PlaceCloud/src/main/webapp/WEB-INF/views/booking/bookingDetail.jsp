<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>예약 정보</title>
</head>
<body>
	<h2>예약 정보</h2>
	<p>예약 번호 : ${bookingVO.bookingId }</p>
	<div>
		<p>${bookingVO.placeName }</p>
		<fmt:formatDate value="${bookingVO.bookingDate }"
		pattern="yyyy-MM-dd" var="bookingDate"/>
		<p>예약 날짜 : ${bookingDate }</p>
		<p>예약 인원 : ${bookingVO.bookingPerson }</p>
		<p>예약자 : ${bookingVO.bookingUserName }</p>
		<p>전화번호 : ${bookingVO.bookingUserPhone }</p>
		<p>이메일 : ${bookingVO.bookingUserEmail }</p>
		<p>사용 목적</p>
		<textarea cols="120" readonly>${bookingVO.bookingPerpose }</textarea>
		<p>요청 사항</p>
		<textarea rows="20" cols="120" readonly>${bookingVO.bookingContent }</textarea>
	</div>
	<br>
	<div>
		<p>결제 금액</p>
		<p>${bookingVO.bookingPrice }원</p>
	</div>
</body>
</html>