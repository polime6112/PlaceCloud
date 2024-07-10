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
	<form id="register" action="register" method="POST">
		<input type="hidden" id="memberEmail" name="memberEmail" value="${sessionScope.login.memberEmail}">
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
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/image.js"></script> --%>
	
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
			
			function validateImages(files){
				var maxSize = 10 * 1024 * 1024; // 10 MB 
				var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i; 
				// 허용된 확장자 정규식 (jpg, jpeg, png, gif)
				
				if(files.length > 1) { // 파일 개수 제한
					alert("파일은 최대 1개만 가능합니다.");
					return false;
				}
				
				for(var i = 0; i < files.length; i++) {
					console.log(files[i]);
					var fileName = files[i].name; // 파일 이름
					var fileSize = files[i].size; // 파일 크기
					
					// 파일 크기가 설정 크기보다 크면
					if (fileSize > maxSize) {
						alert("파일의 최대 크기는 10MB입니다.");
						return false;
					}
					
					// regExp.exec(string) : 지정된 문자열에서 정규식을 사용하여 일치 항목 확인
					// 지정된 문자열이 없는 경우 true를 리턴
			        if(!allowedExtensions.exec(fileName)) {
			            alert("이 파일은 업로드할 수 없습니다. jpg, jpeg, png, gif파일만 가능합니다."); // 알림 표시
			            return false;
			        }
				}

				return true; // 모든 조건을 만족하면 true 리턴
			} // end validateImage()
			
			// 파일을 끌어다 놓을 때(drag&drop)
			// 브라우저가 파일을 자동으로 열어주는 기능을 막음
			$('.image-drop').on('dragenter dragover', function(event){
				event.preventDefault();
				console.log('drag 테스트');
			}); 
			
			$('.image-drop').on('drop', function(event){
				event.preventDefault();
				console.log('drop 테스트');
				
				$('.imageVOImg-list').empty(); // 기존 이미지 vo 초기화

				// 드래그한 파일 정보를 갖고 있는 객체
				var files = event.originalEvent.dataTransfer.files;
				console.log(files);
				
				if(!validateImages(files)) { 
					return;
				}
				
				// Ajax를 이용하여 서버로 파일을 업로드
				// multipart/form-data 타입으로 파일을 업로드하는 객체
				var formData = new FormData();

				for(var i = 0; i < files.length; i++) {
					formData.append("files", files[i]); 
				}
						
				$.ajax({
					type : 'post', 
					url : '../image', 
					data : formData,
					processData : false,
					contentType : false,
					success : function(data) {
						console.log(data);
						var list = '';
						$(data).each(function(){
							// this : 컬렉션의 각 인덱스 데이터를 의미
							console.log(this);
						  	var imageVO = this; // imageVO 저장
						  	// encodeURIComponent() : 문자열에 포함된 특수 기호를 UTF-8로 
						  	// 인코딩하여 이스케이프시퀀스로 변경하는 함수 
							var imagePath = encodeURIComponent(this.imagePath);
							
							// input 태그 생성 
							// - type = hidden
							// - name = imageVO
							// - data-chgName = imageVO.imageChgName
							var input = $('<input>').attr('type', 'hidden')
								.attr('name', 'imageVO')
								.attr('data-chgName', imageVO.imageChgName);
							
							// imageVO를 JSON 데이터로 변경
							// - object 형태는 데이터 인식 불가능
							input.val(JSON.stringify(imageVO));
							
				       		// div에 input 태그 추가
				        	$('.imageVOImg-list').append(input);
						  	
						    // display() 메서드에서 이미지 호출을 위한 문자열 구성
						    list += '<div class="image_item" data-chgName="'+ this.imageChgName +'">'
						    	+ '<pre>'
						    	+ '<input type="hidden" id="imagePath" value="'+ this.imagePath +'">'
						    	+ '<input type="hidden" id="imageChgName" value="'+ imageVO.imageChgName +'">'
						    	+ '<input type="hidden" id="imageExtension" value="'+ imageVO.imageExtension +'">'
						        + '<a href="../image/display?imagePath=' + imagePath + '&imageChgName='
						        + imageVO.imageChgName + "&imageExtension=" + imageVO.imageExtension
						        + '" target="_blank">'
						        + '<img width="100px" height="100px" src="../image/display?imagePath=' 
						        + imagePath + '&imageChgName='
						        + 't_' + imageVO.imageChgName 
						        + "&imageExtension=" + imageVO.imageExtension
						        + '" />'
						        + '</a>'
						        + '<button class="image_delete" >x</button>'
						        + '</pre>'
						        + '</div>';
						}); // end each()

						// list 문자열 image-list div 태그에 적용
						$('.image-list').html(list);
					} // end success
				
				}); // end $.ajax()
				
			}); // end image-drop()
						
			
			$('.image-list').on('click', '.image_item .image_delete', function(){
				console.log(this);
				if(!confirm('삭제하시겠습니까?')) {
					return;
				}
				var imagePath = $(this).prevAll('#imagePath').val();
				var imageChgName = $(this).prevAll('#imageChgName').val();
				var imageExtension= $(this).prevAll('#imageExtension').val();
				console.log(imagePath);
				
				// ajax 요청
				$.ajax({
					type : 'POST', 
					url : '../image/delete', 
					data : {
						imagePath : imagePath, 
						imageChgName : imageChgName,
						imageExtension: imageExtension
					}, 
					success : function(result) {
						console.log(result);
						if(result == 1) {
							$('.image-list').find('div')
						    .filter(function() {
						    	// data-chgName이 선택된 파일 이름과 같은 경우
						        return $(this).attr('data-chgName') === imageChgName;
						    })
						    .remove();
						    
						    $('.imageVOImg-list').find('input')
						    .filter(function() {
						    	// data-chgName이 삭제 선택된 파일 이름과 같은 경우
						        return $(this).attr('data-chgName') === imageChgName;
						    })
						    .remove();

						}

					}
				}); // end ajax()
				
			}); // end image-list.on()
			
		}); // end document
	</script>
</body>
</html>