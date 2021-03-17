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


var userId="${dto.userId}";

$(function() {
	$("#content").keyup(function(e) {
		var text=$(this).val();
		$(".cnt").text(getBytes(text));
		
		if(getBytes(text)>500) {
			alert("최대 500byte까지 입력 가능합니다.");
		}
	});
});

function getBytes(text) {
	var cnt=0;
	for(var i=0; i<text.length; i++) {
		cnt += (text.charCodeAt(i) > 128) ? 2:1;
	}
	return cnt;
}

$(function() {
	$("body").on("click", ".guestsend", function() {
		var userId="${dto.userId}";
		var $tb=$(this).closest("div").prev("div");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var secretType="0";
		if($("#secret").is(":checked")) {
			secretType="1";
		}
		
		var url="${pageContext.request.contextPath}/"+userId+"/insertGuest";
		var query="blogNum=${dto.blogNum}&content="+content+"&secretType="+secretType;
		
		var fn=function(data) {
			if(data==true) {
				alert("방명록을 등록하였습니다.");
			}
		}
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function() {
	$("body").on("click", ".updateGuest", function() {
		var $input=$(this).closest(".guestdiv").find(".guestcontent");
		var content=$input.find("span").text();
		var secretType=$(this).attr("data-secretType");
		var $tb=$(this).closest("div").closest(".info").next("div");
		
		var secret="<span><input type='checkbox' id='updateSecret'><label for='updateSecret'>&nbsp;비밀글&nbsp;</label></span>";

		$input.html("<textarea id='content'>"+content+"</textarea><div style='text-align:right;'>"+secret+"<span class='cnt'>0</span>/500&nbsp;</div>");
		$(".guestcontent #content").focus();
		
		if(secretType==1) {
			$tb.find("#updateSecret").prop("checked", true);
		} else {
			$tb.find("#updateSecret").prop("checked", false);
		}
		
		$(this).text("완료");
		$(this).attr("class", "btn5 updateOk");
		$(this).next("button").text("취소");
		$(this).next("button").attr("class", "btn5 updateCancel");
	});
	
	$("body").on("click", ".updateOk", function() {
		var guestNum=$(this).attr("data-guestNum");
		var userId="${dto.userId}";
		var $tb=$(this).closest("div").closest(".info").next("div");
		var content=$tb.find("textarea").val().trim();
		
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var secretType="0";
		if($("#updateSecret").is(":checked")) {
			secretType="1";
		}

		var url="${pageContext.request.contextPath}/"+userId+"/updateGuest";
		var query="blogNum=${dto.blogNum}&guestNum="+guestNum+"&content="+content+"&secretType="+secretType;
		
		var fn=function(data) {
			if(data==true) {
				alert("수정되었습니다.");
				location.reload();
			}
		}
		
		ajaxJSON(url, "post", query, fn);
	});
	
	$("body").on("click", ".updateCancel", function() {
		location.reload();
	});
});

$(function() {
	$("body").on("click", ".deleteGuest", function() {
		var guestNum=$(this).attr("data-guestNum");
		var userId="${dto.userId}";
		
		var url="${pageContext.request.contextPath}/"+userId+"/deleteGuest";
		var query="blogNum=${dto.blogNum}&guestNum="+guestNum;
		
		if(! confirm("방명록을 삭제하시겠습니까?")) {
			return;
		}
		
		var fn=function(data) {
			if(data==true) {
				alert("방명록이 삭제되었습니다.");
				location.reload();
			}
		}
		
		ajaxJSON(url, "post", query, fn);
	});
});

function listReply(guestNum) {
	var url="${pageContext.request.contextPath}/"+userId+"/listGuestReply";
	var query="guestNum="+guestNum;
	var selector="#replyLayout"+guestNum;
	
	ajaxHTML(url, "get", query, selector);
}

$(function() {
	$("body").on("click", ".replybtn", function() {
		var $reply=$(this).closest("div").prev();
		
		var isVisible=$reply.is(':visible');
		var guestNum=$(this).attr("data-guestNum");
		
		if(isVisible) {
			$reply.slideToggle("500");
			$(this).prev("span").hide();
		} else {
			listReply(guestNum);
			$reply.slideToggle("500");
			$(this).prev("span").show();
		}
	});
});

$(function() {
	$("body").on("click", ".replysend", function() {
		var guestNum=$(this).attr("data-guestNum");		
		var content=$(this).prev("input").val().trim();
		
		if(! content) {
			$(this).prev("input").focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/"+userId+"/insertGuestReply";
		var query="guestNum="+guestNum+"&content="+content;
		
		var fn=function(data) {
			var state=data.state;
			
			if(state==="true") {
				alert("댓글이 등록되었습니다.");
				listReply(guestNum);			
				var replyCount=data.replyCount;
			} else {
				alert("댓글을 추가 하지 못했습니다.");
			}
		}
		ajaxJSON(url, "post", query, fn);
		
		$(this).prev("input").val("");
	});
});

$(function() {
	$("body").on("click", ".deleteGuestReply", function() {
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return;
		}
		var replyNum=$(this).attr("data-replyNum");
		var guestNum=$(this).attr("data-guestNum");

		var url="${pageContext.request.contextPath}/"+userId+"/deleteGuestReply";
		var query="replyNum="+replyNum;
		
		var fn = function(data){
			var state=data.state;
			if(state=="true"){
				listReply(guestNum);			
			}
		};
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<div class="body-container">
	<div class="blogLayout">
         <div style="font-size: 25px; font-weight: bold; text-align: center; margin-bottom: 30px;">
         	방명록
         </div>
         <div class="writeLayout">
         	<form name="guestForm">
	         	<div class="guestBox">
	         		<div class="guestInfo">
	         			<div>
	         				<c:if test="${not empty sessionScope.member}">
		         				<span style="font-size: 20px;">${sessionScope.member.userNick}</span>
		         				<span class="checkSecret" style="margin-left: 20px;">
		         					<input type="checkbox" id="secret">
		         					<label for="secret">&nbsp;비밀글</label>
		         				</span>
	         				</c:if>
	         				<c:if test="${empty sessionScope.member}">
	         					<span style="font-size: 20px;">로그인 후 이용가능합니다.</span>
	         				</c:if>
	         			</div>
	         		</div>
	         		<div>
	         			<textarea id="content" name="content" placeholder="내용을 입력해주세요 *^^*"></textarea>
	         		</div>
	         		<div style="text-align: right;">
	         			<span class="cnt">0</span>/500&nbsp;
	         			<button class="btn3 guestsend">등록</button>
	         		</div>
	         	</div>
         	</form>
         </div>
         <div class="guestLayout">
         	<c:forEach var="vo" items="${guestList}">
	         	<c:choose>
	         	<c:when test="${vo.secretType==1 && sessionScope.member.userId!=vo.userId
	         	 && sessionScope.member.userId!=dto.userId }">
	         	 	<div style="border-bottom: 2px solid; padding: 10px; font-size: 20px; font-weight: bold;">
	         			<i class="fas fa-lock"></i>&nbsp;<span style="font-size: 14px; font-weight: normal;">${vo.created}</span>
	         		</div>
	         		<div class="guestcontent" style="border-bottom: 1px solid; margin-bottom: 30px;">
			         	<span>비밀글입니다</span>
			         </div>
	         	</c:when>
	         	<c:otherwise>
		         	<div class="guestdiv">
			         	<div class="info" style="border-bottom: 2px solid; padding: 10px; font-size: 20px; font-weight: bold;">        		
			         		<c:if test="${vo.secretType==1}">
								<i class="fas fa-lock"></i>
							</c:if><a href="${pageContext.request.contextPath}/${vo.userId}">${vo.userNick}</a>&nbsp;<span style="font-size: 14px; font-weight: normal;">${vo.created}</span>
			         		<div style="float: right;">
				         		<c:if test="${sessionScope.member.userId==vo.userId}">
				         				<button class="btn5 updateGuest" data-guestNum="${vo.guestNum}" data-secretType="${vo.secretType}">수정</button>
			         			</c:if>
			         			<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId==dto.userId}">
				         				<button class="btn5 deleteGuest" data-guestNum="${vo.guestNum}">삭제</button>
				         		</c:if>
				         	</div>	
			         	</div>
			         	<div class="guestcontent">
			         		<span>${vo.content}</span>
			         	</div>
			         	<div style="display: none;">
				         	<div id="replyLayout${vo.guestNum}" class="replyBox"></div>
			         	</div>		         	
			         	<div class="replyInput">
			         		<span class="replyspan" style="display: none;"> 
			         			<input type="text">
			         			<button class="btn3 replysend" data-guestNum="${vo.guestNum}">등록</button>
			         		</span>
			         		<button class="btn4 replybtn" data-guestNum="${vo.guestNum}">댓글 (<span>${vo.replyCount}</span>)</button>
			         	</div>
		         	</div>
	         	</c:otherwise>
	         	</c:choose>
         	</c:forEach>
         </div>
         <div>
         	<p> ${dataCount==0?"<p style=\"margin: 100px;\">등록된 게시물이 없습니다.</p>":paging} </p>
         </div>
	</div>
</div>
