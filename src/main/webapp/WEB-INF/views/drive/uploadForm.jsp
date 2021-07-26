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

	</div>
	<div id="content">
		drive/uploadForm.jsp <br>
		<form id="form1" action="${pageContext.request.contextPath}/drive/upload" method="post" enctype="multipart/form-data" target="myBatisFrame">
			<sec:csrfInput/>
			<input type="file" name="file1"> <p>
			<input type="text" name="title"> <p>
		    <input type="hidden" name="path" value="${pageContext.request.contextPath}/resources/image/"> 
			<input type="submit">
		</form>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>