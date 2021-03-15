<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${replyList}">
<div>
	<span style="font-weight: bold;">${vo.userNick}</span>
	<span>${vo.content}</span>
	<span style="float: right; margin-right: 15px;">
		<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId==userId}">
			<button class="replybtn1 deleteGuestReply" data-guestNum="${vo.guestNum}" data-replyNum="${vo.replyNum}">삭제</button>
		</c:if>
		${vo.created}
	</span>
</div>
</c:forEach>