<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 이미지 등록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<style>
/* 사용자가 이미지를 드롭하는 영역 스타일 */
.placeImage {
	max-width: 500px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.imageUpload {
    width: 100%;
    height: 200px;
    border: 2px dashed grey; /* 테두리 점선 */
    margin-bottom: 20px; /* 아래 여백 */
    text-align: center; /* 텍스트 가운데 정렬 */
    line-height: 200px; /* 세로 중앙 정렬 */
    font-size: 16px; /* 글꼴 크기 */
    color: grey; /* 텍스트 색상 */
}

/* 드롭된 이미지를 출력하는 영역 스타일 */
.imageList {
    margin-top: 20px; /* 위 여백 */
    background-color: #f9f9f9; /* 배경색 */
    border: 1px solid #ddd; /* 테두리 실선 */
    padding: 5px; /* 안쪽 여백 */
    margin-bottom: 20px; /* 아래 여백 */
    height: 120px; /* 높이 */
    width: 100%; /* 너비 */
}

/* 드롭된 이미지의 스타일 */
.imageItem {
    margin-left: 10px; /* 왼쪽 여백 */
    position: relative; /* 상대 위치 */
    display: inline-block; /* 인라인 블록으로 표시 */
    margin: 4px; /* 여백 */
}
</style>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>
	<br>
	<form id="upload" action="upload" method="post" enctype="multipart/form-data">
		<input type="text" name="placeId" name="placeId" value="${placeVO.placeId }" readonly="readonly">
		<input type="file" name="image"> <input type="submit" value="업로드">
	</form>
	<script>
		$(document).ready(function() {
			// 차단할 확장자 정규식 (exe, sh, php, jsp, aspx, zip, alz)
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

				if (!allowedExtensions.exec(imageName)) { // 차단된 확장자인 경우
					alert("이 확장자의 이미지는 첨부할 수 없습니다.");
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