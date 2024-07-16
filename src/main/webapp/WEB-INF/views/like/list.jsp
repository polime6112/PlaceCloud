<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>My likes</title>
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

.container {
	font-family: Arial, sans-serif;
	margin: 50px auto;
	max-width: 1200px;
	padding: 0 30px;
	background-color: #f8f9fa;
}

.container h1 {
	font-size: 24px;
	color: #343a40;
	margin-bottom: 20px;
}

.userInfo {
	float: right;
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
	text-decoration: none;
}

.userInfo:hover {
	background-color: #0056b3;
}

.like-form {
	margin-bottom: 20px;
}

.like-form input[type="date"], .like-form input[type="submit"],
	.like-form select {
	padding: 8px;
	margin-right: 10px;
	border: 1px solid #ced4da;
	border-radius: 5px;
}

.like-form input[type="submit"] {
	background-color: #28a745;
	color: white;
	border: none;
	cursor: pointer;
}

.like-form input[type="submit"]:hover {
	background-color: #218838;
}

.like-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.like-item {
	background-color: #fff;
	border: 2px solid #706FFF;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	padding: 20px;
	width: calc(33.333% - 40px);
	box-sizing: border-box;
}

.like-item a {
	text-decoration: none;
	color: #007bff;
	font-size: 18px;
	display: block;
	margin-bottom: 10px;
}

.like-item a:hover {
	text-decoration: underline;
}

.like-item p {
	margin: 5px 0;
	color: #343a40;
}
</style>
</head>
<header>
	<div class="logo">
		<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
	</div>
</header>
<body>
	<div class="container">
		<h1>${member.memberName }님의 관심 장소 목록</h1>
		<button class="userInfo"
			onclick="location.href='/placecloud/member/myPage'">회원 정보</button>
		<br> <br>
		<div class="row">
			<div class="col-md-12">
				<div class="like-list">
					<c:forEach var="likeVO" items="${likeList }">
						<div class="like-item">
							<a href="../place/detail?placeId=${likeVO.placeId }">${likeVO.placeName }</a>
							<p>${likeVO.placeCategory}</p>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

