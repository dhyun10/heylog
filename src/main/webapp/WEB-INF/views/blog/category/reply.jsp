<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${replyList}">
<div class="bReply">
	<c:choose>
		<c:when test="${vo.secretType==true && sessionScope.member.userId!=vo.userId && sessionScope.member.userId!=userId}">
			<div style="padding: 20px;"><i class="fas fa-lock">&nbsp;</i>비밀댓글입니다.</div>
		</c:when>
		<c:otherwise>
	<c:forEach begin="1" end="${vo.depth}">
		<span style="margin-right: 35px;"></span>
	</c:forEach>
	<img src="${pageContext.request.contextPath}/uploads/blog/${vo.thumbnail}">
	<div style="display: inline-block; vertical-align: middle;">
		<span style="font-weight: bold;">${vo.userNick}
			<c:if test="${vo.secretType==true}">&nbsp;
				<i class="fas fa-lock"></i>
			</c:if>
		</span>
		<p>	
			<span>
				<c:if test="${vo.depth>1}">
					<span style="color: #ff4646; font-size: 12px;">@${vo.replyUser}&nbsp;</span>
				</c:if>
				<span class="contents">${vo.content}</span>
				<span style="margin:0px 5px; font-size: 12px; color: #858585;">${vo.created}</span>
			</span>
			<span class="replybtn" style="float: right; display: none;">
				<c:if test="${sessionScope.member.userId!=null}">
						<a class="replybtn1 answerReply" data-replyNum="${vo.replyNum}" data-secretType="${vo.secretType}">답글쓰기</a>
					<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId==userId}">				
						<a class="replybtn1 updateReply" data-replyNum="${vo.replyNum}">수정</a>/
						<a class="replybtn1 deleteReply" data-replyNum="${vo.replyNum}">삭제</a>
					</c:if>
				</c:if>
			</span>
			<input type="hidden" name="grpNum" id="grpNum" value="${vo.grpNum}">
			<input type="hidden" name="grpOrd" id="grpOrd" value="${vo.grpOrd}">
			<input type="hidden" name="depth" id="depth" value="${vo.depth}">
		</p>
	</div>
	<div style="display: none;">
		<textarea class="answer"></textarea>
		<input type="checkbox" name="answerSecretType"><i class="fas fa-lock"></i>
		<button class="sendAnswer" data-replyNum="${vo.replyNum}">답글등록</button>
	</div>
	</c:otherwise>
	</c:choose>
</div>
</c:forEach>