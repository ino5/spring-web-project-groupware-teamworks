<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
<script defer src="${pageContext.request.contextPath}/community/js/write.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/community/css/community_create.css">
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
<div id="side">
		<button type="button" id="btn1"
			onclick="location.href='${pageContext.request.contextPath}/community/communityCreate'">커뮤니티만들기</button>
		<div id="side_text">
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"> <img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img1">
			</span>커뮤니티게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="as" items="${boardListOfCommunity }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/community/sideboard_list?bd_num=${as.bd_num}">${as.bd_name}</a></li>
				</c:forEach>

			</ol>
		</div>
	</div>
		<div id="content">
		<div id="create_community_wrap">
	<form name="form_insert" action="${pageContext.request.contextPath}/community/communityCreate" method="post" enctype="multipart/form-data">
				<sec:csrfInput/>
			<table  id="create_community">
						<tr style="height: 80px;">
							<td id="p_title">커뮤니티 만들기</td>
							</tr>
							<tr><td><span style="font-size: 18px; padding-left: 20px;">커뮤니티 명</span>
								<input id="subject" type="text" name="bd_name" placeholder="커뮤니티명" class="form_box"></td></tr>
								<tr><td><span style="font-size: 18px; padding-left: 20px;">소개 </span><input id="text_conotent" name="bd_content">${view._content}</td></tr>
								</table>
		
			
		<button type="submit" id="btnUpdete"onclick="">확인</button>
		<button type="submit" id="btnNotice"onclick="form_insert.p_type.value = 1;">취소</button>		
		</form>
	</div>
	</div>
	
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>