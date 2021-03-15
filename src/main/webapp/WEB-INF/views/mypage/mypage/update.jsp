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
	$("#userPwd, #userPwdOk").keyup(function() {
		var pwd=$("#userPwd").val();
		var oPwd="${dto.userPwd}";
		var $input=$("#userPwd");
		var $inputOk=$("#userPwdOk");
		var pwdOk=$("#userPwdOk").val();
		if(pwd!=oPwd) {
			$input.next("span").html(" * 비밀번호가 회원정보와 일치하지 않습니다.");
		} else {
			$input.next("span").html("<i class='fas fa-check'></i>");
		}
		
		if(pwdOk!="") {
			if(pwd==pwdOk) {
				$inputOk.next("span").html("<i class='fas fa-check'></i>");
			} else {
				$inputOk.next("span").html(" * 비밀번호가 일치하지 않습니다.");
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

$(function() {
	var year="${dto.year}";
	var month="${dto.month}";
	var day="${dto.day}";
	
	if(month<10) {
		month=month.substr(1,1);
	}
	if(day<10) {
		day=day.substr(1,1);
	}
	
	$("#year option[value="+year+"]").attr('selected', 'selected');	
	$("#month option[value="+month+"]").attr('selected', 'selected');	
	$("#day option[value="+day+"]").attr('selected', 'selected');
});

$(function() {
	$("body").on("click", "#updateOk", function() {
		var url='${pageContext.request.contextPath}/member/update';
		var query=$("form[name=joinForm]").serialize();
		
		var fn=function(data) {
			if(data==true) {
				alert("회원정보가 변경되었습니다.");
			}
			location.href="${pageContext.request.contextPath}/member/home";
		}
		ajaxJSON(url, "post", query, fn);
	});
});

</script>
<div id="body-page" style="background: #f3f3f3;">
	<div class="right-article">
   		
<p style="font-size: 50px; font-weight: bold;">회원정보 수정</p>
<div id="joinForm" style="display: inline-grid; margin: 20px;">
	<form name="joinForm" method="post">
		<table class="joinTable">
		<tr>
			<td>아이디</td>
			<td><input type="text" id="userId" name="userId" readonly="readonly" value="${dto.userId}"><span></span></td>
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
			<td><input type="text" name="userName" style="width: 100px;" readonly="readonly" value="${dto.userName}"></td>
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
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="017">017</option>
			</select> - 
			<input type="text" name="tel2" style="width: 80px;" value="${dto.tel2}"> - 
			<input type="text" name="tel3" style="width: 80px;" value="${dto.tel3}"></td>
		</tr>
		<tr>
			<td>E-MAIL</td>
			<td>
				<input type="text" name="email1" value="${dto.email1}"> @ 
				<input type="text" name="email2" readonly="readonly" value="${dto.email2}">
				<select name="domain">
					<option value="">이메일 선택</option>
					<option value="gmail.com" ${dto.email2=='gmail.com'?"selected='selected'" : ""}>gmail.com</option>
					<option value="daum.net" ${dto.email2=='daum.net'?"selected='selected'" : ""}>daum.net</option>
					<option value="naver.com" ${dto.email2=='naver.com'?"selected='selected'" : ""}>naver.com</option>
					<option value="self">직접입력</option>
				</select>
			</td>
		</tr>
		</table>
	</form>
	<div style="text-align: center;">
		<button class="btn3" type="button" id="updateOk">수정완료</button>
		<button class="btn4" onclick="location.href='${pageContext.request.contextPath}/member/home';">돌아가기</button>
	</div>
</div>
   </div>
</div>