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
						<td class="txt">${mail.ml_email}</td>
					</tr>
					<tr>
						<td class="title txt">받는사람</td>
						<td class="txt">
							<c:forEach var="mailTo" items="${listOfMailTo}">
								${mailTo.ml_email }
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
			</div>		
			<div id="mail_content">
				${mail.ml_content }
			</div>
			
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>