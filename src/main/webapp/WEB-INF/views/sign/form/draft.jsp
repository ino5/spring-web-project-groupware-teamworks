<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- 썸머노트 -->
<script src="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/board/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.css">
<script type="text/javascript">
	$(document).ready(function() {
		//여기 아래 부분
		$('#summernote').summernote({
			height : 600, // 에디터 높이
			width:1200,

			minHeight : null, // 최소 높이
			maxHeight : null, // 최대 높이
			focus : true, // 에디터 로딩후 포커스를 맞출지 여부
			lang : "ko-KR", // 한글 설정
			placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
			callbacks: {	//이미지 첨부하는 부분
		               onImageUpload : function(files) {
		            	   	alert("onImageUpload : function");
		                    uploadSummernoteImageFile(files[0],this);
		                }
		            }

		});
	});
</script>
<!-- -->
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/signSide.jsp" %>
	</div>
	<div id="content">
		<div id="content_top">content_top</div>
		<div id="content_middle">
			<form action="${pageContext.request.contextPath}/sign/insert" method="post">
				<sec:csrfInput/>
				<input type="hidden" name="sgf_id" value="draft">
				<input type="text" name="title">
				<textarea id="summernote" class="summernote" name="content" placeholder="글 내용" rows="15" readonly >
					text test
				</textarea>
				<input type="submit">
			</form>
		</div>
		<div id="content_bottom">content_bottom</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
<!-- 썸머노트 -->
<script>
	function uploadSummernoteImageFile(file, editor) {
	    data = new FormData();
	    data.append("file", file);
	    $.ajax({
	        data : data,
	        type : "POST",
	        url : _contextPath+"/board/uploadSummernoteImageFile",
	        contentType : false,
	        processData : false,
	        success : function(data) {
	            //항상 업로드된 파일의 url이 있어야 한다.
	            $(editor).summernote('insertImage', _contextPath+data.url);
	        }
	    });
	}
	//$('#summernote').summernote('enable');
	//$('#summernote').summernote('disable');
</script>
<!--  -->
</body>
</html>