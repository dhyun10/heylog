<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function ajaxFileJSON(url, method, query, fn){
	$.ajax({
		type:method,
		url:url,
		processData:false,
		contentType:false,
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
	$("body").on("change", ".blog-thumbnail input[type=file]", function() {
		var target=$(this)[0];
		var thumbnail_div=$(this).closest("div");
        var fileList = target.files ;
        
        var fileNM = $(this).val();
        
        var ext = fileNM.slice(fileNM.lastIndexOf(".") + 1).toLowerCase();

        if (!(ext=="gif"||ext=="jpg"||ext=="png")) {
            alert("이미지파일만 업로드 가능합니다.");
            return false;
        }
        
        var reader = new FileReader();
        reader.readAsDataURL(fileList [0]);
        
		reader.onload = function(e) {
			thumbnail_div.find('img').attr('src', e.target.result);
		}
	});
});

$(function() {
	$("body").on("click", ".updateOk", function() {
		var f=document.blogForm;
		var url='${pageContext.request.contextPath}/manage/setting';
		var query=new FormData(f);
		
		var fn=function(data) {
			if(data==true) {
				alert("블로그 정보가 수정되었습니다.");
			}
			location.href="${pageContext.request.contextPath}/manage/setting";
		}
		ajaxFileJSON(url, "post", query, fn);
	});
});
</script>
<div id="body-page">
	<div class="right-article">
		블로그 설정
		<div class="setLayout" style="margin-top: 10px;">
			<form name="blogForm" enctype="multipart/form-data">
			<div class="blog-thumbnail">
				<label>
				<input type="file" style="display: none;" name="uploads" accept=".jpg,.jpeg,.png,.gif,.bmp">
				<img id="thumbnail" width="180" height="180" src="${pageContext.request.contextPath}/uploads/blog/${dto.thumbnail}">
				</label>
			</div>
			<div class="blog-info">
				<ul>
					<li>블로그 이름</li>
					<li><input type="text" name="blogName" value="${dto.blogName}"></li>
				</ul>
				<ul>
					<li>블로그 닉네임</li>
					<li><input type="text" name="userNick" value="${dto.userNick}"></li>
				</ul>
				<ul>
					<li>블로그 설명</li>
					<li><textarea rows="4" name="blogContent">${dto.blogContent}</textarea></li>
				</ul>
				<ul>
					<li>기본 블로그 주소</li>
					<li><a style="color: #ff2626">${pageContext.request.contextPath}/${dto.userId}</a>
						<input type="hidden" name="userId" value="${dto.userId}">
					</li>
				</ul>
			</div>
			</form>
			<div style="text-align: center;">
				<button class="btn2 updateOk">저장하기</button>
			</div>
		</div>
	</div>
</div>