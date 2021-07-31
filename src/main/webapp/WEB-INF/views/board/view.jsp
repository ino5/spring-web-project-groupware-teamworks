<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>


<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<!-- 서머노트를 위해 추가해야할 부분 -->
<script
	src="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.js"></script>
<script
	src="${pageContext.request.contextPath}/board/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/board/js/summernote/summernote-lite.css">
	<script defer src="${pageContext.request.contextPath}/board/js/view.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/board/css/view.css">

<title>Insert title here</title>
</head>
		<script type="text/javascript">
									$(document).ready(function() {
										//여기 아래 부분
										$('#summernote').summernote({
											height : 600, // 에디터 높이
											width:1200,
			
											minHeight : null, // 최소 높이
											maxHeight : null, // 최대 높이
											focus : true, // 에디터 로딩후 포커스를 맞출지 여부
											lang : "ko-KR", // 한글 설정
											placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
											callbacks: {	//이미지 첨부하는 부분
										               onImageUpload : function(files) {
										            	   	alert("onImageUpload : function");
										                    uploadSummernoteImageFile(files[0],this);
										                }
										            }

										});
									});
									</script>
<body>
<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<button type="button" id="btn1"
			onclick="location.href='${pageContext.request.contextPath}/board/write'">글쓰기</button>
		<div>

			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"> <img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img1">
			</span>전사게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="as" items="${boardListOfAll }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/board/sideboard_list?bd_num=${as.bd_num}">${as.bd_name}</a></li>
				</c:forEach>

			</ol>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${boardListOfAll }">
					<li class="li">${bs.bd_name}</li>
				</c:forEach>

			</ol>
		</div>
		<div>
			<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img2"></span>부서게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${boardListOfDept }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/board/sideboard_list?bd_num=${bs.bd_num}">${bs.bd_name}</a></li>
				</c:forEach>

			</ol>
		</div>
	</div>
	<div id="content">
		<input type="hidden" id="m_id" value="${view.m_id}">
		<input type="hidden" id="loginId" value="${view.loginId}">
		<form
			action="${pageContext.request.contextPath}/board/update?p_num=${view.p_num}&m_id=${view.m_id}&loginId=${view.loginId}"
			method="post">
			<sec:csrfInput />
			<section id="point">
				<article class="pt pt1">
					<table class="pt_tb">
						<tr>
							<td id="p_title" name="p_title" value="${view.p_name}">글 확인하기</td>
						</tr>
						<tr>
						<th style="padding-left: 100px;">제목</th>
							<td class="td_subject"><input id="subject" type="text"
								name="p_name" value="${view.p_name}" placeholder="글 제목"
								class="form_box" disabled style="border: none; background-color: white"></td>

							<td><button
									style="background-color: white; border: none; width: 30px; height: 30px;"
									type="button" id="buttonRecommand"
									onclick="location.href='${pageContext.request.contextPath}/board/recommend?p_num=${view.p_num}'">

									<c:if test="${statusOfLike == 0}">
										<img alt="image"
										src="${pageContext.request.contextPath}/board/img/heart.png"
											style="width: 30px; height: 30px;">
									</c:if>
									<c:if test="${statusOfLike == 1}">
										<img alt="image"
											src="${pageContext.request.contextPath}/board/img/checkedheart.png"
											style="width: 30px; height: 30px;">
									</c:if>
								</button></td>
							<td>조회수: ${view.p_view}</td>
						</tr>
						<tr>
							<td colspan="5"><textarea id="summernote" class="summernote"
									name="p_content" placeholder="글 내용" rows="15" readonly >${view.p_content}</textarea>

								</td>
							
						</tr>
					</table>
				</article>
			</section>
			<button type="submit" id="btnUpdete" >수정</button>
			<button type="button" id="btnDelete" 
				onclick="location.href='${pageContext.request.contextPath}/board/delete?p_num=${view.p_num}'">삭제</button>
					</form>
				<div>
				<form action="${pageContext.request.contextPath}/board/reply_insert?p_num=${view.p_num}&loginId=${view.loginId}"
			method="post">
					<sec:csrfInput />
					<table class="table_rp"style="width: 1000px; height:30px;  ">
						<tr><td>
					    <input  type="text" id = "rp_content" name = "rp_content">
								<button type="submit" id="replyUpdete"onclick="location.href='${pageContext.request.contextPath}/board/view'">댓글등록</button>
						</td></tr>
						
					</table>
				</form>	
					<table id="list_table" style=" margin-top: 4%; border-top: 2px solid #EAEAEA;">
						<c:forEach var="reply" items="${listReply}">
							<tr class="rp_${reply.rp_num}">			
								<td>${reply.m_id}</td>				
								<td>
									<c:if test="${reply.rp_depth > 1}">
										<c:forEach begin="3" end="${reply.rp_depth}" step="1">
											&nbsp;&nbsp;&nbsp;
										</c:forEach>
										ㄴ
									</c:if>
									<span style="margin-left: 100px">${reply.rp_content}</span>
								</td>
								<td><button type="button" id="btnUpdete" onclick="clickDelete(${reply.rp_num})">댓글삭제</button></td>
							</tr>
							<tr class="rp_${reply.rp_num}">
								
	                           <form action="${pageContext.request.contextPath}/board/rereply_insert" method="post">
									<sec:csrfInput/>
									<input type="hidden" name="p_num" value="${reply.p_num}">
									<input type="hidden" name="parent_rp_num" value="${reply.rp_num}">
									<td><input type="text" id = "rp_content" name = "rp_content"></td>
									<td><button type="submit">대댓글등록</button></td>
								</form>							
 							
<%--  								<td><button type="button" id="btnInsert" onclick="clickInsert(${reply.p_num},${reply.rp_num}">대댓글등록</button></td> --%>
 
 
 
                           </tr>
						</c:forEach>
					</table>
				
	</div>
	</div>

		
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>