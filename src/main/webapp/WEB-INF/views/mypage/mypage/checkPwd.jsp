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
		var pwd=$("#userPwd").val();
		var $input=$("#userPwd");
		var $inputOk=$("#userPwdOk");
		var pwdOk=$("#userPwdOk").val();
		
		if(pwdOk!="") {
			if(pwd==pwdOk) {
				$inputOk.next("span").html("<i class='fas fa-check'></i>");
				$inputOk.next().next("p").html("");
			} else {
				$inputOk.next().next("p").html(" * 비밀번호가 일치하지않습니다.");
				$inputOk.next("span").html("");
			}
		}
	});
});

$(function() {
	$("body").on("click", ".deleteOk", function() {
		var userPwd=$("#userPwd").val();
		var $input=$("#userPwd");
		var pwd="${dto.userPwd}";
		var url='${pageContext.request.contextPath}/member/delete';
		var query="userPwd="+userPwd;
		
		if(userPwd!=pwd) {
			$input.next("p").html(" * 회원님의 비밀번호가 맞지 않습니다 .");
			return;
		}
		
		if(!confirm("정말 탈퇴하시겠습니까?")) {
			return false;
		}
		
		var fn=function(data) {
			if(data==true) {
				alert("탈퇴되었습니다.");
			}
			location.href="${pageContext.request.contextPath}/main";
		}
		ajaxJSON(url, "post", query, fn);
	});
});
</script>
<div id="body-page" style="background: #f3f3f3;">
	<div class="right-article" style="text-align: center; width: 700px;">
		<p style="font-size: 30px; font-weight: bold;">비밀번호 확인</p>
		<div id="pwForm">
			<form name="passwordForm">
				<table class="pwTable">
					<tr>
						<td>현재 비밀번호</td>
						<td>
						<input type="password" id="userPwd" name="userPwd">
						<p style="color: red;"></p>
						</td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
						<input type="password" id="userPwdOk" name="userPwdOk">
						<span></span>
						<p></p>
						</td>
					</tr>
				</table>
			</form>
			<div>
				<button class="btn3 deleteOk">회원탈퇴</button>
				<button class="btn4" onclick="location.href='${pageContext.request.contextPath}/member/home';">돌아가기</button>
			</div>
		</div>
	</div>
</div>