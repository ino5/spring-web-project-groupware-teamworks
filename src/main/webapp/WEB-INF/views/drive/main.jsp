<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<script defer src="${pageContext.request.contextPath}/drive/js/main.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/drive/css/main.css">
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/drive/side.jsp" %>
	</div>
	<div id="content">
		<h1>${title}</h1>
		<!-- 드라이브 내 파일 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th>download</th>
					<th>dv_id</th>
					<th>m_id</th>
					<th>dv_filename</th>
					<th>dv_regdate</th>
					<th>cg_num</th>
				</tr>
			</thead>		
		<c:forEach var= "driveFileInfo" items="${driveFileInfoListOfEnterprise}">
			<tr id="row_dv_id_${driveFileInfo.dv_id}">
				<td>
					<button type="button" class="button_download_file" data-dv_id="${driveFileInfo.dv_id}">download</button>
				</td>				
				<td>
					${driveFileInfo.dv_id}
				</td>				
				<td>
					${driveFileInfo.m_id}
				</td>				
				<td>
					${driveFileInfo.dv_filename}
				</td>				
				<td>
					${driveFileInfo.dv_regdate}
				</td>				
				<td>
					${driveFileInfo.cg_num}
				</td>
				<td>
					<button type="button" class="button_delete_file" data-dv_id="${driveFileInfo.dv_id}">삭제</button>
				</td>
			</tr>
		</c:forEach>
		</table>
		
		
		<!-- 파일 업로드 모달창 -->
		<div id="modal_wrap_upload_file">
			<button type="button" id="modal_close_upload_file">x</button>
			<div>
				<form id="form_upload" action="${pageContext.request.contextPath}/drive/upload" method="post" enctype="multipart/form-data">
					<sec:csrfInput/>
					<input type="file" name="file1"> <br>
					<select name="cg_num">
						<option value="1">전사 자료실</option>
						<option value="3">개인 자료실</option>
					</select>
					<input type="submit">
				</form>
			</div>
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>