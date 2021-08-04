<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<script defer src="${pageContext.request.contextPath}/sign/js/signMain.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signMain.css">
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/signSide.jsp" %>
	</div>
	<div id="content">
		전자결재 홈
	</div>
	<!-- 새 결제 진행 모달창 -->
	<div id="modal_wrap_new_sign">
		<button type="button" id="modal_close_new_sign">x</button>
		<div>
			<form id="form_new_sign" action="${pageContext.request.contextPath}/sign/form" method="post" enctype="multipart/form-data">
				<sec:csrfInput/>
				<input type="hidden" name="tb_code" value="sgf">
				<select name="cg_num">
					<optgroup label="일반">
					<option value="101">업무기안</option>
					</optgroup>
				</select>
				<input type="submit">
			</form>
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>


</body>
</html>