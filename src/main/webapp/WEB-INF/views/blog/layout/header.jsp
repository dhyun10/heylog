<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("body").on("click", ".side-back", function() {
		$(".side-menu").css("display", "none");
		$(this).css("display", "none");
	});
	
	$("body").on("click", ".blogmenu", function() {
		$(".side-menu").css("display", "");
		$(".side-back").css("display", "");
	});
})
</script>
<div class="side-menu" style="display: none;">
	<div>
		<div style="padding: 50px 50px 0px; font-size: 24px;">카테고리</div>
		<div class="menu-list">
			<ul>
				<c:forEach var="vo" items="${list}">
				<li>· <a href="${pageContext.request.contextPath}/${dto.userId}/category/${vo.category}">${vo.category}</a> <span>&nbsp;(0)</span></li>
				</c:forEach>
			</ul>
		</div>
		<div class="menu-list">
			<ul>
			<li><a href="${pageContext.request.contextPath}/${dto.userId}">홈</a></li>
			<li><a href="${pageContext.request.contextPath}/${dto.userId}/guest">방명록</a></li>
			</ul>
		</div>
			<div class="menu-list">
				<c:if test="${sessionScope.member.userId==dto.userId}">
					<a href="${pageContext.request.contextPath}/${sessionScope.member.userId}/board/write">글쓰기</a>
				</c:if>
				<c:if test="${not empty sessionScope.member}">
					<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
				</c:if>
				<c:if test="${empty sessionScope.member}">
					<a href="${pageContext.request.contextPath}/member/sign">로그인</a>
				</c:if>
			</div>
	</div>
</div>
<div class="side-back" style="display: none;">

</div>
<div class="header-top">
   <div style="margin: 2px; margin-right: 20px;">
        <a href="${pageContext.request.contextPath}/main" style="text-decoration: none;">
            <span class="heylog">HEYLOG&nbsp;</span>
       </a>
    </div>
</div>
<div style="background: #8a8a8a7a;">
	<div class="blog-header">
	   	<div class="blog-title">
	   		<a href="${pageContext.request.contextPath}/${dto.userId}" style="color: #fff; font-size: 30px;">${dto.blogName}&nbsp;</a>
	 		<c:if test="${sessionScope.member.userId==dto.userId}">
	 			<a href="${pageContext.request.contextPath}/manage/home"><i class="fas fa-cog"></i></a>
	 		</c:if>
	 		<c:if test="${sessionScope.member.userId!=dto.userId}">
	 			<button class="followbtn">팔로우</button>
	 		</c:if>
	 		<div style="font-size: 14px; font-weight: normal;">
	 			${dto.blogContent}
	 		</div>
	 	</div>
	   	<div class="blog-header-right">
	       	<a style="margin-right: 20px;">
	       	<i class="fas fa-search"></i></a>
	       	<a class="blogmenu"><i class="fas fa-bars"></i></a>
	    </div>
    </div>
</div>