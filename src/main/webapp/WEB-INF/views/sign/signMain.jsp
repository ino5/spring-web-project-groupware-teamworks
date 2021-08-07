<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- sign head 공용 -->
<%@include file = "/WEB-INF/views/sign/header/signHead.jsp" %>
<script defer src="${pageContext.request.contextPath}/sign/js/signMain.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signMain.css">
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/header/signSide.jsp" %>
	</div>
	<div id="content">
		<h1>전자결재 홈</h1>
		
		<!-- 기안 진행 문서 -->
		<h1>기안 진행 문서</h1>
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
		<c:forEach var= "sign" items="${listOfSignOfProposalProcessing}">
			<tr>
				<td>${sign.sg_num}</td>
				<td>${sign.m_id}</td>
				<td>${sign.sgf_id}</td>
				<td>${sign.title}</td>
				<td><a href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">view</a></td>
			</tr>
		</c:forEach>
		</table>
		<!-- end of 기안 진행 문서 -->

		<!-- 기안 완료 문서 -->
		<h1>기안 완료 문서</h1>
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
		<c:forEach var= "sign" items="${listOfSignOfProposalCompleted}">
			<tr>
				<td>${sign.sg_num}</td>
				<td>${sign.m_id}</td>
				<td>${sign.sgf_id}</td>
				<td>${sign.title}</td>
				<td><a href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">view</a></td>
			</tr>
		</c:forEach>
		</table>
		<!-- end of 기안 완료 문서 -->

		<!-- 결재 대기 문서 -->
		<h1>결재 대기 문서</h1>
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
		<c:forEach var= "sign" items="${listOfSignOfApprovalWaited}">
			<tr>
				<td>${sign.sg_num}</td>
				<td>${sign.m_id}</td>
				<td>${sign.sgf_id}</td>
				<td>${sign.title}</td>
				<td><a href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">view</a></td>
			</tr>
		</c:forEach>
		</table>
		<!-- end of 결재 대기 문서 -->

		<!-- 결재 처리 문서 -->
		<h1>결재 처리 문서</h1>
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
		<c:forEach var= "sign" items="${listOfSignOfApprovalCompleted}">
			<tr>
				<td>${sign.sg_num}</td>
				<td>${sign.m_id}</td>
				<td>${sign.sgf_id}</td>
				<td>${sign.title}</td>
				<td><a href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">view</a></td>
			</tr>
		</c:forEach>
		</table>
		<!-- end of 결재 처리 문서 -->
		
	</div>

<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>


</body>
</html>