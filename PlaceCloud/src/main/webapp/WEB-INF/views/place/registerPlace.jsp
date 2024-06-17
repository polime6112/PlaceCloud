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

form, .placeImage {
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

/* 사용자가 이미지를 드롭하는 영역 스타일 */
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
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>
	<h1>장소 등록하기</h1>
	<form id="registerPlace" method="POST">
		<input type="hidden" id="memberEmail" name="memberEmail" value="${sessionScope.login.memberEmail}">
		<label for="placeName">장소 이름</label>
		<input type="text" id="placeName" name="placeName" required>
		<label for="placeCategory">카테고리</label>
		<select id="placeCategory" name="placeCategory">
			<option value="옵션을 선택해주세요">옵션을 선택해주세요.</option>
			<option value="파티룸">파티룸</option>
			<option value="회의실">회의실</option>
			<option value="연습실">연습실</option>
			<option value="스튜디오">스튜디오</option>
			<option value="운동시설">운동시설</option>
			<option value="공연장">공연장</option>
		</select>
		<label for="placeContext">장소 설명</label>
		<input type="text" id="placeContext" name="placeContext" required>
		<label for="placeAddress">주소 입력</label>
		<input type="text" id="placeAddress" name="placeAddress" required>
		<label for="placeWarning">주의사항</label>
		<input type="text" id="placeWarning" name="placeWarning" required>
		<label for="placeInfo">장소 설비</label>
		<input type="text" id="placeInfo" name="placeInfo" required>
		<label for="placeMoneyTime">시간당 가격(원/시간)</label>
		<input type="number" id="placeMoneyTime" name="placeMoneyTime" required>
		<label for="placeMoneyPackage">패키지당 가격(원)</label>
		<input type="number" id="placeMoneyPackage" name="placeMoneyPackage" required>
		<br><br>
		<button type="submit">등록</button>
	</form>
	<!-- <hr>
	<div class="placeImage">
		<h2>이미지 등록하기</h2>
		<div class="imageUpload">이미지를 여기에 드래그 앤 드롭 하세요</div>
		<h2>이미지 리스트</h2>
		<div class="imageList">
		</div>
	</div>
	<div class="attachImageList"></div>
	<script type="text/javascript">
		$(document).ready(function(){
			// 이미지 업로드 및 리스트 관리 스크립트 추가
			$('.imageUpload').on('dragover', function(e) {
				e.preventDefault(); // preventDefault : 일정 태그 및 위치에 대한 동작들을 중단
				e.stopPropagation(); // stopPropagation : 상위 엘리먼트까지 영향이 가지 않게 이벤트 중단
				$(this).css('border-color', 'blue');
			});
	
			$('.imageUpload').on('dragleave', function(e) {
				e.preventDefault();
				e.stopPropagation();
				$(this).css('border-color', 'grey');
			});
	
			$('.imageUpload').on('drop', function(e) {
			    e.preventDefault();
			    e.stopPropagation();
			    $(this).css('border-color', 'grey');

			    let files = e.originalEvent.dataTransfer.files;
			    if (files.length === 1 && validateImage(files[0])) {
			        handleFile(files[0]);

			        // Ajax를 사용하여 서버로 파일을 업로드
			        let formData = new FormData();
			        formData.append("image", files[0]); 

			        $.ajax({
			            type: 'POST',
			            url: '../placeImage/imageInsert',
			            data: formData,
			            processData: false,
			            contentType: false,
			            success: function(response) {
			                console.log('Image upload success:', response);
			            },
			            error: function(xhr, status, error) {
			                console.error('Image upload failed:', error);
			                console.error('Response:', xhr.responseText);
			            }
			        });
			    } else {
			        alert("파일은 최대 1개만 업로드할 수 있습니다.");
			    }
			});

			function validateImage(file) {
			    let maxSize = 10 * 1024 * 1024; // 10 MB
			    let allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;

			    if (file.size > maxSize) {
			        alert("파일의 최대 크기는 10MB입니다.");
			        return false;
			    }

			    if (!allowedExtensions.exec(file.name)) {
			        alert("업로드할 수 없는 파일 형식입니다. jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			        return false;
			    }
			    return true;
			}

			function handleFile(file) {
			    let imageList = $('.imageList');
			    imageList.empty(); // 기존 이미지 초기화

			    let reader = new FileReader();

			    reader.onload = function(e) {
			        let img = $('<img>').attr('src', e.target.result).css({
			            'height': '100px',
			            'margin': '5px'
			        });
			        let imageItem = $('<div>').addClass('imageItem').append(img);
			        imageList.append(imageItem);
			    }
			    reader.readAsDataURL(file);
			}
	
			$('#registerPlace').submit(function(e) {
                e.preventDefault();
                // 추가된 폼 데이터 처리
                let formData = new FormData(this);
                $.ajax({
                    type: 'POST',
                    url: '/place/registerPlace',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        alert('폼이 제출되었습니다!');
                    },
                    error: function(xhr, status, error) {
                        console.error('Form submission failed:', error);
                        console.error('Response:', xhr.responseText);
                    }
                });
            });
		});
	</script> -->
</body>
</html>
