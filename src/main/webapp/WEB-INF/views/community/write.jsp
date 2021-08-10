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
<script defer src="${pageContext.request.contextPath}/board/js/write.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/board/css/write.css">

<title>Insert title here</title>
</head>
		<script type="text/javascript">
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
						
									</script>
<body>
<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
		
	<div id="side">
		<button type="button" id="btn1"
			onclick="location.href='${pageContext.request.contextPath}/community/write'">글쓰기</button>
		<div id="side_text">
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"> <img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img1">
			</span>커뮤니티게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="as" items="${boardListOfCommunity }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/community/sideboard_list?bd_num=${as.bd_num}">${as.bd_name}</a></li>
				</c:forEach>

			</ol>
		</div>
	</div>
		<div>
			<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img2"></span>부서게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
					<li class="li">
						</li>
	
			</ol>
		</div>
	</div>
	<div id="content">
			<form name="form_insert" action="${pageContext.request.contextPath}/community/insert" method="post" enctype="multipart/form-data">
				<sec:csrfInput/>
				<section id="point">
					<article class="pt pt1">
					<table>
					<tr>
						<td>게시판선택</td>
						<td colspan="3">
							<select name="bd_num">
								<c:forEach var="boardListOfCommunity" items="${boardListOfCommunity}">
									  <option value="${boardListOfCommunity.bd_num}">${boardListOfCommunity.bd_name}</option>
								</c:forEach>

							</select>
							</td>
							</tr>
							</table>
						<table class="pt_tb">
							<tr>
								<td id="td_title">글 작성하기</td>
							</tr>
							<tr>
							<th>제목</th>
								<td class="td_subject">
								<input id="subject" type="text" name="p_name" placeholder="글 제목" class="form_box">
								</td>
							</tr>
						<tr>
							<td colspan="5"><textarea id="summernote" class="summernote"
									name="p_content" placeholder="글 내용" rows="15" style="width: 900px;">${view.p_content}</textarea>

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
				<input type="hidden" name="p_type" value="2">
				<button type="submit" id="btnUpdete"onclick="">등록</button>
					<button type="submit" id="btnNotice"onclick="form_insert.p_type.value = 1;">공지로등록</button>		
			</form>
		
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>