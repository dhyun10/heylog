<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>

var q="${pageContext.request.contextPath}/${dto.userId}/${bDto.boardNum}/";
var boardNum="${bDto.boardNum}";
var userId="${sessionScope.member.userId}";

$(function() {
	$("body").on("click", ".fa-plus", function() {
		$(this).closest("div").css("width", "155px");
		$(this).css("display", "none");
		$(this).next("span").css("display", "");
	});
});

$(function() {
	$("body").on("click", ".deleteBoard", function() {
		if(confirm("글을 삭제하시겠습니까?")==true) {
			location.href=q+"delete";
		}
		return;		
	});
});

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

$(function () {
	listReply(boardNum);
});

function listReply(boardNum) {
	var url=q+"/listReply";
	var query="boardNum="+boardNum;
	var selector="#replyLayout";
	
	ajaxHTML(url, "get", query, selector);
}

$(function() {
	$("body").on("click", ".article_reply", function() {
		if(userId=='') {
			alert("댓글을 입력하시려면 로그인 해주세요!");
			$(this).blur();
			return;
		}
	});
	
	$("body").on("click", ".sendReply", function() {
		var $tb=$(this).closest("div").prev().prev("textarea");
		var content=$tb.val().trim();
		var secretType=$(this).prev("input:checkbox").is(":checked");
		
		if(!content) {
			$tb.focus();
			return false;
		}
		content=encodeURIComponent(content);

		var url=q+"insertReply";
		var query="boardNum="+boardNum+"&content="+content+"&secretType="+secretType+"&replyType=0";
		
		var fn=function(data) {
			var state=data.state;
			
			if(state==="true") {
				alert("댓글이 등록되었습니다!!!");
				listReply(boardNum);
			} else {
				alert("댓글 등록에 실패했습니다...");
			}
		}

		ajaxJSON(url, "post", query, fn);
		
		$tb.val("");
	});
});

$(function() {
	$("body").on("mouseover", ".bReply", function() {
		$(this).find(".replybtn").css("display", "");
	});
	$("body").on("mouseleave", ".bReply", function() {
		$(this).find(".replybtn").css("display", "none");
	});
	
});

$(function() {
	$("body").on("click", ".updateReply", function() {
		var $tb=$(this).closest("span").prev("span");
		var content=$tb.find(".contents").text();
		$tb.html("<textarea class='updateText'>"+content+"</textarea>");
		$(".updateText").focus();
		
		$(".answerReply").css("display", "none");
		$(this).text("완료");
		$(this).attr("class", "replybtn1 updateReplySend");
		$(this).next("a").text("취소");
		$(this).next("a").attr("class", "replybtn1 cancel");
	});
	
	$("body").on("click", ".updateReplySend", function() {
		var replyNum=$(this).attr("data-replyNum");
		var $tb=$(this).closest("span").prev("span").find("textarea");
		var content=$tb.val().trim();
		
		content=encodeURIComponent(content);
		
		var url=q+"updateReply";
		var query="content="+content+"&replyNum="+replyNum;

		var fn=function(data) {
			var state=data.state;
			if(state==="true") {
				alert("수정되었습니다!!!");		
				listReply(boardNum);
			} else {
				alert("수정이 실패했습니다...");
			}
		}

		ajaxJSON(url, "post", query, fn);
		
	});
});

