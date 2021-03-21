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

$(function() {
	$("body").on("click", ".allCheck", function() {
		if($(this).prop("checked")) {
			$("input[name=chk]").prop("checked", true);
		} else {
			$("input[name=chk]").prop("checked", false);
		}
	});
	
	$("body").on("click", ".check", function() {
		$(".allCheck").prop("checked", false);
	});
});

$(function() {
	$("body").on("mouseover", ".guestBooklist-ul", function() {
		$(this).find(".guestSpanbtn").css("display", "");
	});
	$("body").on("mouseleave", ".guestBooklist-ul", function() {
		$(this).find(".guestSpanbtn").css("display", "none");
	});
	
});

$(function() {
	$("body").on("click", ".deleteAll", function() {
		if(! confirm("선택하신 댓글을 삭제하시겠습니까?")) {
			return;
		}
		
		var checkArr=new Array();
		var boardArr=new Array();
		
		$("input[name='chk']:checked").each(function() {
			checkArr.push($(this).attr("data-replyNum"));
			boardArr.push($(this).attr("data-boardNum"));
		});
		
		for(var i=0; i<checkArr.length; i++) {
			var boardNum=boardArr[i];
			var replyNum=checkArr[i];
			var userId="${sessionScope.member.userId}";
			
			var url="${pageContext.request.contextPath}/"+userId+"/"+boardNum+"/deleteReply";
			var query="replyNum="+replyNum+"&boardNum="+boardNum;
			
			var fn=function(data) {
				if(data==true) {
				}
			}

			ajaxJSON(url, "post", query, fn);
		}

		alert("댓글이 삭제되었습니다.");
		location.reload();
	});
});

$(function() {
	$("body").on("click", ".deleteReply", function() {
		var replyNum=$(this).attr("data-replyNum");
		var boardNum=$(this).attr("data-boardNum");
		var userId="${sessionScope.member.userId}";
		
		var url="${pageContext.request.contextPath}/"+userId+"/"+boardNum+"/deleteReply";
		var query="replyNum="+replyNum+"&boardNum="+boardNum;
		
		
		if(! confirm("댓글을 삭제하시겠습니까?")) {
			return;
		}
		
		var fn=function(data) {
			var state=data.state;
			if(state==="true") {
				alert("댓글이 삭제되었습니다.");
				location.reload();
			}
		}

		ajaxJSON(url, "post", query, fn);
	});
});

$(function() {
	$("body").on("change", "#secretType", function() {
		var replyNum=$(this).attr("data-replyNum");
		var blogNum=$(this).attr("data-blogNum");
		
		var secretType=$(this).val();

		var url="${pageContext.request.contextPath}/manage/updateReplySecret";
		var query="blogNum="+blogNum+"&replyNum="+replyNum+"&secretType="+secretType;
		
		var fn=function(data) {
			if(data==true) {
				alert("변경되었습니다.");
				location.reload();
			}
		}

		ajaxJSON(url, "post", query, fn);
	});
});
</script>
<div id="body-page">
	<div class="right-article">
		댓글 관리
		<div class="guestBookmenu">
			<span>
				<input type="checkbox" class="allCheck" style="margin-right: 5px;">
				<button class="replybtn1 deleteAll">삭제</button>
			</span>
			<span style="float: right;">
				<a><i class="fas fa-search"></i></a>
			</span>
		</div>
		<div class="guestBooklist">
			<c:forEach var="dto" items="${list}">
			<ul class="guestBooklist-ul">
				<li>
					<div><input type="checkbox" name="chk" class="check" data-replyNum="${dto.replyNum}" data-boardNum="${dto.boardNum}" value="${dto.replyNum}"></div>
					<div>
						<ul>
							<li style="color: #a2a2a2;"><span style="margin-right:5px; font-weight: bold; color: black;">${dto.userNick}</span>${dto.created}</li>
						</ul>
						<ul>
							<li style="font-size: 12px; color: #a5a5a5;"> <i class="fas fa-angle-double-right"> [${dto.category}] ${dto.subject}</i></li>
						</ul>
						<ul>
							<li> ${dto.content}</li>
						</ul>
					</div>
					<span class="guestSpanbtn" style="float: right; margin-top: 7px; display: none;">
						<select name="secretType" id="secretType" data-blogNum="${dto.blogNum}" data-replyNum="${dto.replyNum}">
							<option value="false" ${dto.secretType=='false'?"selected='selected'":""}>공개</option>
							<option value="true" ${dto.secretType=='true'?"selected='selected'":""}>비공개</option>
						</select>
						<button class="btn5">차단</button>
						<button class="btn5 deleteReply" data-boardNum="${dto.boardNum}" data-replyNum="${dto.replyNum}">삭제</button>
					</span>
				</li>
			</ul>
			</c:forEach>
		</div>
         <div style="margin: 30px 0px;">
         	<p> ${dataCount==0?"<p style=\"margin: 100px;\">등록된 게시물이 없습니다.</p>":paging} </p>
         </div>
	</div>
</div>