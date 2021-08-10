<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<style>
img {
	width: 50px;
	height: 50px;
	border-radius: 30px;
	
}
</style>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">
		<img src="${pageContext.request.contextPath}/resource/member/photo/${member.m_id}.jpg" onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'"/>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>