<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>

	<h2 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">글 작성</h2>
	<form action="../review/register" method="post">
		<input type="hidden" name="placeId" id="placeId" value="${placeId }">
		<div>
			<span>제목 : </span>
			<input type="text" name="reviewTitle" placeholder="제목" maxlength="20" required>
		</div>
		<div>
			<span>작성자 : </span>
			<input type="text" name="memberEmail" value="${login.memberEmail}" readonly>
		</div>
		<div>
			<span>내용 : </span>
			<textarea rows="20" cols="120" name="reviewContent" placeholder="내용" maxlength="50" required></textarea>
		</div>
		<div>
			<input type="submit" value="리뷰 등록">
		</div>	
	</form>
</body>
</html>