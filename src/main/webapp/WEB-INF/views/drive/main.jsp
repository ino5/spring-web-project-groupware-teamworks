<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/drive/uploadForm'">파일 업로드</button>
	</div>
	<div id="content">

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>