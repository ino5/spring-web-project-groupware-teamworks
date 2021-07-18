<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file = "/WEB-INF/views/sample/sampleList2.jsp" %>
	sampleList.jsp<br>
	<h2>List</h2>
	<table>
		<thead>
			<tr>
				<th>num</th>
				<th>name</th>
			</tr>
		</thead>
		<c:forEach var="sample" items="${sampleList}">
			<tr>
				<td>${sample.num}</td>
				<td>${sample.name}</td>
			</tr>
		</c:forEach>
	</table>
	<br><br>
	<h2>Insert</h2>
	<form action="${pageContext.request.contextPath}/sample/insert">
		num:
		<input type="text" name="num" />
		<br> name:
		<input type="text" name="name" />
		<br>
		<input type="submit" />
	</form>
</body>
</html>