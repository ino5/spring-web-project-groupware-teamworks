<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 세션 아이디 -->
<sec:authentication property="principal.username" var="sec_m_id" />
<input type="hidden" name="sec_m_id" id="sec_m_id" value="${sec_m_id}">

<!-- 로딩 중 모달 -->
	<div id="loading_modal">
	</div>
	<div class="gif_spinner">
	</div>	
   
<!-- header 부분     -->
	<header>
			<a href="${pageContext.request.contextPath}/main"><img id="logo" alt="" src="${pageContext.request.contextPath}/header/img/logo.png"></a>
		<nav class="head_nav">
			<ul>
<%-- 				<li><a onclick="location.href('${pageContext.request.contextPath}/main');" class="button3" style="vertical-align:middle; padding-top: 18px; padding-bottom: 11px;"><img alt="image" --%>
<%-- 					src="${pageContext.request.contextPath}/header/img/logo.png" style="width: 30px; height: 23px;"></a></li> --%>
				<li><a id= "hide_changeSideDisplay" class="class_changeSideDisplay" onclick="javascript:doShow()" class="button3"><img alt="image"
					src="${pageContext.request.contextPath}/header/img/side_show.png" style="width: 30px; height: 23px;"></a></li>
				<li><a id= "show_changeSideDisplay" class="class_changeSideDisplay" onclick="javascript:doShow()" class="button3"><img alt="image"
					src="${pageContext.request.contextPath}/header/img/side_hide.png" style="width: 30px; height: 23px;"></a></li>	
				<li><a href="${pageContext.request.contextPath}/main" id="head_main">홈</a></li>
				<li><a onclick="waitLoading(); location.href='${pageContext.request.contextPath}/mail';" id="head_mail">메일</a></li>
				<li><a href="${pageContext.request.contextPath}/time" id="head_time">근태관리</a></li>
				<li><a href="${pageContext.request.contextPath}/sign" id="head_sign">전자결재</a></li>
				<li><a href="${pageContext.request.contextPath}/calendar" id="head_calendar">캘린더</a></li>
				<li><a href="${pageContext.request.contextPath}/board" id="head_board">게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/community" id="head_community">커뮤니티</a></li>
				<li><a href="${pageContext.request.contextPath}/address" id="head_address">주소록</a></li>
				<li><a href="${pageContext.request.contextPath}/drive" id="head_drive">드라이브</a></li>
<%-- 				<li><a href="${pageContext.request.contextPath}/reservation" id="head_reservation">예약</a></li> --%>
<%-- 				<li><a href="${pageContext.request.contextPath}/survey" id="head_survey">설문</a></li> --%>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="${pageContext.request.contextPath}/admin" id="head_admin">관리자</a></li>
				</sec:authorize>
			</ul>
		</nav>
		<div id="header_right">		
			<img id="my_photo" onclick="showHeaderRightModal();" src="${pageContext.request.contextPath}/resource/member/photo/${sec_m_id}.jpg" onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'">

		</div>
	</header>

	
	<!-- 헤더 오른쪽 프로필 사진 눌렀을 때 나오는 메뉴 -->	
	<div id="header_right_modal">
		<ul>
			<li><a href="${pageContext.request.contextPath}/login/simpleMyProfile">
				기본정보
			</a></li>
				
			<li><a onclick="form_logout.submit();">
				로그아웃
			</a></li>
						
		</ul>
	</div>
	
	<!-- 로그아웃 form-->
	<div id="div_logout">
		<form id="form_logout" name="form_logout" action="${pageContext.request.contextPath}/login/logout" method="POST">
			<sec:csrfInput/>
			<input type="submit" value="logout">
		</form>	
	</div>