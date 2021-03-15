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
	$("#userPwd, #userPwdOk").keyup(function() {
		var $input=$("#userPwd");
		var pwd=$("#userPwd").val();
		
		if(pwd.length<8) {
			$input.next().next("p").html(" * 비밀번호는 8자이상만 가능합니다.");
			$input.next("span").html("");
		} else {
			$input.next("span").html("<i class='fas fa-check'></i>");
			$input.next().next("p").html("");
		}
	});
});


$(function() {
	$("body").on("click", ".updatePwd", function() {
		var userPwd=$("#userPwd").val();
		var $input=$("#userOriPwd");
		var pwd="${dto.userPwd}";
		var oPwd=$("#userOriPwd").val();
		var url='${pageContext.request.contextPath}/member/updatePwd';
		var query="userPwd="+userPwd;
		
		if(oPwd!=pwd) {
			$input.next("p").html(" * 현재 비밀번호가 맞지 않습니다 .");
			return;
		}
		
		var fn=function(data) {
			if(data==true) {
				alert("비밀번호가 변경되었습니다.");
			}
			location.href="${pageContext.request.contextPath}/member/home";
		}
		ajaxJSON(url, "post", query, fn);
	});
});
</script>
<div id="body-page" style="background: #f3f3f3;">
	<div class="right-article" style="text-align: center; width: 700px;">
		<p style="font-size: 30px; font-weight: bold;">비밀번호 변경</p>
		<div id="pwForm">
			<form name="passwordForm">
				<table class="pwTable">
					<tr>
						<td>현재 비밀번호</td>
						<td>
						<input type="password" id="userOriPwd" name="userOriPwd">
						<p style="color: red;"></p>
						</td>
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td>
						<input type="password" id="userPwd" name="userPwd">
						<span></span>
						<p></p>
						</td>
					</tr>
				</table>
			</form>
			<div>
				<button class="btn3 updatePwd">변경하기</button>
				<button class="btn4" onclick="location.href='${pageContext.request.contextPath}/member/home';">돌아가기</button>
			</div>
		</div>
	</div>
</div>