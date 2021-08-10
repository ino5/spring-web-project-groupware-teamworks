<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/login/css/login1.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body onselectstart="return false" ondragstart="return false"> 
	<div class="container">
		<div id="div_login"
			style="border: solid 1px #e0e0e0;">
			<form action="${pageContext.request.contextPath}/login/login" method="post">
			<sec:csrfInput/>
				<div>
					<p style="margin-top: 50px;">
						<span id="team">Team</span> <span id="works">works</span>
					</p>
				</div>
				<fieldset style="border: 0;">
					<div>
						<input type="text" class="login" name="m_id" style="margin-top: 50px;" placeholder="아이디">
					</div>
					<div>
						<input type="password" class="login" name="m_password" placeholder="비밀번호">
					</div>
					<div>
						<input type="submit" class="btn_login" value="로그인">
					</div>
					<div style="float: left; margin-left: 128px; margin-top: 10px;">
						<input type="checkbox" name="remember-me" id="chk_1"><label
					for="chk_1"  style="font-weight: bold; font-size: 17px">로그인 상태 유지</label>
					</div>
				</fieldset>

			</form>
		</div>
	</div>
</body>
</html>