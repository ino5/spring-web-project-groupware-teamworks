<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<%@include file = "/WEB-INF/views/drive/header/driveHead.jsp" %>
<script defer src="${pageContext.request.contextPath}/drive/js/main.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/drive/css/main.css">
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>

	<div id="side">
		<%@include file = "/WEB-INF/views/drive/header/driveSide.jsp" %>
	</div>
	<div id="content">
		<div id="content_top">
			<h1>${title}</h1>
		</div>
		<!-- 드라이브 내 파일 목록 테이블 -->
		<table id="table_drive">
			<thead>
				<tr>
					<th>파일명</th>
					<th>등록자</th>
					<th>등록날짜</th>
					<th>삭제</th>
				</tr>
			</thead>		
		<c:forEach var= "driveFileInfo" items="${driveFileInfoListOfEnterprise}">
			<tr id="row_dv_id_${driveFileInfo.dv_id}">								
				<td>
					${driveFileInfo.dv_filename} <button type="button" class="button_download button_download_file" data-dv_id="${driveFileInfo.dv_id}">download</button>
				</td>	
				<td>
					${driveFileInfo.m_id}
				</td>			
				<td>
					<fmt:formatDate value="${driveFileInfo.dv_regdate}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate>
				</td>				
				<td>
					<button type="button" class="button_download button_delete_file" data-dv_id="${driveFileInfo.dv_id}">삭제</button>
				</td>
			</tr>
		</c:forEach>
		</table>
		
		

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>