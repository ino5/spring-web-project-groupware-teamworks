<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${jspType != 'w' }">
<h1>${mapOfSignContent.title}<span>&nbsp;&nbsp;in ${sign.sgf_name}</span></h1>
</c:if>
<c:if test="${jspType == 'w' }">
<h1 class="sign_line_title">결재 라인</h1>
</c:if>			

<!-- 상단 버튼 -->
<c:if test="${jspType == 'r' }">
	<c:forEach var= "signLine" items="${listOfSignLine}">
		<c:if test="${signLine.m_id == principal.m_id && signLine.sgl_status == 0}">
			<button type="button" id="button_approval">
				<span class="ic_toolbar approval"></span>
				<span class="txt">결재</span>
			</button>
			<button type="button" id="button_return">
				<span class="ic_toolbar return"></span>
				<span class="txt">반려</span>
			</button>
		</c:if>	
	</c:forEach>
	<!-- 결재하기 모달창 -->
	<div id="modal_wrap_approval" class="modal_wrap">
		<h1>결재하시겠습니까?</h1>
		<form method="post" action="${pageContext.request.contextPath}/sign/approval">
			<sec:csrfInput/>
			<input type="hidden" name="sg_num" value="${sign.sg_num}">
			<input type="hidden" name="sgf_id" value="${sign.sgf_id}">
			<input type="hidden" name="sgl_status" value="1">
			<button type="submit" id="button_approval_yes">결재</button>
		</form>
		<button type="button" id="button_approval_no">취소</button>
	</div>						
	<!-- 반려하기 모달창 -->
	<div id="modal_wrap_return" class="modal_wrap">
		<h1>반려하시겠습니까?</h1>
		<form method="post" action="${pageContext.request.contextPath}/sign/approval">
			<sec:csrfInput/>
			<input type="hidden" name="sg_num" value="${sign.sg_num}">
			<input type="hidden" name="sgf_id" value="${sign.sgf_id}">
			<input type="hidden" name="sgl_status" value="2">
			<button type="submit" id="button_return_yes">반려</button>
		</form>
		<button type="button" id="button_return_no">취소</button>
	</div>	
</c:if>
<c:if test="${jspType == 'r' && mapOfSignContent.dv_id != null}">
	
	<button type="button" class="button_download_file" data-dv_id="${mapOfSignContent.dv_id}">
		<span class="ic_toolbar save"></span>
		<span class="txt">첨부파일 (${dv_filename})</span>						
	</button>
</c:if>
<div id="sign_line">
	<c:if test="${jspType == 'w' }">
		<ul id="sortable" class="sortable">
		</ul>
		<button type="button" id="button_new_sign_line">
			<span class="ic_toolbar plus"></span>
			<span class="txt">결재라인 추가</span>
		</button>
	</c:if>	
	<c:if test="${jspType == 'r' }">
<%-- 				<c:forEach var= "signLine" items="${listOfSignLine}"> --%>
<%-- 					${signLine.m_name} ${signLine.dpt_name} ${signLine.pt_name}<br> --%>
<%-- 				</c:forEach> --%>
	</c:if>
</div>

<!-- 결재라인 추가 모달창 -->
<div id="modal_wrap_new_sign_line" class="modal_wrap">
	<button type="button" id="modal_close_new_sign_line" class="button_x"><span class="ic_gnb_x"></button>
	<h1>결재라인 추가</h1>
	<div class="modal_content">
		<div id="sign_line_form_list">	
			<c:forEach var= "member" items="${listOfMember}">
				<button class="button_new_sign_line_member"type="button" onclick="addSignLine('${member.m_id}', '${member.m_name}', '${member.dpt_name}', '${member.pt_name}'); closeModalOfNewSignLine();">${member.m_name} ${member.dpt_name} ${member.pt_name}</button><br>
			</c:forEach>
		</div>
	</div>
</div>	