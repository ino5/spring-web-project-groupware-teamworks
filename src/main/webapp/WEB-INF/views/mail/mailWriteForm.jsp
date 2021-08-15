<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<!-- mail head 공용 -->
<%@include file = "/WEB-INF/views/mail/mailHead.jsp" %>
<!-- mail write js-->
<script defer src="${pageContext.request.contextPath}/mail/js/mailWrite.js"></script>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/mail/writeForm'">메일쓰기</button>
	</div>
	<div id="content">
		<div id="mail_write_content_wrap">
			<form method="post" action="${pageContext.request.contextPath}/mail/send" enctype="multipart/form-data">
				<sec:csrfInput/>
				<table>
					<tr>
						<td>받는 사람</td>
						<td><input type="text" name="addressTo"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="ml_title"></td>
					</tr>
					<tr>
						<td colspan="100">
							<textarea id="summernote" class="summernote" name="ml_content" placeholder="글 내용" rows="15" readonly >
							</textarea>
						</td>						
					</tr>
					<tr>
						<td>
							<input type="file" name="multipartFile">
						</td>
					</tr>
					<tr>
						<td>
							<input type="file" name="multipartFile">
						</td>
					</tr>					
					<tr>
						<td><input type="submit"></td>
					</tr>
				</table>
		
			</form>		
		</div>

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>