<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>찜 목록</title>
</head>
<body>
	<div>
		<h1>찜한 공간</h1>
		<br><br>
		<div>
			<div>
				<table class="table">
                    <thead>
                        <tr>
                            <th>예약 공간</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="likeListVO" items="${likeList }">
                            <tr>
                                <td><a href="../place/infoPlace?placeId=${likeListVO.placeId }">${likeListVO.placeName }</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
			</div>
		</div>
	</div>
</body>
</html>