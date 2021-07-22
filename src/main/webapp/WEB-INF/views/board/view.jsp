<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
</head>
<body>
<div id="side">
		<button type="button" id="btn1">일정등록</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/images/right.png"
					style="width: 16px; height: 12px; transition:0.5s;" id="img1"></span> <span
				id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/images/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 내 캘린더</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li"><input type="checkbox" name="check" id="chk_1"><label
					for="chk_1">전체일정</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_2"><label
					for="chk_2">개인일정</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_3"><label
					for="chk_3">AI개발팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_4"><label
					for="chk_4">SW개발팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_5"><label
					for="chk_5">기획팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_6"><label
					for="chk_6">경영지원팀</label></li>
			</ol>
		</div>

	</div>

	<div id="content">
			<form>
				<sec:csrfInput/>
				<input type="hidden" name="m_id" value="${view.m_id}">
				<section id="point">
					<article class="pt pt1">
						<table class="pt_tb">
							<tr>
								<td id="p_title"  name="p_title" value="${view.p_name}">글 확인하기</td>
							</tr>
							<tr>
								<td class="td_subject">
									<input id="subject" type="text" name="p_name"  value="${view.p_name}" placeholder="글 제목" class="form_box">
								</td>
								<td>
									<select id="select_bd_code" name="bd_code" >
										<option value="1">정보공유</option>
										<option value="2">취준톡톡</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="5">
									<textarea id="content" name="p_content" placeholder="글 내용" rows="15" class="form_box">${view.p_content}</textarea>
								</td>
							</tr>
						</table>
					</article>
				</section>
			</form>
		
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>