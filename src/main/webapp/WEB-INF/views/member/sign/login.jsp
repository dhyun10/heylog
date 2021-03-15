<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function loginOk() {
	var f=document.loginForm;
	
	f.action="${pageContext.request.contextPath}/member/loginOk";
	f.submit();
}

function ajaxHTML(url, method, query, selector){
	$.ajax({
		type:method,
		url:url,
		data:query,
		success:function(data){
			$(selector).html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status===403){
				login();
				return false;
			} else if(jqXHR.status===410){
				alert("삭제된 게시물입니다.");
				return false;
			} else if(jqXHR.status===402){
				alert("권한이 없습니다.");
				return false;
			}
			
			console.log(jqXHR.responseText);
		}
	});
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

function ajaxTEXT(url, method, query, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:"text",
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

function findId() {	
	var url="${pageContext.request.contextPath}/member/findId";
	var query="";
	var selector = "#signForm";
	
	ajaxHTML(url, "get", query, selector);
}

function findPwd() {	
	var url="${pageContext.request.contextPath}/member/findPwd";
	var query="";
	var selector = "#signForm";
	
	ajaxHTML(url, "get", query, selector);
}


</script>
<div class="body-container">
   <div class="signLayout">
		<div id="signForm" style="display: inline-grid; margin: 50px;">
   		<p style="font-size: 50px; font-weight: bold; margin-bottom: 50px;" >LOGIN</p>
			<form name="loginForm" method="post">
				<table>
				<tr>
					<td colspan="2"><input type="text" name="userId" placeholder="ID"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="password" name="userPwd" placeholder="Password"></td>
				</tr>
				<tr>
					<td colspan="2">${message}</td>
				</tr>
				</table>
			</form>
			<table>
				<tr>
					<td colspan="2"><button class="btn1" onclick="javascript:loginOk();">로그인</button></td>
				</tr>
				<tr>
					<td><label><input type="checkbox"> 로그인 상태 유지</label></td>
					<td><a href="javascript:findId();">아이디</a>/<a href="javascript:findPwd();">비밀번호 찾기</a></td>
				</tr>
			</table>
		</div>
   </div>
</div>
