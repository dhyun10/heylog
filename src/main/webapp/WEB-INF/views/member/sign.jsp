<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="body-container">
   <div class="signLayout">
   		<div id="signForm" style="display: inline-grid; margin: 50px;">
   		<p style="font-size: 50px; font-weight: bold; margin-bottom: 50px;">HEYLOG</p>
   			<button class="btn1" style="background: #fff4a8;" onclick="location.href='${pageContext.request.contextPath}/member/join'">회원가입하기</button>
   			<button class="btn1" onclick="location.href='${pageContext.request.contextPath}/member/login';">이미 회원이에요</button>
   		</div>
   </div>
</div>