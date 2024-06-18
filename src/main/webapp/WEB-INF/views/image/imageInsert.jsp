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
	<form id="insertImage" method="POST">
		<input type="text" id="placeId" name="placeId" value="${placeVO.placeId }" readonly>
		<input type="hidden" id="placeName" name="placeName" value="${placeVO.placeName }" readonly>
		<div class="placeImage">
			<h2>이미지 등록하기</h2>
			<div class="imageUpload">이미지를 여기에 드래그 앤 드롭 하세요</div>
			<h2>이미지 리스트</h2>
			<div class="imageList">
			</div>
		</div>	
		<button type="submit">등록</button>
	</form>
	<script type="text/javascript">
	$(document).ready(function(){
	    let file = []; // 전역으로 파일 변수 정의
	    
	    // 이미지 업로드 및 리스트 관리 스크립트
	    $('.imageUpload').on('dragover', function(e) {
	        e.preventDefault();
	        e.stopPropagation();
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
	        file = e.originalEvent.dataTransfer.files; // 드롭된 파일 저장
	        handleFile(file[0]); // 드롭된 파일 처리
	    });
	    
	    $('#insertImage').submit(function(e) {
	        e.preventDefault();
	        if (file.length === 1 && validateImage(file[0])) {
	            // 서버로 파일을 업로드하는 Ajax 요청
	            let formData = new FormData();
	            formData.append("image", file[0]);
	            
	            var placeId = $('#placeId').val();
	            console.log("placeId : " + placeId);

	            $.ajax({
	                type: 'POST',
	                url: '/placecloud/image/imageInsert/' + placeId,
	                data: formData,
	                processData: false,
	                contentType: false,
	                success: function(response) {
	                    console.log('Image upload success:', response);
	                    window.location.href = '../place/infoPlace?placeId=' + placeId;
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
	});
	</script>
</body>
</html>