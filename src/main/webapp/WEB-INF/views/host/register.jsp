<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장소 등록 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/image.css">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
	color: #333;
	display: flex;
	flex-direction: column;
	align-items: center;
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

h1 {
	text-align: center;
	margin-top: 20px;
}

form {
	width: 90%;
	max-width: 500px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	gap: 10px;
}

input[type="text"], input[type="number"], textarea, select{
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

textarea {
	resize: vertical;
}

.registerBtn{
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
	border: none;
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
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
	<sec:authentication property="principal" var="principal"/>
	<form id="register" action="register" method="POST">
		<input type="hidden" id="memberEmail" name="memberEmail" value="${principal.username}">
		<label for="placeName">장소 이름</label>
		<input type="text" id="placeName" name="placeName" maxlength="30">
		<label for="placeCategory">카테고리</label>
		<select id="placeCategory" name="placeCategory">
			<option value="">옵션을 선택해주세요.</option>
			<option value="파티룸">파티룸</option>
			<option value="회의실">회의실</option>
			<option value="녹음실">녹음실</option>
			<option value="스튜디오">스튜디오</option>
			<option value="공연장">공연장</option>
		</select>
		<!-- 한 프로젝트 안에서 통일성을 주기 위해 javaScript로 required를 빼고 입력하지 않았을 때 주의 문구 띄우기 -->
		<label for="placeContext">장소 설명</label>
		<textarea rows="4" id="placeContext" name="placeContext" maxlength="100"></textarea>
		<label for="placeAddress">주소 입력</label>
		<input type="text" id="placeAddress" name="placeAddress" maxlength="50">
		<label for="placeWarning">주의사항</label>
		<textarea rows="4" id="placeWarning" name="placeWarning" maxlength="100"></textarea>
		<label for="placeInfo">장소 설비</label>
		<textarea rows="4" id="placeInfo" name="placeInfo" maxlength="100"></textarea>
		<label for="placeMoneyTime">시간당 가격(원/시간)</label>
		<input type="number" id="placeMoneyTime" name="placeMoneyTime">
	</form>
	<div class="image-upload">
		<h2>이미지 파일 업로드</h2>
		<p>* 이미지 파일은 1개만 가능합니다.</p>
		<p>* 최대 용량은 10MB 입니다.</p>
		<div class="image-drop"></div>
		<h2>선택한 이미지 파일 :</h2>
		<div class="image-list"></div>
	</div>
	
	<div class="imageVOImg-list">
	</div>
	
	<button id="registerBtn">등록</button>
	<script>
		$(document).ready(function() {
			// register 데이터 전송
			$('#registerBtn').click(function() {
				var placeName = $('#placeName').val().trim(); // 문자열의 양끝 공백 제거
				var placeContext = $('#placeContext').val().trim();
				var placeAddress = $('#placeAddress').val().trim();
				var placeWarning = $('#placeWarning').val().trim();
				var placeInfo = $('#placeInfo').val().trim();
				var placeMoneyTime = $('#placeMoneyTime').val().trim();
 				
				if (placeName === '' || placeContext === '' || placeAddress === ''
						|| placeWarning === '' || placeInfo === '' || placeMoneyTime === '') {
					alert("모든 사항을 작성해주세요.");
					return;
				} else {
					alert("등록되었습니다");
				}
				
				// form 객체 참조
				var register = $('#register');

				var imageVO = JSON.parse($('.imageVOImg-list input').val());
				console.log(imageVO);
				
				var inputPath = $('<input>').attr('type', 'hidden')
				.attr('name', 'imagePath');
				inputPath.val(imageVO.imagePath);
				
				var inputRealName = $('<input>').attr('type', 'hidden')
				.attr('name', 'imageRealName');
				inputRealName.val(imageVO.imageRealName);
				
				var inputChgName = $('<input>').attr('type', 'hidden')
				.attr('name', 'imageChgName');
				inputChgName.val(imageVO.imageChgName);
				
				var inputExtension = $('<input>').attr('type', 'hidden')
				.attr('name', 'imageExtension');
				inputExtension.val(imageVO.imageExtension);
				
				register.append(inputPath);
				register.append(inputRealName);
				register.append(inputChgName);
				register.append(inputExtension);
				
				register.submit();
			});
		});
	</script>
	<script src="${pageContext.request.contextPath }/resources/js/image.js">
	</script>
</body>
</html>