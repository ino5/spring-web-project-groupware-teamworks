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
		<form action="${pageContext.request.contextPath}/sample/test/memberPhoto/update" method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<input type="file" name="multipartFile"> <p>
			<input type="submit">
		</form>

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>