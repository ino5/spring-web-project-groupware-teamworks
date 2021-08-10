<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/talk/js/MemberList.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/talk/css/MemberList.css">
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
	<div class="container">
		<h1>${roomName}</h1>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="m_id" value="${m_id}">
		<input type="hidden" id="m_name" value="${m_name}">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		<div id="meName"></div>
		<div id="chating" class="chating">
			<c:forEach var="list" items="${talkList}">
				<c:if test="${m_id != list.m_id }">
				<div id="memo">
					<p class='others'> ${list.m_name} : ${list.tk_content}</p>
					<p class='date2'>
					<fmt:formatDate value="${list.tk_time_sent}" pattern="yy-MM-dd"/><br>
					<fmt:formatDate value="${list.tk_time_sent}" pattern="HH:mm"/></p>
				</div>
				</c:if>
				<c:if test="${m_id == list.m_id }">
				<div id="memo">
					<p class='me'> 나 : ${list.tk_content}</p>
					<p class='date'>
					<fmt:formatDate value="${list.tk_time_sent}" pattern="yy-MM-dd"/><br>
					<fmt:formatDate value="${list.tk_time_sent}" pattern="HH:mm"/></p>
				</div>
				</c:if>
			</c:forEach>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">전송</button></th>
				</tr>
				<tr>
					<th>파일</th>
					<th><input  type="file" id="fileUpload"></th>
					<th><button onclick="fileSend()" id="sendFileBtn"><img alt="다운.png" src="${pageContext.request.contextPath}/talk/img/다운.png"></button></th>
				</tr>
			</table>
		</div>
	</div>
</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>