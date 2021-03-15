<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function sendOk() {
	var userId="${dto.userId}";
	var f = document.boardForm;

  	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

        str = f.content.value;
        if(!str || str=="<p>&nbsp;</p>") {
     		f.content.focus();
        	return false;
        }
        
        f.action="${pageContext.request.contextPath}/"+userId+"/board/write";
        f.submit();
};
</script>

<div class="body-container" style="width: 900px;">
	<form name="boardForm" method="post">   
    <div class="body-title">
        <div>
        	<select class="cateBox" name="categoryNum">
	        	<option>카테고리</option>
	        	<c:choose>
		        	<c:when test="${list!=null}">
			        	<c:forEach var="dto" items="${list}">
			        		<option value="${dto.categoryNum}">${dto.category}</option>	
			        	</c:forEach>
		        	</c:when>	        	
		        	<c:otherwise>
		        		<option value="0">카테고리 없음</option>
		        	</c:otherwise>
	        	</c:choose>
        	</select>
        </div>
        <div>
       		<input class="subject" name="subject" placeholder="제목을 입력하세요 ">
        </div>
    </div>
    
    <div>
        <textarea class="content" name="content"></textarea>
    </div>
    <div>
    	
    </div>
    <div style="float: right;">
    	<button class="btn4">임시 저장</button>
        <button class="btn3" onclick="sendOk();">작성 완료</button>
    </div>
    </form>
</div>