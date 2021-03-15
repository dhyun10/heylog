<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("body").on("click", "input[name=findtype]", function() {
		val=$(this).val();
		if(val=='email') {
			$("input[name=tel]").val("");
			$("input[name=email]").closest("tr").css("display", "");
			$("input[name=tel]").closest("tr").css("display", "none");
		} else {
			$("input[name=email]").val("");
			$("input[name=email]").closest("tr").css("display", "none");
			$("input[name=tel]").closest("tr").css("display", "");
		}
	});
});

$(function() {
	$("body").on("click", "#searchId", function() {
		var userName=$("input[name=userName]").val();
		var type=$("input[name=findtype]:checked").val();
		var val;

		if(type=='tel') {
			val=$("input[name=tel]").val();
		} else if(type=='email') {
			val=$("input[name=email]").val();
		}
		
		var url="${pageContext.request.contextPath}/member/findId";
		var query="userName="+userName+"&"+type+"="+val;
		
		var fn=function(data){
			if(data!='') {
				$("#id").html("회원님의 아이디는 ["+data+"] 입니다.");
			} else if(data=='') {
				$("#id").html("일치하는 회원정보가 없습니다.");
			}
		};

		ajaxTEXT(url, "post", query, fn);
	});
});
</script>

<p style="font-size: 40px; font-weight: bold;">아이디 찾기</p>
<div id="" style="margin: 30px;">
	<table>
		<tr>
			<td><input type="radio" name="findtype" value="tel">전화번호로 찾기</td>
			<td><input type="radio" name="findtype" value="email">이메일로 찾기</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="userName" placeholder="이름"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="tel" placeholder="전화번호"></td>
		</tr>		
		<tr style="display: none;">
			<td colspan="2"><input type="text" name="email" placeholder="이메일 ex)abc123@naver.com..."></td>
		</tr>
		<tr>
			<td colspan="2" id="id"></td>
		</tr>
		<tr>
			<td colspan="2"><button class="btn1" id="searchId">확인</button></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: right;"><a href="javascript:findPwd();">비밀번호 찾기</a></td>
		</tr>
	</table>
</div>