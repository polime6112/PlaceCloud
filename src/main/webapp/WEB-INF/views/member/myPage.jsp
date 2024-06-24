<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body {
    background-color: #f6f6f6;
}

#myInfoContainer {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    width: fit-content;
    margin: auto;
    margin-top: 50px;
}

#myInfo {
    text-align: right;
    margin-bottom: 20px;
}

#myInfo label {
    display: inline-block;
    margin-bottom: 10px;
    font-size: 18px;
    font-weight: bold;
    width: 100px;
}

#myInfo input[type="text"] {
    display: inline-block;
    margin-bottom: 10px;
    padding: 5px;
    font-size: 16px;
    border: none;
    border-bottom: 1px solid #ccc;
    background-color: transparent;
    width: 200px;
}

#updateForm, #deleteForm {
    display: inline-block;
    vertical-align: top;
    margin-left: 20px;
}
</style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
        </div>
    </header>

    <h1 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">마이페이지</h1>
  
    <div id="myInfoContainer">
        <form id="myInfo">
            <label for="email">이메일:</label> <input type="text" id="memberEmail"
                name="memberEmail" value="${member.memberEmail}" readonly><br>

            <label for="name">닉네임:</label> <input type="text" id="memberName"
                name="memberName" value="${member.memberName}" readonly><br>

            <label for="phone">전화번호:</label> <input type="text" id="memberPhone"
                name="memberPhone" value="${member.memberPhone}" readonly><br>
        </form>
        <c:if test="${not empty profileVO }">
	        <img class="image" src="../profile/display?profilePath=${profileVO.profilePath }
	        							&profileChgName=${profileVO.profileChgName}
	        							&profileExtension=${profileVO.profileExtension}"
	        							alt="프로필 사진을 추가해주세요">
	        <form id="delete" action="../profile/delete" method="GET">
	        	<input type="text" name="memberEmail" id="memberEmail" value="${member.memberEmail }">
	        	<button>프로필 사진 삭제</button>
	        </form>
        </c:if>
		<c:if test="${empty profileVO }">
			<button name="upload" onclick="location.href='../profile/upload?memberEmail=${member.memberEmail}'">
			프로필 사진 등록
			</button>
		</c:if>
		
        <form id="updateForm" action="updateInfo" method="get">
            <input type="submit" value="정보 변경">
        </form>

        <form id="deleteForm" action="remove" method="get">
            <button id="removeBtn" type="submit">회원 탈퇴</button>
        </form>
        
        
    </div>

</body>
</html>
