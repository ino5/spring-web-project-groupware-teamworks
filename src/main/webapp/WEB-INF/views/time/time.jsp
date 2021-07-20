<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<link rel="styleSheet" href="${pageContext.request.contextPath}/time/css/time.css">
<script src="${pageContext.request.contextPath}/time/js/time.js"></script>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<section id="clock">
			<span id="clock1"></span> <br> <span id="clock2"></span>
		</section>
		<section style="margin-bottom: 5px;">
			<span class="clock3">출근시간</span> <span class="clock4">미등록</span> <br>
			<span class="clock3">퇴근시간</span> <span class="clock4">미등록</span>
		</section>
		<section style="margin-left: 20px;">
			<hr
				style="border: none; border: 1px dashed #BDBDBD; margin-bottom: 50px;">
		</section>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/time/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/time/img/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 근태관리</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li">내 근태 현황</li>
				<li class="li">내 연차 내역</li>
				<li class="li">내 인사정보</li>
			</ol>
		</div>
		<div id="div2">
			<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/time/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/time/img/white.png"
					style="width: 16px; height: 12px;" id="img2"></span> 전사 근태관리</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li">전사 근태현황</li>
				<li class="li">전사 근태통계</li>
				<li class="li">전사 인사정보</li>
				<li class="li">전사 연차현황</li>
				<li class="li">전사 연차 사용내역</li>
			</ol>
		</div>

	</div>
	<div id="content">
		<p id="content1">근태현황
		</p>
		<div>
			<span class="btn_month" id="prevMonth"><</span><span id="month1"></span><span class="btn_month" id="nextMonth">></span>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>