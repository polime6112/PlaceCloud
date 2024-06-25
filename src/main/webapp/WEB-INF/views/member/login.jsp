<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게스트 로그인</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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

#loginForm {
	border: 1px solid #706FFF;
	width: 40%;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	position: relative;
	margin: 200px auto;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	box-sizing: border-box;
	font-size: 16px;
}

#loginBtn {
	width: 100%;
	background-color: #FFD700;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	font-family: Arial, sans-serif;
}

#join {
	text-align: center;
	margin-top: 20px;
}

#joinBtn {
	border: none;
	background: none;
	padding: 0;
	font: inherit;
	cursor: pointer;
	text-decoration: underline;
	color: #706FFF;
	font-family: Arial, sans-serif;
	margin-left: 10px;
}

#joinBtn:hover {
	color: #404040;
	text-decoration: underline;
}

</style>

</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
        </div>
    </header>
    
    <form id="loginForm" class="form" action="${pageContext.request.contextPath }/member/memberLogin" method="post">
        <h1 style="text-align: center; font-size: 40px; font-weight:900; color: #706FFF;">로그인</h1>
        <input id="memberEmail" name="memberEmail" type="text" placeholder="이메일">
        <input id="memberPw" name="memberPw" type="password" placeholder="비밀번호">
        
        <button id="loginBtn" type="submit">이메일로 로그인</button>
        
        <div id="join">
            <span>아직 회원이 아니신가요?</span><button id="joinBtn" type="button">회원가입</button>
        </div>
              
    </form>
    
    <script type="text/javascript">
        $(document).ready(function() {
        	
        	var loginFailMessage = "${loginFailMessage}";
            if (loginFailMessage !== "") {
                alert(loginFailMessage); // 경고창으로 실패 메시지 출력
            }
            
            $("#joinBtn").click(function() {
                console.log('signBtn');
                location.href = "${pageContext.request.contextPath }/member/join";
            
            }); // end joinBtn.click()
        	
        }); // end document
        
    </script>
</body>
</html>
