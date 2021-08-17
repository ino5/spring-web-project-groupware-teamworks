<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/login/css/simpleMyProfile.css">
<script defer src="${pageContext.request.contextPath}/login/js/simpleMyProfile.js"></script>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">
		<div id="simpleMyProfileWrap">
			<h1>기본정보</h1>
			<form action="${pageContext.request.contextPath}/login/simpleMyProfile/save" method="post" enctype="multipart/form-data">
				<sec:csrfInput/>
				<table id=table_simple_my_profile>
					<tr>
						<td class="td_title">사진</td>
						<td>
							<div id="image_preview">
								<img id="my_photo" onclick="" src="/sproject/resource/member/photo/${principal.m_id}.jpg" onerror="this.src='/sproject/resource/member/photo/default.jpg'">
							</div>
							<input id="multipartFile" type="file" name="multipartFile">
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${principal.m_name}</td>
					</tr>
					<tr>
						<td>사번</td>
						<td>${principal.m_empnum}</td>
					</tr>
					<tr>
						<td>부서</td>
						<td>${principal.dpt_name}</td>
					</tr>
					<tr>
						<td>직위</td>
						<td>${principal.pt_name}</td>
					</tr>
					<tr>
						<td>회사 이메일</td>
						<td>${principal.m_id}@teamworksgroup.shop</td>
					</tr>
					<tr>
						<td>생일</td>
						<td>${principal.m_birth}</td>
					</tr>
				</table>
				<input class="button" type="submit">
			</form>
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>