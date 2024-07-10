<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js">
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/profile.css">
<style type="text/css">
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

#memberForm {
	width: 600px;
	padding: 40px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin: 100px auto;
}

.join {
	width: calc(100% - 20px);
	margin-top: 10px;
	padding: 10px;
	font-size: 16px;
}

#email, #password, #confirmPw, #nickname, #phone, #status, #terms {
	margin-bottom: 15px;
}

#button {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

#goBackBtn {
	width: 48%;
	background-color: #ccc;
	color: #000000;
	border: none;
	padding: 15px 20px;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	text-align: center;
	text-decoration: none;
	transition: background-color 0.3s ease;
}

#goBackBtn:hover {
	background-color: #999;
}

#joinBtn {
	width: 48%;
	background-color: #ffc107;
	color: #000;
	border: none;
	padding: 15px 20px;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	text-align: center;
	transition: background-color 0.3s ease;
}

#joinBtn:hover {
	background-color: #ffca28;
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>

    <form id="memberForm" action="join" method="post">
        <h3 class="css" style="text-align: center; font-size: 40px; font-weight:900; color: #706FFF;">회원가입</h3>
        
     	<!-- 이메일  -->
        <div id="email">
            <input class="join" type="text" id="memberEmail" name="memberEmail" placeholder="이메일" maxlength="30">
            <span id="emailValidMsg"></span>
        </div>
        
        <!-- 비밀번호 -->
        <div id="password">
            <input class="join" type="password" id="memberPw" name="memberPw" placeholder="비밀번호" maxlength="16">
            <span id="pwValidMsg"></span>
        </div>
        
        <!-- 비밀번호 확인 -->
        <div id="confirmPw">
            <input class="join" type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 확인" maxlength="16">
            <span id="pwConfirmValidMsg"></span>
        </div>
        
        <!-- 닉네임 -->
        <div id="nickname">
            <input class="join" type="text" id="memberName" name="memberName" placeholder="닉네임" maxlength="10">
            <span id="nameValidMsg"></span>
        </div>
        
        <!-- 전화번호 -->
        <div id="phone">
            <input class="join" type="text" id="memberPhone" name="memberPhone" placeholder="전화번호(-제외)" maxlength="11">
            <span id="phoneValidMsg"></span>
        </div>
        
        <!-- 회원 구분 -->
        <div id="status">
        		<input type="radio" id="guest" name="memberStatus" value="guest" checked>게스트
        		<input type="radio" id="host" name="memberStatus" value="host">호스트
        </div>

		<div class="profile-upload">
			<h2>이미지 파일 업로드</h2>
			<p>* 이미지 파일은 1개만 가능합니다.</p>
			<p>* 최대 용량은 10MB 입니다.</p>
			<div class="profile-drop"></div>
			<h2>선택한 이미지 파일 :</h2>
			<div class="profile-list"></div>
		</div>

		<div class="profileVOImg-list"></div>

		<!-- 뒤로가기 회원가입 버튼  -->
		<div id="button">
			<a href="#" id="goBackBtn">뒤로가기</a>
			<button id="joinBtn">회원가입</button>
		</div>
	</form>
   
	<script type="text/javascript">

	$(document).ready(function(){
		// register 데이터 전송
		$('#joinBtn').click(function() {
			var memberEmail = $('#memberEmail').val().trim(); // 문자열의 양끝 공백 제거
			var memberPw = $('#memberPw').val().trim();
			var memberName = $('#memberName').val().trim();
			var memberPhone = $('#memberPhone').val().trim();
			
			// form 객체 참조
			var memberForm = $('#memberForm');

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
			
			memberForm.append(inputPath);
			memberForm.append(inputRealName);
			memberForm.append(inputChgName);
			memberForm.append(inputExtension);
			
			memberForm.submit();
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
		
		
	    let emailFlag = false; // 이메일 유효성 검사
	    let passwordFlag = false; // 비밀번호 유효성 검사
	    let passwordConfirmFlag = false; // 비밀번호 확인 유효성 검사
	    let nameFlag = false; // 닉네임 유효성 검사
	    let phoneFlag = false; // 전화번호 유효성 검사

	    // 회원가입 버튼 클릭 시
	    $('#joinBtn').click(function(event){
	        event.preventDefault(); // 기본 동작 취소
	        
	        // 각 필드에 대해 유효성 검사 함수 호출
	        emailValid();
	        passwordValid();
	        passwordConfirmValid();
	        nameValid();
	        phoneValid();
	        
	        // 모든 유효성 검사 플래그가 true인지 확인
	        if(emailFlag && passwordFlag && nameFlag && phoneFlag) {
	            // 모든 조건이 true면 회원가입 수행	           
	        } else {
	            // 유효성 검사 실패 시 메시지 출력
	            if(!emailFlag) {
	                $('#emailValidMsg').html('이메일을 확인해주세요');
	                $('#emailValidMsg').css('color', 'red');
	                $('#emailValidMsg').css('display', 'inline-block');
	            }
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
	    }); // end joinBtn.click()

	    // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
	    $('#goBackBtn').click(function(){
	        console.log('goBack()');  
	        window.history.back();
	        
	    }); // end goBackBtn.click()

	    // 이메일 유효성 검사
	    $('#memberEmail').on("propertychange change keyup paste input", function(){
	        emailValid();
	        
	    }); // end memberEmail.keyup()

	    function emailValid() {
	        console.log('emailKeyup()');
	        let memberEmail = $('#memberEmail').val();
	        // 이메일 정규 표현식
	        let emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@(naver\.com|daum\.net|gmail\.com)$/;

	        if(memberEmail.trim() === '') { // 이메일이 입력 되지 않은 경우 또는 공백만 입력된 경우
	            console.log('이메일 입력 x');
	            $('#emailValidMsg').html('이메일을 입력해주세요');
	            $('#emailValidMsg').css('color', 'red');
	            $('#emailValidMsg').css('display', 'inline-block');
	            emailFlag = false;
	            return;
	        } 

	        if(!emailRegex.test(memberEmail)) { // 이메일 정규 표현식 검사
	            console.log('이메일 형식');
	            $('#emailValidMsg').html('이메일 형식에 맞게 작성해주세요');
	            $('#emailValidMsg').css('color', 'red');
	            $('#emailValidMsg').css('display', 'inline-block');
	            emailFlag = false;
	        } else {
	            emailDoubleCheck(); // 함수 호출
	        }
	        
	    } // end emailValid()

	    // 이메일 중복 체크
	    function emailDoubleCheck() {
	        console.log('emailDoubleCheck()');
	        let memberEmail = $('#memberEmail').val();

	        let data = {memberEmail : memberEmail}
	        $.ajax({
	            url : '../member/emailCheck',
	            type : 'POST',
	            data : data,
	            success : function(result) {
	                if(result != 'fail') {  // 이메일 사용 가능
	                    console.log('사용 가능');
	                    $('#emailValidMsg').html('사용 가능한 이메일');
	                    $('#emailValidMsg').css('color', 'green');
	                    $('#emailValidMsg').css('display', 'inline-block');
	                    emailFlag = true;
	                } else { // 이메일 이미 사용중
	                    console.log('사용 불가');
	                    $('#emailValidMsg').html('중복된 이메일입니다');
	                    $('#emailValidMsg').css('color', 'red');
	                    $('#emailValidMsg').css('display', 'inline-block');
	                    emailFlag = false;
	                }
	                
	            } // end success
	            
	        }); // end ajax
	        
	    } // end emailDoubleCheck()

	    // 비밀번호 유효성 검사
	    $('#memberPw').on("propertychange change keyup paste input", function(){
	        passwordValid();
	        
	    }); // end passwordValid();

	    function passwordValid() {
	        console.log('pwkeyup()');
	        let memberPw = $('#memberPw').val();
	        let passwordConfirm = $('#passwordConfirm').val();
	        // 비밀번호 정규 표현식(최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자 포함)
	        let passwordRegex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;

	        if(memberPw.trim() === '') { // 비밀번호 입력 안한 경우 또는 공백만 입력된 경우
	            console.log('비밀번호 입력 x');
	            $('#pwValidMsg').html('비밀번호를 입력해주세요');
	            $('#pwValidMsg').css('color', 'red');
	            $('#pwValidMsg').css('display', 'inline-block');
	            passwordFlag = false;
	            return;
	        }

	        if(!passwordRegex.test(memberPw)) { // 비밀번호 형식 검사
	            console.log('비밀번호 형식');
	            $('#pwValidMsg').html('비밀번호는 최소 8자에서 16자까지 대문자, 숫자, 특수 문자를 포함해야 합니다');
	            $('#pwValidMsg').css('color', 'red');
	            $('#pwValidMsg').css('display', 'inline-block');
	            passwordFlag = false;
	        } else {
	            $('#pwValidMsg').html('사용 가능한 비밀번호');
	            $('#pwValidMsg').css('color', 'green');
	            $('#pwValidMsg').css('display', 'inline-block');
	            passwordFlag = true;
	        }

	        // 비밀번호 확인란과 비밀번호 일치 여부 확인
	        if(memberPw !== passwordConfirm) {
	            console.log('비밀번호 불일치');
	            $('#pwConfirmValidMsg').html('비밀번호가 일치하지 않습니다');
	            $('#pwConfirmValidMsg').css('color', 'red');
	            $('#pwConfirmValidMsg').css('display', 'inline-block');
	            passwordFlag = false;
	        } else {
	            console.log('비밀번호 일치');
	            $('#pwConfirmValidMsg').html('비밀번호가 일치합니다');
	            $('#pwConfirmValidMsg').css('color', 'green');
	            $('#pwConfirmValidMsg').css('display', 'inline-block');
	            passwordFlag = true;
	        }
	        
	    } // end passwordValid()

	    // 비밀번호 확인 
	    $('#passwordConfirm').on("propertychange change keyup paste input", function(){
    		passwordConfirmValid();
    		
		}); // end passwordConfirm.keyup()

		function passwordConfirmValid() {
    		console.log('pwConfirmKeyup()');
    		let memberPw = $('#memberPw').val();
    		let passwordConfirm = $('#passwordConfirm').val();

    		// 입력한 비밀번호와 비밀번호 확인이 같은지 확인
    		if(memberPw !== passwordConfirm) {
        		console.log('비밀번호 불일치');
        		$('#pwConfirmValidMsg').html('비밀번호가 일치하지 않습니다');
        		$('#pwConfirmValidMsg').css('color', 'red');
        		$('#pwConfirmValidMsg').css('display', 'inline-block');
        		passwordConfirmFlag = false;
    	   } else {
        		console.log('비밀번호 일치');
       			$('#pwConfirmValidMsg').html('비밀번호가 일치합니다');
        		$('#pwConfirmValidMsg').css('color', 'green');
        		$('#pwConfirmValidMsg').css('display', 'inline-block');
        		passwordConfirmFlag = true;
        	}
     	} // end passwordConfirmValid()

		// 닉네임 유효성 검사
		$('#memberName').on("propertychange change keyup paste input", function(){
		    nameValid();  
		    
		}); // end memberName.keyup()

		function nameValid() {
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
		        $('#nameValidMsg').html('2자 이상 10자이하 영어 또는 한글 또는 숫자로 구성');
		        $('#nameValidMsg').css('color', 'red');               
		        $('#nameValidMsg').css('display', 'inline-block');
		        nameFlag = false;
		    } else {
		        nameDoubleCheck(); // 함수 호출
		    }
		    
		} // end nameValid()

		// 닉네임 중복 체크
		function nameDoubleCheck() {
		    console.log('nameDoubleCheck()');
		    let memberName = $('#memberName').val();

		    let data = {memberName: memberName};
		    $.ajax({
		        url: '../member/nameCheck', // 적절한 URL로 변경
		        type: 'POST',
		        data: data,
		        success: function(result) {
		            if (result != 'fail') {  // 닉네임 사용 가능
		                console.log('사용 가능');
		                $('#nameValidMsg').html('사용 가능한 닉네임');
		                $('#nameValidMsg').css('color', 'green');
		                $('#nameValidMsg').css('display', 'inline-block');
		                nameFlag = true;
		            } else { // 닉네임 이미 사용 중
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
	        phoneValid();
	        
	    }); // end memberPhone.keyup()

	    function phoneValid() {
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
	            $('#phoneValidMsg').html('전화번호 형식에 맞게 작성해주세요');
	            $('#phoneValidMsg').css('color', 'red');
	            $('#phoneValidMsg').css('display', 'inline-block');
	            phoneFlag = false;
	        } else {
	            $('#phoneValidMsg').html('사용 가능한 전화번호입니다');
	            $('#phoneValidMsg').css('color', 'green');
	            $('#phoneValidMsg').css('display', 'inline-block');
	            phoneFlag = true;
	        }
	        
	    } // end phoneValid()
	    
	}); // end document.ready()

	</script>

</body>
</html>