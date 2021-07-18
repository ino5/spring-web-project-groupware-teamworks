<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<link rel="styleSheet" href="${pageContext.request.contextPath}/login/css/passwordCheck.css">
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="content">
		<div id="content_top"></div>
		passwordCheck<br>
		<form action="${pageContext.request.contextPath}/login/passwordCheckResult" method="post">
			<sec:csrfInput/>
			pw : <input type="password" name="m_password">
			<input type="submit">
		</form>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>