<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>login/login.jsp</h1>
<form action="${pageContext.request.contextPath}/login/login" method="post">
	<sec:csrfInput/>
	id : <input type="text" name="m_id">
	pw : <input type="password" name="m_password">
	<input type="submit">
</form>
</body>
</html>