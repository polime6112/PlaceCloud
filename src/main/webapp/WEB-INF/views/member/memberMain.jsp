<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js">
</script>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>

	<c:if test="${empty sessionScope.login.memberEmail }">
		<a href="memberLogin">로그인</a>
	</c:if>
	<c:if test="${not empty sessionScope.login.memberEmail }">
		<a href="logout">로그아웃</a>
		<a href="myPage">마이페이지</a>
		<c:if test="${sessionScope.login.memberStatus == 'guest'}">
			<a href="${pageContext.request.contextPath}/place/mainPlace">장소 보기</a>
			<a href="${pageContext.request.contextPath}/booking/bookingList">예약 목록</a>
			<a href="${pageContext.request.contextPath}/booking/bookingInsert">예약 하기</a>
			<a href="${pageContext.request.contextPath}/review/list">리뷰</a>
		</c:if>
		<c:if test="${sessionScope.login.memberStatus == 'host' }">
			<a href="${pageContext.request.contextPath}/place/myPlace?memberEmail=${sessionScope.login.memberEmail}">내가 등록한 장소들</a>		
		</c:if>
	</c:if>
</body>
</html>