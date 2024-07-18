<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		font-family: Arial, sans-serif;
	}
    .header-section {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 10px 20px;
        position: relative;
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

    .login-section {
        display: flex;
        gap: 15px;
        align-items: center;
        position: absolute;
        right: 20px;
    }

    .btn {
        background-color: #f0f0f0;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        text-decoration: none;
        color: #333;
        transition: background-color 0.3s;
    }

    .btn:hover {
        background-color: #ddd;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
    <div class="header-section">
        <div class="logo">
            <a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
        </div>
        <!-- 로그아웃 상태 -->
        <div class="login-section">
            <sec:authorize access="isAnonymous()">
                <a class="btn" href="../member/join">회원 가입</a>
                <a class="btn" href="../auth/login">로그인</a>
            </sec:authorize>
            <!-- 로그인 상태 -->
            <sec:authorize access="isAuthenticated()">
                <p><sec:authentication property="principal.member.memberName"/>님 <br>환영합니다</p>
                <a class="btn" href="../member/myPage">마이페이지</a>
                <form action="../auth/logout" method="post">
                    <input class="btn" type="submit" value="로그아웃">
                </form>
                <!-- 호스트 권한 확인 -->
                <sec:authorize access="hasRole('ROLE_HOST')">
                    <a class="btn" href="../host/myPlace">내가 등록한 장소들</a>
                </sec:authorize>
            </sec:authorize>
        </div>
    </div>
</body>
</html>