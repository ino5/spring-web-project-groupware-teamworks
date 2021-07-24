<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/talk/js/talk.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/talk/css/talk.css">
<meta charset="UTF-8">
	<title>Chating</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side"></div>
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
					<table id="roomList" class="roomList"></table>
				</div>
				<div>
					<table class="inputTable">
						<tr>
							<th>방 이름</th>
							<th><input type="text" name="roomName" id="roomName"></th>
							<th><button id="createRoom">방 만들기</button></th>
						</tr>
					</table>
				</div>
			</div>
	</div>
	<div class="container">
		<h1>${roomName}</h1>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		<div id="meName"></div>
		<div id="chating" class="chating">
		</div>
		
		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onclick="chatName()" id="startBtn">+</button></th>
				</tr>
			</table>
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