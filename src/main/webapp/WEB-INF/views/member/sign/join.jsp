<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function(){
	setDateBox();
});    

function setDateBox(){
	var dt = new Date();
	var year = "";
	var com_year = dt.getFullYear();
	
	$("#year").append("<option value=''>연도</option>");
		for(var y = (com_year); y >= (com_year-70); y--){
			$("#year").append("<option value='"+ y +"'>"+ y +"</option>");
		}
	var month;
	$("#month").append("<option value=''>월</option>");
		for(var i = 1; i <= 12; i++){
			$("#month").append("<option value='"+ i +"'>"+ i +"</option>");
		}
		
	var day;
	$("#day").append("<option value=''>일</option>");
		for(var i = 1; i <= 31; i++){
			$("#day").append("<option value='"+ i +"'>"+ i + "</option>");
		}
}
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
	$("#userId").blur(function() {
		var userId=$("#userId").val();
		var $input=$("#userId");
		var url="${pageContext.request.contextPath}/member/check_id";
		var query="userId="+userId;
		
		if(userId.length==0) {
			$input.next("span").html(" * 아이디를 입력하세요.");
			$input.focus();
			return;
		}
		
		var fn=function(data) {
			if(data==1) {
				$input.next("span").html(" * 중복된 아이디가 있습니다.");				
			} else {
				$input.next("span").html("<i class='fas fa-check'></i>");
			}
		}
		ajaxJSON(url, "post", query, fn);
	});
});

$(function() {
	$("#userPwd, #userPwdOk").keyup(function() {
		var pwd=$("#userPwd").val();
		var $input=$("#userPwd");
		var $inputOk=$("#userPwdOk");
		var pwdOk=$("#userPwdOk").val();
		if(pwd.length<8) {
			$input.next("span").html(" * 비밀번호는 8자이상만 가능합니다.");
		} else {
			$input.next("span").html("<i class='fas fa-check'></i>");
		}
		
		if(pwdOk!="") {
			if(pwd==pwdOk) {
				$inputOk.next("span").html("<i class='fas fa-check'></i>");
			} else {
				$inputOk.next("span").html(" * 비밀번호가 일치하지않습니다.");
			}
		}
	});
});

$(function() {
	$("body").on("change", "select[name=domain]", function() {
		val=$(this).val();
		$input=$("input[name=email2]");
		if(val=='self') {
			$input.val("");
			$input.attr("readonly", false);
		} else {
			$input.attr("readonly", true);
			$input.val(val);
		}
	});
});


function joinOk() {
	f=document.joinForm;
	
	f.action="${pageContext.request.contextPath}/member/joinOk";
	f.submit();
}

</script>
<div class="body-container">
   <div class="signLayout">
   		
<p style="font-size: 50px; font-weight: bold;">JOIN</p>
<div id="joinForm" style="display: inline-grid; margin: 50px;">
	<form name="joinForm" method="post">
		<table class="joinTable">
		<tr>
			<td>아이디</td>
			<td><input type="text" id="userId" name="userId"><span></span></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" id="userPwd" name="userPwd">
			<span></span></td> 
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td>
			<input type="password" id="userPwdOk" name="userPwdOK">
			<span></span>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="userName" style="width: 100px;"></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>
				<select name="year" id="year"></select>
				<select name="month" id="month"></select>
				<select name="day" id="day"></select>
			</td>
		</tr>
		<tr>
			<td>핸드폰번호</td>
			<td>
			<select name="tel1" style="width: 80px;">
				<option>010</option>
				<option>011</option>
				<option>016</option>
				<option>017</option>
			</select> - 
			<input type="text" name="tel2" style="width: 80px;"> - 
			<input type="text" name="tel3" style="width: 80px;"></td>
		</tr>
		<tr>
			<td>E-MAIL</td>
			<td>
				<input type="text" name="email1"> @ 
				<input type="text" name="email2" readonly="readonly">
				<select name="domain">
					<option value="">이메일 선택</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
					<option value="naver.com">naver.com</option>
					<option value="self">직접입력</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="border: 0;">
				약관동의
			</td>
			<td>
				<p><textarea rows="10" cols="80" style="resize: none;"></textarea><p>
			</td>
		</tr>		
		<tr>
			<td colspan="2">
			<p style="text-align: right; padding: 10px"><input type="checkbox"> 네, 동의합니다.</p>
			</td>
		</tr>
		</table>
	</form>
	<div>
		<button class="btn1" onclick="joinOk();">가입완료</button>
		<button class="btn1" onclick="location.href='${pageContext.request.contextPath}/member/sign';">돌아가기</button>
	</div>
</div>
   </div>
</div>