<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 등록한 장소들</title>
<style>
	.wrap-btn {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
		gap: 32px;
	}
	
	.btn-keyword {
		padding: 16px;
		background-color: white;
		cursor: pointer;
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
<script src="https://code.jquery.com/jquery-3.7.1.js">
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
    <div class="wrap-btn">
	    <button class="btn-keyword" onclick="location.href='../place/searchPlace?placeCategory=' + ${keyword }">
	    	<img class="icon" src="/placecloud/resources/image/party.png"/>
	    	<div class="keyword">파티룸</div>
	    </button>
	    <button class="btn-keyword" onclick="location.href='../place/searchPlace?placeCategory=' + ${keyword }">
	    	<img class="icon" src="/placecloud/resources/image/meeting.png"/>
	    	<div class="keyword">회의실</div>
	    </button>
	    <button class="btn-keyword" onclick="location.href='../place/searchPlace?placeCategory=' + ${keyword }">
	    	<img class="icon" src="/placecloud/resources/image/record.png"/>
	    	<div class="keyword">녹음실</div>
	    </button>
	    <button class="btn-keyword" onclick="location.href='../place/searchPlace?placeCategory=' + ${keyword }">
	    	<img class="icon" src="/placecloud/resources/image/studio.png"/>
	    	<div class="keyword">스튜디오</div>
	    </button>
	    <button class="btn-keyword" onclick="location.href='../place/searchPlace?placeCategory=' + ${keyword }">
	    	<img class="icon" src="/placecloud/resources/image/stage.png"/>
	    	<div class="keyword">공연장</div>
	    </button>
    </div>
    <br><br><br>
    <div class="placeList">
	    <c:forEach var="place" items="${List}">
	        <div class="placeCard" onclick="location.href='../place/infoPlace?placeId=' + ${place.placeId}">
	        	<%-- <div class="placeImage">${place.placeImage }</div> --%>
	            <div class="placeName">${place.placeName}</div>
	            <div class="placeCategory">${place.placeCategory}</div>
	        </div>
	    </c:forEach>
	</div>
</body>
</html>
