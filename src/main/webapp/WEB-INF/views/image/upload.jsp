<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 이미지 등록</title>
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
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>
	<br>
	<form id="upload" action="upload" method="post" enctype="multipart/form-data">
		<input type="text" name="placeId" value="${placeVO.placeId }" readonly="readonly">
		<input type="file" name="image"> <input type="submit" value="업로드">
	</form>
	<script>
		$(document).ready(function() {
			// 허용할 확장자 정규식 (jpg, jpeg, png, gif)
			var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;

			// 파일 전송 form validation
			$("#upload").submit(function(event) {
				var imageInput = $("input[name='image']"); // File input 요소 참조
				var image = imageInput.prop('images')[0]; // file 객체 참조
				var imageName = imageInput.val();

				if (!image) { // file이 없는 경우
					alert("이미지를 선택하세요.");
					event.preventDefault();
					return;
				}

				if (!allowedExtensions.exec(imageName)) { // 허용된 확장자가 아닌 경우
					alert("이 확장자의 파일은 첨부할 수 없습니다.");
					event.preventDefault();
					return;
				}

				var maxSize = 10 * 1024 * 1024; // 10 MB 
				if (image.size > maxSize) {
					alert("이미지 크기가 너무 큽니다. 최대 크기는 10MB입니다.");
					event.preventDefault();
				}
			});
		});
	</script>
</body>
</html>