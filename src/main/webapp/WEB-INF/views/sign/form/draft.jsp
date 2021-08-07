<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- 썸머노트  라이브러리-->
<script src="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/board/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.css">
<!-- end of 썸머노트 -->
<!-- 썸머노트 관련 js -->
<script src="${pageContext.request.contextPath}/sign/js/scriptForSummernoteInSign.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signFormDraft.css">
<script src="${pageContext.request.contextPath}/sign/js/signFormDraft.js"></script>

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
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/signSide.jsp" %>
	</div>
<form method="post" enctype="multipart/form-data">
	<sec:csrfInput/>
	<div id="content">
		<div id="content_top">
			<h1>content_top</h1>
			<h1>${jspType}</h1>
			<h2>${mapOfsignContent.title}</h2>
			<h2>${mapOfsignContent.dv_id}</h2>
			<h1><c:if test="${jspType == 'w' }"> true</c:if></h1>
			<div id="sign_line">
				<h3>결재라인</h3>
				<button type="button" id="button_new_sign_line">결재라인 추가</button>
				<ul id="sortable">
					이름 부서 직위
						<!-- 샘플 -->
<!-- 					<li class="ui-state-default"> -->
<!-- 						<span class="ic ic_drag"></span> -->
<!-- 						<input type="hidden" name="sgl_m_id" value= "iin140"> -->
<!-- 						<input type="hidden" name="sgl_type" value= "1">														 -->
<!-- 					</li> -->
				</ul>
				<br><br>
			</div>
			
			<!-- 결재라인 추가 모달창 -->
			<div id="modal_wrap_new_sign_line">
				<button type="button" id="modal_close_new_sign_line">x</button>
				<div>
					<c:forEach var= "member" items="${listOfMember}">
						<button type="button" onclick="addSignLine('${member.m_id}', '${member.m_name}', '${member.dpt_name}', '${member.pt_name}'); closeModalOfNewSignLine();">${member.m_name}</button><br>
					</c:forEach>
				</div>
			</div>			
		</div>
		
		<div id="content_middle">
			<h1>content_middle</h1>
			<h3>문서 양식 : 업무 기안</h3>
			<input type="hidden" name="sgf_id" value="draft">
			<div id="div_title">
				<c:if test="${jspType == 'r'}">
					${mapOfsignContent.title }
				</c:if>			
				<c:if test="${jspType == 'w'}">
					제목: <input type="text" name="title">
				</c:if>
			</div>
			<div id="div_content">
				<c:if test="${jspType == 'r'}">
					${mapOfsignContent.content}
				</c:if>
				<c:if test="${jspType == 'w'}">
					<textarea id="summernote" class="summernote" name="content" placeholder="글 내용" rows="15" readonly >
						text test
					</textarea>
				</c:if>
			</div>
			<div id="div_file">
				<c:if test="${jspType == 'w'}">
					<input type="file" name="file1"> <br>
				</c:if>			
			</div>				
		</div>
		
		<div id="content_bottom">
			<br><br>
			<h1>content_bottom</h1>
			<input type="submit" formaction="${pageContext.request.contextPath}/sign/insert">
		</div>
	</div>
</form>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
<!-- 썸머노트 -->
<script>
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
	                    uploadSummernoteImageFile(files[0],this);
	                }
	            }
	
	});
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
</script>
<!-- end of 썸머노트  -->


</body>
</html>