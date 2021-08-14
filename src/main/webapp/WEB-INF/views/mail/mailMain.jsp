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
		<table id="list_mail">
			<c:forEach var="mail" items="${listOfMail}" >
				<tr>
					<td>${mail.ml_num}</td>
					<td>${mail.ml_email}</td>
					<td>
						<a href="${pageContext.request.contextPath}/mail/view/${mail.ml_num}">${mail.ml_title}</a>
					</td>
					<td>${mail.ml_regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>