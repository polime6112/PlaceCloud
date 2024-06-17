<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용후기 게시판</title>
<style>
ul {
	list-style-type: none;
	text-align: center;
}

li {
	display: inline-block;
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
		</div>
	</header>

	<h1 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">이용후기</h1>
	<a href="register"><input type="button" value="글 작성"></a>
	<form id="searchForm" action="list" method="get">
		<select name="type" class="type-box">
			<option value="reviewTitle" <c:out value='${param.type == "reviewTitle" ? "selected" : ""}'/>>제목</option>
			<option value="memberEmail" <c:out value='${param.type == "memberEmail" ? "selected" : ""}'/>>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어 입력">
    	<input type="submit" value="검색">
	</form>
	<hr>
	<table>
		<thead>
			<tr>
				<th style="width: 60px">이용후기 번호</th>
				<th style="width: 60px">장소 번호</th>
				<th style="width: 700px">제목</th>
				<th style="width: 120px">작성자</th>
				<th style="width: 100px">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="reviewVO" items="${reviewList }">
				<tr>
					<td>${reviewVO.reviewId }</td>
					<td>${reviewVO.placeId }</td>
					<td><a href="detail?reviewId=${reviewVO.reviewId }">${reviewVO.reviewTitle }</a></td>
					<td>${reviewVO.memberEmail }</td>
					<!-- reviewDateCreated 데이터 포멧 변경 -->
					<fmt:formatDate value="${reviewVO.reviewDateCreated }"
						pattern="yyyy-MM-dd HH:mm:ss" var="reviewDateCreated" />
					<td>${reviewDateCreated }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<ul>
		<!-- 이전 버튼 생성을 위한 조건문 -->
		<c:if test="${pageMaker.isPrev() }">
			<li><a href="list?pageNum=${pageMaker.startNum - 1}&type=${param.type}&keyword=${param.keyword}">이전</a></li>
		</c:if>
		<!-- 반복문으로 시작 번호부터 끝 번호까지 생성 -->
		<c:forEach begin="${pageMaker.startNum }" end="${pageMaker.endNum }"
			var="num">
			<li><a href="list?pageNum=${num }&type=${param.type}&keyword=${param.keyword}">${num }</a></li>
		</c:forEach>
		<!-- 다음 버튼 생성을 위한 조건문 -->
		<c:if test="${pageMaker.isNext() }">
			<li><a href="list?pageNum=${pageMaker.endNum + 1}&type=${param.type}&keyword=${param.keyword}">다음</a></li>
		</c:if>
	</ul>

</body>
</html>