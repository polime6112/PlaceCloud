<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 등록한 장소들</title>
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
    .wrap-btn {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 30px;
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
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(document).ready(function() {
/*     // 이미지를 동적으로 추가하는 함수
    function addImageToPlaceCard(placeId, imagePath, imageChgName, imageExtension) {
        // 이미지 요소 생성
        let img = document.createElement('img');
        img.className = 'placeImage';
        img.src = '../image/display?attachPath=' + encodeURIComponent(imagePath) +
                   '&attachChgName=' + encodeURIComponent(imageChgName) +
                   '&attachExtension=' + encodeURIComponent(imageExtension);
        // 이미지를 추가할 장소 카드 요소 가져오기
        let placeCard = document.getElementById('placeCard_' + placeId);
        // 장소 카드에 이미지 요소 추가
        placeCard.appendChild(img);
    }
    
    // JSP에서 forEach로 생성된 각 placeCard에 이미지 추가하기
    <c:forEach var="imageVO" items="${imageVO}">
        addImageToPlaceCard(${imageVO.placeId}, '${imageVO.imagePath}', '${imageVO.imageChgName}', '${imageVO.imageExtension}');
    </c:forEach> */
    
    // 버튼 클릭 시 카테고리 값을 URL 파라미터로 전달
    $('.btn-keyword').on('click', function() {
        let category = $(this).find('.category').text();
        location.href = '../place/search?placeCategory=' + encodeURIComponent(category);
    });
});
</script>
</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
        </div>
    </header>
    <br><br>
    <input type="hidden" id="memberEmail" value="${sessionScope.login.memberEmail}">
    <div class="placeList">
        <div class="wrap-btn">
            <button class="btn-keyword">
                <img class="icon" src="../resources/image/party.png"/>
                <div class="category">파티룸</div>
            </button>
            <button class="btn-keyword">
                <img class="icon" src="../resources/image/meeting.png"/>
                <div class="category">회의실</div>
            </button>
            <button class="btn-keyword">
                <img class="icon" src="../resources/image/record.png"/>
                <div class="category">녹음실</div>
            </button>
            <button class="btn-keyword">
                <img class="icon" src="../resources/image/studio.png"/>
                <div class="category">스튜디오</div>
            </button>
            <button class="btn-keyword">
                <img class="icon" src="../resources/image/stage.png"/>
                <div class="category">공연장</div>
            </button>
        </div>
        <br><br><br>
        <c:forEach var="placeVO" items="${list}">
            <div class="placeCard" id="placeCard" onclick="location.href='../place/detail?placeId=' + ${placeVO.placeId}">
                <div class="placeName">${placeVO.placeName}</div>
                <div class="placeCategory">${placeVO.placeCategory}</div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
