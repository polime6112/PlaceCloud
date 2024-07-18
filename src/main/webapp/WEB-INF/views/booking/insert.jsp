<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>공간 예약</title>
<style>
body {
	font-family: Arial, sans-serif;
}
textarea {
        resize: none;
}
#insertbody {
	border: 2px solid #706FFF; /* 테두리 두께와 색상 설정 */
	width: 80%; /* 원하는 너비로 조정, 필요에 따라 변경 */
	max-width: 800px; /* 최대 너비 설정 */
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

#payBtn {
	background-color: #FFD700;
}

#payBtn:hover {
	background-color: #f3e85a;
}

#backBtn {
	background-color: #f44336;
}

#backBtn:hover {
	background-color: #b32d2d;
}

.image-container {
    margin-top: 20px;
    text-align: center;
}

.image {
    width: 100%;
    max-height: 400px;
    border: 1px solid #ddd;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
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
<%@include file="../fix/header.jsp"%>
<body>
	<h1>공간 예약</h1>
	<div id="insertbody">
		<form id="insertform" action="../ready" method="get">
			<div>
				<input type="hidden" name="placeId" value="${placeVO.placeId }">
				<p>예약 공간</p>
				<input type="text" id="placeName" name="placeName" readonly value="${placeVO.placeName }"> <br> <br>
				<div class="image-upload">
					<div class="image-view">
						<div class="image-list">
							<!-- 이미지 파일 처리 코드 -->
							<c:forEach var="imageVO" items="${placeVO.imageList}">
							        <div class="image_item">
							        	<a href="../image/get?imageId=${imageVO.imageId }" target="_blank">
										<img src="../image/get?imageId=${imageVO.imageId }&imageExtension=${imageVO.imageExtension}"/></a>
							        </div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br>
				<p>카테고리 : ${placeVO.placeCategory }</p>
				<p>주소 : ${placeVO.placeAddress }</p>
				<p>장소 설비 : ${placeVO.placeInfo }</p>
				<p>주의 사항 : ${placeVO.placeWarning }</p>
			</div>
			<div>
				<p>예약 날짜(필수)</p>
				<input id="date" type="date" name="bookingDate" required> 
				<span id="dateErrorMsg"></span> <br>
				<p>예약 인원(필수)</p>
				<input id="person" type="text" name="bookingPerson" maxlength="3" required>
				<span id="personErrorMsg"></span>
			</div>
			<div>
				<sec:authentication property="principal" var="principal"/>
				<p>예약자(필수)</p>
				<input id="name" type="text" name="bookingUserName" required>
				<span id="nameErrorMsg"></span> <br>
				<p>전화번호(필수)</p>
				<input id="phone" type="text" name="bookingUserPhone" maxlength="11"
					placeholder="(-)을 제외하고 입력해주세요." required value="${principal.member.memberPhone }"> 
					<span id="phoneErrorMsg"></span> <br>
				<p>이메일</p>
				<input id="email" type="email" id="bookingEmail" name="bookingUserEmail" readonly
					value="${principal.member.memberEmail }"> <br>
				<p>사용 목적(선택)</p>
				<textarea cols="120" name="bookingPerpose"
					placeholder="공간의 사용 목적을 입력 (최대 100자)" maxlength="100"></textarea>
				<br>
				<p>요청 사항(선택)</p>
				<textarea rows="20" cols="120" name="bookingContent"
					placeholder="남기고 싶은 말을 적어주세요.(최대 500자)" maxlength="500"></textarea>
			</div>
			<div>
				<p>결제 금액</p>
				<input type="text" name="bookingPrice" readonly
					value="${placeVO.placeMoneyTime }"> <br>
			</div>
			<div style="text-align: center;">
				<button id="payBtn">결제하기</button>
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
				location.href = "../place/detail?placeId=${placeVO.placeId }"
			}); // end pageBack.click()
		})

		$(document).ready(function() {
			let dateFlag = false; // 날짜 유효성 검사
			let personFlag = false; // 인원수 유효성 검사
			let nameFlag = false; // 닉네임 유효성 검사
			let phoneFlag = true; // 전화번호 유효성 검사

			
			$('#payBtn').click(function(event) {
				event.preventDefault(); // 기본 동작 취소
				// 각 필드에 대해 유효성 검사 함수 호출
				bookingDateError();
				personError();
				nameError();
				phoneError();

				// 모든 유효성 검사 플래그가 true인지 확인
				if (dateFlag && personFlag && nameFlag && phoneFlag) {
					// 모든 조건이 true면 회원가입 수행
					$('#insertform').submit(); // 폼 제출
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
				bookingDateError();
				dateError();

			}); // end date.keyup()
			
			/* $('#date').focusout(function() {
				dateError()
			}); */
			
			function bookingDateError() {
				console.log('dateChange()');
				let date = $('#date').val();
				let placeName = $('#placeName').val();
				console.log('date : ' + date + ' / placeName : ' + placeName);
				
				let url = '../booking/selectDate/' + date + '/' + placeName;
				console.log('url : ' + url);
				
				$.getJSON(
					url,
					function(data) {
						console.log('data : ' + data);
						if(data != '') {
							$('#dateErrorMsg').html('해당 날짜는 이미 예약이 찼습니다. 다른 날짜를 선택하세요.');
							$('#dateErrorMsg').css('color', 'red');
							$('#dateErrorMsg').css('display', 'inline-block');
							dateFlag = false;
							return;
						}
					}
				)
			}
			
			function dateError() {
				console.log('dateChange()');
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
				// 숫자 정규 표현식(2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성)
				let personRegex = /^[0-9]{1,3}$/;

				if (person.trim() === '') { // 예약 인원이 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('인원수 입력 x');
					personFlag = false;
					return;
				} else if (person.trim() === '0') {
					console.log('0명 입력 x');
					$('#personErrorMsg').html('최소 예약 인원은 1명입니다');
					$('#personErrorMsg').css("color", 'red');
					$('#personErrorMsg').css('display', 'inline-block');
					personFlag = false;
				} else if (person > 200) {
					console.log('최대 입력 인원 초과');
					$('#personErrorMsg').html('최대 입력 인원은 200명입니다');
					$('#personErrorMsg').css("color", 'red');
					$('#personErrorMsg').css('display', 'inline-block');
					personFlag = false;
				} else {
					$('#personErrorMsg').html('');
					personFlag = true;
				}

				$('#person').focusout(function() {
					personFocusOut();
				});

				function personFocusOut() {
					console.log('personFocusOut()');
					let person = $('#person').val();
					// 숫자 정규 표현식(2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성)
					let personRegex = /^[0-9]{1,3}$/;
					if (!personRegex.test(person)) { // 숫자 정규 표현식 검사
						console.log('숫자 형식');
						$('#personErrorMsg').html('숫자만 입력가능합니다');
						$('#personErrorMsg').css('color', 'red');
						$('#personErrorMsg').css('display', 'inline-block');
						personFlag = false;
					} else {
						personFlag = true;
					}
				}

			} // end personError()

			// 예약자 유효성 검사
			$('#name').keyup(function() {
				nameError();

			}); // end name.keyup()

			function nameError() {
				console.log('nameKeyup()');
				let name = $('#name').val();

				if (name.trim() === '') { // 이름이 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('이름 입력 x');
					$('#nameErrorMsg').html('');
					nameFlag = false;
					return;
				} else {
					$('#nameErrorMsg').html('');
					nameFlag = true;
				}

				$('#name').focusout(function() {
					nameFocusOut();
				});

				function nameFocusOut() {
					console.log('nameFocusOut()');
					let name = $('#name').val();
					// 예약자 이름 정규 표현식(2자 이상 10자이하 영어 또는 2자 ~ 4자 한글로 구성)
					let nameRegex = /^([가-힣]{2,4}|[a-zA-Z]{1,20})$/;

					if (!nameRegex.test(name)) { // 한글, 영어 정규 표현식 검사
						console.log('이름 형식');
						$('#nameErrorMsg').html('이름을 확인해주세요(예: 홍길동)');
						$('#nameErrorMsg').css('color', 'red');
						$('#nameErrorMsg').css('display', 'inline-block');
						nameFlag = false;
					} else {
						nameFlag = true;
					}
				}

			} // end nameError()

			// 전화번호 유효성 검사
			$('#phone').keyup(function() {
				phoneError();

			}); // end phone.keyup()

			function phoneError() {
				console.log('phoneKeyup()');
				let phone = $('#phone').val();

				if (phone.trim() === '') { // 전화번호가 입력 되지 않은 경우 또는 공백만 입력된 경우
					console.log('전화번호 입력 x');
					phoneFlag = false;
					return;
				} else {
					$('#phoneErrorMsg').html('');
				}

				$('#phone').focusout(function() {
					phoneFocusOut();
				});

				function phoneFocusOut() {
					console.log('phoneFocusOut()');
					let phone = $('#phone').val();
					// 전화번호 정규 표현식
					let phoneRegex = /^010\d{4}\d{4}$/;
					if (!phoneRegex.test(phone)) { // 전화번호 정규 표현식 검사
						console.log('전화번호 형식');
						$('#phoneErrorMsg').html('전화번호를 확인해주세요');
						$('#phoneErrorMsg').css('color', 'red');
						$('#phoneErrorMsg').css('display', 'inline-block');
						phoneFlag = false;
					} else {
						phoneFlag = true;
					}
				}

			} // end phoneError()
		}) // end document
		
	</script>

</body>
</html>
