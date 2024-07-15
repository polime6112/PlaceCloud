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
		<input type="text" id="postcode" placeholder="우편번호">
		<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="address" placeholder="주소"><br>
		<input type="text" id="detailAddress" placeholder="상세주소">
		<input type="text" id="extraAddress" placeholder="참고항목">
		<input type="hidden" id="placeAddress" name="placeAddress">
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

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>

	<script>
		$(document).ready(function() {
			// register 데이터 전송
			$('#registerBtn').click(function() {
				var placeName = $('#placeName').val().trim();
				var placeContext = $('#placeContext').val().trim();
				var placeWarning = $('#placeWarning').val().trim();
				var placeInfo = $('#placeInfo').val().trim();
				var placeMoneyTime = $('#placeMoneyTime').val().trim();
				var postcode = $('#postcode').val().trim();
				var address = $('#address').val().trim();
				var detailAddress = $('#detailAddress').val().trim();
				var extraAddress = $('#extraAddress').val().trim();
				var fullAddress = postcode + ' ' + address + ' ' + detailAddress + ' ' + extraAddress;
				
				if (placeName === '' || placeContext === '' || postcode === '' || address === '' || detailAddress === '' || placeWarning === '' || placeInfo === '' || placeMoneyTime === '') {
					alert("모든 사항을 작성해주세요.");
					return;
				} else {
					alert("등록되었습니다");
				}
	
				$('#placeAddress').val(fullAddress);
			
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