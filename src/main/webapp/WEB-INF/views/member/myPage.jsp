<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.logo {
	text-align: center;
	margin: 20px 0;
}

.logo a {
	font-size: 2em;
	text-decoration: none;
	color: #333;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

#myInfoContainer {
	border: 1px solid #706FFF;
	width: 40%;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	background-color: #fff;
	margin: 100px auto;
}

h1 {
	text-align: center;
	font-size: 40px;
	font-weight: 900;
	color: #706FFF;
}

label {
	display: block;
	margin-top: 10px;
	font-weight: bold;
	text-align: left;
}

input[type="text"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	box-sizing: border-box;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f9f9f9;
	text-align: left;
}

button, input[type="submit"] {
	width: 100%;
	background-color: #FFD700;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	font-family: Arial, sans-serif;
}

button:hover, input[type="submit"]:hover {
	background-color: #e6c300;
}

.image {
	display: block;
	margin: 20px auto;
	border-radius: 50%;
	width: 150px;
	height: 150px;
	object-fit: cover;
}

form {
	margin-top: 20px;
	text-align: left;
}

</style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
        </div>
    </header>

  
    <div id="myInfoContainer">
        <form id="myInfo">
    		<h1 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">마이페이지</h1>
            <label for="email">이메일:</label> <input type="text" id="memberEmail"
                name="memberEmail" value="${member.memberEmail}" readonly><br>

            <label for="name">닉네임:</label> <input type="text" id="memberName"
                name="memberName" value="${member.memberName}" readonly><br>

            <label for="phone">전화번호:</label> <input type="text" id="memberPhone"
                name="memberPhone" value="${member.memberPhone}" readonly><br>
        </form>
        <c:if test="${not empty profileVO }">
	        <img class="image" src="../profile/display?profilePath=${profileVO.profilePath}&profileChgName=${profileVO.profileChgName}&profileExtension=${profileVO.profileExtension}"
	        						 alt="프로필 사진을 추가해주세요">
	        <form id="delete" action="../profile/delete" method="GET">
	        	<input type="hidden" name="memberEmail" id="memberEmail" value="${member.memberEmail }" readonly>
	        	<button>프로필 사진 삭제</button>
	        </form>
        </c:if>
		<c:if test="${empty profileVO }">
			<button name="upload" onclick="location.href='../profile/upload?memberEmail=${member.memberEmail}'">
			프로필 사진 등록
			</button>
		</c:if>
		
		<button id="bookingList" onclick="location.href='../booking/list'">예약 목록</button>
		
        <form id="updateForm" action="updateInfo" method="get">
            <input type="submit" value="정보 변경">
        </form>

        <form id="deleteForm" action="remove" method="get">
            <button id="removeBtn" type="submit">회원 탈퇴</button>
        </form>
        
        
    </div>

</body>
</html>
