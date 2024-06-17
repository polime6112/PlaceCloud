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
        $(document).ready(function(){
        	getFeedbackList();
        	
            $('#deleteReview').click(function(){
                if(confirm('삭제하시겠습니까?')) {
                    $('#deleteForm').submit(); 
                }
            }); // end deleteReview.click()
            
            $('#feedbackBtn').click(function(){
                var reviewId = $('#reviewId').val(); // 게시판 번호
                var memberEmail = $('#memberEmail').val(); // 회원 이메일
                var feedbackContent = $('#feedbackContent').val(); // 댓글 내용

                var obj = {
                    'reviewId' : reviewId,
                    'memberEmail' : memberEmail,
                    'feedbackContent' : feedbackContent
                };

                console.log(obj);

                $.ajax({
                    type : 'post',
                    url  : '../feedback/feedbackInsert',
                    data : obj, 
                    success : function(result) {
                        console.log(result); 
                        if(result == "InsertSuccess") {
                            console.log('성공');
                            alert('댓글 등록');
                            getFeedbackList();
                        } else {
                            console.log('실패');
                            alert('댓글 등록 실패');
                        }
                    } // end success
                }); // end ajax()
            }); // end feedbackBtn.click()

            function getFeedbackList() {
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
                        $('#feedbackSelectAll').empty();
                        var selectAllView = '';
                        console.log(data);

                        if (data.length > 0) {
                            $.each(data, function(index, feedback) {
                                var replaceContent = feedback.feedbackContent;
                                replaceContent = replaceContent.replaceAll("&", "&amp;");
                                replaceContent = replaceContent.replaceAll("\n", " ");
                                replaceContent = replaceContent.replaceAll("'", " ");
                                replaceContent = replaceContent.replaceAll("<", "&lt;");
                                replaceContent = replaceContent.replaceAll(">", "&gt;");
                                replaceContent = replaceContent.replaceAll("\"", "&quot;");
								
                                // 날짜 변환
                                var feedbackDate = new Date(feedback.feedbackDateCreated);
                                var formattedDate = feedbackDate.getFullYear() + '-' +
                                                    ('0' + (feedbackDate.getMonth() + 1)).slice(-2) + '-' +
                                                    ('0' + feedbackDate.getDate()).slice(-2) + ' ' +
                                                    ('0' + feedbackDate.getHours()).slice(-2) + ':' +
                                                    ('0' + feedbackDate.getMinutes()).slice(-2) + ':' +
                                                    ('0' + feedbackDate.getSeconds()).slice(-2);
                                
                                selectAllView += '<div class="feedback" id="feedbackId' + feedback.feedbackId + '">';
                                selectAllView += '<p>&nbsp;&nbsp;' + feedback.memberEmail + '</p>';
                                selectAllView += '<p>&nbsp;&nbsp;' + replaceContent + '</p>';
                                selectAllView += '<p>&nbsp;&nbsp;' + formattedDate + '</p>';
                                
                                if (memberEmail === feedback.memberEmail) {
                                    selectAllView += '<div class="row">';
                                    selectAllView += '<div class="col-12">';
/*                                     selectAllView += '<button type="button" class="editBtn" data-feedbackId="' + feedback.feedbackId + '">수정</button>';
                                    selectAllView += '<button type="button" class="deleteBtn" data-feedbackId="' + feedback.feedbackId + '">삭제</button>'; */
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
                        alert('실패');
                    }
                
                }); // end ajax
            
            } // end getFeedbackList()
            
        }); // end document.ready()
    </script>
    
</body>
</html>
