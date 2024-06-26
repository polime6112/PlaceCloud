<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>booking Insert</title>
</head>
<body>
	<h1>공간 예약</h1>
	<form id="insertform" action="../kakaoPay" method="post">
		<div>
			<input type="hidden" name="placeId" value="${PlaceVO.placeId }">
			<p>예약 공간</p>
			<input type="text" name="placeName" readonly value="${PlaceVO.placeName }">
			<br><br>
			<c:if test="${not empty ImageVO }">
				<img class="image" src="../image/display?imagePath=${ImageVO.imagePath }&imageChgName=${ImageVO.imageChgName}
									&imageExtension=${ImageVO.imageExtension}" alt="이미지 로딩 실패">
			</c:if>
			<br>
			<p>카테고리 : ${PlaceVO.placeCategory }</p>
			<p>주소 : ${PlaceVO.placeAddress }</p>
			<p>장소 설비 : ${PlaceVO.placeInfo }</p>
			<p>주의 사항 : ${PlaceVO.placeWarning }</p>
		</div>
		<div>
			<p>예약 날짜</p>
			<input id="date" type="date" name="bookingDate" required>
			<br>
			<p>예약 인원</p>
			<input id="person" type="text" name="bookingPerson" maxlength="3" required>
			<span id="personValidMsg"></span>
		</div>
		<div>
			<p>예약자</p>
			<input id="name" type="text" name="bookingUserName" required>
			<span id="nameValidMsg"></span>
		<br>
			<p>전화번호</p>
			<input id="phone" type="text" name="bookingUserPhone" maxlength="11" required value="${sessionScope.login.memberPhone }">
			<span id="phoneValidMsg"></span>
		<br>
			<p>이메일</p>
			<input id="email" type="email" name="bookingUserEmail" readonly value="${sessionScope.login.memberEmail }">
		<br>
			<p>사용 목적</p>
			<textarea cols="120" name="bookingPerpose" 
			placeholder="공간의 사용 목적을 입력 (최대 100자)" maxlength="100"></textarea>
		<br>
			<p>요청 사항</p>
			<textarea rows="20" cols="120" name="bookingContent" 
			placeholder="남기고 싶은 말을 적어주세요.(최대 500자)" maxlength="500"></textarea>
		</div>
		<div>
			<p>결제 금액</p>
			<input type="text" name="bookingPrice" readonly value="${PlaceVO.placeMoneyTime }">
			<br>
		</div>
			<button id="pageBack">뒤로가기</button>
			<button id="booking" type="submit" >결제하기</button>
	</form>
	
	<script type="text/javascript">
		
		// 현재 날짜를 'YYYY-MM-DD' 형식으로 변환
		const today = new Date().toISOString().split('T')[0];

		// input 요소의 min 속성에 현재 날짜를 설정
		document.getElementById('date').setAttribute('min', today);
		
		$(document).ready(function(){
			let personFlag = false; // 인원수 유효성 검사
		    let nameFlag = false; // 닉네임 유효성 검사
		    let phoneFlag = false; // 전화번호 유효성 검사
			
			$('#booking').click(function(event){
				event.preventDefault(); // 기본 동작 취소
				// 각 필드에 대해 유효성 검사 함수 호출
				personValid();
		        nameValid();
		        phoneValid();
		        
		        // 모든 유효성 검사 플래그가 true인지 확인
		        if(personFlag && nameFlag && phoneFlag) {
		            // 모든 조건이 true면 회원가입 수행
		            $('#insertform').submit(); // 폼 제출
		        } else {
		            // 유효성 검사 실패 시 메시지 출력
		            if(!personFlag) {
		                $('#personValidMsg').html('예약 인원을 확인해주세요');
		                $('#personValidMsg').css('color', 'red');
		                $('#personValidMsg').css('display', 'inline-block');
		            }
		            if(!nameFlag) {
		                $('#nameValidMsg').html('예약자를 확인해주세요');
		                $('#nameValidMsg').css('color', 'red');
		                $('#nameValidMsg').css('display', 'inline-block');
		            }
		            if(!phoneFlag) {
		                $('#phoneValidMsg').html('전화번호를 확인해주세요');
		                $('#phoneValidMsg').css('color', 'red');
		                $('#phoneValidMsg').css('display', 'inline-block');
		            }
		        }
		    }); // end booking.click()

		    // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
		    $('#pageBack').click(function(){
		        console.log('pageBack()');  
		        location.href="../place/detail?placeId=${PlaceVO.placeId }"
		        
		    }); // end pageBack.click()

		 	// 예약 인원 유효성 검사
			$('#person').keyup(function(){
			    personValid();  
			    
			}); // end person.keyup()

			function personValid() {
			    console.log('personKeyup()');
			    let person = $('#person').val();
			    // 숫자 정규 표현식(2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성)
			    let personRegex = /^[0-9]{1,3}$/;

			    if(person.trim() === '') { // 예약 인원이 입력 되지 않은 경우 또는 공백만 입력된 경우
			        console.log('인원수 입력 x');
			        personFlag = false;
			        return;
			    } else if(person.trim() === '0') {
			    	console.log('0명 입력 x');
			    	$('#personValidMsg').html('최소 예약 인원은 1명입니다');
			        $('#personValidMsg').css("color", 'red');               
			        $('#personValidMsg').css('display', 'inline-block');
			    } else if(person > 200) {
			    	console.log('최대 인원 초과입력');
			    	$('#personValidMsg').html('최대 예약 인원은 200명입니다');
			        $('#personValidMsg').css("color", 'red');               
			        $('#personValidMsg').css('display', 'inline-block');
			    } else {
			    	$('#personValidMsg').html('');
			    }
			
			$('#person').focusout(function(){
				personFocusOut();     
			});    
			    
			function personFocusOut() {
				console.log('personFocusOut()');
				let person = $('#person').val();
			    // 숫자 정규 표현식(2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성)
			    let personRegex = /^[0-9]{1,3}$/;
			    if(!personRegex.test(person)) { // 숫자 정규 표현식 검사
			        console.log('숫자 형식');
			        $('#personValidMsg').html('숫자만 입력가능합니다');
			        $('#personValidMsg').css('color', 'red');               
			        $('#personValidMsg').css('display', 'inline-block');
			        personFlag = false;
			    } else {
			    	personFlag = true;
			    }				
			}			    
			    
			} // end personValid()
		    
			// 예약자 유효성 검사
			$('#name').keyup(function(){
			    nameValid();  
			    
			}); // end name.keyup()

			function nameValid() {
			    console.log('nameKeyup()');
			    let name = $('#name').val();
			    // 닉네임 정규 표현식(2자 이상 10자이하 영어 또는 한글로 구성)
			    let nameRegex = /^[a-zA-Z가-힣]{1,20}$/;

			    if(name.trim() === '') { // 이름이 입력 되지 않은 경우 또는 공백만 입력된 경우
			        console.log('이름 입력 x');
			        $('#nameValidMsg').html('');
			        nameFlag = false;
			        return;
			    } else {
			        $('#nameValidMsg').html('');
			    }
			
			$('#name').focusout(function(){
				nameFocusOut();     
			});   
			    
			function nameFocusOut() {
				console.log('nameFocusOut()');
			    let name = $('#name').val();
			    // 닉네임 정규 표현식(2자 이상 10자이하 영어 또는 한글로 구성)
			    let nameRegex = /^[a-zA-Z가-힣]{1,20}$/;
			    
			    if(!nameRegex.test(name)) { // 한글, 영어 정규 표현식 검사
			        console.log('이름 형식');
			        $('#nameValidMsg').html('이름을 확인해주세요');
			        $('#nameValidMsg').css('color', 'red');               
			        $('#nameValidMsg').css('display', 'inline-block');
			        nameFlag = false;
			    } else {
			    	nameFlag = true;
			    }
			}			    
			    
			} // end nameValid()

		    // 전화번호 유효성 검사
		    $('#phone').keyup(function(){
		        phoneValid();
		        
		    }); // end phone.keyup()

		    function phoneValid() {
		        console.log('phoneKeyup()');
		        let phone = $('#phone').val();
		        // 전화번호 정규 표현식
		        let phoneRegex = /^010\d{4}\d{4}$/;

		        if(phone.trim() === '') { // 전화번호가 입력 되지 않은 경우 또는 공백만 입력된 경우
		            console.log('전화번호 입력 x');
		            phoneFlag = false;
		            return;
		        } else {
		            $('#phoneValidMsg').html('');
		        }
		        
		        
		    $('#phone').focusout(function(){
				phoneFocusOut();     
			});
		    
		    function phoneFocusOut() {
		    	console.log('phoneKeyup()');
		        let phone = $('#phone').val();
		        // 전화번호 정규 표현식
		        let phoneRegex = /^010\d{4}\d{4}$/;
		        if(!phoneRegex.test(phone)) { // 전화번호 정규 표현식 검사
		            console.log('전화번호 형식');
		            $('#phoneValidMsg').html('전화번호를 확인해주세요');
		            $('#phoneValidMsg').css('color', 'red');
		            $('#phoneValidMsg').css('display', 'inline-block');
		            phoneFlag = false;
		        } else {
		            phoneFlag = true;
		        }
		    }
		    
		        
		    } // end phoneValid()
			
		}) // end document
		
		
		
	</script>
	
	
</body>
</html>