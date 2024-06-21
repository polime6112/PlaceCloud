<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리별 장소</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .logo {
        text-align: center;
        margin: 20px 0;
    }
    .logo a {
        font-size: 2em;
        text-decoration: none;
        color: #333;
    }
    .placeList {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
    }
    .placeCard {
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 20px;
        width: 300px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        cursor: pointer;
        transition: transform 0.3s, box-shadow 0.3s;
    }
    .placeCard:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }
    .placeName {
        font-size: 1.5em;
        margin-bottom: 10px;
    }
    .placeCategory {
        font-size: 1.2em;
        color: #666;
    }
    .placeImage {
        width: 100%;
        height: auto;
        border-radius: 5px;
        margin-top: 10px;
    }
</style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath}/member/memberMain">PlaceCloud</a>
        </div>
    </header>
    <br><br>
    <input type="hidden" id="memberEmail" value="${sessionScope.login.memberEmail}">
    <div class="placeList">
        <c:forEach var="placeVO" items="${placeVOList}">
            <c:if test="${placeVO.placeCategory == param.placeCategory}">
                <div class="placeCard" onclick="location.href='../place/detail?placeId=' + ${placeVO.placeId}">
                    <div class="placeName">${placeVO.placeName}</div>
                    <div class="placeCategory">${placeVO.placeCategory}</div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</body>
</html>
