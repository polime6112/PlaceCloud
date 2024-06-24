<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookingCancel</title>
</head>
<body>
	<input type="hidden" name="placeId" value="${bookingVO.placeId }">
	<script type="text/javascript">
		alert('결제가 취소되었습니다!');
		location.href="bookingInsert?placeId="${placeId};
	</script>
</body>
</html>