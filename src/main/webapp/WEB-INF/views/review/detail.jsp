<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<style type="text/css">
.logo {
	text-align: center;
	margin: 20px 0;
}

.logo a {
	font-size: 2em;
	text-decoration: none;
	color: #333;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
}

main {
	width: 80%;
	margin: 20px auto;
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	font-size: 40px;
	font-weight: 900;
	color: #706FFF;
}

.review-details {
	margin-bottom: 10px;
}

.review-content textarea {
	width: 100%;
	resize: none;
}

.button-group {
	text-align: center;
	margin: 20px 0;
}

.button-group button {
	padding: 10px 20px;
	margin: 5px;
	border: none;
	background-color: #706FFF;
	color: white;
	cursor: pointer;
}

.button-group button:hover {
	background-color: #5a54ff;
}

#commentSelectAll {
	list-style-type: none;
	padding: 0;
}

#commentSelectAll li {
	border-bottom: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
}

.comment {
	margin-bottom: 10px;
}

.reply-list {
	padding-left: 20px;
}

.reply {
	border-top: 1px solid #ccc;
	padding-top: 10px;
	margin-top: 10px;
}

textarea {
	resize: none;
}
</style>
<title>${reviewVO.reviewTitle }</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="${pageContext.request.contextPath }/place/main">PlaceCloud</a>
		</div>
	</header>

	<h2
		style="text-align: center; font-size: 30px; font-weight: 900; color: #706FFF;">Q&A 및 이용후기 보기</h2>

	<div>
		<span>이용 후기 번호 : ${reviewVO.reviewId }</span> <input type="hidden" id="placeId" value="${reviewVO.placeId }"> 
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
		<fmt:formatDate value="${reviewVO.reviewDateCreated }"
			pattern="yyyy-MM-dd HH:mm:ss" var="reviewDateCreated" />
		<span>작성일 : ${reviewDateCreated }</span>
	</div>

	<div>
		<textarea rows="20" cols="120" readonly>${reviewVO.reviewContent }</textarea>
	</div>

	<button onclick="location.href='../review/list?placeId=${reviewVO.placeId}'">목록</button>
	<sec:authentication property="principal" var="user"/>	
	<sec:authorize access="isAuthenticated()">
		<c:if test="${reviewVO.memberEmail eq user.username }"> <!-- eq : equal (==) -->
			<button onclick="location.href='edit?reviewId=${reviewVO.reviewId}'">수정</button>
			<button id="deleteReview">삭제</button>
		</c:if>
	</sec:authorize>
	
	<hr>

	<div>
		<ul id="commentSelectAll">

		</ul>
	</div>
	<hr>
	<div id="writeComment">
		<input type="hidden" id="reviewId" value="${reviewVO.reviewId}">
		<p>
			<sec:authorize access="isAnonymous()">
				<a href="../auth/login">* 댓글을 작성하려면 로그인해 주세요.</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<label>댓글 작성</label><br>
				<input type="hidden" id="memberEmail" value="${user.username}">
				<textarea id="commentContent" name="commentContent" rows="5" cols="80" placeholder="댓글을 입력하세요" maxlength="50"></textarea>
				<br>
				<button name="commentBtn" id="commentBtn">작성</button>
			</sec:authorize>
		</p>
	</div>


	<form id="deleteForm" action="deleteReview" method="post">
		<input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
		<input type="hidden" name="placeId" value="${reviewVO.placeId }">
	</form>

	<div id="commentList"></div>

	<script type="text/javascript">
    
    function getCommentList() {
    	console.log('getCommentList()');
        var reviewId = $('#reviewId').val();
        console.log("확인 : " + reviewId);
        var memberEmail = $('#memberEmail').val();
        console.log("확인 : " + memberEmail);

        $.ajax({
            type: 'post',
            data: JSON.stringify({ reviewId: reviewId }),
            dataType: 'json', 
            contentType: 'application/json',
            url: '../comment/commentAllList',

            success: function(data) {
                console.log("Success: ", data);
                $('#commentSelectAll').empty();
                var selectAllView = '';
                
                if (data.length > 0) {
                    $.each(data, function(index, comment) {
                        var replaceContent = comment.commentContent;
                       
                        
                        // 날짜 이상하게 보여서 formatte
                        var commentDate = new Date(comment.commentDateCreated);
                        var formattedDate = commentDate.getFullYear() + '-' +
                                            ('0' + (commentDate.getMonth() + 1)).slice(-2) + '-' +
                                            ('0' + commentDate.getDate()).slice(-2) + ' ' +
                                            ('0' + commentDate.getHours()).slice(-2) + ':' +
                                            ('0' + commentDate.getMinutes()).slice(-2) + ':' +
                                            ('0' + commentDate.getSeconds()).slice(-2);
                        
                        // 댓글 리스트
                        selectAllView += '<li>댓글번호 &nbsp; '+ comment.commentId;
                        selectAllView += '<div class="comment" id="commentId' + comment.commentId + '">';
                        selectAllView += '<p>&nbsp;&nbsp;' + comment.memberEmail + '</p>';
                        selectAllView += '<p>&nbsp;&nbsp;' + replaceContent + '</p>';
                        selectAllView += '<p>&nbsp;&nbsp;' + formattedDate + '</p>';
						
                        // 댓글 작성한 이메일과 로그인한 이메일이 같으면
                        if(comment.memberEmail == memberEmail ) {
                        selectAllView += '<div class="row">';
                        selectAllView += '<div class="col-12">';
                        // 수정 및 삭제 버튼
                        selectAllView += '<button type="button" data-commentId="' + comment.commentId + '" class="mini token operator" onclick="updateAndDeleteCommentBtn(' + comment.commentId + ', \'' + formattedDate + '\', \'' + replaceContent + '\', \'' + comment.memberEmail + '\')" id="updateComment">수정 및 삭제</button>';
                        selectAllView += '</div></div>';
                        }
                        
                     	// 대댓글 작성 폼 
                        selectAllView += '<div id="replyForm' + comment.commentId + '" style="display:none;">';
                        selectAllView += '<textarea id="replyContent' + comment.commentId + '" rows="3" cols="50" maxlength="50"></textarea><br>';
                        selectAllView += '<button type="button" id="submitReply" onclick="submitReply(' + comment.commentId + ')">답글 등록</button>';
                        selectAllView += '</div>';
                        
                     	// 대댓글 보기 버튼
                     	selectAllView += '<button type="button" class="mini token operator" onclick="toggleReply(' + comment.commentId + ')">답글 보기/숨기기</button>';
						
                     	// 대댓글 리스트
                        selectAllView += '<div id="replyList' + comment.commentId + '" class="reply-list" style="display:none;"></div>';
	
                        selectAllView += '</div></li>';
						 
                    });
                                        
                } else {
                    selectAllView += '--등록된 댓글이 없습니다.--';
                }
                // append 추가
                $("#commentSelectAll").append(selectAllView);
            },
            error: function() {
                alert('통신 실패');
            }
        });
    } // end getCommentList()
    
 	// 대댓글 작성/리스트 폼 보이기/숨기기
    function toggleReply(commentId) {
        console.log('toggleReply()');
        var memberEmail = $('#memberEmail').val();
        var replyForm = $('#replyForm' + commentId);
        var replyList = $('#replyList' + commentId);

        if(replyForm.is(':visible')) {
            replyForm.hide();
            replyList.hide();
        } else {
            $.ajax({
                type: 'post',
                data: JSON.stringify({ commentId: commentId }),
                dataType: 'json', 
                contentType: 'application/json',
                url: '../reply/replies', 

                success: function(data) {
                    console.log("replies Success: ", data);
                    var repliesView = '';
                    if (data.length > 0) {
                        $.each(data, function(index, reply) {
                            var replaceContent = reply.replyContent;
                            
                            
                            var replyDate = new Date(reply.replyDateCreated);
                            var formattedDate = replyDate.getFullYear() + '-' +
                                                ('0' + (replyDate.getMonth() + 1)).slice(-2) + '-' +
                                                ('0' + replyDate.getDate()).slice(-2) + ' ' +
                                                ('0' + replyDate.getHours()).slice(-2) + ':' +
                                                ('0' + replyDate.getMinutes()).slice(-2) + ':' +
                                                ('0' + replyDate.getSeconds()).slice(-2);

                            repliesView += '<div class="reply" id="reply' + reply.replyId + '">';
                            repliesView += '<p>&nbsp;&nbsp;' + reply.memberEmail + ' / ' + formattedDate + '</p>';
                            repliesView += '<p id="replyContent' + reply.replyId + '">&nbsp;&nbsp;' + replaceContent + '</p>';
                            
                            if(memberEmail === reply.memberEmail) {
                                repliesView += '<button type="button" onclick="showEditReply(' + reply.replyId + ', ' + commentId + ')">수정</button>';
                                repliesView += '<button type="button" onclick="deleteReply(' + reply.replyId + ', ' + commentId + ')">삭제</button>';
                            }
                            
                            repliesView += '</div>';
                            
                        });
                    } else {
                        repliesView = '<p>--등록된 답글이 없습니다--</p>';
                    }
                    replyList.html(repliesView);
                    replyForm.show();
                    replyList.show();
                },
                error: function() {
                    alert('통신 실패');
                }
            });
        }
    } // end toggleReply()

    // 대댓글 수정 창 보이기
    function showEditReply(replyId, commentId) {
        var replyContent = $('#replyContent' + replyId).text().trim();
        
        var editForm = '<div id="editReplyForm' + replyId + '">';
        editForm += '<textarea id="editReplyContent' + replyId + '" rows="3" cols="50" maxlength="50">' + replyContent + '</textarea>';
        editForm += '<br>';
        editForm += '<button type="button" onclick="saveReply(' + replyId + ', ' + commentId + ')">저장</button>';
        editForm += '<button type="button" onclick="cancelEditReply(' + replyId + ')">취소</button>';
        editForm += '</div>';

        $('#reply' + replyId).append(editForm);
    }

    // 대댓글 수정 취소
    function cancelEditReply(replyId) {
        $('#editReplyForm' + replyId).remove();
    }
	
 	// 대댓글 수정
    function saveReply(replyId, commentId) {
        console.log('saveReply()');

        var editReplyContent = $('#editReplyContent' + replyId).val();

        if (editReplyContent == '') {
            alert('내용을 입력해주세요');
            return;
        }

        var obj = {
            'replyId': replyId,
            'replyContent': editReplyContent,
            'commentId': commentId
        };

        $.ajax({
            type: 'post',
            url: '../reply/repliesUpdate',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(data) {
                if (data === 'UpdateSuccess') {
                    alert('답글이 수정되었습니다');
                    toggleReply(commentId); 
                } else {
                    alert('답글 수정 실패');
                }
            },
            error: function() {
                alert('통신 실패');
            }
        }); // end ajax()
        
    } // end saveReply()
    
 	// 대댓글 등록 함수
    function submitReply(commentId) {
        console.log('submitReply()');
        
        var memberEmail = $('#memberEmail').val();
        var replyContent = $('#replyContent' + commentId).val();

        if (replyContent == '') {
            alert('내용을 입력해주세요');
            return;
        }

        var obj = {
            'commentId': commentId,
            'memberEmail': memberEmail,
            'replyContent': replyContent
        };

        $.ajax({
            type: 'post',
            url: '../reply/repliesInsert',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(data) {
                if (data === "InsertSuccess") {
                    alert('답글이 등록되었습니다');
                    toggleReply(commentId); 
                    $('#replyContent' + commentId).val('');
                } else {
                    alert('답글 등록 실패');
                }
            },
            error: function() {
                if(confirm('로그인 이후 이용이 가능합니다. 로그인 하시겠습니까?')){
                	location.href="../auth/login";
          
                }
            }
        }); // end ajax()
        
    } // end submitReply()
    
 	// 대댓글 삭제
    function deleteReply(replyId, commentId) {
 		console.log('deleteReply()');
 		
        if (confirm('답글을 정말 삭제하시겠습니까?')) {
            var obj = {
                'replyId': replyId,
                'commentId': commentId
            };

            $.ajax({
                type: 'post',
                url: '../reply/repliesDelete',
                data: JSON.stringify(obj),
                contentType: 'application/json',
                success: function(data) {
                    if (data === 'DeleteSuccess') {
                        alert('답글이 삭제되었습니다');
                        getCommentList();
                    } else {
                        alert('답글 삭제 실패');
                    }
                },
                error: function() {
                    alert('통신 실패');
                }
            });
        }
    } // end deleteReply()
    
    
 	// 댓글 등록 버튼
    $('#commentBtn').click(function() {
    	console.log('commentBtn()');
        var reviewId = $('#reviewId').val();
        var memberEmail = $('#memberEmail').val();
        var commentContent = $('#commentContent').val();
		
        
	    if (commentContent == '') {
        	alert("내용을 입력하세요");
            return;
        	}
	    
        var obj = {
            'reviewId': reviewId,
            'memberEmail': memberEmail,
            'commentContent': commentContent
        };

        $.ajax({
            type: 'post',
            url: '../comment/commentInsert',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(result) {
                if (result == "InsertSuccess") {
                    alert('댓글 등록 되었습니다');
                    $('#commentContent').val('');
                    getCommentList();
                } else {
                	alert('댓글 등록 실패');
                }
            },
            error: function() {
                alert('통신 실패');
            }
            
        }); // end ajax()
        
    }); // end feedbackBtn.click()
	
 	// 댓글 및 수정 버튼 눌렀을때
    function updateAndDeleteCommentBtn(commentId, commentDateCreated, commentContent, memberEmail) {
        console.log('updateAndDeleteCommentBtn()');
    	var updateCommentView = "";

        if ($('#commentId').val() != null) {
            alert("이미 수정 중인 댓글이 있습니다");
            return;
        }

        updateCommentView += '<div class="comment" style="white-space:pre" id="commentId' + commentId + '">';
        updateCommentView += '<p>&nbsp;&nbsp;' + memberEmail + ' / ' + commentDateCreated + '</p>';
        updateCommentView += '<p> <label>&nbsp;&nbsp;댓글 수정</label> <br>';
        updateCommentView += '<input type="hidden" id="commentId" name="commentId" value="' + commentId + '">';
        updateCommentView += '<textarea style="white-space:pre" id="updateContent' + commentId + '" class="mini2" rows="5" cols="80" maxlength="50" name="updateContent' + commentId + '" maxlength="300" placeholder="' + commentContent + '" autofocus>';
        updateCommentView += commentContent; 
        updateCommentView += '</textarea></p>';
        updateCommentView += '<div class="row">';
        updateCommentView += '<div class="col-12">';
        updateCommentView += '<button type="button" class="mini" id="updateContentBtn' + commentId + '" onclick="updateComment(' + commentId + ', \'' + reviewId + '\')">댓글 수정</button>';
        updateCommentView += '<button type="button" class="mini" onclick="cancel()">취소</button>';
        updateCommentView += '<button type="button" class="mini" onclick="deleteComment(' + commentId + ', \'' + reviewId + '\')">댓글 삭제</button>';
        updateCommentView += '</div></div>'; 
        updateCommentView += '</div>'; 

        $('#commentId' + commentId).replaceWith(updateCommentView);
        
    } // end updateAndDeleteCommentBtn()
	
 	// 댓글 수정 버튼
    function updateComment(commentId, reviewId) {
    	console.log('updateComment()');
    	var commentId = $('#commentId').val();
    	console.log('commentId 확인 :' + $('#commentId').val());
    	var reviewId = $('#reviewId').val();
    	console.log('reviewId 확인 : ' + $('#reviewId').val());
        var updateContent = $('#updateContent' + commentId).val();

        if (updateContent == '') {
            alert("수정할 내용을 입력하세요");
            return;
        }

        var obj = {
            "commentContent": updateContent,
            "commentId": commentId,
            "reviewId": reviewId 
        };

        $.ajax({
            type: 'post',
            url: '../comment/commentUpdate',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            success: function(data) {
                if (data === 'UpdateSuccess') {
                    alert('댓글이 수정되었습니다');
                    getCommentList();
                } else {
                    alert('댓글 수정 실패');
                }
            },
            error: function() {
                alert('통신 실패');
            }
            
        }); // end ajax()
        
    } // end updateComment()
	
    // 댓글 삭제 버튼
    function deleteComment(commentId, reviewId) {
    	console.log('deleteComment()');
    	var commentId = $('#commentId').val();
    	console.log('commentId 확인 :' + $('#commentId').val());
    	var reviewId = $('#reviewId').val();
    	console.log('reviewId 확인 : ' + $('#reviewId').val());
    	
    	
        if (confirm(commentId + "번 댓글을 정말 삭제하시겠습니까?")) {
            var obj = {
                "commentId": commentId,
                "reviewId": reviewId
            };

            $.ajax({
                type: 'post',
                url: '../comment/commentDelete',
                data: JSON.stringify(obj),
                contentType: 'application/json',
                success: function(data) {
                    if (data === 'DeleteSuccess') {
                        alert('댓글이 삭제되었습니다');
                        getCommentList();
                    } else {
                        alert('댓글 삭제 실패');
                    }
                },
                error: function() {
                    alert('통신 실패');
                }
                
            }); // end ajax()
        }
        
    } // end deleteComment()
	
    // 취소 버튼
    function cancel() {
    	console.log('cancel()');
    	getCommentList();
    	
    } // end cancel()
    
    $(document).ready(function() {
        getCommentList();
        
        // 게시판 삭제
        $('#deleteReview').click(function() {
            if (confirm('삭제하시겠습니까?')) {
                $('#deleteForm').submit(); 
            }
            
        }); // end deleteReview.click()
        
    }); // end document()

    </script>

</body>
</html>
