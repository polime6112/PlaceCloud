<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>이용후기 게시판</title>
<style>
body {
	font-family: Arial, sans-serif;
	line-height: 1.6;
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

h1 {
	text-align: center;
	font-size: 40px;
	font-weight: 900;
	color: #706FFF;
	margin-bottom: 20px;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

#searchForm {
	text-align: right;
}

.type-box {
	padding: 5px;
	margin-right: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table th, table td {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
}

table th {
	background-color: #f2f2f2;
	font-weight: bold;
	text-transform: uppercase;
}

.pagination {
	list-style-type: none;
	text-align: center;
	padding: 0;
	margin-top: 20px;
}

.pagination li {
	display: inline-block;
	margin-right: 5px;
}

.pagination li a {
	display: block;
	padding: 8px 12px;
	text-decoration: none;
	color: #333;
	background-color: #f2f2f2;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.pagination li a:hover {
	background-color: #e0e0e0;
}

#createBtn {
	padding: 8px 16px;
	font-size: 14px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 4px;
}

#createBtn:hover {
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

    <h1 style="text-align: center; font-size: 30px; font-weight: 900; color: #706FFF;">Q&A 및 이용후기</h1>
    <div class="top-bar">
        <input id="createBtn" type="button" value="글 작성">
        <form id="searchForm" action="list" method="get">
            <select name="type" class="type-box">
                <option value="reviewTitle" ${pagination.type == 'reviewTitle'?'selected':'' }>제목</option>
                <option value="memberEmail" ${pagination.type == 'memberEmail'?'selected':'' }>작성자</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어 입력">
            <input type="submit" value="검색">
        </form>
    </div>
    <hr>
    <table>
        <thead>
            <tr>
                <th style="width: 60px">게시판 번호</th>
                <th style="width: 60px">장소 번호</th>
                <th style="width: 700px">제목</th>
                <th style="width: 120px">작성자</th>
                <th style="width: 100px">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="reviewVO" items="${reviewList }">
            	<input type="hidden" id="placeId" value="${placeId }">
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
    <ul class="pagination">
        <!-- 이전 버튼 생성을 위한 조건문 -->
        <c:if test="${pageMaker.isPrev() }">
            <li class="css1"><a class="css2" href="list?type=${pagination.type }&keyword=${pagination.keyword }&pageNum=${pageMaker.startNum - 1}&pageSize=${pagination.pageSize}">이전</a></li>
        </c:if>
        <!-- 반복문으로 시작 번호부터 끝 번호까지 생성 -->
        <c:forEach begin="${pageMaker.startNum }" end="${pageMaker.endNum }" var="num">
            <li class="css1"><a class="css2" href="list?type=${pagination.type }&keyword=${pagination.keyword }&pageNum=${num }&pageSize=${pagination.pageSize }">${num }</a></li>
        </c:forEach>
        <!-- 다음 버튼 생성을 위한 조건문 -->
        <c:if test="${pageMaker.isNext() }">
            <li class="css1"><a class="css2" href="list?type=${pagination.type }&keyword=${pagination.keyword }&pageNum=${pageMaker.endNum + 1}&pageSize=${pagination.pageSize}">다음</a></li>
        </c:if>
    </ul>

    <script type="text/javascript">
        $(document).ready(function(){
            $('#createBtn').click(function(){
                location.href="${pageContext.request.contextPath}/review/register?placeId=${placeId}";
                
            }); // end createBtn.click()
        }); // end document()
    </script>

</body>
</html>
