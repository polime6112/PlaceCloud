<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<!-- jQuery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/profile.css">
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

#updateForm {
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

#button a, #updateBtn {
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

#updateBtn {
	background-color: #4CAF50; 
}

#goBackBtn:hover, #updateBtn:hover {
	opacity: 0.8;
}

.profile-upload {
	width: 600px;
	padding: 40px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin: 100px auto;
	background-color: #fff;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	text-align: center;
}

.profile-upload h2 {
	margin-bottom: 10px;
	font-size: 24px;
	color: #706FFF;
}

.profile-upload p {
	font-size: 14px;
	color: #666;
}

.profile-drop {
	text-align: center;
	width: 90%;
	padding: 20px;
	border: 2px dashed #ccc;
	border-radius: 10px;
	background-color: #f9f9f9;
	cursor: pointer;
}

.profile-drop:hover {
	background-color: #e6e6e6;
}

.profile-list, .profileVOImg-list {
	text-align: center;
	margin-top: 20px;
}

.profile_item {
	display: inline-block;
	margin-right: 10px;
	position: relative;
}

.profile_item img {
	border-radius: 10px;
}

.profile_delete {
	position: absolute;
	top: 0;
	right: 0;
	background-color: rgba(0, 0, 0, 0.5);
	color: #fff;
	border: none;
	border-radius: 50%;
	width: 20px;
	height: 20px;
	cursor: pointer;
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
    <form id="updateForm" action="updateInfo" method="post">
        
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
	    	<button id="updateBtn">저장하기</button>		
		</div>
		
    </form>
    
		<div class="profile-upload">
			<h2>이미지 파일 업로드</h2>
			<p>* 이미지 파일은 1개만 가능합니다.</p>
			<p>* 최대 용량은 10MB 입니다.</p>
			<div class="profile-drop"></div>
			<h2>선택한 이미지 파일 :</h2>
			<div class="profile-list"></div>
		</div>

		<div class="profileVOImg-list"></div>
		
    <script type="text/javascript">
    	$(document).ready(function(){
    		
    		// register 데이터 전송
    		$('#updateBtn').click(function() {
    			var memberEmail = $('#memberEmail').val().trim(); // 문자열의 양끝 공백 제거
    			var memberPw = $('#memberPw').val().trim();
    			var memberName = $('#memberName').val().trim();
    			var memberPhone = $('#memberPhone').val().trim();
    			
    			// form 객체 참조
    			var updateForm = $('#updateForm');

    			var profileVO = JSON.parse($('.profileVOImg-list input').val());
    			console.log(profileVO);
    			
    			var inputPath = $('<input>').attr('type', 'hidden')
    			.attr('name', 'profilePath');
    			inputPath.val(profileVO.profilePath);
    			
    			var inputRealName = $('<input>').attr('type', 'hidden')
    			.attr('name', 'profileRealName');
    			inputRealName.val(profileVO.profileRealName);
    			
    			var inputChgName = $('<input>').attr('type', 'hidden')
    			.attr('name', 'profileChgName');
    			inputChgName.val(profileVO.profileChgName);
    			
    			var inputExtension = $('<input>').attr('type', 'hidden')
    			.attr('name', 'profileExtension');
    			inputExtension.val(profileVO.profileExtension);
    			
    			updateForm.append(inputPath);
    			updateForm.append(inputRealName);
    			updateForm.append(inputChgName);
    			updateForm.append(inputExtension);
    			
    			updateForm.submit();
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
    		$('.profile-drop').on('dragenter dragover', function(event){
    			event.preventDefault();
    			console.log('drag 테스트');
    		}); 
    		
    		$('.profile-drop').on('drop', function(event){
    			event.preventDefault();
    			console.log('drop 테스트');
    			
    			$('.profileVOImg-list').empty(); // 기존 이미지 vo 초기화

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
    				url : '../profile', 
    				data : formData,
    				processData : false,
    				contentType : false,
    				success : function(data) {
    					console.log(data);
    					var list = '';
    					$(data).each(function(){
    						// this : 컬렉션의 각 인덱스 데이터를 의미
    						console.log(this);
    					  	var profileVO = this; // profileVO 저장
    					  	// encodeURIComponent() : 문자열에 포함된 특수 기호를 UTF-8로 
    					  	// 인코딩하여 이스케이프시퀀스로 변경하는 함수 
    						var profilePath = encodeURIComponent(this.profilePath);
    						
    						// input 태그 생성 
    						// - type = hidden
    						// - name = profileVO
    						// - data-chgName = profileVO.profileChgName
    						var input = $('<input>').attr('type', 'hidden')
    							.attr('name', 'profileVO')
    							.attr('data-chgName', profileVO.profileChgName);
    						
    						// profileVO를 JSON 데이터로 변경
    						// - object 형태는 데이터 인식 불가능
    						input.val(JSON.stringify(profileVO));
    						
    			       		// div에 input 태그 추가
    			        	$('.profileVOImg-list').append(input);
    					  	
    					    // display() 메서드에서 이미지 호출을 위한 문자열 구성
    					    list += '<div class="profile_item" data-chgName="'+ this.profileChgName +'">'
    					    	+ '<pre>'
    					    	+ '<input type="hidden" id="profilePath" value="'+ this.profilePath +'">'
    					    	+ '<input type="hidden" id="profileChgName" value="'+ profileVO.profileChgName +'">'
    					    	+ '<input type="hidden" id="profileExtension" value="'+ profileVO.profileExtension +'">'
    					        + '<a href="../profile/display?profilePath=' + profilePath + '&profileChgName='
    					        + profileVO.profileChgName + "&profileExtension=" + profileVO.profileExtension
    					        + '" target="_blank">'
    					        + '<img width="100px" height="100px" src="../profile/display?profilePath=' 
    					        + profilePath + '&profileChgName='
    					        + 't_' + profileVO.profileChgName 
    					        + "&profileExtension=" + profileVO.profileExtension
    					        + '" />'
    					        + '</a>'
    					        + '<button class="profile_delete" >x</button>'
    					        + '</pre>'
    					        + '</div>';
    					}); // end each()

    					// list 문자열 profile-list div 태그에 적용
    					$('.profile-list').html(list);
    				} // end success
    			
    			}); // end $.ajax()
    			
    		}); // end profile-drop()
    					
    		
    		$('.profile-list').on('click', '.profile_item .profile_delete', function(){
    			console.log(this);
    			if(!confirm('삭제하시겠습니까?')) {
    				return;
    			}
    			var profilePath = $(this).prevAll('#profilePath').val();
    			var profileChgName = $(this).prevAll('#profileChgName').val();
    			var profileExtension= $(this).prevAll('#profileExtension').val();
    			console.log(profilePath);
    			
    			// ajax 요청
    			$.ajax({
    				type : 'POST', 
    				url : '../profile/delete', 
    				data : {
    					profilePath : profilePath, 
    					profileChgName : profileChgName,
    					profileExtension: profileExtension
    				}, 
    				success : function(result) {
    					console.log(result);
    					if(result == 1) {
    						$('.profile-list').find('div')
    					    .filter(function() {
    					    	// data-chgName이 선택된 파일 이름과 같은 경우
    					        return $(this).attr('data-chgName') === profileChgName;
    					    })
    					    .remove();
    					    
    					    $('.profileVOImg-list').find('input')
    					    .filter(function() {
    					    	// data-chgName이 삭제 선택된 파일 이름과 같은 경우
    					        return $(this).attr('data-chgName') === profileChgName;
    					    })
    					    .remove();

    					}

    				}
    			}); // end ajax()
    			
    		}); // end profile-list.on()
    		
    		let passwordFlag = false; // 비밀번호 유효성 검사
    		let nameFlag = false; // 닉네임 유효성 검사
    		let phoneFlag = false; // 전화번호 유효성 검사
    		
    		// 저장하기 버튼 클릭 시
    	$('#updateeBtn').click(function(event){
    		console.log('updateBtn');
    		event.preventDefault(); // 기본 이벤트 동작 방지
    			
    		// 모든 유효성 검사 플래그가 true인지 확인
    		if(passwordFlag && nameFlag && phoneFlag ) {
    		// 모든 조건이 true면 정보 변경 수행
    		$('#updateInfo').submit(); // 폼 제출   		
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
