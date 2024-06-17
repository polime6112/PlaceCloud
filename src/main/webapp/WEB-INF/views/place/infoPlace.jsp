<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 상세정보</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<button name="mainPlace" onclick="location.href='../place/myPlace?memberEmail=${sessionScope.login.memberEmail}'">등록한 장소들</button>
	</c:if>
	<br>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<input type="text" id="memberName" value="">
	</c:if>
	<input type="hidden" id="memberEmail" value="${placeVO.memberEmail }">
	<fmt:formatDate value="${placeVO.placeCreateDate }" pattern="yyyy-MM-dd HH:mm:ss" var="placeCreateDate" />
	<p>작성일 : ${placeCreateDate }</p>
	장소 이름 <input type="text" id="placeName" value="${placeVO.placeName }" readonly><br>
	<br> 카테고리 <input type="text" id="placeCategory" value="${placeVO.placeCategory }" readonly><br>
	<br> 장소 설명 <input type="text" id="placeContext" value="${placeVO.placeContext }" readonly><br>
	<br> 주소 <input type="text" id="placeAddress" value="${placeVO.placeAddress }" readonly><br>
	<br> 주의사항 <input type="text" id="placeWarning" value="${placeVO.placeWarning }" readonly><br>
	<br> 장소 설비 <input type="text" id="placeInfo" value="${placeVO.placeInfo }" readonly><br>
	<br> 시간당 가격(원/시간) <input type="text" id="placeMoneyTime" value="${placeVO.placeMoneyTime }" readonly><br>
<%-- 	<br>
	<%
	    int placeId = (int) request.getAttribute("placeVO.placeId");
	%>
	<img src="<%= ImageUploadUtil.makePath(placeId) %>"> --%>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<a href="${pageContext.request.contextPath}/booking/bookingInsert">예약 하기</a>
	</c:if>
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<br> <button name="updatePlace" onclick="location.href='../place/updatePlace?placeId=${placeVO.placeId}'">장소 정보 수정</button><br>
		<br> <button name="imageInsert" onclick="location.href='../image/imageInsert?placeId=${placeVO.placeId}'">장소 사진 추가</button><br>
		<br> <button name="deletePlace" onclick="location.href='../place/deletePlace?placeId=${placeVO.placeId}&memberEmail=${placeVO.memberEmail}'">장소 삭제</button>
	</c:if>
</body>
</html>