$(function() {
	$("body").on("click", ".deleteReply", function() {
		if(!confirm("댓글을 삭제하시겠습니까?")) {
			return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var grpNum=$(this).attr("data-grpNum");
		var grpOrd=$(this).attr("data-grpOrd");
		
		var url=q+"deleteReply";
		var query="replyNum="+replyNum+"&boardNum="+boardNum+"&grpNum="+grpNum+"&grpOrd="+grpOrd;
		
		var fn=function(data) {
			var state=data.state;
			
			if(state==="true") {
				alert("댓글이 성공적으로 삭제되었습니다.");
				listReply(boardNum);
			} else {
				alert("알 수 없는 오류로 댓글이 삭제되지 않았습니다...");
			}
		}

		ajaxJSON(url, "post", query, fn);

	});
});

$(function() {
	$("body").on("click", ".answerReply", function() {
		$(this).closest("div").next("div").css("display", "");		
		$(this).text("취소");
		$(this).attr("class", "replybtn1 cancel");
	});
	
	$("body").on("click", ".sendAnswer", function() {
		var content=$(this).prev().prev().prev("textarea").val().trim();

		var replyNum=$(this).attr("data-replyNum");
		var secretType=$(this).prev().prev("input:checkbox").is(":checked");
		
		var $tb=$(this).closest("div").prev("div").find("p");
		var grpNum=$tb.find("#grpNum").val();
		var grpOrd=$tb.find("#grpOrd").val();
		var depth=$tb.find("#depth").val();
	
		content=encodeURIComponent(content);
		
		var url=q+"insertAnswer";
		var query="boardNum="+boardNum+"&content="+content+"&secretType="+secretType+
			"&replyType="+replyNum+"&grpNum="+grpNum+"&grpOrd="+grpOrd+"&depth="+depth;
		
		var fn=function(data) {
			var state=data.state;
			
			if(state==="true") {
				alert("댓글이 성공적으로 등록되었습니다.");
				listReply(boardNum);
			} else {
				alert("댓글이 등록되지 않았습니다...");
			}
		}

		ajaxJSON(url, "post", query, fn);
	});
	
	$("body").on("click", ".cancel", function() {
		listReply(boardNum);
	});
});

$(function() {
	$("body").on("click", ".boardLike", function() {
		if(userId=='') {
			alert("글을 추천하려면 로그인해주세요.");
			return;
		} else if (userId=="${dto.userId}") {
			alert("본인의 글은 추천할 수 없습니다.");
			return;
		}
		
		$(this).attr("class", "fas fa-heart boardUnlike");
		$(".boardUnlike").css("color", "red");
		
		var url=q+"insertBoardLike";
		var query="";
		
		var fn=function(data) {
			var state=data.state;
			
			if(state=="true") {
				alert("글을 추천하였습니다!");
			}
		}
				
		ajaxJSON(url, "post", query, fn);
	});
	
	$("body").on("click", ".boardUnlike", function() {
		$(this).attr("class", "far fa-heart boardLike");
		$(".boardLike").css("color", ""); 
		
		var url=q+"deleteBoardLike";
		var query="";
		
		var fn=function(data) {
			var state=data.state;
			
			if(state=="true") {
				alert("추천을 취소했습니다!");
			}
		}
		
		ajaxJSON(url, "post", query, fn);
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
    	<div>
    		<c:if test="${!empty tList}">
	    		<c:forEach var="vo" items="${tList}">
	    			<a style="font-size: 13px; color: #858585;">#${vo.tag}</a>
	    		</c:forEach>
    		</c:if>
    	</div>
    	<div class="article_btn">
    		<c:if test="${likeUser==0}">
	    		<i class="far fa-heart boardLike"></i>
    		</c:if>
    		<c:if test="${likeUser==1}">
    			<i class="fas fa-heart boardUnlike" style="color: red;"></i>
    		</c:if>
    		<span>&nbsp;추천</span> 
    		<i class="far fa-copy"></i>
    		<i class="fas fa-plus"> </i>
    		<span style="display: none; margin-left: 10px;">
			<c:if test="${dto.userId==sessionScope.member.userId}">
				<a>정보</a> 
	    		<a href="${pageContext.request.contextPath}/${dto.userId}/${bDto.boardNum}/update">수정</a>
	    		<a class="deleteBoard">삭제</a>
    		</c:if>
    		<c:if test="${dto.userId!=sessionScope.member.userId}">
    			<a><i class="fas fa-exclamation-circle"> 신고하기</i></a>
    		</c:if>
    		</span>
    	</div>
    </div>
    
    <div style="max-width: 800px; margin: 80px auto;">
    	<p style="font-size: 16px; font-weight: bold;">댓글</p>
		<div id="replyLayout" style="margin: 15px 5px; font-size: 14px;"></div>
		   	<textarea class="article_reply" placeholder="댓글을 입력하세요." name="content"></textarea>	
   		<div>
   			<button style="float: left;" class="btn4">목록으로</button>
   		</div>
   		<div style="float: right; font-size: 12px;">
   			<input type="checkbox" name="secretType"> 비공개 &nbsp;
   			<button class="sendReply">댓글쓰기</button>
   		</div>
    </div>
</div>