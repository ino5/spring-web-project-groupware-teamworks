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
<!--  sign form 관련 css와 js -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signForm.css">
<script defer src="${pageContext.request.contextPath}/sign/js/signForm.js"></script>
</head>



<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<input type="hidden" id="data_jspType" value="${jspType}">
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/header/signSide.jsp" %>
	</div>
<c:if test="${jspType == 'w' }">
	<form method="post" enctype="multipart/form-data">
</c:if>
	<sec:csrfInput/>
	<div id="content">
		<div id="content_top">
			<%@include file = "/WEB-INF/views/sign/header/signContentTop.jsp" %>				
		</div>
		<div id="content_middle">
			<input type="hidden" name="sgf_id" value="jmsscgi">
			<div id="div_content_wrap">
				<div id="div_content_container">
					<h1 class="sgf_name">증명서신청(개인)</h1>
					<%@include file = "/WEB-INF/views/sign/header/signContentContainerUpperPart.jsp" %>
										
					<div id="div_content">
						<table id="tb_content">
							<tr>
								<td class="td_head td_style_short">제목</td>
								<td class="td_style_long" colspan="99">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.title }
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_long" type="text" name="title">
									</c:if>								
								</td>
							</tr>
							<tr>
								<td class="td_head td_style_short">발행일자</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.sdate}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="date" name="sdate">
									</c:if>									
								</td>
								<td class="td_head td_style_short">용도</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.yd}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="text" name="yd">
									</c:if>									
								</td>
								
							</tr>
							<tr>
								<td class="td_head td_style_short">제출처</td>
								<td class="td_style_middle" colspan="3">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.jcc}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_100per" type="text" name="jcc">
									</c:if>									
								</td>							
							</tr>
							<tr>
								<td class="td_head td_style_short">영문주소</td>
								<td class="td_style_middle" colspan="3">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.jcc}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_100per" type="text" name="ymjs">
									</c:if>									
								</td>							
							</tr>
							<tr>
								<td class="td_head td_style_short">비고</td>
								<td class="td_style_middle" colspan="3">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.bg}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_100per" type="text" name="bg">
									</c:if>									
								</td>							
							</tr>
						</table>
						<div style="height: 14px"></div>
						<span class="td_head">※ 영문증명서 신청시는 영문 주소를 반드시 기입하셔야 합니다.</span>
					</div>

				</div>
				<div id="div_file">
					<c:if test="${jspType == 'w'}">
						<span class="title">파일 첨부</span> <input type="file" name="multipartFile">
					</c:if>		
				</div>	
			</div>
			
		</div>
		
		<div id="content_bottom">
			<%@include file = "/WEB-INF/views/sign/header/signContentBottom.jsp" %>
		</div>
	</div>
<c:if test="${jspType == 'w' }">
	</form>
</c:if>	
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>