<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/main.css">
<script src="${pageContext.request.contextPath}/admin/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<title>Insert title here</title>
</head>
<!-- 바디 태그 더블 클릭 시 블록 선택 방지 -->
<body onselectstart="return false" ondragstart="return false">
	<div class="container">
		<div class="side" id="hide">
			<div>
				<div
					style="color: #37d2e7; font-size: 20px; font-weight: bold; margin-left: 5%; cursor: pointer;"
				>site Admin</div>
				<div id="text">
				<h3 style= "color: #bbb; font-size: 24px; cursor: pointer;">관리자 페이지</h3>
				</div>
				<div></div>
				<div class="menu_hover">
					<a id="button1" class="button1" style="color: white;" onclick="location.href='${pageContext.request.contextPath}/admin/admin'">
						<span id="span_hover"><img alt="image"`
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img1"
						></span> <span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png" style="width: 16px; height: 12px;"
							id="img1"
						></span> 개인 주소록
					</a>
					<ol id="scroll" style="display: none; list-style: none;">
<!-- 						<li class="li">전체 주소록</li> -->
<!-- 						<li class="li">개인</li> -->
<!-- 						<li class="li">연락처 주소록 추가</li> -->
					</ol>
				</div>
				<div id="div2" class="menu_hover">
					<a id="button2" class="button1" style="color: white;">
						<span id="span_hover"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img2"
						></span> <span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png" style="width: 16px; height: 12px;"
							id="img2"
						></span> 부서 주소록
					</a>
					<ol id="scroll" style="display: none; list-style: none;">
						<li class="li">새글쓰기</li>
						<li class="li">이동</li>
						<li class="li">복사</li>
						<li class="li">삭제</li>
						<li class="li">공지로 등록</li>
						<li class="li">목록다운로드</li>
					</ol>
				</div>
			</div>
		</div>
		<div id="content">
			<h2>
				<span style="color: #8C8C8C; font-size: 20px; font-weight: bold; margin-top: 20px;">관리자 페이지 Main</span>
			</h2>
			<br>
			<div style="z-index: 2; padding-top: 20px; margin-left: 50px; margin-bottom: 100px;">
				<h2>
					<span id="content1" style="font-weight: bold; font-size: 35px;">사원 현황</span>
				</h2>
			</div>
			
			<div style="width:800px; display: inline-block; margin: 0px 70px;">
			    <canvas id="myChart"></canvas>
			</div>
			<div style="width:800px; display: inline-block;">
			    <canvas id="myChart_time"></canvas>
			</div>
	</div>
	
</body> 
</html>