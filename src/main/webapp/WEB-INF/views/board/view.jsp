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
<script defer
	src="${pageContext.request.contextPath}/community/js/view.js"></script>
<link rel="styleSheet"
	href="${pageContext.request.contextPath}/board/css/view.css">

<title>Insert title here</title>
</head>
<script type="text/javascript">
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
		<div style="height: 40px;"></div>
		<div id="text_conotent">글 확인하기</div>
		<input type="hidden" id="m_id" value="${view.m_id}"> <input
			type="hidden" id="loginId" value="${view.loginId}">
		<form
			action="${pageContext.request.contextPath}/board/update?p_num=${view.p_num}&m_id=${view.m_id}&loginId=${view.loginId}"
			method="post">
			<sec:csrfInput />
			<section id="point">
				<article class="pt pt1">
					<table class="pt_tb">
						<tr>
							<td id="p_title" name="p_title" value="${view.p_name}"></td>
						</tr>
						<tr>
							<th style="padding-left: 100px; font-size: 24px; color: #383838;">제목</th>
							<td class="td_subject"><input id="subject" type="text"
								name="p_name" value="${view.p_name}" placeholder="글 제목"
								class="form_box" readonly="readonly"
								style="border: none; background-color: white"></td>

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
									name="p_content" placeholder="글 내용" rows="15" readonly>${view.p_content}</textarea>

							</td>

						</tr>
					</table>
				</article>
			</section>
			<button type="submit" id="btnUpdete">수정</button>
			<button type="button" id="btnDelete"
				onclick="location.href='${pageContext.request.contextPath}/board/delete?p_num=${view.p_num}'">삭제</button>
		</form>


		<div>

			<sec:csrfInput />
			<table id="list_table"
				style="margin-top: 4%; border-top: 2px solid #EAEAEA; width: 100%;">
				<c:forEach var="reply" items="${listReply}">
					<tr class="rp_${reply.rp_num}">
						<td><img alt="image"
							src="${pageContext.request.contextPath}/board/img/white.png"
							style="width: 0px; height: 34px;"
							class="td_${reply.rp_num}_${reply.rp_depth}"><img
							style="border-radius: 70%; width: 35px; height: 35px;"
							src="${pageContext.request.contextPath}/resource/member/photo/${reply.m_id}.jpg"
							onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'" />${reply.m_name}
							${reply.pt_name}
							<button class="ic_answer"
								style="background: transparent; border: 0; font-size: 15px; font-weight: bold; color: #8c8c8c"
								type="button" onclick="javascript:doShow2(${reply.rp_num})">
								<img style="width: 15px;" alt=""
									src="${pageContext.request.contextPath}/community/img/arrow.png">
								댓글
							</button></td>
					</tr>
					<tr class="rp_${reply.rp_num}">
						<td><img alt="image"
							src="${pageContext.request.contextPath}/board/img/white.png"
							style="width: 0px; height: 34px;"
							class="td_${reply.rp_num}_${reply.rp_depth}_${reply.rp_order}">${reply.rp_content}
							<button type="button" id="btnUpdete2"
								onclick="clickDelete(${reply.rp_num})" style="float: right;">
								<img alt="image"
									src="${pageContext.request.contextPath}/board/img/delete.png"
									style="width: 16px; height: 12px; margin-left: 3px; margin-bottom: -16">
							</button></td>
					</tr>

					<tr class="rp_${reply.rp_num}">
						<td style="display: none;" class="speed_${reply.rp_num}">
							<form id="frm_rereply_${reply.rp_num}"
								name="frm_rereply_${reply.rp_num}"
								action="${pageContext.request.contextPath}/board/rereply_insert"
								method="post">
								<sec:csrfInput />
								<input type="hidden" name="p_num" value="${reply.p_num}">
								<input type="hidden" name="rp_ref" value="${reply.rp_ref}">
								<input type="hidden" name="parent_rp_num"
									value="${reply.rp_num}"><img alt="image"
									src="${pageContext.request.contextPath}/board/img/white.png"
									style="width: 0px; height: 34px; float: left;"
									class="td_${reply.rp_num}_${reply.rp_depth}_${reply.rp_order}_${reply.rp_order}">
								<input type="text" id="rp_content2" name="rp_content"
									style="float: left; display: inline-block;">
							</form>
							<button type="button" id="btnUpdete2"
								onclick="document.getElementById('frm_rereply_${reply.rp_num}').submit();"
								style="float: right;">
								<img alt="image"
									src="${pageContext.request.contextPath}/board/img/pencil.png"
									style="width: 16px; height: 16px;">
							</button>
						</td>


					</tr>
					<script type="text/javascript">
						var ww = 35 * ${reply.rp_depth};
						var www = 100+(ww);
						var wwww = 200+(ww);
							$('.td_${reply.rp_num}_${reply.rp_depth}').width(ww + 'px');
							$('.td_${reply.rp_num}_${reply.rp_depth}_${reply.rp_order}').width(www + 'px');
							$('.td_${reply.rp_num}_${reply.rp_depth}_${reply.rp_order}_${reply.rp_order}').width(wwww + 'px');
					</script>
				</c:forEach>
			</table>
			<form
				action="${pageContext.request.contextPath}/board/reply_insert?p_num=${view.p_num}&loginId=${view.loginId}"
				method="post">
				<sec:csrfInput />
				<table class="table_rp"
					style="width: 100%; height: 30px; margin-top: 20px; padding-bottom: 30px; border-bottom: 2px solid #D5D5D5;">
					<tr>
						<td style="width: 100%;"><div style="float: left;">
								<img
									style="border-radius: 70%; width: 35px; height: 35px; margin-left: 60px;"
									src="${pageContext.request.contextPath}/resource/member/photo/${m_id}.jpg"
									onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'" />
							</div>
							<div style="display: inline-block; margin-left: 5px;">
								<input type="text" id="rp_content" name="rp_content">
							</div>
							<button type="submit" id="replyUpdete"
								onclick="location.href='${pageContext.request.contextPath}/board/view'">댓글등록</button>
						</td>
					</tr>
				</table>

				<script type="text/javascript">
						// div speed 만들기
						function doShow2(i) {
							if ($('.speed_'+i).is(":visible")) {
								$('.speed_'+i).hide();
							} else {
								$('.speed_'+i).show();
							}
						}
					</script>
			</form>
			<div style="height: 100px;"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>