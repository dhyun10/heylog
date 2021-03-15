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
			<div class="fallowBox">
				<ul>
					<li>팔로워 수</li>
					<li>0</li>
				</ul>
				<ul>
					<li>팔로잉 수</li>
					<li>0</li>
				</ul>
			</div>
		</div>
		<div class="menuBox">
			<div><i class="fas fa-home"> <a href="${pageContext.request.contextPath}/manage/home">블로그관리 홈</a></i></div>
			<div><i class="far fa-file-alt"></i> 내 블로그
				<ul>
					<li><a href="${pageContext.request.contextPath}/manage/setting">블로그 관리</a></li>
				</ul>
				<ul>
					<li>글 관리</li>
				</ul>
				<ul>
					<li><a href="${pageContext.request.contextPath}/manage/category">카테고리 관리</a></li>
				</ul>
				<ul>
					<li>공지 관리</li>
				</ul>
			</div>
			<div><i class="far fa-comment-dots"></i> 댓글 · 방명록
				<ul>
					<li>댓글 관리</li>
				</ul>
				<ul>
					<li><a href="${pageContext.request.contextPath}/manage/guestbook">방명록 관리</a></li>
				</ul>
				<ul>
					<li>공지 관리</li>
				</ul>
			</div>
			<div><i class="fas fa-user-friends"></i> 이웃
				<ul>
					<li>이웃 관리</li>
				</ul>
			</div>
			<div><i class="far fa-chart-bar"></i> 통계
				<ul>
					<li>방문 통계</li>
				</ul>
				<ul>
					<li>유입 키워드</li>
				</ul>
			</div>
		</div>
	</div>
</div>