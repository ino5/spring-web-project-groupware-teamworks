<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/talk/js/room.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/talk/css/room.css">
<title>Room</title>
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
</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>