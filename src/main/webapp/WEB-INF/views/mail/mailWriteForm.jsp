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
<!-- mail write js-->
<script defer src="${pageContext.request.contextPath}/mail/js/mailWrite.js"></script>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<%@include file = "/WEB-INF/views/mail/header/mailSide.jsp" %>
	</div>
	<div id="content">
		<div id="mail_write_content_wrap">
			<form method="post" action="${pageContext.request.contextPath}/mail/send" enctype="multipart/form-data">
				<sec:csrfInput/>
				<table id="table_write">
					<tr>
						<td class="title txt">보내는 사람</td>
						<td><div class="border_bottom"><span class="txt">${principal.m_name}</span><span class="txt_gray">&nbsp;&nbsp;&lt;${principal.m_id}@teamworksgroup.shop&gt;</span></div></td>
					</tr>
					<tr>
						<td class="title txt">받는 사람</td>
						<td><input class="border_bottom txt" type="text" name="addressTo" value="${email}"></td>
					</tr>
					<tr>
						<td class="title txt">제목</td>
						<td><input class="border_bottom txt" type="text" name="ml_title"></td>
					</tr>
					<tr>
						<td class="title txt">첨부</td>
						<td><input class="multipartFile" type="file" name="multipartFile"></td>
					</tr>
					<tr>
						<td class="content" colspan="100">
							<textarea id="summernote" class="summernote" name="ml_content" placeholder="글 내용" rows="15" readonly >
							</textarea>
						</td>						
					</tr>				
				</table>
				<div id="form_footer">
					<button class="mail_button" type="submit" onclick="waitLoading();">
						<span class="ic_toolbar send"></span>
						<span class="txt_button">보내기</span>
					</button>	
				</div>					
			</form>		
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>