<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("#submenu").hover(function() {
		$(".sublist").css("display", "");
	}, function() {
		$(".sublist").css("display", "none");
	});
});
</script>
<div style="background: #2f2f2f;">
<div class="header-top">
    <div class="header-left">
        <div style="margin: 2px; margin-right: 20px;">
            <a href="${pageContext.request.contextPath}/main" style="text-decoration: none;">
                <span class="heylog">HEYLOG&nbsp;</span>
            </a>
        </div>
        <div class="header-center">
        	<a>이달의 블로그</a>
        	<a>둘러보기</a>        	
        	<c:if test="${not empty sessionScope.member}">
                <a href="${pageContext.request.contextPath}/${sessionScope.member.userId}">내 블로그</a>
                <a>내 이웃</a>
        	</c:if>
        </div>
        <div class="header-right">
        	<a style="margin-right: 20px;"><input type="text" placeholder="Search">
        	<i class="fas fa-search"></i></a>
        	<c:if test="${empty sessionScope.member}">
                <a href="${pageContext.request.contextPath}/member/sign">로그인</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <div style="color:white;" id="submenu">${sessionScope.member.userName}님!&nbsp;
                
                <i class="fas fa-angle-down"></i>&nbsp;
                	<div style="display: none;" class="sublist">
	            <c:if test="${sessionScope.member.userId!='admin'}">
	                	<ul><li><a href="${pageContext.request.contextPath}/manage/home">블로그관리</a></li></ul>
                		<ul><li><a href="${pageContext.request.contextPath}/member/home">내 정보</a></li></ul>
                </c:if>
                		<ul><li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li></ul>
                	</div>
                </div>
                <c:if test="${sessionScope.member.userId=='admin'}">
                	<a href="${pageContext.request.contextPath}/admin"><i class="fas fa-cog"></i></a>
            	</c:if>
        	</c:if>
        </div>
    </div>
</div>
</div>
<div class="sub-header" style="font-size: 13px;">
	<i class="fas fa-volume-down"></i><a> [알립니다] 어쩌고저쩌고 </a>
</div>
