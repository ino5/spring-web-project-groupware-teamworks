<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/sample/js/sampleAjax.js"></script>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">
		<button id="ajaxButton">버튼</button>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>