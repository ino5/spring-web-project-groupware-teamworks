<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- mail head 공용 -->
<%@include file = "/WEB-INF/views/mail/header/mailHead.jsp" %>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<%@include file = "/WEB-INF/views/mail/header/mailSide.jsp" %>
	</div>
	<div id="content">
		<div id="mail_wrap">
			<div id="mail_header">
				<div id="title">
					<span class="span_title">받은메일함</span>
					<span class="span_gray">전체메일</span>
					<span class="span_number">${numRead + numUnread}</span>
					&nbsp;/&nbsp;
					<span class="span_gray">안읽은 메일</span>
					<span class="span_number">${numUnread}</span>
				</div>
				<div id="tool_bar">
				</div>
			</div>
			<div id="list_mail_wrap">
				<table id="list_mail">
					<tbody>
						<c:forEach var="mail" items="${listOfMail}" >
							<tr
								<c:if test="${mail.ml_read == '1'}">
									class="tr_read"
								</c:if>
							>
								<td class="email">${mail.ml_email}</td>
								<td>
									<a href="${pageContext.request.contextPath}/mail/view/${mail.ml_num}">${mail.ml_title}</a>
								</td>
								<td class="date"><fmt:formatDate value="${mail.ml_regdate}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate></td>				
							</tr>
						</c:forEach>
					</tbody>
				</table>		
			</div>
			<div id="mail_footer">
				<a href="${pageContext.request.contextPath}/mail?currentPage=1" class="ic_paginate ic_first"></a>
				<c:if test="${commonPaging.currentPage != 1}">
					<a href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage - 1}" class="ic_paginate ic_previous"></a>
				</c:if>
				<c:if test="${commonPaging.currentPage == 1}">
					<a href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_previous"></a>
				</c:if>				
				<c:forEach var="index" begin="${commonPaging.startPage}" end="${commonPaging.endPage}">
					<c:if test="${index == commonPaging.currentPage}">
						<a href="${pageContext.request.contextPath}/mail?currentPage=${index}" class="paginate_active paginate_button">${index}</a>
					</c:if>
					<c:if test="${index != commonPaging.currentPage}">
						<a href="${pageContext.request.contextPath}/mail?currentPage=${index}" class="paginate_button">${index}</a>
					</c:if>
				</c:forEach>
				<c:if test="${commonPaging.currentPage != commonPaging.totalPage}">
					<a href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage + 1}" class="ic_paginate ic_next"></a>
				</c:if>
				<c:if test="${commonPaging.currentPage == commonPaging.totalPage}">
					<a href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_next"></a>
				</c:if>
				<a href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.totalPage}" class="ic_paginate ic_last"></a>
			</div>
		</div>

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>