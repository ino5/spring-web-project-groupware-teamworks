<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>login/join.jsp</h2>
<form action="${pageContext.request.contextPath}/login/join" method="post">
	id : <input type="text" name="m_id">
	pw : <input type="password" name="m_password">
	<sec:csrfInput/>
	<input type="submit">
</form>
</body>
</html>