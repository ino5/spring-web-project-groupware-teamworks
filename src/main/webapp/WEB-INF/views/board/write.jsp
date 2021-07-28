<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<!-- 서머노트를 위해 추가해야할 부분 -->
<script
	src="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.js"></script>
<script
	src="${pageContext.request.contextPath}/board/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.css">
<!--  -->
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
			<div id="side">
		<button type="button" id="btn1">일정등록</button>
		<button type="button" id="btn1">글쓰기</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/images/right.png"
					style="width: 16px; height: 12px; transition:0.5s;" id="img1"></span> <span
				id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/images/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${listBoard }">
				<li class="li">${bs.bd_name}</li>
				</c:forEach>

			</ol>
		</div>
	</div>

	<div id="content">
			<form action="${pageContext.request.contextPath}/board/insert" method="post" enctype="multipart/form-data">
				<sec:csrfInput/>
				<input type="hidden" name="m_id" value="">
				<section id="point">
					<article class="pt pt1">
						<table class="pt_tb">
							<tr>
								<td id="td_title">글 작성하기</td>
							</tr>
							<tr>
								<td class="td_subject">
									<input id="subject" type="text" name="p_name" placeholder="글 제목" class="form_box">
								</td>
								<td>
									<select id="select_bd_code" name="bd_code">
										<option value="1">정보공유</option>
										<option value="2">취준톡톡</option>
									</select>
								</td>
							</tr>
						<tr>
							<td colspan="5"><textarea id="summernote" class="summernote"
									name="p_content" placeholder="글 내용" rows="15">${view.p_content}</textarea>

								<script type="text/javascript">
									$(document).ready(function() {
										//여기 아래 부분
										$('#summernote').summernote({
											height : 300, // 에디터 높이
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
									$('.summernote').summernote({
										height : 300,
										lang : "ko-KR"
									});
									function uploadSummernoteImageFile(file, editor) {
							            data = new FormData();
							            data.append("file", file);
							            $.ajax({
							                data : data,
							                type : "POST",
							                url : "/uploadSummernoteImageFile",
							                contentType : false,
							                processData : false,
							                success : function(data) {
							                    //항상 업로드된 파일의 url이 있어야 한다.
							                    $(editor).summernote('insertImage', data.url);
							                }
							            });
							        }

								</script></td>
						</tr>
						</table>
					</article>
				</section>
				<button type="submit" id="btnUpdete"onclick="location.href='${pageContext.request.contextPath}/board'">등록</button>
			</form>
		
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>