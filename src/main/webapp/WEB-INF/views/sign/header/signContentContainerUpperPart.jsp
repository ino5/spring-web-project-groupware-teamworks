<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>					
<!-- 문서 기본 정보 테이블 -->
<table id="tb_sign_info">
	<tr>
		<td class="td_head">기안자</td>
		<td>
			${sign.m_name}
			<c:if test="${jspType == 'w'}">
				${principal.m_name}
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="td_head">소속</td>
		<td>
			${sign.dpt_name}
			<c:if test="${jspType == 'w'}">
				${principal.dpt_name}
			</c:if>
		</td>							
	</tr>
	<tr>
		<td class="td_head">직위</td>
		<td>
			${sign.pt_name}
			<c:if test="${jspType == 'w'}">
				${principal.pt_name}
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="td_head">기안일</td>
		<c:if test="${jspType == 'r'}">
			<td><fmt:formatDate value="${sign.sg_regdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
		</c:if>
		<c:if test="${jspType == 'w'}">
			<td class="today"></td>
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
	<c:if test="${jspType != 'w'}">
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
	</c:if>
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