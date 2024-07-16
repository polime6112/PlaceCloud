<%@page import="web.spring.placecloud.config.ServletConfig"%>
<%@page import="web.spring.placecloud.util.ImageUploadUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>장소 상세정보</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
    }
    header {
        background-color: #4CAF50;
        padding: 10px 0;
        text-align: center;
    }
    .logo a {
        color: white;
        font-size: 24px;
        text-decoration: none;
    }
    .container {
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .container input[type="text"], .container textarea {
        width: calc(100% - 22px);
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        font-size: 16px;
        background-color: #f9f9f9;
    }
    
    textarea {
    	resize: none;
    }
    
    .container p {
        font-size: 14px;
        color: #666;
    }
    .image-container {
        margin-top: 20px;
        text-align: center;
    }
    .image {
        max-width: 100%;
        max-height: 400px;
        border: 1px solid #ddd;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    .button-container {
        margin-top: 20px;
        text-align: center;
    }
    .button-container button, .button-container a {
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        margin: 5px;
        text-decoration: none;
        font-size: 16px;
    }
    .button-container button:hover, .button-container a:hover {
        background-color: #0056b3;
    }
    .container button, .container a {
        display: inline-block;
        padding: 10px 20px;
        margin: 5px 0;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .container button:hover, .container a:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>
	<br>
	<br>
	<sec:authentication property="principal" var="principal"/>
	<sec:authorize access="isAuthenticated()">
		<input type="hidden" name="memberEmail" id="memberEmail" value="${principal.member.memberEmail}">	
	</sec:authorize>
	<input type="hidden" name="placeId" id="placeId" value="${placeVO.placeId }">
	<fmt:formatDate value="${placeVO.placeCreateDate }" pattern="yyyy-MM-dd HH:mm:ss" var="placeCreateDate" />
	<p>작성일 : ${placeCreateDate }</p>
	장소 이름 <input type="text" id="placeName" value="${placeVO.placeName }" readonly><br>
	<br> 카테고리 <input type="text" id="placeCategory" value="${placeVO.placeCategory }" readonly><br>
	<br> 장소 설명<br><br> <textarea rows="4" cols="20" id="placeContext" readonly>${placeVO.placeContext }</textarea><br>
	<br> 주소 <input type="text" id="placeAddress" value="${placeVO.placeAddress }" readonly><br>
	<br> 주의사항<br><br> <textarea rows="4" cols="20" id="placeWarning" readonly>${placeVO.placeWarning }</textarea><br>
	<br> 장소 설비<br><br> <textarea rows="4" cols="20" id="placeInfo" readonly>${placeVO.placeInfo }</textarea><br>
	<br> 시간당 가격(원/시간) <input type="text" id="placeMoneyTime" value="${placeVO.placeMoneyTime }" readonly><br>
	<br>
	<c:if test="${not empty placeVO }">
		<img class="image" src="../image/display?imagePath=${placeVO.imagePath }&imageChgName=${placeVO.imageChgName}
									&imageExtension=${placeVO.imageExtension}" alt="이미지 로딩 실패">
	</c:if>
	<br>
	<div>
		<!-- 비회원 상태 -->
		<sec:authorize access="isAnonymous()">
			<button id="bookingBtn">예약 하기</button>
			<div id="likePlace"></div>
		</sec:authorize>
		<!-- 게스트 권한 확인 -->
		<sec:authorize access="hasRole('ROLE_GUEST')">
			<button id="bookingBtn">예약 하기</button>
			<div id="likePlace"></div>
		</sec:authorize>
		<!-- 호스트 권한 확인 -->
		<sec:authorize access="hasRole('ROLE_HOST')">
			<div>
				<c:if test="${principal.username == placeVO.memberEmail }">
				<br> <button name="update" onclick="location.href='../host/update?placeId=${placeVO.placeId}'">장소 정보 수정</button><br>
				<br> <button name="delete" onclick="location.href='../host/delete?placeId=${placeVO.placeId}'">장소 삭제</button>
				</c:if>
			</div>
		</sec:authorize>
		<button id="Q&A" onclick="location.href='../review/list?placeId=${placeVO.placeId }'">이용 후기, Q&A 관리</button>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			getLike();
			let memberEmail = $('#memberEmail').val();
			$('#bookingBtn').click(function(){
				if(memberEmail != null) {
					console.log("작동?");
					location.href="${pageContext.request.contextPath}/booking/insert?placeId=${placeVO.placeId}";
				} else {
					console.log("작동?");
					if(confirm('로그인 이후 이용이 가능합니다. 로그인 하시겠습니까?')){
						console.log("작동?");
						location.href="../auth/login";
					}
				}
			});
			
			// 관심 장소 등록 여부 검사
			function getLike() {
				let memberEmail = $('#memberEmail').val();
				let placeId = $('#placeId').val();
				console.log("memberEmail : " + memberEmail + " / placeId : " + placeId);
				
				let url = '../like/selectOne/' + memberEmail + '/' + placeId;
				console.log("url : " + url);
				$('#likePlace').html('<button class="likeBtn_insert">찜 하기</button>');
				if(memberEmail != '') {
					$.getJSON(
						url,
						function(data) {
							console.log("data : " + data);
								
							let likeData = '';
								
							if(data != '') {
								likeData = '<button class="likeBtn_delete">찜 취소</button>';
							}
							$('#likePlace').html(likeData);
						} // end function()
					); // end getJSON()
				}
			} // end getLike()
			
			
			// 찜 하기 버튼
			$('#likePlace').on('click', '.likeBtn_insert', function(){
				console.log(this);
				if(memberEmail != null) {
					let memberEmail = $('#memberEmail').val();
					let placeId = $('#placeId').val();
					let placeName = $('#placeName').val();
					
					let likeObj = {
							'memberEmail' : memberEmail,
							'placeId' : placeId,
							'placeName' : placeName
					}
					console.log(likeObj);
					console.log("작동?");
					// ajax 송수신
					$.ajax({
						type : 'POST',
						url : '../like/insert',
						headers : {
							'Content-Type' : 'application/json'
						},
						data : JSON.stringify(likeObj),
						success : function(result) {
							console.log(result);
							if(result == 1) {
								getLike();
							}
						}
					}); 
				} else {
					console.log("작동?");
					if(confirm('로그인 이후 이용이 가능합니다. 로그인 하시겠습니까?')){
						console.log("작동?");
						location.href="../auth/login";
					}
				}
				
				
			}); // end likeBtn_insert.on
			
			// 찜 삭제 버튼
			$('#likePlace').on('click', '.likeBtn_delete', function(){
				console.log(this);
				let memberEmail = $('#memberEmail').val();
				let placeId = $('#placeId').val();
				
				$.ajax({
					type : 'DELETE',
					url : '../like/' + memberEmail + '/' + placeId,
					headers : {
						'Content-Type' : 'application/json'
					},
					success : function(result) {
						console.log(result);
						if(result == 1) {
							getLike();
						}
					}
				}) 
			}); // end likeBtn_delete.on
			
		}); // end document()
	</script>
	
</body>
</html>
