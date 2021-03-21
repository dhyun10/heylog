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
		if(!confirm("선택하신 방명록을 삭제하시겠습니까?")) {
			return;
		}
		
		var checkArr=new Array();
		
		$("input[name='chk']:checked").each(function() {
			checkArr.push($(this).attr("data-guestNum"));
		});
		
		for(var i=0; i<checkArr.length; i++) {
			var blogNum="${blogNum}";
			var guestNum=checkArr[i];
			var userId="${sessionScope.member.userId}";
			
			var url="${pageContext.request.contextPath}/"+userId+"/deleteGuest";
			var query="blogNum="+blogNum+"&guestNum="+guestNum;
			
			var fn=function(data) {
				if(data==true) {
				}
			}

			ajaxJSON(url, "post", query, fn);
		}

		alert("방명록이 삭제되었습니다.");
		location.reload();
	});
});

$(function() {
	$("body").on("click", ".deleteGuest", function() {
		var guestNum=$(this).attr("data-guestNum");
		var blogNum=$(this).attr("data-blogNum");
		var userId="${sessionScope.member.userId}";
		
		var url="${pageContext.request.contextPath}/"+userId+"/deleteGuest";
		var query="blogNum="+blogNum+"&guestNum="+guestNum;
		
		
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

$(function() {
	$("body").on("change", "#secretType", function() {
		var guestNum=$(this).attr("data-guestNum");
		var blogNum=$(this).attr("data-blogNum");
		
		var secretType=$(this).val();

		var url="${pageContext.request.contextPath}/manage/updateGuestSecret";
		var query="blogNum="+blogNum+"&guestNum="+guestNum+"&secretType="+secretType;
		
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
		방명록 관리
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
					<div><input type="checkbox" name="chk" class="check" data-guestNum="${dto.guestNum}" value="${dto.guestNum}"></div>
					<div>
						<ul>
							<li style="color: #a2a2a2;"><span style="margin-right:5px; font-weight: bold; color: black;">${dto.userNick}</span>${dto.created}</li>
						</ul>
						<ul>
							<li>${dto.content}</li>
						</ul>
					</div>
					<span class="guestSpanbtn" style="float: right; margin-top: 7px; display: none;">
						<select name="secretType" id="secretType" data-blogNum="${dto.blogNum}" data-guestNum="${dto.guestNum}">
							<option value="0" ${dto.secretType=='0'?"selected='selected'":""}>공개</option>
							<option value="1" ${dto.secretType=='1'?"selected='selected'":""}>비공개</option>
						</select>
						<button class="btn5">차단</button>
						<button class="btn5 deleteGuest" data-blogNum="${dto.blogNum}" data-guestNum="${dto.guestNum}">삭제</button>
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