<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 부분     -->
	<header>
		<%-- 	<img alt="" src="${pageContext.request.contextPath}/images/11.JPG" style="width: 20%;"> --%>
		<nav class="head_nav">
			<ul>
				<li><a onclick="javascript:doShow()" class="button3" style="vertical-align:middle; padding-top: 18px; padding-bottom: 11px;"><img alt="image"
					src="${pageContext.request.contextPath}/header/img/full.png" style="width: 30px; height: 23px;"></a></li>
				<li><a href="${pageContext.request.contextPath}/main.jsp">홈</a></li>
				<li><a href="#">메일</a></li>
				<li><a href="${pageContext.request.contextPath}/time.jsp" style="background-color: #4374D9;">근태관리</a></li>
				<li><a href="#">전자결재</a></li>
				<li><a href="${pageContext.request.contextPath}/calendar.jsp">캘린더</a></li>
				<li><a href="#">게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/juso.jsp">주소록</a></li>
				<li><a href="#">드라이브</a></li>
				<li><a href="#">예약</a></li>
				<li><a href="#">설문</a></li>
			</ul>
		</nav>
	</header>