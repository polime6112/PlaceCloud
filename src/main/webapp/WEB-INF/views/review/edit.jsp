<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${reviewVO.reviewTitle }</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>
	
	<h2 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">리뷰 수정</h2>
	<form id="editForm" action="edit" method="post">
		<div>
			<span>리뷰 번호 : </span>
			<input type="text" name="reviewId" value="${reviewVO.reviewId }" readonly>
		</div>
		
		<div>
			<span>리뷰 제목 : </span>
			<input type="text" name="reviewTitle" placeholder="리뷰 제목" maxlength="20" value="${reviewVO.reviewTitle }" required>
		</div>
		
		<div>
			<span> 작성자 : ${reviewVO.memberEmail }</span>
		</div>
		
		<div>
			<span>내용 : </span>
			<textarea rows="20" cols="120" name="reviewContent" placeholder="내용 입력"  maxlength="300" required>${reviewVO.reviewContent }</textarea>
		</div>
		
		<div>
			<input type="submit" value="수정">
		</div>	
	</form>
</body>
</html>