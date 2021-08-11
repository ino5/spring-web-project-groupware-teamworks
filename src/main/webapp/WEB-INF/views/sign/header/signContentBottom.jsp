<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${jspType == 'w'}">
	<button type="submit" formaction="${pageContext.request.contextPath}/sign/insert">
		<span class="ic_toolbar approval"></span>
		<span class="txt">결재요청</span>
	</button>
</c:if>