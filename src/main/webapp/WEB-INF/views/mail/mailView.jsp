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

		<div id="mail_view_content_wrap">
			<div id="header">
				<div id="title">${mail.ml_title }</div>
				<table id="mail_info">
					<tr>
						<td class="title txt">보낸사람</td>
						<td class="txt">${mail.ml_emailForHtml}</td>
					</tr>
					<tr>
						<td class="title txt">받는사람</td>
						<td class="txt">
							<c:forEach var="mailTo" items="${listOfMailTo}">
								${mailTo.ml_emailForHtml}
							</c:forEach>
						</td>
					</tr>				
					<c:if test="${fn:length(listOfDriveFileInfo) > 0}">
						<tr>
							<td class="title txt">첨부파일</td>
							<td>
								<c:forEach var="driveFileInfo" items="${listOfDriveFileInfo}">
									<button type="button" class="button_download_file mail_button" data-dv_id="${driveFileInfo.dv_id}">${driveFileInfo.dv_filename}</button>
								</c:forEach>							
							</td>
						</tr>
					</c:if>		
				</table>
				<div id="toolbar_wrap">
					<a class="btn_tool" href="${pageContext.request.contextPath}/mail/writeForm?ml_num=${mail.ml_num}">
						<span class="ic_toolbar reply"></span><span class="mail_tool_txt">답장</span>
					</a>				
					<a class="btn_tool" href="${pageContext.request.contextPath}/mail/delete?ml_num=${mail.ml_num}" onclick="waitLoading();">
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
			<div id="mail_content">
				${mail.ml_content }
			</div>
			
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>