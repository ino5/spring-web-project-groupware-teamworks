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
			<input type="hidden" name="sgf_id" value="ojt">
			<div id="div_content_wrap">
				<div id="div_content_container">
					<h1 class="sgf_name">신규입사자 OJT 계획 및 진행사항 점검표</h1>
					<%@include file = "/WEB-INF/views/sign/header/signContentContainerUpperPart.jsp" %>
										
					<div id="div_content">
						<table id="tb_content">
							<tr>
								<td class="td_head td_style_short">입사일</td>
								<td class="td_style_short">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.memberdate}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input type="date" name="memberdate">
									</c:if>									
								</td>
								<td class="td_head td_style_short">OJT기간</td>
								<td class="td_style_middle" colspan="99">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.sdate} ~ ${mapOfSignContent.edate} 
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input type="date" name="sdate">
											&nbsp;&nbsp;~&nbsp;&nbsp;
										<input type="date" name="edate">
									</c:if>									
								</td>
							</tr>
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
								<td class="td_head td_style_short" rowspan="2">일정</td>
								<td class="td_head td_style_short" colspan="3">교육사항</td>
								<td class="td_head td_style_short" rowspan="2">교육확인<br>(교육자)</td>
								<td class="td_head td_style_short" rowspan="2">비고</td>
							</tr>
							<tr>
								<td class="td_head td_style_short">교육항목</td>
								<td class="td_head td_style_middle">세부사항</td>
								<td class="td_head td_style_short">교육자</td>
							</tr>
							<!-- OJT 교육 내용 -->	
							<c:forEach begin="1" end="10" varStatus="status">	
								<tr>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.ij1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.ij2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.ij3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.ij4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.ij5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.ij6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.ij7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.ij8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.ij9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.ij10 }
												</c:when>
											</c:choose>
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<input type="date" name="ij${status.index}">
										</c:if>								
									</td>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.gyhm1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.gyhm2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.gyhm3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.gyhm4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.gyhm5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.gyhm6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.gyhm7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.gyhm8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.gyhm9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.gyhm10 }
												</c:when>
											</c:choose>
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<input class="td_style_100per" type="text" name="gyhm${status.index}">
										</c:if>								
									</td>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.sbsh1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.sbsh2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.sbsh3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.sbsh4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.sbsh5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.sbsh6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.sbsh7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.sbsh8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.sbsh9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.sbsh10 }
												</c:when>	
											</c:choose>
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<textarea class="textarea_full" name="sbsh${status.index}"></textarea>
										</c:if>								
									</td>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.gyj1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.gyj2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.gyj3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.gyj4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.gyj5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.gyj6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.gyj7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.gyj8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.gyj9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.gyj10 }
												</c:when>
											</c:choose>
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<input class="td_style_100per" type="text" name="gyj${status.index}">
										</c:if>								
									</td>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.gyhi1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.gyhi2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.gyhi3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.gyhi4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.gyhi5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.gyhi6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.gyhi7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.gyhi8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.gyhi9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.gyhi10 }
												</c:when>
											</c:choose>		
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<input class="td_style_100per" type="text" name="gyhi${status.index}">
										</c:if>								
									</td>
									<td class="td_style_short td_style_height_middle">
										<c:if test="${jspType == 'r'}">
											<c:choose>
												<c:when test="${status.index == '1'}">
													${mapOfSignContent.bg1 }
												</c:when>
												<c:when test="${status.index == '2'}">
													${mapOfSignContent.bg2 }
												</c:when>
												<c:when test="${status.index == '3'}">
													${mapOfSignContent.bg3 }
												</c:when>
												<c:when test="${status.index == '4'}">
													${mapOfSignContent.bg4 }
												</c:when>
												<c:when test="${status.index == '5'}">
													${mapOfSignContent.bg5 }
												</c:when>
												<c:when test="${status.index == '6'}">
													${mapOfSignContent.bg6 }
												</c:when>
												<c:when test="${status.index == '7'}">
													${mapOfSignContent.bg7 }
												</c:when>
												<c:when test="${status.index == '8'}">
													${mapOfSignContent.bg8 }
												</c:when>
												<c:when test="${status.index == '9'}">
													${mapOfSignContent.bg9 }
												</c:when>
												<c:when test="${status.index == '10'}">
													${mapOfSignContent.bg10 }
												</c:when>
											</c:choose>
										</c:if>			
										<c:if test="${jspType == 'w'}">
											<input class="td_style_100per" type="text" name="bg${status.index}">
										</c:if>								
									</td>
								</tr>						
							</c:forEach>
							<!-- OJT 교육 내용 -->
						</table>
				
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