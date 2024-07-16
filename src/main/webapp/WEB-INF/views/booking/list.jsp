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
<script type="text/javascript">
        // 페이지가 로드되면 실행되는 JavaScript 코드
        window.onload = function() {
            // 주소창 URL을 변경하는 예제
            history.pushState({}, 'Booking', '/placecloud/booking/list');
        };
</script>
<style>
.container {
	font-family: Arial, sans-serif;
	margin: 50px auto;
	max-width: 1200px;
	padding: 0 30px;
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

.booking-form input[type="date"], .booking-form input[type="submit"],
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

.booking-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.booking-item {
	background-color: #fff;
	border: 2px solid #706FFF;
	border-radius: 15px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	padding: 20px;
	width: calc(33.333% - 40px);
	box-sizing: border-box;
}

.booking-item a {
	text-decoration: none;
	color: #007bff;
	font-size: 18px;
	display: block;
	margin-bottom: 10px;
}

.booking-item a:hover {
	text-decoration: underline;
}

.booking-item p {
	margin: 5px 0;
	color: #343a40;
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
<%@include file="../fix/header.jsp"%>
<body>
	<div class="container">
		<h1>${member.memberName }님의 예약목록</h1>
		<button class="userInfo"
			onclick="location.href='/placecloud/member/myPage'">회원 정보</button>
		<br> <br>
		<div class="row">
			<div class="col-md-12">
				<form class="booking-form" action="../booking/list" method="get">
					<input type="date" id="startDate" name="startDate" value="${bpagination.startDate }">
					~&nbsp;
					<input type="date" id="endDate" name="endDate" value="${bpagination.endDate }">
					<input type="submit" value="검색"> <select class="pageSize"
						id="pageSize" name="pageSize" onChange="pageChange()">
						<option value="6"
							<c:if test="${bpagination.pageSize == 6 }">selected</c:if>>6개
							보기</option>
						<option value="12"
							<c:if test="${bpagination.pageSize == 12 }">selected</c:if>>12개
							보기</option>
						<option value="18"
							<c:if test="${bpagination.pageSize == 18 }">selected</c:if>>18개
							보기</option>
						<option value="24"
							<c:if test="${bpagination.pageSize == 24 }">selected</c:if>>24개
							보기</option>
					</select>
				</form>
				<br>
				<div class="booking-list">
					<c:forEach var="bookingVO" items="${bookingList }">
						<div class="booking-item">
							<p>예약 번호 : ${bookingVO.bookingId }</p>
							<a href="../booking/detail?bookingId=${bookingVO.bookingId }">${bookingVO.placeName }</a>
							<fmt:formatDate value="${bookingVO.bookingDate }"
								pattern="yyyy-MM-dd" var="bookingDate" />
							<p>예약 날짜: ${bookingDate }</p>
						</div>
					</c:forEach>
				</div>
				<ul class="bpagination">
					<c:if test="${bpageMaker.isPrev() }">
						<li class="page-item"><a class="page-link"
							href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.startNum - 1 }&pageSize=${bpagination.pageSize}">이전</a></li>
					</c:if>
					<c:forEach begin="${bpageMaker.startNum }"
						end="${bpageMaker.endNum }" var="num">
						<li class="page-item"><a class="page-link"
							href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${num }&pageSize=${bpagination.pageSize}">${num }</a></li>
					</c:forEach>
					<c:if test="${bpageMaker.isNext() }">
						<li class="page-item"><a class="page-link"
							href="list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.endNum + 1 }&pageSize=${bpagination.pageSize}">다음</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			let startdate = $('#startDate').val();
			let enddate = $('#endDate').val();
			
			if(startdate !== "" || enddate !== "") {
				document.getElementById('endDate').setAttribute('min', startdate);
				document.getElementById('startDate').setAttribute('max', enddate);	
			} 
						
			$('#startDate').change(function() {
				setDateMax();
			})
			
			function setDateMax() {
				console.log('setDateMax()');
				// 시작일의 값을 가져옴
				let startdate = $('#startDate').val();
				// 종료일의 최소값을 시작일로 설정
				document.getElementById('endDate').setAttribute('min', startdate);	
			}
			
			$('#endDate').change(function() {
				setDateMin();
			})
			
			function setDateMin() {
				console.log('setDateMin()');
				// 종료일의 값을 가져옴
				let enddate = $('#endDate').val();
				// 시작일의 최대값을 종료일로 설정
				document.getElementById('startDate').setAttribute('max', enddate);	
			}
			
		});
			
		
		function pageChange() {
			let pageSize = document.getElementById('pageSize').value;
			location.href = "list?startDate=${bpagination.startDate }&endDate=${bpagination.endDate }&pageNum=${bpageMaker.startNum }&pageSize="
					+ pageSize;
		}
	</script>
</body>
</html>

