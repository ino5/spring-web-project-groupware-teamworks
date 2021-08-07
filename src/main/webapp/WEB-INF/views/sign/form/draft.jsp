<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- sign head 공용 -->
<%@include file = "/WEB-INF/views/sign/header/signHead.jsp" %>
<!--  sign draft -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signFormDraft.css">
<script src="${pageContext.request.contextPath}/sign/js/signFormDraft.js"></script>
</head>



<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<input type="hidden" id="data_jspType" value="${jspType}">
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/header/signSide.jsp" %>
	</div>
<form method="post" enctype="multipart/form-data">
	<sec:csrfInput/>
	<div id="content">
		<div id="content_top">
			<h2>${mapOfSignContent.title}</h2>
			
			<div id="sign_line">
				<h3>결재라인</h3>
			<c:if test="${jspType == 'w' }">	
				<button type="button" id="button_new_sign_line">결재라인 추가</button>
				이름 부서 직위
				<ul id="sortable">
						<!-- 샘플 -->
<!-- 					<li class="ui-state-default"> -->
<!-- 						<span class="ic ic_drag"></span> -->
<!-- 						<input type="hidden" name="sgl_m_id" value= "iin140"> -->
<!-- 						<input type="hidden" name="sgl_type" value= "1">														 -->
<!-- 					</li> -->
				</ul>
			</c:if>	
			<c:if test="${jspType == 'r' }">
				<c:forEach var= "signLine" items="${listOfSignLine}">
					${signLine.m_name} ${signLine.dpt_name} ${signLine.pt_name}<br>
				</c:forEach>
			</c:if>
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
			<h3>문서 양식 : 업무 기안</h3>
			<input type="hidden" name="sgf_id" value="draft">
			<div id="div_title">
				<c:if test="${jspType == 'r'}">
					${mapOfSignContent.title }
				</c:if>			
				<c:if test="${jspType == 'w'}">
					제목: <input type="text" name="title">
				</c:if>
			</div>
			<div id="div_content">
				<c:if test="${jspType == 'r'}">
					${mapOfSignContent.content}
				</c:if>
				<c:if test="${jspType == 'w'}">
					<textarea id="summernote" class="summernote" name="content" placeholder="글 내용" rows="15" readonly >
						text test
					</textarea>
				</c:if>
			</div>
			<div id="div_file">
				<c:if test="${jspType == 'r'&& mapOfSignContent.dv_id != null}">
					${dv_filename}
					<button type="button" class="button_download_file" data-dv_id="${mapOfSignContent.dv_id}">download</button> <br>
				</c:if>
				<c:if test="${jspType == 'w'}">
					<input type="file" name="file1"> <br>
				</c:if>		
			</div>				
		</div>
		
		<div id="content_bottom">
			<br><br>
			<c:if test="${jspType == 'w'}">
				<input type="submit" formaction="${pageContext.request.contextPath}/sign/insert">
			</c:if>
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