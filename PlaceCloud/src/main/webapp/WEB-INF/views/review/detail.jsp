<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>${reviewVO.reviewTitle }</title>
</head>
<body>
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath }/member/memberMain">PlaceCloud</a>
        </div>
    </header>

    <h2 style="text-align: center; font-size: 40px; font-weight: 900; color: #706FFF;">이용 후기 보기</h2>
    
    <div>
        <span>이용 후기 번호 : ${reviewVO.reviewId }</span>
        <input type="hidden" id="reviewId" value="${reviewVO.reviewId}">
    </div>
    
    <div>
        <span>제목 : ${reviewVO.reviewTitle }</span>
    </div>
    
    <div>
        <span>작성자 : ${reviewVO.memberEmail }</span>
    </div>
    
    <div>
        <!-- boardDateCreated 데이터 포멧 변경 -->
        <fmt:formatDate value="${reviewVO.reviewDateCreated }" pattern="yyyy-MM-dd HH:mm:ss" var="reviewDateCreated"/>
        <span>작성일 : ${reviewDateCreated }</span>
    </div>
    
    <div>
        <textarea rows="20" cols="120" readonly>${reviewVO.reviewContent }</textarea>
    </div>
   
    <button onclick="location.href='list'">이용 후기 목록</button>
    <c:if test="${sessionScope.login != null && sessionScope.login.memberEmail == reviewVO.memberEmail}">
        <button onclick="location.href='edit?reviewId=${reviewVO.reviewId}'">이용 후기 수정</button>
        <button id="deleteReview">이용 후기 삭제</button>
    </c:if>
    <hr>
    <c:if test="${sessionScope.login != null}">
        <div>
        	<ul id="feedbackSelectAll">
        	
        	</ul>
        </div>
        <hr>
        <div id="writeComment">
        	<input type="hidden" id="reviewId" value="${reviewVO.reviewId}">
        	<input type="hidden" id="memberEmail" value="${sessionScope.login.memberEmail}">
            <p>
                <label>댓글 등록</label><br>
                <textarea id="feedbackContent" name="feedbackContent" rows="5" cols="80" placeholder="댓글을 입력하세요" maxlength="300"></textarea>
            </p>
            <div class="Comment1">
                <label>댓글 작성자</label>
                <input type="text" name="memberEmail" id="memberEmail" value="${sessionScope.login.memberEmail}" readonly><br>
            </div>
            <div class="Comment2">
                <button name="feedbackBtn" id="feedbackBtn" type="submit">댓글 작성</button>   	   	   	
            </div>        
        </div>
    </c:if>
   
    <form id="deleteForm" action="deleteReview" method="post">
        <input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
    </form>
   
    <div id="feedbackList"></div>
   
    <script type="text/javascript">
    
    function getFeedbackList() {
    	console.log('getFeedbackList()');
        var reviewId = $('#reviewId').val();
        console.log("확인 : " + reviewId);
        var memberEmail = $('#memberEmail').val();
        console.log("확인 : " + memberEmail);

        $.ajax({
            type: 'post',
            data: JSON.stringify({ reviewId: reviewId }),
            dataType: 'json', 
            contentType: 'application/json',
            url: '../feedback/feedbackAllList',

            success: function(data) {
                console.log("Success: ", data);
                $('#feedbackSelectAll').empty();
                var selectAllView = '';
                
                if (data.length > 0) {
                    $.each(data, function(index, feedback) {
                        var replaceContent = feedback.feedbackContent;
                        replaceContent = replaceContent.replaceAll("&", "&amp;");
                        replaceContent = replaceContent.replaceAll("\n", " ");
                        replaceContent = replaceContent.replaceAll("'", " ");
                        replaceContent = replaceContent.replaceAll("<", "&lt;");
                        replaceContent = replaceContent.replaceAll(">", "&gt;");
                        replaceContent = replaceContent.replaceAll("\"", "&quot;");
                        
                        var feedbackDate = new Date(feedback.feedbackDateCreated);
                        var formattedDate = feedbackDate.getFullYear() + '-' +
                                            ('0' + (feedbackDate.getMonth() + 1)).slice(-2) + '-' +
                                            ('0' + feedbackDate.getDate()).slice(-2) + ' ' +
                                            ('0' + feedbackDate.getHours()).slice(-2) + ':' +
                                            ('0' + feedbackDate.getMinutes()).slice(-2) + ':' +
                                            ('0' + feedbackDate.getSeconds()).slice(-2);
                        
                        selectAllView += '<li>댓글번호 &nbsp; '+ feedback.feedbackId;
                        selectAllView += '<div class="feedback" id="feedbackId' + feedback.feedbackId + '">';
                        selectAllView += '<p>&nbsp;&nbsp;' + feedback.memberEmail + '</p>';
                        selectAllView += '<p>&nbsp;&nbsp;' + replaceContent + '</p>';
                        selectAllView += '<p>&nbsp;&nbsp;' + formattedDate + '</p>';

                        if (memberEmail === feedback.memberEmail) {
                            selectAllView += '<div class="row">';
                            selectAllView += '<div class="col-12">';
                            selectAllView += '<button type="button" data-feedbackId="' + feedback.feedbackId + '" class="mini token operator" onclick="updateAndDeleteFeedbackBtn(' + feedback.feedbackId + ', \'' + formattedDate + '\', \'' + replaceContent + '\', \'' + feedback.memberEmail + '\')" id="updateFeedback">수정 및 삭제</button>';
                            selectAllView += '</div></div>';
                        }

                        selectAllView += '</div></li>';
                    });
                } else {
                    selectAllView += '--등록된 댓글이 없습니다.--';
                }
                $("#feedbackSelectAll").append(selectAllView);
            },
            error: function() {
                alert('통신 실패');
            }
        });
    }

    $('#feedbackBtn').click(function() {
    	console.log('feedbackBt')
        var reviewId = $('#reviewId').val();
        var memberEmail = $('#memberEmail').val();
        var feedbackContent = $('#feedbackContent').val();

        if (feedbackContent == '') {
            alert("내용을 입력하세요");
            return;
        }

        var obj = {
            'reviewId': reviewId,
            'memberEmail': memberEmail,
            'feedbackContent': feedbackContent
        };

        $.ajax({
            type: 'post',
            url: '../feedback/feedbackInsert',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(result) {
                if (result == "InsertSuccess") {
                    alert('댓글 등록 되었습니다');
                    $('#feedbackContent').val('');
                    getFeedbackList();
                } else {
                    alert('댓글 등록 실패');
                }
            },
            error: function() {
                alert('통신 실패');
            }
        });
    });

    function updateAndDeleteFeedbackBtn(feedbackId, feedbackDateCreated, content, memberEmail) {
        console.log('updateAndDeleteFeedbackBtn()');
    	var updateFeedbackView = "";

        if ($('#feedbackId').val() != null) {
            alert("이미 수정 중인 댓글이 있습니다");
            return;
        }

        updateFeedbackView += '<div class="feedback" style="white-space:pre" id="feedbackno' + feedbackId + '">';
        updateFeedbackView += '<p>&nbsp;&nbsp;' + memberEmail + ' / ' + feedbackDateCreated + '</p>';
        updateFeedbackView += '<p> <label>&nbsp;&nbsp;댓글 수정</label> <br>';
        updateFeedbackView += '<input type="hidden" id="feedbackId" name="feedbackId" value="' + feedbackId + '">';
        updateFeedbackView += '<textarea style="white-space:pre" id="updateContent' + feedbackId + '" class="mini2" rows="5" cols="80" name="updateContent' + feedbackId + '" maxlength="300" placeholder="' + content + '" autofocus>';
        updateFeedbackView += content; 
        updateFeedbackView += '</textarea></p>';
        updateFeedbackView += '<div class="row">';
        updateFeedbackView += '<div class="col-12">';
        updateFeedbackView += '<button type="button" class="mini" id="updateContentBtn' + feedbackId + '" onclick="updateFeedback(' + feedbackId + ', \'' + reviewId + '\')">댓글 수정</button>';
        updateFeedbackView += '<button type="button" class="mini" onclick="cancel()">취소</button>';
        updateFeedbackView += '<button type="button" class="mini" onclick="deleteFeedback(' + feedbackId + ', \'' + reviewId + '\')">댓글 삭제</button>';
        updateFeedbackView += '</div></div>'; 
        updateFeedbackView += '</div>'; 

        $('#feedbackId' + feedbackId).replaceWith(updateFeedbackView);
    }

    function updateFeedback(feedbackId, reviewId) {
    	console.log('updateFeedback()');
    	var feedbackId = $('#feedbackId').val();
    	console.log('feedbackId 확인 :' + $('#feedbackId').val());
    	var reviewId = $('#reviewId').val();
    	console.log('reviewId 확인 : ' + $('#reviewId').val());
        var updateContent = $('#updateContent' + feedbackId).val();

        if (updateContent == '') {
            alert("수정할 내용을 입력하세요");
            return;
        }

        var obj = {
            "feedbackContent": updateContent,
            "feedbackId": feedbackId,
            "reviewId": reviewId // reviewId 추가
        };

        $.ajax({
            type: 'post',
            url: '../feedback/feedbackUpdate',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(data) {
                if (data === 'UpdateSuccess') {
                    alert('댓글이 수정되었습니다');
                    getFeedbackList();
                } else {
                    alert('댓글 수정 실패');
                }
            },
            error: function() {
                alert('통신 실패');
            }
        });
    }

    function deleteFeedback(feedbackId, reviewId) {
    	console.log('deleteFeedback()');
    	var feedbackId = $('#feedbackId').val();
    	console.log('feedbackId 확인 :' + $('#feedbackId').val());
    	var reviewId = $('#reviewId').val();
    	console.log('reviewId 확인 : ' + $('#reviewId').val());
    	
    	
        if (confirm(feedbackId + "번 댓글을 정말 삭제하시겠습니까?")) {
            var obj = {
                "feedbackId": feedbackId,
                "reviewId": reviewId
            };

            $.ajax({
                type: 'post',
                url: '../feedback/feedbackDelete',
                data: JSON.stringify(obj),
                contentType: 'application/json',
                success: function(data) {
                    if (data === 'DeleteSuccess') {
                        alert('댓글이 삭제되었습니다');
                        getFeedbackList();
                    } else {
                        alert('댓글 삭제 실패');
                    }
                },
                error: function() {
                    alert('통신 실패');
                }
            });
        }
    }
	
    function cancel() {
    	console.log('cancel()');
    	getFeedbackList();
    }
    $(document).ready(function() {
        getFeedbackList();
        
        $('#deleteReview').click(function() {
            if (confirm('삭제하시겠습니까?')) {
                $('#deleteForm').submit(); 
            }
        });
    });

    </script>
    
</body>
</html>
