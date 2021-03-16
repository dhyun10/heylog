<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="body-container">
    <div class="blogLayout">
    	전체 게시물 (${boardCount})
    	<div class="listLayout">
    		<c:forEach var="vo" items="${bList}">
    		<div class="list-category">
    			<span class="list-thumbnail">
    				<img>
    			</span>
    			<div class="list-info">
		    		<ul class="list-title" style="font-size: 20px;">
		    			<li>
			    			<a href="${pageContext.request.contextPath}/${dto.userId}/${vo.boardNum}">
			    				<span>
			    					<c:if test="${vo.category!=null}">[${vo.category}]</c:if>
			    					<c:if test="${vo.category==null}"></c:if>
			    				</span> ${vo.subject}
			    			</a>
		    			</li>
		    			<li style="float: right;"><i class="far fa-bookmark"></i></li>
		    		</ul>
		    		<ul>
		    			<li class="list-content">${vo.content}</li>
		    		</ul>
		    		<ul>
		    			<li>${vo.created}</li>
		    		</ul>
	    		</div>
    		</div>
    		</c:forEach>
    	</div>
    	<div>
         	<p> ${boardCount==0?"<p style=\"margin: 100px;\">등록된 게시물이 없습니다.</p>":paging} </p>
    		<button class="btn4">새로고침</button>
        </div>
    </div>
</div>