<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 상세정보</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<button name="mainPlace" onclick="location.href='../place/myPlace?memberEmail=${sessionScope.login.memberEmail}'">등록한 장소들</button>
	</c:if>
	<br>
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<input type="text" id="memberName" value="${placeVO.memberEmail }">
		<div id="likePlace"></div>
		<button id="like"></button>
	</c:if>
	<input type="hidden" id="memberEmail" value="${placeVO.memberEmail }">
	<input type="hidden" id="placeId" value="${placeVO.placeId }">
	<fmt:formatDate value="${placeVO.placeCreateDate }" pattern="yyyy-MM-dd HH:mm:ss" var="placeCreateDate" />
	<p>작성일 : ${placeCreateDate }</p>
	장소 이름 <input type="text" id="placeName" value="${placeVO.placeName }" readonly><br>
	<br> 카테고리 <input type="text" id="placeCategory" value="${placeVO.placeCategory }" readonly><br>
	<br> 장소 설명 <input type="text" id="placeContext" value="${placeVO.placeContext }" readonly><br>
	<br> 주소 <input type="text" id="placeAddress" value="${placeVO.placeAddress }" readonly><br>
	<br> 주의사항 <input type="text" id="placeWarning" value="${placeVO.placeWarning }" readonly><br>
	<br> 장소 설비 <input type="text" id="placeInfo" value="${placeVO.placeInfo }" readonly><br>
	<br> 시간당 가격(원/시간) <input type="text" id="placeMoneyTime" value="${placeVO.placeMoneyTime }" readonly><br>
	<br>
<%-- 	<input type="text" id="uploadPath" value="${uploadPath }" readonly>
   	<input type="text" id="imagePath" value="${imageVO.imagePath }" readonly>
   	<input type="text" id="imageName" value="${imageVO.imageName }" readonly>
   	<input type="text" id="imageExtension" value="${imageVO.imageExtension }" readonly> --%>
	<%-- <c:if test="${not empty imageVO }">
	<input type="text" id="img" value="${uploadPath }/${imageVO.imagePath}/${imageVO.imageName}.${imageVO.imageExtension}" readonly>
		<img src="${uploadPath}/${imageVO.imagePath}/${imageVO.imageName}.${imageVO.imageExtension}" alt="이미지 로딩 실패">
	</c:if> --%>
	
	<br>
	<c:if test="${sessionScope.login.memberStatus == 'guest' }">
		<a href="${pageContext.request.contextPath}/booking/bookingInsert?placeId=${placeVO.placeId}">예약 하기</a>
	</c:if>
	
	<c:if test="${sessionScope.login.memberStatus == 'host' }">
		<br> <button name="updatePlace" onclick="location.href='../place/updatePlace?placeId=${placeVO.placeId}'">장소 정보 수정</button><br>
		<br> <button name="upload" onclick="location.href='../image/upload?placeId=${placeVO.placeId}'">장소 사진 추가</button><br>
		<br> <button name="deletePlace" onclick="location.href='../place/deletePlace?placeId=${placeVO.placeId}&memberEmail=${placeVO.memberEmail}'">장소 삭제</button>
	</c:if>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			// 찜하기 기능
			$('#like').click(function(){
				let userEmail = $('#memberEmail').val(); // 찜한 계정 정보
				let placeId = $('#placeId').val(); // 찜한 장소 번호
				let placeName = $('#placeName').val(); // 찜한 장소 이름
				
				// javascript 객체 생성
				let obj = {
						'userEmail' : userEmail,
						'placeId' : placeId,
						'placeName' : placeName
				}
				console.log(obj);
				
				// ajax 송수신
				$.ajax({
					type : 'POST', // 메서드 타입
					url : '../like', // url
					headers : { // 헤더 정보
						'Content-Type' : 'application/json' // json content-type 설정
					},
					date : JSON.stringify(obj), // JSON으로 변환
					success : function(result) { // 전송 성공 시 서버에서 result 값 전송
						console.log(result);
						if (result == 1) {
							alert('찜 하기 성공');
							getLike();
						}
					}
				})
			}) // end like.clike()
			
			function getLike() {
				let placeId = $('#boardId').val();
				
				let url = '../'
			}
			
			
		})
		
		
	</script>
	
</body>
</html>
