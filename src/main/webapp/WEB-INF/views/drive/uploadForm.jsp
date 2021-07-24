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
		<form method="post">
			<sec:csrfInput/>
			<input type="submit" value="업로드" class="" formaction="${pageContext.request.contextPath}/drive/upload">
		</form>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>