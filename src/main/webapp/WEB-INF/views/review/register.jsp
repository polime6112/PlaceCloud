<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
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

header {
	background-color: #f2f2f2;
	padding: 10px;
	text-align: center;
}

.logo a {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	text-decoration: none;
}
</style>
</head>
<body>
<%@include file="../fix/header.jsp"%>

	<h2 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">글 작성</h2>
	<form action="../review/register" method="post">
		<input type="hidden" name="placeId" id="placeId" value="${placeId }">
		<div>
			<span>제목 : </span>
			<input type="text" name="reviewTitle" placeholder="제목" maxlength="20" required>
		</div>
		<div>
			<span>작성자 : </span>
			<sec:authentication property="principal" var="principal"/>
			<input type="text" name="memberEmail" value="${principal.username}" readonly>
		</div>
		<div>
			<span>내용 : </span>
			<br><br>
			<textarea rows="20" cols="120" name="reviewContent" placeholder="내용" maxlength="50" required></textarea>
		</div>
		<div>
			<button id="register">등록</button>
		</div>	
	</form>
	
</body>
</html>