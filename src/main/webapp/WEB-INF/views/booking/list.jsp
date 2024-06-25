<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>My bookings</title>
<style>
    .container {
        font-family: Arial, sans-serif;
        margin: 50px auto;
        max-width: 1200px;
        padding: 0 15px;
        background-color: #f8f9fa;
    }
    .container h1 {
        font-size: 24px;
        color: #343a40;
        margin-bottom: 20px;
    }
    .userInfo {
        float: right;
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        text-decoration: none;
    }
    .userInfo:hover {
        background-color: #0056b3;
    }
    .booking-form {
        margin-bottom: 20px;
    }
    .booking-form input[type="date"],
    .booking-form input[type="submit"],
    .booking-form select {
        padding: 8px;
        margin-right: 10px;
        border: 1px solid #ced4da;
        border-radius: 5px;
    }
    .booking-form input[type="submit"] {
        background-color: #28a745;
        color: white;
        border: none;
        cursor: pointer;
    }
    .booking-form input[type="submit"]:hover {
        background-color: #218838;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .table th, .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    .table th {
        background-color: #e9ecef;
    }
    .table tr:hover {
        background-color: #f1f3f5;
    }
    .bpagination {
        display: flex;
        justify-content: center;
        list-style: none;
        padding: 0;
    }
    .bpagination li {
        margin: 0 5px;
    }
    .bpagination a {
        display: block;
        padding: 8px 16px;
        text-decoration: none;
        color: #007bff;
        border: 1px solid #dee2e6;
        border-radius: 5px;
    }
    .bpagination a:hover {
        background-color: #e9ecef;
    }
    .bpagination .active a {
        background-color: #007bff;
        color: white;
        border: none;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>${sessionScope.login.memberName }님의 예약 목록</h1>
        <button class="userInfo" onclick="location.href='/placecloud/member/myPage'">회원 정보</button>
        <br><br>
        <div class="row">
            <div class="col-md-12">
                <form class="booking-form" action="../booking/list" method="get">
                    <input type="date" id="startDate" name="startDate" value="${bpagination.startDate }">
                     ~ 
                    <input type="date" id="endDate" name="endDate" value="${bpagination.endDate }">
                    <input type="submit" value="검색">
                    <select class="pageSize" id="pageSize" name="pageSize" onChange="pageChange()">
                        <option value="5" <c:if test="${bpagination.pageSize == 5 }">selected</c:if>>5줄 보기</option>
                        <option value="10" <c:if test="${bpagination.pageSize == 10 }">selected</c:if>>10줄 보기</option>
                        <option value="15" <c:if test="${bpagination.pageSize == 15 }">selected</c:if>>15줄 보기</option>
                        <option value="20" <c:if test="${bpagination.pageSize == 20 }">selected</c:if>>20줄 보기</option>
                    </select>
                </form>
                <br>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>예약 공간</th>
                            <th>예약 날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bookingVO" items="${bookingList }">
                            <tr>
                                <td>${bookingVO.bookingId }</td>
                                <td><a href="../booking/detail?bookingId=${bookingVO.bookingId }">${bookingVO.placeName }</a></td>
                                <fmt:formatDate value="${bookingVO.bookingDate }" pattern="yyyy-MM-dd" var="bookingDate" />
                                <td>${bookingDate }</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul class="bpagination">
                    <c:if test="${bpageMaker.isPrev() }">
                        <li class="page-item"><a class="page-link" href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.startNum - 1 }&pageSize=${bpagination.pageSize}">이전</a></li>
                    </c:if>
                    <c:forEach begin="${bpageMaker.startNum }" end="${bpageMaker.endNum }" var="num">
                        <li class="page-item"><a class="page-link" href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${num }&pageSize=${bpagination.pageSize}">${num }</a></li>
                    </c:forEach>
                    <c:if test="${bpageMaker.isNext() }">
                        <li class="page-item"><a class="page-link" href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.endNum + 1 }&pageSize=${bpagination.pageSize}">다음</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function pageChange() {
            let pageSize = document.getElementById('pageSize').value;
            location.href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.startNum }&pageSize=" + pageSize;
        }
    </script>
</body>
</html>

