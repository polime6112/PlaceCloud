<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
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

form {
	width: 500px; /* 너비를 늘림 */
	padding: 30px; /* 패딩을 늘림 */
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
	text-align: center; /* 가운데 정렬 */
	margin: 100px auto;
}

#errorGuide {
	color: gray;
}

#guideMsg {
	color: red;
	margin-top: 10px;
}

#goBackBtn {
	background-color: black;
	color: white;
	padding: 10px 20px;
	text-decoration: none;
	border: none;
	border-radius: 5px;
	margin-right: 10px;
	transition: background-color 0.3s ease;
}

#goBackBtn:hover {
	background-color: #333;
}

#removeBtn {
	background-color: purple;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

#removeBtn:hover {
	background-color: #6a5acd;
}

input[type="checkbox"] {
	transform: scale(1.5);
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>
	
    <form id="removeForm" action="remove" method="post">
        <h3 id="title">서비스 탈퇴 전에 꼭 확인하세요</h3>
        
        <div class="center">
            <p id="errorGuide">서비스 탈퇴시 내 프로필, 예약내역 등의 모든 정보가 삭제 되며 이후 복구가 불가능 합니다</p>    
        </div>
        
        <div>
            <input id="agreeMemberOut" type="checkbox">
            <label for="agreeMemberOut">위의 내용을 숙지했으며 서비스 탈퇴에 동의합니다</label>
        </div>
        
        <p id="guideMsg">
            <i class="fas fa-info-circle"></i>
            서비스 탈퇴 동의는 필수입니다
        </p>
        
        <a href="#" id="goBackBtn">뒤로가기</a>
        <button type="submit" id="removeBtn">서비스 탈퇴</button>
    </form>
</body>
	<script type="text/javascript">
		$(document).ready(function(){
			
		// 뒤로가기 버튼 클릭 시 이전 페이지로 이동
		$('#goBackBtn').click(function(){
		    console.log('goBack()');  
		    window.history.back();
		          
		}); // end goBackBtn.click()	
		
		// 초기 상태에서 탈퇴 버튼 비활성화
	    $('#removeBtn').prop('disabled', true);
		
	    // 체크박스 클릭 감지
	    $('#agreeMemberOut').click(function(){
	        // 체크 여부 확인
	        if($('#agreeMemberOut').prop('checked')) {
	            // 체크되었을 때 회원 탈퇴 버튼 활성화
	            console.log('체크');
	            $('#removeBtn').prop('disabled', false);
	        } else {
	        	console.log('체크 해제');
	            // 체크가 해제되었을 때 회원 탈퇴 버튼 비활성화
	            $('#removeBtn').prop('disabled', true);
	        }
	    });
		
		}); // end document
	</script>
	
</html>
