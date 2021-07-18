<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
sampleList2.jsp<br>
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
	<br>