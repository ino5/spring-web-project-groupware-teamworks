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
		<form action='<c:url value="/testPage/insert_data"/>' method="post" id="insert_data">
			작성자 이름을 입력하세요. <br>
			<input name="user_name" type="text" id="user_name"><br>
			비밀번호를 입력하세요. <br>
			<input name="password" type="text" id="passward"><br>
			메세지를 입력하세요. <br>
			<input name="message" type="text" id="message"><br>
			<button type="submit">등록</button>
		</form>
	</div>
	<div id="content">

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>