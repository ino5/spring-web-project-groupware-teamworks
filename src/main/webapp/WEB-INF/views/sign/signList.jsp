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
		<h1>전자결재 문서 목록</h1>
		
		<!-- 문서 -->
		<c:if test="${listType == 'proposalProcessing'}"><h1>기안 진행 문서</h1></c:if>
		<c:if test="${listType == 'proposalCompleted'}"><h1>기안 완료 문서</h1></c:if>
		<c:if test="${listType == 'approvalWaited'}"><h1>결재 대기 문서</h1></c:if>
		<c:if test="${listType == 'approvalCompleted'}"><h1>결재 처리 문서</h1></c:if>
		<table class="table_sign_list">
			<thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>기안자</th>
					<th>결재양식</th>
					<th>제목</th>
					<th>결재상태</th>
				</tr>
			</thead>
		<c:forEach var= "sign" items="${listOfSign}">
			<tr>
				<td>${sign.sg_num}</td>
				<td><fmt:formatDate value="${sign.sg_regdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
				<td>${sign.m_name}</td>
				<td>${sign.sgf_name}</td>
				<td class="td_sign_title"><a href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">${sign.title}</a></td>
				<td>
					<c:if test="${sign.sg_status == '0'}"><span class="status ongoing">진행중</span></c:if>
					<c:if test="${sign.sg_status == '1'}"><span class="status completed">완료</span></c:if>
					<c:if test="${sign.sg_status == '2'}"><span class="status rejected">반려</span></c:if>
				</td>
			</tr>
		</c:forEach>
		</table>
		<!-- end of 문서 -->
		<div id="paging">
			<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=1" class="ic_paginate ic_first"></a>
			<c:if test="${commonPaging.currentPage != 1}">
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${commonPaging.currentPage - 1}" class="ic_paginate ic_previous"></a>
			</c:if>
			<c:if test="${commonPaging.currentPage == 1}">
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_previous"></a>
			</c:if>				
			<c:forEach var="index" begin="${commonPaging.startPage}" end="${commonPaging.endPage}">
				<c:if test="${index == commonPaging.currentPage}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${index}" class="paginate_active paginate_button">${index}</a>
				</c:if>
				<c:if test="${index != commonPaging.currentPage}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${index}" class="paginate_button">${index}</a>
				</c:if>
			</c:forEach>
			<c:if test="${commonPaging.currentPage != commonPaging.totalPage}">
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${commonPaging.currentPage + 1}" class="ic_paginate ic_next"></a>
			</c:if>
			<c:if test="${commonPaging.currentPage == commonPaging.totalPage}">
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_next"></a>
			</c:if>
			<a onclick="waitLoading();" href="${pageContext.request.contextPath}/sign/list/proposalProcessing?currentPage=${commonPaging.totalPage}" class="ic_paginate ic_last"></a>
		</div>	
	</div>

<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>


</body>
</html>