<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
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
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 16px;
    }
    .placeCard {
        border: 1px solid #dddddd;
        padding: 16px;
        background-color: white;
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        transition: transform 0.2s;
    }
    .placeCard:hover {
        transform: scale(1.05);
    }
    .placeName {
        font-weight: bold;
        margin-bottom: 8px;
    }
    .placeCategory {
        color: gray;
    }
</style>
<title>내가 등록한 장소들</title>
<script src="https://code.jquery.com/jquery-3.7.1.js">
</script>
</head>
<body>
	<%@include file="../fix/header.jsp"%>
	<sec:authentication property="principal" var="principal"/>
    <h2>${principal.member.memberName}의 페이지</h2>
    <input type="hidden" id="memberEmail" value="${principal.username}">
    <button name="register" onclick="location.href='../host/register'">장소 등록하기</button><br><br>
    <hr>
    <div class="placeList">
	    <c:forEach var="place" items="${List}">
	        <div class="placeCard" onclick="location.href='../host/detail?placeId=' + ${place.placeId}">
	            <div class="placeName">${place.placeName}</div>
	            <div class="placeCategory">${place.placeCategory}</div>
	        </div>
	    </c:forEach>
	</div>
</body>
</html>
