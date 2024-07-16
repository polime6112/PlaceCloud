<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
            
            <!-- 이메일  -->
            <label for="email">이메일:</label> 
            <input type="text" id="memberEmail"
                name="memberEmail" value="${member.memberEmail}" readonly><br>
			
			<!-- 닉네임  -->
            <label for="name">닉네임:</label> <input type="text" id="memberName"
                name="memberName" value="${member.memberName}" readonly><br>
			
			<!-- 전화번호  -->
            <label for="phone">전화번호:</label> <input type="text" id="memberPhone"
                name="memberPhone" value="${member.memberPhone}" readonly><br>
        </form>
        
        <!-- 프로필 이미지  -->
	    <img class="image" src="../profile/get?memberEmail=${member.memberEmail}&profileExtension=${member.profileExtension}"
				alt="프로필 사진을 추가해주세요">
				
		<!-- 찜 목록  -->
		<button id="likeList" onclick="location.href='../like/list'">관심 장소 목록</button>
		<!-- 예약 목록 -->
		<button id="bookingList" onclick="location.href='../booking/list'">예약 목록</button>
		<!-- 회원 정보 수정  -->      
       	<button id="modifyMember" onclick="location.href='../member/updateInfo'">정보 수정</button>
       	<!-- 회원 탈퇴  -->
       	<button id="removeBtn" onclick="location.href='../member/remove'">회원 탈퇴</button>

    </div>
      
</body>
</html>
