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
	<h1>memberInfo.jsp</h1>
	${pageContext.request.contextPath}<br>
	m_id : ${m_id}
	<form action="${pageContext.request.contextPath}/login/logout" method="POST">
		<sec:csrfInput/>
		<input type="submit" value="logout">
	</form>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>