<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>예약 정보</title>
<style>
body {
    font-family: Arial, sans-serif;
}
#detailbody {
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
textarea {
        resize: none;
}
#backBtn {
    background-color: #f44336;
}
#backBtn:hover {
    background-color: #e41e1e;
}
#updateBtn {
    background-color: #4CAF50;
}
#updateBtn:hover {
    background-color: #45a049;
}
#deleteBtn {
    background-color: #ff9800;
}
#deleteBtn:hover {
    background-color: #e68900;
}
img {
    max-width: 100%;
    height: auto;
    display: block;
    margin: 10px 0;
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
    <h1>예약 정보</h1>
    <div id="detailbody">
        <div>
            <p>예약 번호: ${bookingVO.bookingId }</p>
            <div>
                <p>${bookingVO.placeName }</p>
                <br>
                <c:if test="${not empty placeVO }">
                    <img class="image"
                        src="../image/get?placeId=${placeVO.placeId }&imageExtension=${placeVO.imageExtension}"
                        alt="이미지 로딩 실패">
                </c:if>
                <fmt:formatDate value="${bookingVO.bookingDate }"
                    pattern="yyyy-MM-dd" var="bookingDate" />
                <p>예약 날짜: ${bookingDate }</p>
                <p>예약 인원: ${bookingVO.bookingPerson }</p>
                <p>예약자: ${bookingVO.bookingUserName }</p>
                <p>전화번호: ${bookingVO.bookingUserPhone }</p>
                <p>이메일: ${bookingVO.bookingUserEmail }</p>
                <p>사용 목적</p>
                <textarea cols="120" readonly>${bookingVO.bookingPerpose }</textarea>
                <p>요청 사항</p>
                <textarea rows="20" cols="120" readonly>${bookingVO.bookingContent }</textarea>
            </div>
            <br>
            <div>
                <p>결제 금액</p>
                <p>${bookingVO.bookingPrice }원</p>
            </div>
            <button id="backBtn" onclick="location.href='list'">뒤로가기</button>
            <button id="updateBtn" onclick="location.href='update?bookingId=${bookingVO.bookingId }'">수정하기</button>
            <button id="deleteBtn">예약 취소</button>
            <form id="deleteform" action="delete" method="post">
                <input type="hidden" name="bookingId" value="${bookingVO.bookingId }">
            </form>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#deleteBtn').click(function() {
                if (confirm('취소하시겠습니까?')) {
                	alert('예약이 취소되었습니다!');
                    $('#deleteform').submit(); // form 데이터 전송
                }
            });
        }); // end document
    </script>

</body>
</html>

