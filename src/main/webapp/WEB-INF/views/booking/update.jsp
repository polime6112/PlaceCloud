<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>BookingUpdate</title>
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

body {
	font-family: Arial, sans-serif;
}
textarea {
        resize: none;
}
#updatebody {
	border: 2px solid #706FFF;
	width: 80%;
	max-width: 800px;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	position: relative;
	margin: 50px auto;
	background-color: #fff;
}

input[type="text"], input[type="date"], input[type="email"], textarea {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	box-sizing: border-box;
	font-size: 16px;
}

input[readonly] {
	background-color: #f1f1f1;
}

button {
	width: 100%;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	font-family: Arial, sans-serif;
}

#updateBtn {
	background-color: #4CAF50;
}

#updateBtn:hover {
	background-color: #45a049;
}

#backBtn {
	background-color: #f44336;
}

#backBtn:hover {
	background-color: #e41e1e;
}

img {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 10px 0;
}

span {
	display: block;
	margin-top: 5px;
	font-size: 0.9em;
	color: red;
}

h1 {
	text-align: center;
	font-size: 40px;
	font-weight: 900;
	color: #706FFF;
}
</style>
</head>
<header>
	<div class="logo">
		<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
	</div>
</header>
<body>
	<h1>예약 수정</h1>
	<div id="updatebody">
		<div>
			<input type="hidden" name="placeId" value="${booking.placeId }">
			<p>예약 공간</p>
			<input type="text" name="placeName" readonly value="${booking.placeName }">
		</div>
		<form id="updateform" action="update" method="post">
			<input type="hidden" name="bookingId" value="${bookingVO.bookingId }">
			<div>
				<p>예약 날짜</p>
				<fmt:formatDate value="${bookingVO.bookingDate }" pattern="yyyy-MM-dd" var="bookingDate"/>
				<input id="date" type="date" name="bookingDate" value="${bookingDate }" required>
				<span id="dateErrorMsg"></span>
				<br>
				<p>예약 인원</p>
				<input id="person" type="text" name="bookingPerson" value="${bookingVO.bookingPerson }" maxlength="3" required>
				<span id="personErrorMsg"></span>
			</div>
			<div>
				<p>예약자</p>
				<input id="name" type="text" name="bookingUserName" value="${bookingVO.bookingUserName }" required>
				<span id="nameErrorMsg"></span>
				<br>
				<p>전화번호</p>
				<input id="phone" type="text" name="bookingUserPhone" value="${bookingVO.bookingUserPhone }" maxlength="11" required>
				<span id="phoneErrorMsg"></span>
				<br>
				<p>사용 목적</p>
				<textarea cols="120" name="bookingPerpose" placeholder="공간의 사용 목적을 입력 (최대 100자)" maxlength="100">${bookingVO.bookingPerpose }</textarea>
				<br>
				<p>요청 사항</p>
				<textarea rows="20" cols="120" name="bookingContent" placeholder="남기고 싶은 말을 적어주세요.(최대 500자)" maxlength="500">${bookingVO.bookingContent }</textarea>
			</div>
			<div>
				<p>결제 금액</p>
				<input type="text" name="bookingPrice" readonly value="${bookingVO.bookingPrice }">
				<br>
			</div>
			<div style="text-align: center;">
				<button id="updateBtn">수정하기</button>
			</div>
		</form>
		<button id="backBtn">뒤로가기</button>
	</div>

	<script type="text/javascript">
	
		const today = new Date(); // 객체를 생성
		today.setHours(0, 0, 0, 0); // 오늘 날짜의 00:00:00로 설정하여 시간 부분을 제거
		// 현재 날짜를 'YYYY-MM-DD' 형식으로 변환 (로컬 시간 기준)
		const offset = today.getTimezoneOffset() * 60000; // 밀리초 단위의 타임존 오프셋 계산
		const localToday = new Date(today.getTime() - offset).toISOString().split('T')[0];
		// input 요소의 min 속성(최소값)에 현재 날짜를 설정
		document.getElementById('date').setAttribute('min', localToday);
		
		$(document).ready(function() {
			// 뒤로가기 버튼 클릭 시 이전 페이지로 이동
			$('#backBtn').click(function() {
				console.log('backBtn()');
				location.href = "../booking/detail?bookingId=${bookingVO.bookingId }"
			}); // end pageBack.click()
		})
		
		$(document).ready(function() {
			let dateFlag = true; // 날짜 유효성 검사
			let personFlag = true; // 인원수 유효성 검사
			let nameFlag = true; // 닉네임 유효성 검사
			let phoneFlag = true; // 전화번호 유효성 검사

			$('#updateBtn').click(function(event) {
				event.preventDefault(); // 기본 동작 취소
				// 각 필드에 대해 유효성 검사 함수 호출
				dateError();
				personError();
				nameError();
				phoneError();

				// 모든 유효성 검사 플래그가 true인지 확인
				if (dateFlag && personFlag && nameFlag && phoneFlag) {
					// 모든 조건이 true면 예약 수정 수행
					if(confirm('수정하시겠습니까?')){
						$('#updateform').submit(); // form 데이터 전송
					}
				} else {
					// 유효성 검사 실패 시 메시지 출력
					if (!dateFlag) {
						$('#dateErrorMsg').html('예약 날짜를 확인해주세요');
						$('#dateErrorMsg').css('color', 'red');
						$('#dateErrorMsg').css('display', 'inline-block');
					}
					if (!personFlag) {
						$('#personErrorMsg').html('예약 인원을 확인해주세요');
						$('#personErrorMsg').css('color', 'red');
						$('#personErrorMsg').css('display', 'inline-block');
					}
					if (!nameFlag) {
						$('#nameErrorMsg').html('예약자를 확인해주세요');
						$('#nameErrorMsg').css('color', 'red');
						$('#nameErrorMsg').css('display', 'inline-block');
					}
					if (!phoneFlag) {
						$('#phoneErrorMsg').html('전화번호를 확인해주세요');
						$('#phoneErrorMsg').css('color', 'red');
						$('#phoneErrorMsg').css('display', 'inline-block');
					}
				}
			}); // end booking.click()

			// 예약 날짜 유효성 검사
			$('#date').change(function() {
				dateError();

			}); // end date.keyup()

			function dateError() {
				console.log('dateKeyup()');
				let date = $('#date').val();

				if (date.trim() === '') { // 날짜가 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('날짜 입력 x');
					$('#dateErrorMsg').html('날짜를 입력하세요');
					$('#dateErrorMsg').css("color", 'red');
					$('#dateErrorMsg').css('display', 'inline-block');
					dateFlag = false;
					return;
				} else {
					$('#dateErrorMsg').html('');
					dateFlag = true;
				}
			}

			// 예약 인원 유효성 검사
			$('#person').keyup(function() {
				personError();

			}); // end person.keyup()

			function personError() {
				console.log('personKeyup()');
				let person = $('#person').val();
				let personPattern = /^[0-9]{1,3}$/;

				if (person.trim() === '') { // 인원수가 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('인원수 입력 x');
					$('#personErrorMsg').html('인원수를 입력하세요');
					$('#personErrorMsg').css("color", 'red');
					$('#personErrorMsg').css('display', 'inline-block');
					personFlag = false;
					return;
				} else if (!personPattern.test(person)) { // 유효성 검사 실패
					console.log('인원수 유효성 검사 실패');
					$('#personErrorMsg').html('유효한 인원수를 입력하세요');
					$('#personErrorMsg').css('color', 'red');
					$('#personErrorMsg').css('display', 'inline-block');
					personFlag = false;
					return;
				} else { // 유효성 검사 통과
					$('#personErrorMsg').html('');
					personFlag = true;
				}
			}

			// 예약자 이름 유효성 검사
			$('#name').keyup(function() {
				nameError();

			}); // end name.keyup()

			function nameError() {
				console.log('nameKeyup()');
				let name = $('#name').val();
				let namePattern = /^[a-zA-Z가-힣]{2,30}$/;

				if (name.trim() === '') { // 이름이 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('예약자 입력 x');
					$('#nameErrorMsg').html('예약자를 입력하세요');
					$('#nameErrorMsg').css("color", 'red');
					$('#nameErrorMsg').css('display', 'inline-block');
					nameFlag = false;
					return;
				} else if (!namePattern.test(name)) { // 유효성 검사 실패
					console.log('예약자 유효성 검사 실패');
					$('#nameErrorMsg').html('유효한 예약자를 입력하세요');
					$('#nameErrorMsg').css('color', 'red');
					$('#nameErrorMsg').css('display', 'inline-block');
					nameFlag = false;
					return;
				} else { // 유효성 검사 통과
					$('#nameErrorMsg').html('');
					nameFlag = true;
				}
			}

			// 전화번호 유효성 검사
			$('#phone').keyup(function() {
				phoneError();

			}); // end phone.keyup()

			function phoneError() {
				console.log('phoneKeyup()');
				let phone = $('#phone').val();
				let phonePattern = /^[0-9]{10,11}$/;

				if (phone.trim() === '') { // 전화번호가 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('전화번호 입력 x');
					$('#phoneErrorMsg').html('전화번호를 입력하세요');
					$('#phoneErrorMsg').css("color", 'red');
					$('#phoneErrorMsg').css('display', 'inline-block');
					phoneFlag = false;
					return;
				} else if (!phonePattern.test(phone)) { // 유효성 검사 실패
					console.log('전화번호 유효성 검사 실패');
					$('#phoneErrorMsg').html('유효한 전화번호를 입력하세요');
					$('#phoneErrorMsg').css('color', 'red');
					$('#phoneErrorMsg').css('display', 'inline-block');
					phoneFlag = false;
					return;
				} else { // 유효성 검사 통과
					$('#phoneErrorMsg').html('');
					phoneFlag = true;
				}
			}
		}); // end ready()
	</script>
</body>
</html>
