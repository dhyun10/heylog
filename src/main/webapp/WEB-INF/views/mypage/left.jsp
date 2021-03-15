<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="body-page"  style="background: #f3f3f3;">
	<div class="left-profile">
		<div class="profileBox">
			<div class="imageBox">
				<img width="100" height="100">
			</div>
			<div class="nameBox">
				<ul>
					<li>${sessionScope.member.userName}</li>
				</ul>
				<ul>
					<li>(${sessionScope.member.userId})</li>
				</ul>
			</div>
		</div>
		<div class="menuBox">
			<div><i class="fas fa-home"> 홈</i></div>
			<div><i class="far fa-user"> 내 계정</i>
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/setting">기본정보</a></li>
				</ul>
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/update">회원정보수정</a></li>
				</ul>
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/updatePwd">비밀번호 변경</a></li>
				</ul>
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/delete">회원탈퇴</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>