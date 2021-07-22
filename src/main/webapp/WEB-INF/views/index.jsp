<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file = "/WEB-INF/views/header/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<meta charset="UTF-8" http-equiv="refresh" content="0; URL='${pageContext.request.contextPath}/login/login'" />
=======
<%-- <%@include file = "/WEB-INF/views/header/headerHead.jsp" %> --%>
<meta charset="UTF-8" http-equiv="refresh" content="0; URL='${pageContext.request.contextPath}/login/memberInfo'" />
>>>>>>> 2471d5dc14b25488b455149463b1f86b26bfe665
<title>Insert title here</title>
</head>
<body>
<%
	response.sendRedirect("chat");
%>
</body>
</html>