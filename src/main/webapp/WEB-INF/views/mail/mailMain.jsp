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
					<c:if test="${mode=='received'}">
						<span class="span_title">받은메일함</span>
					</c:if>
					<c:if test="${mode=='sent'}">
						<span class="span_title">보낸메일함</span>
					</c:if>
					<span class="span_gray">전체메일</span>
					<span class="span_number">${numRead + numUnread}</span>
					&nbsp;/&nbsp;
					<span class="span_gray">안읽은 메일</span>
					<span class="span_number">${numUnread}</span>
				</div>
				<div id="toolbar_wrap">
					<input type="checkbox" name="all_listOfMl_num" class="all_checkbox_mail">
					<a class="btn_tool" onclick="deleteMails();">
						<span class="ic_toolbar del"></span><span class="mail_tool_txt">삭제</span>
					</a>
					<c:if test="${mode=='received'}">
						<div id="mail_server_time">
							서버 동기화 시간: <fmt:formatDate value="${updateDateOfDb}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
						</div>
					</c:if>
					<div style="clear:both;"></div>
				</div>
			</div>
			<div id="list_mail_wrap">
				<table id="list_mail">
					<tbody>
						<c:forEach var="mail" items="${listOfMail}" >
							<tr
								id="tr_mail_${mail.ml_num}"
								<c:if test="${mail.ml_is_read == '1'}">
									class="tr_read"
								</c:if>
								
							>
								<td class="td_checkbox_mail"><input type="checkbox" name="listOfMl_num" class="checkbox_mail" value="${mail.ml_num}"></td>
								<td class="email">${mail.ml_emailForHtml}</td>
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
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=1" class="ic_paginate ic_first"></a>
				<c:if test="${commonPaging.currentPage != 1}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage - 1}" class="ic_paginate ic_previous"></a>
				</c:if>
				<c:if test="${commonPaging.currentPage == 1}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_previous"></a>
				</c:if>				
				<c:forEach var="index" begin="${commonPaging.startPage}" end="${commonPaging.endPage}">
					<c:if test="${index == commonPaging.currentPage}">
						<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${index}" class="paginate_active paginate_button">${index}</a>
					</c:if>
					<c:if test="${index != commonPaging.currentPage}">
						<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${index}" class="paginate_button">${index}</a>
					</c:if>
				</c:forEach>
				<c:if test="${commonPaging.currentPage != commonPaging.totalPage}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage + 1}" class="ic_paginate ic_next"></a>
				</c:if>
				<c:if test="${commonPaging.currentPage == commonPaging.totalPage}">
					<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.currentPage}" class="ic_paginate ic_next"></a>
				</c:if>
				<a onclick="waitLoading();" href="${pageContext.request.contextPath}/mail?currentPage=${commonPaging.totalPage}" class="ic_paginate ic_last"></a>
			</div>
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>