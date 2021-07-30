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
	${pageContext.request.contextPath} <br>
	m_id : ${member.m_id} <br>
	m_password : ${member.m_password} <br>
	m_name : ${member.m_name} <br>
	m_empnum : ${member.m_empnum} <br>
	m_birth : ${member.m_birth} <br>
	m_phone : ${member.m_phone} <br>
	m_email : ${member.m_email} <br>
	dpt_code : ${member.dpt_code} <br>
	pt_code : ${member.pt_code} <br>
	m_lastdate : ${member.m_lastdate} <br>
	m_status : ${member.m_status} <br>
	<form action="${pageContext.request.contextPath}/login/logout" method="POST">
		<sec:csrfInput/>
		<input type="submit" value="logout">
	</form>
</body>
</html>