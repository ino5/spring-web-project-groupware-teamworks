<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/talk/js/Member.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/talk/css/Member.css">
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div class="wrap">
			<div id="content1">
			<div id="room1">
			<div id="logo">
				<div class="img">
					<img alt="로고.jpg" src="${pageContext.request.contextPath}/talk/img/로고.png">
				</div>
				<div class="h5"><b>TEAM</b></div>
				<div class="h6"><b>works</b></div>
			</div>
				<div id="roomContainer" class="roomContainer">
					<table id="memberlist" class="memberlist">
						<tr>
							<th>이름</th>
						</tr>
						<c:forEach var="list" items="${memberList}">
							<c:if test="${list.m_id != m_id }">
							<tr>
								<td><input type="hidden" id="m_id2" value="${list.m_id }"><button type="button"  onclick="location.href='${pageContext.request.contextPath}/talk/moveChating?m_id2=${list.m_id}'">${list.m_name }</button></td>
							</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
	</div>
</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>