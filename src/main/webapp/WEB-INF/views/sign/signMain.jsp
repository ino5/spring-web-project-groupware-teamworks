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
		<!-- 결재 대기 문서 카드-->
		<c:forEach var= "sign" items="${listOfSignOfApprovalWaited}">
			<div class="card_wrapper">
				<header>
					<span class="status ongoing">진행중</span>
				</header>
				<div class="card_subject">
					${sign.title}
				</div>
				<div class="card_content">
					<table>
					<tr>
						<td>기안자:&nbsp;</td>
						<td>${sign.m_name}</td>
					</tr>
					<tr>
						<td>기안일:&nbsp;</td>
						<td><fmt:formatDate value="${sign.sg_regdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					</tr>
					<tr>
						<td>결재양식:&nbsp;</td>
						<td>${sign.sgf_name} </td>
					</tr>					
					</table>
				</div>
				<div class="card_action">
					<a class="btn_link" href="${pageContext.request.contextPath}/sign/view/${sign.sgf_id}/${sign.sg_num}">결재하기</a>
				</div>
			</div>
		</c:forEach>		
		<div style="clear:both"></div>
		
		<!-- 기안 진행 문서 -->
		<h2>기안 진행 문서</h2>
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
		<tbody>
		<c:forEach var= "sign" items="${listOfSignOfProposalProcessing}">
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
		</tbody>
		</table>
		<!-- end of 기안 진행 문서 -->

		<!-- 기안 완료 문서 -->
		<h2>기안 완료 문서</h2>
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
		<tbody>
		<c:forEach var= "sign" items="${listOfSignOfProposalCompleted}">
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
		</tbody>
		</table>
		<!-- end of 기안 완료 문서 -->

		<!-- 결재 대기 문서  -->
		<h2>결재 대기 문서</h2>
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
		<tbody>
		<c:forEach var= "sign" items="${listOfSignOfApprovalWaited}">
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
		</tbody>
		</table>
		<!-- end of 결재 대기 문서 -->

		<!-- 결재 처리 문서 listOfSignOfApprovalCompleted -->
		<h2>결재 처리 문서</h2>
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
		<tbody>
		<c:forEach var= "sign" items="${listOfSignOfApprovalCompleted}">
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
		</tbody>
		</table>
		<!-- end of 결재 처리 문서 -->
		<div style="height: 300px;"></div>
	</div>

<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>


</body>
</html>