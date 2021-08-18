<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="black_bg"></div>
<button type="button" id="button_new_sign" onclick="location.href='${pageContext.request.contextPath}/mail/writeForm'">메일쓰기</button> <br>


<!-- 메뉴 -->
<div>
<a id="button1" class="menu_button">
	<span id="span_hover"><img alt="image" src="${pageContext.request.contextPath}/time/img/right.png" style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
	<span id="span_none"><img alt="image" src="${pageContext.request.contextPath}/time/img/white.png" style="width: 16px; height: 12px;" id="img1"></span>
	메일함
</a>
<ol id="scroll1" class="scroll" style="display: none; list-style: none;">
		<li class="li"><p class="menu_title">
			<a href="${pageContext.request.contextPath}/mail">받은 메일함</a>
		</p></li>
		<li class="li"><p class="menu_title">
			<a href="${pageContext.request.contextPath}/mail?mode=sent">보낸 메일함</a>
		</p></li>
	
</ol>
</div>
<!-- <div style="margin-top: 30px;"> -->
<!-- <a id="button2" class="menu_button"><span id="span_hover"><img -->
<!-- 		alt="image" -->
<%-- 		src="${pageContext.request.contextPath}/time/img/right.png" --%>
<!-- 		style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span> -->
<!-- 	<span id="span_none"><img alt="image" -->
<%-- 		src="${pageContext.request.contextPath}/time/img/white.png" --%>
<!-- 		style="width: 16px; height: 12px;" id="img1"></span> 결재 문서</a> -->
<!-- <ol id="scroll2" class="scroll" style="display: none; list-style: none;"> -->
<!-- 	<li class="li"><p class="menu_title"> -->
<%-- 		<a href="${pageContext.request.contextPath}/sign/list/proposalProcessing">결재 대기 문서</a> --%>
<!-- 		</p></li> -->
<!-- 	<li class="li"><p class="menu_title"> -->
<%-- 		<a href="${pageContext.request.contextPath}/sign/list/proposalCompleted">결재 처리 문서</a> --%>
<!-- 		</p></li> -->
<!-- </ol> -->
<!-- </div> -->