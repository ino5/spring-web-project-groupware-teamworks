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
	<form action="${pageContext.request.contextPath}/sample/finalTest/insert">
		작성자 이름을 입력하세요<br>
		<input type="text" name="name"><br>
		비밀번호를 입력하세요<br>		
		<input type="password" name="password"><br>
		메세지를 입력하세요<br>
		<input type="text" name="message"><br>
		<input type="submit">
	</form>
</body>
</html>