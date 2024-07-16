<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlaceCloud</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 30px;
    }
    .placeList {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
    }
    .wrap-btn {
        display: flex;
        justify-content: center;
        gap: 10px;
    }
    .btn-keyword {
        background-color: #f0f0f0;
        border: none;
        border-radius: 5px;
        padding: 10px;
        text-align: center;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .btn-keyword:hover {
        background-color: #ddd;
    }
    .btn-keyword img.icon {
        width: 50px;
        height: 50px;
    }
    .btn-keyword .keyword {
        margin-top: 5px;
        font-size: 1em;
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
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(document).ready(function() {
    // 버튼 클릭 시 카테고리 값을 URL 파라미터로 전달
    $('.btn-keyword').on('click', function() {
        let category = $(this).find('.category').text();
        location.href = '../place/search?placeCategory=' + encodeURIComponent(category);
    });
});
</script>
</head>
<body>
	
	<%@include file="../fix/header.jsp"%>
    
    <br><br>
	<div class="container">
		<div class="wrap-btn">
			<button class="btn-keyword">
				<img class="icon" src="../resources/image/party.png" />
				<div class="category">파티룸</div>
			</button>
			<button class="btn-keyword">
				<img class="icon" src="../resources/image/meeting.png" />
				<div class="category">회의실</div>
			</button>
			<button class="btn-keyword">
				<img class="icon" src="../resources/image/record.png" />
				<div class="category">녹음실</div>
			</button>
			<button class="btn-keyword">
				<img class="icon" src="../resources/image/studio.png" />
				<div class="category">스튜디오</div>
			</button>
			<button class="btn-keyword">
				<img class="icon" src="../resources/image/stage.png" />
				<div class="category">공연장</div>
			</button>
		</div>
		<div class="placeList">
			<c:forEach var="placeVO" items="${list}">
				<div class="placeCard" id="placeCard"
					onclick="location.href='../place/detail?placeId=' + ${placeVO.placeId}">
					<div class="placeName">${placeVO.placeName}</div>
					<div class="placeCategory">${placeVO.placeCategory}</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>
