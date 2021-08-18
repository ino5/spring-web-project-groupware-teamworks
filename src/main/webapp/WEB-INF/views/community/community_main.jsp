<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<link rel="styleSheet" href="${pageContext.request.contextPath}/community/css/community_main.css">
<script src="${pageContext.request.contextPath}/community/js/community_main.js"></script>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
		<div id="side">
		<button type="button" id="btn1"
			onclick="location.href='${pageContext.request.contextPath}/community/write_Community'">커뮤니티 만들기</button>
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
					<li class="li">
						<c:if test="${as.is_joined != '0'}">
							<a href="${pageContext.request.contextPath}/community/sideboard_list?bd_num=${as.bd_num}">${as.bd_name}</a>

						</c:if>
						
						<c:if test="${as.is_joined == '0'}">
						    <a href="${pageContext.request.contextPath}/community/sideboard_list?bd_num=${as.bd_num}" style="color: #BDBDBD;">${as.bd_name}</a>     
							<button  style="padding: 4px 4px 4px;color: #fff; font-weight: normal; border:none; font-size: 11px; line-height: 12px; background: #aeb2ba; letter-spacing: -1px;" 
							           id="boardSet2_${as.bd_num}">가입하기</button>
						</c:if>
					</li>
				</c:forEach>

			</ol>
		</div>
	</div>
<div id="content">
<div id="main_Text">
<h1 style="margin-left: 60px; margin-top:30px; font-weight: normal;font-size: 20px;">커뮤니티 홈</h1>
</div>
<div class="block">

			<div id="board_table">	
			
			<input type="hidden" formmethod="post" formaction="${pageContext.request.contextPath}/community/update?p_num=${view.p_num}&m_id=${view.m_id}&loginId=${view.loginId}">
						<sec:csrfInput />
					<c:forEach var="ps" items="${listPost}">
					<div id="community_list">
				<ul>
				<li  style="margin-top: 20px;">${ps.bd_name} > ${ps.p_name} <span id="img_com" style="color: black;"> &nbsp;&nbsp;&nbsp; <img alt="image"
											src="${pageContext.request.contextPath}/community/img/arrow5.png"
											style="width: 20px; height: 15px;"> &nbsp;${ps.p_view} </span></li>
				<li ><a style="font-size: 20px;" href='${pageContext.request.contextPath}/community/view?p_num=${ps.p_num}'>${ps.p_content}</a></li>
			
				<li>
				<img style="border-radius:70%; width:30px; height: 30px; " src="${pageContext.request.contextPath}/resource/member/photo/${ps.m_id}.jpg" onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'"/>
				${ps.m_name}${ps.pt_name}&nbsp; &nbsp; &nbsp;
				<fmt:formatDate value="${ps.p_regdate}" pattern="yyyy-MM-dd HH:mm:ss"/><button style="background-color: transparent; border: none;" type="button" id="buttonRecommand" onclick="location.href='${pageContext.request.contextPath}/board/recommend?p_num=${view.p_num}'">
</button>
			<c:if test="${ps.is_liked == 0}">
			<img alt="image" src="${pageContext.request.contextPath}/board/img/heart.png"
											style="width: 30px; height: 30px; margin-left: 800px;">
									</c:if>
									<c:if test="${ps.is_liked == 1}">
										<img alt="image"
											src="${pageContext.request.contextPath}/board/img/checkedheart.png"
											style="width: 30px; height: 30px; margin-left: 800px;">
									</c:if></li>
		
								
				</ul>	
				</div>
					</c:forEach>	
			</div>
			</div>
 </div>
	<c:forEach var="as" items="${boardListOfCommunity }">
	<div id="myModal2_${as.bd_num}" class="modal">
	
		<!-- Modal content -->
		<div class="modal-content">
		
			<p>
				<span style="font-size: 20px; font-weight: bold;">가입을 하시겠습니까? <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					 id="x_icon_${as.bd_num}" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form" name="modal_form" name="form_insert" action="${pageContext.request.contextPath}/community/CommunitySign?bd_num=${as.bd_num}" method="post" enctype="multipart/form-data">
	
			<sec:csrfInput/>
				<table>
		          <tr> 
					<td id="btnNotice"><button type="submit" onclick="">가입</button>	</td></tr>	
				</table>
			</form>
		</div>
	</div>
	<script>
	//커뮤니티 가입 모달
		$(document).ready(function() {
		// 가입 클릭 시 모달창 열기
		$("#boardSet2_${as.bd_num}").on("click", function () {
			$('#myModal2_${as.bd_num}').show();
		});
		//모달창 Close 기능
			$("#x_icon_${as.bd_num}").unbind('click').on('click', function() {
				$('#myModal2_${as.bd_num}').hide();
			});
		});
	</script>
	</c:forEach>
	
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>