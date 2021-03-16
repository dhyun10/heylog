<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("body").on("click", ".fa-plus", function() {
		$(this).closest("div").css("width", "155px");
		$(this).css("display", "none");
		$(this).next("span").css("display", "");
	});
});
</script>

<div class="body-container">
    <div class="body-title">
        <div align="center" style="margin: 30px 0px 50px 0px; font-size: 14px;">
        	<span style="font-size: 32px; font-weight: bold;"> ${bDto.subject}</span>
        	<p>${bDto.created} · ${bDto.category}</p>
        </div>
    </div>
    
    <div style="max-width: 800px; margin: 50px auto; min-height: 50px;">
    	<p style="min-height: 150px;">${bDto.content}</p>
    	<div class="article_btn">
    		<i class="far fa-heart"> 추천 </i> 
    		<i class="fas fa-share-alt"> </i> 
    		<i class="fas fa-plus"> </i>
    		<span style="display: none; margin-left: 10px;">
			<c:if test="${dto.userId==sessionScope.member.userId}">
				<a>정보</a> 
	    		<a href="${pageContext.request.contextPath}/${dto.userId}/${bDto.boardNum}/update">수정</a>
	    		<a href="${pageContext.request.contextPath}/${dto.userId}/${bDto.boardNum}/delete">삭제</a>
    		</c:if>
    		<c:if test="${dto.userId!=sessionScope.member.userId}">
    			<a><i class="fas fa-exclamation-circle"> 신고하기</i></a>
    		</c:if>
    		</span>
    	</div>
    </div>
    
    <div style="max-width: 800px; margin: 50px auto;">
    	<p style="margin-bottom: 20px; font-size: 16px; font-weight: bold;">댓글</p>
   		<textarea class="article_reply" placeholder="댓글을 입력하세요."></textarea>
   		<div style="float: right; font-size: 12px;">
   			<input type="checkbox"> 비공개 &nbsp;
   			<button class="sendReply">댓글쓰기</button>
   		</div>
    </div>
</div>