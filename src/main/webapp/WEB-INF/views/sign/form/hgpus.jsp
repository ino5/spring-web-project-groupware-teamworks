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
			<input type="hidden" name="sgf_id" value="hgpus">
			<div id="div_content_wrap">
				<div id="div_content_container">
					<h1 class="sgf_name">회계(입금.출금.대체)품의서</h1>
					<%@include file = "/WEB-INF/views/sign/header/signContentContainerUpperPart.jsp" %>
										
					<div id="div_content">
						<table id="tb_content">
							<tr>
								<td class="td_head td_style_short">지급요청일</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.jgyci}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="date" name="jgyci">
									</c:if>									
								</td>
								<td class="td_head td_style_short">종류</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										<input type="checkbox" name="jr_sggss" value="on" 
											<c:if test="${mapOfSignContent.jr_sggss == 'on'}"> checked </c:if> 
											onclick="return false;"> 세금계산서&nbsp;&nbsp;								
										
										<input type="checkbox" name="jr_giysj" value="on" 
											<c:if test="${mapOfSignContent.jr_giysj == 'on'}"> checked </c:if> 
											onclick="return false;"> 간이영수증&nbsp;&nbsp;	
										
										<input type="checkbox" name="jr_sycd" value="on" 
											<c:if test="${mapOfSignContent.jr_sycd == 'on'}"> checked </c:if> 
											onclick="return false;"> 신용카드&nbsp;&nbsp;	
										
										<input type="checkbox" name="jr_kt" value="on" 
											<c:if test="${mapOfSignContent.jr_kt == 'on'}"> checked </c:if> 
											onclick="return false;"> 기타&nbsp;&nbsp;			
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input type="checkbox" name="jr_sggss" value="on"> 세금계산서&nbsp;&nbsp;
										<input type="checkbox" name="jr_giysj" value="on"> 간이영수증&nbsp;&nbsp;
										<input type="checkbox" name="jr_sycd" value="on"> 신용카드&nbsp;&nbsp;
										<input type="checkbox" name="jr_kt" value="on"> 기타&nbsp;&nbsp;
									</c:if>									
								</td>
							</tr>
							<tr>
								<td class="td_head td_style_short">금액</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.price}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="text" name="price">
									</c:if>									
								</td>
								<td class="td_head td_style_short">사업자 등록번호</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.sujdrbh}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="text" name="sujdrbh">
									</c:if>									
								</td>								
							</tr>
							<tr>
								<td class="td_head td_style_short">계좌번호</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.gjbh}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="text" name="gjbh">
									</c:if>									
								</td>
								<td class="td_head td_style_short">지급은행</td>
								<td class="td_style_middle">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.jguh}
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input class="td_style_middle" type="text" name="jguh">
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
								<c:if test="${jspType == 'r'}">
									<td id="td_content" colspan="100">
										${mapOfSignContent.content}
									</td>
								</c:if>
								<c:if test="${jspType == 'w'}">
									<td colspan="100">
										<textarea id="summernote" class="summernote" name="content" placeholder="글 내용" rows="15" readonly >
										</textarea>
									</td>
								</c:if>									
							</tr>
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