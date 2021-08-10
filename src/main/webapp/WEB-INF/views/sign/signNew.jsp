<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- sign head 공용 -->
<%@include file = "/WEB-INF/views/sign/header/signHead.jsp" %>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/header/signSide.jsp" %>
	</div>
	<div id="content">
		<div id="content_top">content_top</div>
		<div id="content_middle">
			<%@include file = "/WEB-INF/views/sign/form/draft.jsp" %>		
		</div>
		<div id="content_bottom">content_bottom</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>