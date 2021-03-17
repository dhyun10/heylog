<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${replyList}">
<div class="bReply">
	<span style="font-weight: bold;">${vo.userNick}</span>
	<c:if test="${vo.secretType==true}">
		<i class="fas fa-lock"></i>
	</c:if>
	<p>
		<span>
			<span class="contents">${vo.content}</span>
			<span style="margin:0px 5px; font-size: 12px; color: #858585;">${vo.created}</span>
		</span>
		<span class="replybtn" style="float: right; display: none;">
			<a class="replybtn1 answerReply" data-replyNum="${vo.replyNum}">답글쓰기</a>
			<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId==userId}">				
				<a class="replybtn1 updateReply" data-replyNum="${vo.replyNum}">수정</a>/
				<a class="replybtn1 deleteReply" data-replyNum="${vo.replyNum}">삭제</a>
			</c:if>
		</span>
	</p>
	<div style="display: none;">
		<textarea class="answer"></textarea>
		<button class="sendReply">댓글쓰기</button>
	</div>
</div>
</c:forEach>