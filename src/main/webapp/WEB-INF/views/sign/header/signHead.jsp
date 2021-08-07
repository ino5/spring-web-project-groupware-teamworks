<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 썸머노트  라이브러리-->
<script src="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/board/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.css">
<!-- end of 썸머노트 -->
<!-- 썸머노트 관련 js -->
<script src="${pageContext.request.contextPath}/sign/js/scriptForSummernoteInSign.js"></script>


<!-- 파일 다운로드 관련 js -->
<script defer src="${pageContext.request.contextPath}/drive/js/main.js"></script>

<!-- jquery-ui sortable -->
<style>
  	#sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; position: relative; }
	#sortable li span { position: absolute; margin-left: -1.3em; }
</style>
<script>
	$(function() {
		$( "#sortable" ).sortable();
	    $( "#sortable" ).disableSelection();
	});
</script>
<!-- end of jquery-ui sortable  -->