<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
    textarea {
    	resize: none;
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
	<%@include file="../fix/header.jsp"%>
	<br>
	<sec:authentication property="principal" var="principal"/>
	<c:if test="${principal.username == placeVO.memberEmail }">
		<button name="myPlace" onclick="location.href='../host/myPlace'">등록한 장소들</button>
	</c:if>
	<br>
	<br>	
	<input type="hidden" name="placeId" id="placeId" value="${placeVO.placeId }">
	<input type="hidden" name="memberEmail" id="memberEmail" value="${placeVO.memberEmail }">
	<fmt:formatDate value="${placeVO.placeCreateDate }" pattern="yyyy-MM-dd HH:mm:ss" var="placeCreateDate" />
	<p>작성일 : ${placeCreateDate }</p>
	장소 이름 <input type="text" id="placeName" value="${placeVO.placeName }" readonly><br>
	<br> 카테고리 <input type="text" id="placeCategory" value="${placeVO.placeCategory }" readonly><br>
	<br> 장소 설명 <input type="text" id="placeContext" value="${placeVO.placeContext }" readonly><br>
	<br> 주소 <br><br><textarea rows="4" cols="20" id="placeAddress" readonly>${placeVO.placeAddress }</textarea><br>
	<br> 주의사항<br><br> <textarea rows="4" cols="20" id="placeWarning" readonly>${placeVO.placeWarning }</textarea><br>
	<br> 장소 설비<br><br> <textarea rows="4" cols="20" id="placeInfo" readonly>${placeVO.placeInfo }</textarea><br>
	<br> 가격 <input type="text" id="placeMoneyTime" value="${placeVO.placeMoneyTime }" readonly><br>
	<br>
	<div class="image-upload">
		<div class="image-view">
			<div class="image-list">
				<!-- 이미지 파일 처리 코드 -->
				<c:forEach var="imageVO" items="${placeVO.imageList}">
				        <div class="image_item">
				        	<a href="../image/get?imageId=${imageVO.imageId }" target="_blank">
							<img src="../image/get?imageId=${imageVO.imageId }&imageExtension=${imageVO.imageExtension}"/></a>
				        </div>
				</c:forEach>
			</div>
		</div>
	</div>
	<br>
	<div>
		<c:if test="${principal.username == placeVO.memberEmail }">
			<br> <button name="update" onclick="location.href='../host/update?placeId=${placeVO.placeId}'">장소 정보 수정</button><br>
			<br> <button name="delete" onclick="location.href='../host/delete?placeId=${placeVO.placeId}'">장소 삭제</button>
		</c:if>
	</div>
</body>
</html>
