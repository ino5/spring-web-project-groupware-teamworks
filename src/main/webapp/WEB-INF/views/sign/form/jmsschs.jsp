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
			<input type="hidden" name="sgf_id" value="jmsschs">
			<div id="div_content_wrap">
				<div id="div_content_container">
					<h1 class="sgf_name">증명서신청(회사)</h1>
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
								<td class="td_head td_style_short" rowspan="4">신청내용</td>
								<td class="td_style_short td_no_border">법인 등기부 등본</td>
								<td class="td_style_middle td_right_border">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.bidgbdb} &nbsp;부
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_short" type="text" name="bidgbdb"> &nbsp;부
									</c:if>							
							</tr>
							<tr>
								<td class="td_style_short td_no_border">법인 인감 증명서</td>
								<td class="td_style_middle td_right_border">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.biigjms} &nbsp;부
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_short" type="text" name="biigjms"> &nbsp;부
									</c:if>																		
								</td>
							</tr>
							<tr>
								<td class="td_style_short td_no_border">사업자등록증 사본</td>
								<td class="td_style_middle td_right_border">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.sujdrjsb} &nbsp;부
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_short" type="text" name="sujdrjsb"> &nbsp;부
									</c:if>																		
								</td>
							</tr>
							<tr>
								<td class="td_style_short td_bottom_border">
									기타:&nbsp;
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.kt1}
									</c:if>
									<c:if test="${jspType == 'w'}">
										<input class="td_style_short" type="text" name="kt1">
									</c:if>
								</td>
								<td class="td_style_middle td_right_bottom_border">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.kt2} &nbsp;부
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_short" type="text" name="kt2"> &nbsp;부
									</c:if>																		
								</td>
							</tr>
							<tr>
								<td class="td_head td_style_short">용도</td>
								<td class="td_style_middle" colspan="3">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.yd}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_100per" type="text" name="yd">
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