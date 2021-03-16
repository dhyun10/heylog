<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function ajaxJSON(url, method, query, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:"json",
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status===403){
				login();
				return false; 
			}
			console.log(jqXHR.responseText);
		}
	});
}


function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type:method
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	}
	    	
	    	console.log(jqXHR.responseText);
	    }
	});
}

</script>

<div class="body-container">
	<div class="blogLayout">
        ${category} (${boardCount})
    	<div class="listLayout">
    		<c:forEach var="vo" items="${bList}">
    		<div class="list-category">
    			<a>
	    			<span class="list-thumbnail">
	    				<img>
	    			</span>
    			</a>
    			<div class="list-info">
		    		<ul class="list-title" style="font-size: 20px;">
		    			<li><a href="${pageContext.request.contextPath}/${dto.userId}/${vo.boardNum}"><span>[${vo.category}]</span> ${vo.subject}</a></li>
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
