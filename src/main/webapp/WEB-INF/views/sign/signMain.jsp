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
		<h1>전자결재 홈</h1>
		<h1>기안 진행 문서(proposal)</h1>
		<table>
			<thead>
				<tr>
					<td>sg_num</td>
					<td>m_id</td>
					<td>sgf_id</td>
					<td>title</td>
					<td>Link</td>
				</tr>
			</thead>
		<c:forEach var= "SignOfProposalProcessing" items="${listOfSignOfProposalProcessing}">
			<tr>
				<td>${SignOfProposalProcessing.sg_num}</td>
				<td>${SignOfProposalProcessing.m_id}</td>
				<td>${SignOfProposalProcessing.sgf_id}</td>
				<td>${SignOfProposalProcessing.title}</td>
				<td><a href="${pageContext.request.contextPath}/sign/view/${SignOfProposalProcessing.sgf_id}/${SignOfProposalProcessing.sg_num}">view</a></td>
			</tr>
		</c:forEach>
		</table>
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