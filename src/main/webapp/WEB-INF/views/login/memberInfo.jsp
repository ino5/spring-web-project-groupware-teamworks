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
	<h1>memberInfo.jsp</h1>
	${pageContext.request.contextPath}<br>
	m_id : ${m_id}
	<form action="${pageContext.request.contextPath}/login/logout" method="POST">
		<sec:csrfInput/>
		<input type="submit" value="logout">
	</form>
</body>
</html>