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
<!--  sign draft -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/sign/css/signForm.css">
<script src="${pageContext.request.contextPath}/sign/js/signForm.js"></script>
</head>



<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<input type="hidden" id="data_jspType" value="${jspType}">
	<div class="black_bg"></div>
	<div id="side">
		<%@include file = "/WEB-INF/views/sign/header/signSide.jsp" %>
	</div>
<form method="post" enctype="multipart/form-data">
	<sec:csrfInput/>
	<div id="content">
		<div id="content_top">
			<h1>${mapOfSignContent.title}<span>&nbsp;&nbsp;in ${sign.sgf_name}</span></h1>
			<c:if test="${jspType == 'r' }">
				<button type="button">
					<span class="ic_toolbar approval"></span>
					<span class="txt">결재</span>
				</button>
				<button type="button">
					<span class="ic_toolbar return"></span>
					<span class="txt">반려</span>
				</button>				
			</c:if>
			<div id="sign_line">
				<c:if test="${jspType == 'w' }">
					<h3>결재라인</h3>
					<button type="button" id="button_new_sign_line">결재라인 추가</button>
					이름 부서 직위
					<ul id="sortable">
					</ul>
				</c:if>	
				<c:if test="${jspType == 'r' }">
	<%-- 				<c:forEach var= "signLine" items="${listOfSignLine}"> --%>
	<%-- 					${signLine.m_name} ${signLine.dpt_name} ${signLine.pt_name}<br> --%>
	<%-- 				</c:forEach> --%>
				</c:if>
			</div>

			<!-- 결재라인 추가 모달창 -->
			<div id="modal_wrap_new_sign_line">
				<button type="button" id="modal_close_new_sign_line">x</button>
				<div>
					<c:forEach var= "member" items="${listOfMember}">
						<button type="button" onclick="addSignLine('${member.m_id}', '${member.m_name}', '${member.dpt_name}', '${member.pt_name}'); closeModalOfNewSignLine();">${member.m_name}</button><br>
					</c:forEach>
				</div>
			</div>
					
		</div>
		
		<div id="content_middle">
			<input type="hidden" name="sgf_id" value="draft">
			<div id="div_content_wrap">
				<div id="div_content_container">
					<h1 class="sgf_name">업 무 기 안</h1>
					
					<!-- 문서 기본 정보 테이블 -->
					<table id="tb_sign_info">
						<tr>
							<td class="td_head">기안자</td>
							<td>${sign.m_name}</td>
						</tr>
						<tr>
							<td class="td_head">소속</td>
							<td>${sign.dpt_name}</td>							
						</tr>
						<tr>
							<td class="td_head">직위</td>
							<td>${sign.pt_name}</td>
						</tr>
						<tr>
							<td class="td_head">기안일</td>
							<c:if test="${jspType == 'r'}">
								<td><fmt:formatDate value="${sign.sg_regdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
							</c:if>
							<c:if test="${jspType == 'w'}">
								<td class="now_date"></td>
							</c:if>
						</tr>
						<tr>
							<td class="td_head">문서번호</td>
							<td>${sign.sg_num}</td>
						</tr>
					</table>
								
					<!-- sign line: 결재 -->
					<div id="sign_line_wrap">
						<!-- sign line: 신청 -->
						<table class="tb_sign_line">
							<tr>
								<td rowspan="3" class="td_head">신청</td>
								<td class="td_rank">${sign.pt_name}</td>
							</tr>
							<tr>
								<td class="td_name">${sign.m_name}</td>
							</tr>
							<tr>
								<td class="td_date"><fmt:formatDate value="${sign.sg_regdate}" pattern="yyyy/MM/dd"></fmt:formatDate></td>
							</tr>					
						</table>
						<c:forEach var= "signLine" items="${listOfSignLine}">
							<table class="tb_sign_line">
								<tr>
									<td rowspan="3" class="td_head">승인</td>
									<td class="td_rank">${signLine.pt_name}</td>
								</tr>
								<tr>
									<td class="td_name">
										<c:if test="${signLine.sgl_status == '1'}">
											<img src="${pageContext.request.contextPath}/sign/img/stamp_approval.png"><br>
										</c:if>
										${signLine.m_name}
									</td>
								</tr>
								<tr>
									<td class="td_date">
										<c:if test="${signLine.sgl_status == '1'}">
											<fmt:formatDate value="${signLine.sgl_regdate}" pattern="yyyy/MM/dd"></fmt:formatDate>
										</c:if>
										<c:if test="${signLine.sgl_status == '2'}">
											<fmt:formatDate value="${signLine.sgl_regdate}" pattern="MM/dd"></fmt:formatDate>(반려)
										</c:if>										
									</td>
								</tr>					
							</table>
						</c:forEach>
					</div>					
					
					<div id="div_content">
						<table id="tb_content">
							<tr>
								<td class="td_head td_style_short">제목 </td>
								<td class="td_style_long">
									<c:if test="${jspType == 'r'}">
										${mapOfSignContent.title }
									</c:if>			
									<c:if test="${jspType == 'w'}">
										<input type="text" name="title">
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
											&nbsp;
										</textarea>
									</td>
								</c:if>									
							</tr>
						</table>
				
					</div>

				</div>
			</div>
			<div id="div_file">
				<c:if test="${jspType == 'r'&& mapOfSignContent.dv_id != null}">
					${dv_filename}
					<button type="button" class="button_download_file" data-dv_id="${mapOfSignContent.dv_id}">download</button> <br>
				</c:if>
				<c:if test="${jspType == 'w'}">
					<input type="file" name="file1"> <br>
				</c:if>		
			</div>				
		</div>
		
		<div id="content_bottom">
			<br><br>
			<c:if test="${jspType == 'w'}">
				<input type="submit" formaction="${pageContext.request.contextPath}/sign/insert">
			</c:if>
		</div>
	</div>
</form>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
<!-- 썸머노트 -->
<script>
	$('#summernote').summernote({
		height : 600, // 에디터 높이
		width: 1100,
		fontSize: 16,
		
		minHeight : null, // 최소 높이
		maxHeight : null, // 최대 높이
		focus : true, // 에디터 로딩후 포커스를 맞출지 여부
		lang : "ko-KR", // 한글 설정
		placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
		callbacks: {	//이미지 첨부하는 부분
	               onImageUpload : function(files) {
	                    uploadSummernoteImageFile(files[0],this);
	                }
	            }
	
	});
	function uploadSummernoteImageFile(file, editor) {
	    data = new FormData();
	    data.append("file", file);
	    $.ajax({
	        data : data,
	        type : "POST",
	        url : _contextPath+"/board/uploadSummernoteImageFile",
	        contentType : false,
	        processData : false,
	        success : function(data) {
	            //항상 업로드된 파일의 url이 있어야 한다.
	            $(editor).summernote('insertImage', _contextPath+data.url);
	        }
	    });
	}
</script>
<!-- end of 썸머노트  -->


</body>
</html>