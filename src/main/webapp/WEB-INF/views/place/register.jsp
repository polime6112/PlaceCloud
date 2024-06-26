<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장소 등록 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
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
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
	color: #333;
}

h1, h2 {
	text-align: center;
	margin-top: 20px;
}

form {
	max-width: 500px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

input[type="text"], input[type="number"], button, select {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type="text"], input[type="number"] {
	height: 40px;
}

button {
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>
	<h1>장소 등록하기</h1>
	<form id="register" action="register" method="POST">
		<input type="hidden" id="memberEmail" name="memberEmail" value="${sessionScope.login.memberEmail}">
		<label for="placeName">장소 이름</label>
		<input type="text" id="placeName" name="placeName" maxlength="30" required>
		<label for="placeCategory">카테고리</label>
		<select id="placeCategory" name="placeCategory">
			<option value="옵션을 선택해주세요">옵션을 선택해주세요.</option>
			<option value="파티룸">파티룸</option>
			<option value="회의실">회의실</option>
			<option value="녹음실">녹음실</option>
			<option value="스튜디오">스튜디오</option>
			<option value="공연장">공연장</option>
		</select>
		<label for="placeContext">장소 설명</label>
		<input type="text" id="placeContext" name="placeContext" maxlength="20" required>
		<label for="placeAddress">주소 입력</label>
		<input type="text" id="placeAddress" name="placeAddress" maxlength="50" required>
		<label for="placeWarning">주의사항</label>
		<input type="text" id="placeWarning" name="placeWarning" required>
		<label for="placeInfo">장소 설비</label>
		<input type="text" id="placeInfo" name="placeInfo" required>
		<label for="placeMoneyTime">시간당 가격(원/시간)</label>
		<input type="number" id="placeMoneyTime" name="placeMoneyTime" required>
		<br><br>
		<button type="submit">등록</button>
	</form>
</body>
</html>
