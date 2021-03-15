<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("body").on("click", "input[name=findtype]", function() {
		val=$(this).val();
		if(val=='email') {
			$("input[name=email]").closest("tr").css("display", "");
			$("input[name=tel]").closest("tr").css("display", "none");
		} else {
			$("input[name=email]").closest("tr").css("display", "none");
			$("input[name=tel]").closest("tr").css("display", "");
		}
	});
});

$(function() {
	$("body").on("click", "#searchPassword", function() {
		var userId=$("input[name=userId]").val();
		var email=$("input[name=email]").val();
		
		var url="${pageContext.request.contextPath}/member/findPwd";
		var query="userId="+userId+"&email="+email;
		
		var fn=function(data){
			if(data==true) {
				alert("회원님의 이메일로 임시비밀번호를 발급하였습니다.");
			}
			location.href="${pageContext.request.contextPath}/member/login";
		};

		ajaxJSON(url, "post", query, fn);
	});
});
</script>

<p style="font-size: 40px; font-weight: bold;">비밀번호 찾기</p>
<div id="" style="margin: 50px;">
	<form action="">
		<table>
		<tr>
			<td colspan="2"><input type="text" name="userId" placeholder="ID"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="email" placeholder="email..."></td>
		</tr>
		<tr>
			<td colspan="2"><button class="btn1" id="searchPassword">확인</button></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: right;"><a href="javascript:findId();">아이디 찾기</a></td>
		</tr>
		</table>
	</form>
</div>