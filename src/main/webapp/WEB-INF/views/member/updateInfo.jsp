<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<!-- jQuery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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

#updateInfo {
	border: 1px solid #706FFF;
	width: 40%;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	background-color: #fff;
	margin: 100px auto;
}

h1 {
	text-align: center;
	font-size: 40px;
	font-weight: 900;
	color: #706FFF;
}

label {
	display: block;
	margin-top: 10px;
	font-weight: bold;
	text-align: left;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	box-sizing: border-box;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f9f9f9;
	text-align: left;
}

#button {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}

#button a, #saveBtn {
	padding: 10px 20px;
	text-decoration: none;
	color: #fff;
	font-weight: bold;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

#goBackBtn {
	background-color: #FFA500; 
}

#saveBtn {
	background-color: #4CAF50; 
}

#goBackBtn:hover, #saveBtn:hover {
	opacity: 0.8;
}

</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>

    <h1 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">정보 수정</h1>
    <form id="updateInfo" action="updateInfo" method="post">
        
        <!-- 이메일  -->
        <div id="email">
        	<label for="email">이메일:</label>
            <input class="join" type="text" id="memberEmail" name="memberEmail" value="${member.memberEmail}" placeholder="이메일" maxlength="30" readonly>
        </div>
        
       	<!-- 비밀번호 -->
        <div id="password">
	        <label for="email">비밀번호:</label>
            <input class="join" type="password" id="memberPw" name="memberPw" placeholder="비밀번호" maxlength="16" required>
            <span id="pwValidMsg"></span>
        </div>
        
        <!-- 닉네임 -->
        <div id="nickname">
        	<label for="name">닉네임:</label>
            <input class="join" type="text" id="memberName" name="memberName" placeholder="닉네임" maxlength="10" required>
            <span id="nameValidMsg"></span>
        </div>
        
        <!-- 전화번호 -->
        <div id="phone">
	        <label for="phone">전화번호:</label>
            <input class="join" type="text" id="memberPhone" name="memberPhone" placeholder="전화번호" maxlength="13" required>
            <span id="phoneValidMsg"></span>
        </div>
        
        <!-- 뒤로가기 저장하기 버튼  -->
        <div id="button">
   			<a href="#" id="goBackBtn">뒤로가기</a>
	        <button type="submit" id="saveBtn">저장하기</button>		
		</div>
		
		<!-- CSRF 토큰 -->
	    <!-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
   		-->
    </form>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		let passwordFlag = false; // 비밀번호 유효성 검사
    		let nameFlag = false; // 닉네임 유효성 검사
    		let phoneFlag = false; // 전화번호 유효성 검사
    		
    		// 저장하기 버튼 클릭 시
    	$('#saveBtn').click(function(event){
    		console.log('saveBtn');
    		event.preventDefault(); // 기본 이벤트 동작 방지
    			
    		// 모든 유효성 검사 플래그가 true인지 확인
    		if(passwordFlag && nameFlag && phoneFlag ) {
    		// 모든 조건이 true면 정보 변경 수행
    		$('#updateInfo').submit(); // 폼 제출
    		alert('정보 변경 완료');
    		} else {
    			// 유효성 검사 실패 시 메시지 출력
    			if(!passwordFlag) {
    		          $('#pwValidMsg').html('비밀번호를 확인해주세요');
    		          $('#pwValidMsg').css('color', 'red');
    		          $('#pwValidMsg').css('display', 'inline-block');
    		         }
    		    if(!nameFlag) {
    		          $('#nameValidMsg').html('닉네임을 확인해주세요');
    		          $('#nameValidMsg').css('color', 'red');
    		          $('#nameValidMsg').css('display', 'inline-block');
    		         }
    		     if(!phoneFlag) {
    		          $('#phoneValidMsg').html('전화번호를 확인해주세요');
    		          $('#phoneValidMsg').css('color', 'red');
    		          $('#phoneValidMsg').css('display', 'inline-block');
    		         }
    			}
    				
    		}) // end saveBtn.click()
    		
    	// 뒤로가기 버튼 클릭 시 이전 페이지로 이동
	    $('#goBackBtn').click(function(){
	    	console.log('goBack()');  
	    	window.history.back();
	          
	       }); // end goBackBtn.click()
    		
    	// 비밀번호 유효성 검사
		$('#memberPw').on("propertychange change keyup paste input", function(){
			console.log('pwkeyup()');
			let memberPw = $('#memberPw').val();
			// 비밀번호 정규 표현식(최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자 포함)
			let passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
			
			if(memberPw.trim() === '') { // 비밀번호 입력 되지 않을 경우 또는 공백만 입력된 경우
				console.log('비밀번호 입력 x');
				$('#pwValidMsg').html('비밀번호를 입력해주세요');
				$('#pwValidMsg').css('color', 'red');
				$('#pwValidMsg').css('display', 'inline-block');
				passwordFlag = false;
				return;
			}
			
			if(!passwordRegex.test(memberPw)) { // 비밀번호 정규 표현식 검사
				console.log('비밀번호 형식');
				$('#pwValidMsg').html('비밀번호는 최소 8자에서 16자까지 대문자 숫자 및 특수 문자를 포함해야 합니다');
				$('#pwValidMsg').css('color', 'red');
				$('#pwValidMsg').css('display', 'inline-block');
				passwordFlag = false;
			} else {
				console.log('비밀번호 체크 완료');
				$('#pwValidMsg').html('사용 가능한 비밀번호');
				$('#pwValidMsg').css('color', 'green');
				$('#pwValidMsg').css('display', 'inline-block');
				passwordFlag = true;
			}
				
		}); // end memberPw.keyup()
		
		// 닉네임 유효성 검사
		$('#memberName').on("propertychange change keyup paste input", function(){
			console.log('nameKeyup()');
			let memberName = $('#memberName').val();
			// 닉네임 정규 표현식(2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성)
			let nameRegex = /^[a-zA-Z가-힣0-9]{2,10}$/;
			
			if(memberName.trim() === '') { // 닉네임이 입력 되지 않은 경우 또는 공백만 입력된 경우
		        console.log('닉네임 입력 x');
		        $('#nameValidMsg').html('닉네임을 입력해주세요');
		        $('#nameValidMsg').css("color", 'red');               
		        $('#nameValidMsg').css('display', 'inline-block');
		        nameFlag = false;
		        return;
		    }

		    if(!nameRegex.test(memberName)) { // 닉네임 정규 표현식 검사
		        console.log('닉네임 형식');
		        $('#nameValidMsg').html('닉네임은 2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성');
		        $('#nameValidMsg').css("color", 'red');
		        $('#nameValidMsg').css('display', 'inline-block');
		        nameFlag = false;
		    } else {
		        nameDoubleCheck(); // 함수 호출       
		    }
			
		}); // end memberName.keyup()
		
		// 닉네임 중복 체크
		function nameDoubleCheck() {
			console.log('nameDoubleCheck()');
			let memberName = $('#memberName').val();
			
			let data = {memberName : memberName}
			
			$.ajax({
				url : '../member/nameCheck',
				type : 'POST',
				data : data,
				success : function(result) {
					if(result != 'fail') {  // 닉네임 사용 가능
                    	console.log('사용 가능');
                        $('#nameValidMsg').html('사용 가능한 닉네임');
                    	$('#nameValidMsg').css('color', 'green');
                    	$('#nameValidMsg').css('display', 'inline-block');
     					nameFlag = true;
                    } else { // 닉네임 이미 사용중
                    	console.log('사용 불가');
                        $('#nameValidMsg').html('중복된 닉네임입니다');
                        $('#nameValidMsg').css('color', 'red');
                        $('#nameValidMsg').css('display', 'inline-block');
                       	nameFlag = false;
                    }
					
				} // end success
				
			}); // end ajax
			
		} // end nameDoubleCheck()
		
		// 전화번호 유효성 검사
		$('#memberPhone').on("propertychange change keyup paste input", function(){
			console.log('phoneKeyup()');
			let memberPhone = $('#memberPhone').val();
			// 전화번호 정규 표현식
			let phoneRegex = /^010\d{4}\d{4}$/;
			
			if(memberPhone.trim() === '') { // 전화번호가 입력 되지 않은 경우 또는 공백만 입력된 경우
				console.log('전화번호 입력 x');
				$('#phoneValidMsg').html('전화번호를 입력해주세요');
				$('#phoneValidMsg').css('color', 'red');
				$('#phoneValidMsg').css('display', 'inline-block');
				phoneFlag = false;
				return;				
			}
			
			if(!phoneRegex.test(memberPhone)) { // 전화번호 정규 표현식 검사
				console.log('전화번호 형식');
				$('#phoneValidMsg').html('전화번호 형식에 맞게 입력해주세요');
				$('#phoneValidMsg').css('color', 'red');
				$('#phoneValidMsg').css('display', 'inline-block');
				phoneFlag = false;
			} else {
				console.log('전화번호 체크 완료');
				$('#phoneValidMsg').html('사용 가능한 전화번호');
				$('#phoneValidMsg').css('color', 'green');
				$('#phoneValidMsg').css('display', 'inline-block');
				phoneFlag = true;
			}
			
		}); // end memberPhone.keyup();
    		
    	}) // end document
    </script>
</body>
</html>
