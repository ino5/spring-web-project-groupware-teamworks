<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 부분     -->
	<header>
		<%-- 	<img alt="" src="${pageContext.request.contextPath}/images/11.JPG" style="width: 20%;"> --%>
		<nav class="head_nav">
			<ul>
				<li><a onclick="javascript:doShow()" class="button3" style="vertical-align:middle; padding-top: 18px; padding-bottom: 11px;"><img alt="image"
					src="${pageContext.request.contextPath}/header/img/full.png" style="width: 30px; height: 23px;"></a></li>
				<li><a href="${pageContext.request.contextPath}/main" id="head_main">홈</a></li>
				<li><a href="${pageContext.request.contextPath}/mail" id="head_mail">메일</a></li>
				<li><a href="${pageContext.request.contextPath}/time" id="head_time">근태관리</a></li>
				<li><a href="${pageContext.request.contextPath}/sign" id="head_sign">전자결재</a></li>
				<li><a href="${pageContext.request.contextPath}/calendar" id="head_calendar">캘린더</a></li>
				<li><a href="${pageContext.request.contextPath}/board" id="head_board">게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/community" id="head_community">커뮤니티</a></li>
				<li><a href="${pageContext.request.contextPath}/address" id="head_address">주소록</a></li>
				<li><a href="${pageContext.request.contextPath}/drive" id="head_drive">드라이브</a></li>
				<li><a href="${pageContext.request.contextPath}/reservation" id="head_reservation">예약</a></li>
				<li><a href="${pageContext.request.contextPath}/survey" id="head_survey">설문</a></li>
				<li><a href="${pageContext.request.contextPath}/admin" id="head_admin">관리자</a></li>
			</ul>
		</nav>
	</header>