<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	var tag={};
	var count=0;
	
	function addTag(value) {
		tag[count]=value;
		count++;
	}
	
	function marginTag() {
		return Object.values(tag).filter(function(word) {
			return word!="";
		})
	}
	
	$(".hashTagInput").keydown(function(key) {
		if(key.keyCode==13) {
			var val=$(this).val();
			
			if(val!='') {
				var result=Object.values(tag).filter(function(word) {
					return word==val;
				})
				
				if(result.length==0) {
					$(".tagList").append("<span class='hashTag'>#"+val+"<span class='tagDel' idx='"+count+"'>x</span></span>");
					addTag(val);
					$(this).val("");
				} else {
					alert("중복된 태그가 있습니다.");
					$(this).focus();
				}
			}
		}
	});
	
	$("body").on("click", ".tagDel", function() {
		var index=$(this).attr("idx");
		tag[index]="";
		$(this).parent().remove();
	});
	
	$("body").on("click", "#send", function() {
		var userId="${dto.userId}";
		var mode="${mode}";
		
		var f = document.boardForm;
		var q=userId+"/board/${mode}";

        if($(".cateBox option:selected").val()=='0') {
        	alert("카테고리를 선택하세요 !!");
        	f.categoryNum.focus();
        	return false;
        }
        
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
	        
	        var tag=marginTag();
	        $(".tag").val(tag);
	        
	    if(mode=='update') {
	    	q=userId+"/${bDto.boardNum}/"+mode;
	    }
	        
		f.action="${pageContext.request.contextPath}/"+q;
		f.submit();
	});
});

</script>

<div class="body-container" style="width: 900px;">
	<form name="boardForm" method="post" onsubmit="return false;">   
    <div class="body-title">
        <div>
        	<select class="cateBox" name="categoryNum">
	        	<option value="0">카테고리 선택</option>
	        	<c:choose>
		        	<c:when test="${list!=null}">
			        	<c:forEach var="dto" items="${list}">
			        		<option value="${dto.categoryNum}" ${dto.categoryNum==bDto.categoryNum?'selected':''}>${dto.category}</option>	
			        	</c:forEach>
		        	</c:when>
	        	</c:choose>
        	</select>
        </div>
        <div>
       		<input class="subject" name="subject" placeholder="제목을 입력하세요 " value="${bDto.subject}">
        </div>
    </div>
    
    <div>
        <textarea class="content" name="content">${bDto.content}</textarea>
    </div>
    <div style="margin-bottom: 10px;">
    	<input type="text" placeholder="#태그" class="hashTagInput">
    	<span class="tagList">
    		<c:forEach var="vo" items="${tList}">
    			<span class="hashTag">${vo.tag}<span class="tagDel">x</span></span>
    		</c:forEach>
    	</span>
    </div>
    <div style="float: right;">
    	<input type="hidden" name="tag" class="tag">
    	<button class="btn4">임시 저장</button>
        <button class="btn3" id="send">${mode=='update'?'수정 완료':'작성 완료'}</button>
    </div>
    </form>
</div>