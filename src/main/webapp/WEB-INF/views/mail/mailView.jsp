<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- 파일 다운 위한 js -->
<script defer src="${pageContext.request.contextPath}/drive/js/main.js"></script>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">
		보낸 사람: ${mail.ml_email } <br>
		받는 사람:
		<c:forEach var="mailTo" items="${listOfMailTo}">
			${mailTo.ml_email }
		</c:forEach>
		<br>
		제목: ${mail.ml_title } <br>
		내용
		${mail.ml_content } <br>
		
		첨부파일:
		<c:forEach var="driveFileInfo" items="${listOfDriveFileInfo}">
			<button type="button" class="button_download_file" data-dv_id="${driveFileInfo.dv_id}">${driveFileInfo.dv_filename}</button>
		</c:forEach>
		<br>

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>