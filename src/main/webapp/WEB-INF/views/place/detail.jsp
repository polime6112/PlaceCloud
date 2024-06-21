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
<title>장소 상세정보</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
    }
    header {
        background-color: #4CAF50;
        padding: 10px 0;
        text-align: center;
    }
    .logo a {
        color: white;
        font-size: 24px;
        text-decoration: none;
    }
    .container {
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .container input[type="text"], .container textarea {
        width: calc(100% - 22px);
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        font-size: 16px;
        background-color: #f9f9f9;
    }
    .container p {
        font-size: 14px;
        color: #666;
    }
    .image-container {
        margin-top: 20px;
        text-align: center;
    }
    .image {
        max-width: 100%;
        max-height: 400px;
        border: 1px solid #ddd;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    .button-container {
        margin-top: 20px;
        text-align: center;
    }
    .button-container button, .button-container a {
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        margin: 5px;
        text-decoration: none;
        font-size: 16px;
    }
    .button-container button:hover, .button-container a:hover {
        background-color: #0056b3;
    }
    .container button, .container a {
        display: inline-block;
        padding: 10px 20px;
        margin: 5px 0;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .container button:hover, .container a:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<button name="myPlace" onclick="location.href='../place/myPlace?memberEmail=${sessionScope.login.memberEmail}'">등록한 장소들</button>
	</c:if>
	<br>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<input type="text" id="memberName" value="${placeVO.memberEmail }">
	</c:if>
	<input type="hidden" id="placeId" value="${placeVO.placeId }">
	<input type="hidden" id="memberEmail" value="${placeVO.memberEmail }">
	<fmt:formatDate value="${placeVO.placeCreateDate }" pattern="yyyy-MM-dd HH:mm:ss" var="placeCreateDate" />
	<p>작성일 : ${placeCreateDate }</p>
	장소 이름 <input type="text" id="placeName" value="${placeVO.placeName }" readonly><br>
	<br> 카테고리 <input type="text" id="placeCategory" value="${placeVO.placeCategory }" readonly><br>
	<br> 장소 설명 <input type="text" id="placeContext" value="${placeVO.placeContext }" readonly><br>
	<br> 주소 <input type="text" id="placeAddress" value="${placeVO.placeAddress }" readonly><br>
	<br> 주의사항<br><br> <textarea rows="4" cols="20" id="placeWarning" readonly>${placeVO.placeWarning }</textarea><br>
	<br> 장소 설비<br><br> <textarea rows="4" cols="20" id="placeInfo" readonly>${placeVO.placeInfo }</textarea><br>
	<br> 시간당 가격(원/시간) <input type="text" id="placeMoneyTime" value="${placeVO.placeMoneyTime }" readonly><br>
	<br>
	<c:if test="${not empty imageVO }">
		<img class="image" src="../image/display?imagePath=${imageVO.imagePath }&imageChgName=${imageVO.imageChgName}
									&imageExtension=${imageVO.imageExtension}" alt="이미지 로딩 실패">
	</c:if>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<a href="${pageContext.request.contextPath}/booking/bookingInsert?placeId=${placeVO.placeId}">예약 하기</a>
	</c:if>
	
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<br> <button name="update" onclick="location.href='../place/update?placeId=${placeVO.placeId}'">장소 정보 수정</button><br>
		<br> <button name="upload" onclick="location.href='../image/upload?placeId=${placeVO.placeId}'">장소 사진 추가</button><br>
		<br> <button name="delete" onclick="location.href='../place/delete?placeId=${placeVO.placeId}&memberEmail=${placeVO.memberEmail}'">장소 삭제</button>
	</c:if>
</body>
</html>
