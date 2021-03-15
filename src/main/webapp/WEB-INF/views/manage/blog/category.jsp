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
	var index=0;

	$("body").on("click", ".addCate", function() {
		if(index<10) {	
			var input="<i class='fas fa-chevron-right'></i><input type=text name=category["+index+"]>";
			var button_div="<div style='float:right; margin-right: 10px;'><button class='btn5 saveCate'>확인</button><button class='btn5 cancelBtn'>취소</button></div>";	
			var span="<span style='display:none;' class='cateName'></span><div style='display:none; float:right; margin-right: 10px;'><button class='btn5 updateCate'>수정</button><button class='btn5'>관리</button><button class='btn5 deleteCate'>삭제</button></div>";
			
			$(".addCate").before("<div class='cate'>"+input+button_div+span+"</div>");

			index++;
		} else {
			alert("카테고리는 10개까지 추가 가능합니다.");
		}
	});
	
	$("body").on("click", ".cate .saveCate", function() {
		var $input=$(this).closest("div").prev(".cate input[type=text]");
		var $button=$input.next("div");
		var cate=$input.val();
		
		var url="${pageContext.request.contextPath}/manage/insertCate";
		var query="blogNum=${dto.blogNum}&category="+cate+"&subNum=0";
		
		if(cate=="") {
			alert("카테고리 이름을 입력하세요");
			$input.focus();
			return;
		}
		
		var fn=function(data) {
			if(data==true) {
				alert("카테고리가 추가되었습니다.");
				location.reload();
			}	
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});

$(function() {
	$("body").on("mouseover", ".scate", function() {
		$(this).find("span").next("div").css("display", "");
	});
	$("body").on("mouseleave", ".scate", function() {
		$(this).find("span").next("div").css("display", "none");
	});
	
	$("body").on("click", ".cancelBtn", function() {
		location.reload();
	});
});

$(function() {
	$("body").on("click", ".updateCate", function() {
		$(this).closest("div").css("display", "none");
		$(this).closest("div").prev("span").css("display", "none");
		$(this).closest("div").prev().prev("div").css("display", "");
		$(this).closest("div").prev().prev().prev("input").css("display", "");
		$(this).closest(".scate").attr("class", "ucate");
	});
	
	$("body").on("click", ".ucate .saveCate", function() {
		var $input=$(this).closest("div").prev(".ucate input[type=text]");
		var $button=$input.next("div");
		var cate=$input.val();
		var cateNum=$(this).attr("data-category");
		
		var url="${pageContext.request.contextPath}/manage/updateCate";
		var query="blogNum=${dto.blogNum}&categoryNum="+cateNum+"&category="+cate;
		
		var fn=function(data) {
			if(data==true) {
				alert("카테고리가 수정되었습니다.");
				location.reload();
			}	
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});

$(function() {
	$("body").on("click", ".scate .deleteCate", function() {
		var cateNum=$(this).attr("data-category");
		
		var url="${pageContext.request.contextPath}/manage/deleteCate";
		var query="blogNum=${dto.blogNum}&categoryNum="+cateNum;
		
		if(! confirm("카테고리를 삭제하시겠습니까?")) {
			return;
		}
		
		var fn=function(data) {
			if(data==true) {
				alert("카테고리가 삭제되었습니다.");
				location.reload();
			}	
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});
</script>
<div id="body-page">
	<div class="right-article">
		카테고리 설정
		<div class="setLayout" style="margin-top: 10px;">
			<div class="categoryBox">
				<div class="allCate"><i class="fas fa-bars"></i> 전체보기</div>
				<c:forEach var="vo" items="${list}">
					<div class="scate"><i class="fas fa-chevron-right"></i>
						<input type="text" value="${vo.category}" name="category[${vo.categoryNum}]" style="display: none;">
							<div style="float: right; margin-right: 10px; display: none;">
								<button class="btn5 saveCate" data-category="${vo.categoryNum}">확인</button>
								<button class="btn5 cancelBtn">취소</button>
							</div>
							<span style="" class="cateName">${vo.category}</span>
							<div style="display:none; float:right; margin-right: 10px;">
								<button class="btn5 updateCate">수정</button>
								<button class="btn5">관리</button>
								<button class="btn5 deleteCate" data-category="${vo.categoryNum}">삭제</button>
						</div>
					</div>
				</c:forEach>
				<div class="addCate"><i class="fas fa-plus"></i> 카테고리 추가</div>
			</div>
		</div>
			<div style="text-align: center;">
				<button class="btn2 saveCateList">저장하기</button>
			</div>
	</div>
</div>