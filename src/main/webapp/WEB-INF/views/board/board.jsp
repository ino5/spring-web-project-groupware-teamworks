<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet" href="${pageContext.request.contextPath}/board/css/board.css">
<script src="${pageContext.request.contextPath}/board/js/board.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
		<div id="side">
		<button type="button" id="btn1">글쓰기</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/images/right.png"
					style="width: 16px; height: 12px; transition:0.5s;" id="img1"></span><span
				id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/images/white.png"
					style="width: 16px; height: 12px;" id="img1"></span>전사게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${boardListOfAll }">
				<li class="li">${bs.bd_name}</li>
				</c:forEach>

			</ol>
			</div>
			<div>
						<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/images/right.png"
					style="width: 16px; height: 12px; transition:0.5s;" id="img2"></span> <span
				id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/images/white.png"
					style="width: 16px; height: 12px;" id="img2"></span>부서게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${boardListOfDept }">
				<li class="li">${bs.bd_name}</li>
				</c:forEach>

			</ol>
		</div>

	</div>

	<div id="content">
	
		<form action="${pageContext.request.contextPath}/searching.do">
			<table id="searchBox">
				<tr>
					<td><select id="option" name="standard">
							<option ${(param.standard == "clvalue1")?"selected":"" }
								value='clvalue1'>게시판 <option ${(param.standard == "clvalue2")?"selected":"" }
								value='clvalue2'>통합검색
				
					</select></td>
				<td><input id="search" type="text" name="name"
						value="${param.name}" placeholder="검색" size="100"></td>
				<td><img
						src="${pageContext.request.contextPath}/images/search.png"
						width="14px" height="13px"></td>
			</tr>
		</table>
	</form>
			<div id="board_table">
				<section class="tool_bar">
					<ul class="tool_ul">
						<li><button type="button" class="btn2"onclick="location.href='${pageContext.request.contextPath}/board/write'">
								새글쓰기
							</button></li>

						<li><button type="button" class="btn2">
								이동
							</button></li>
						<li><button type="button" class="btn2">
								삭제
							</button></li>
						<li><button type="button" class="btn2">
								공지로 등록
							</button></li>
					</ul>
				</section>
				<table id="list_table" style="margin-top: 4%; border-top: 2px solid #EAEAEA;">
					<tr>
						<td
							style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;"
						>
							<input type="checkbox" name="check" id="chk_1" onclick='selectAll(this)'>
							<label for="chk_1"></label>
						</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">번호</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">제목</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성자</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성일</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">조회</td>
					
					</tr>
					<c:forEach var="ps" items="${listPost }">
					<form >
						
					</form>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>${ps.p_num}</td>
						<td><a href='${pageContext.request.contextPath}/board/view?p_num=${ps.p_num}'>${ps.p_name}</a></td>
						<td>${ps.m_id}</td>
						<td>${ps.p_regdate}</td>
						<td>${ps.p_view}</td>		
					</tr>
						</c:forEach>
				</table>
			</div>
			<div class="pageNum">
		<c:if test="${pg.startPage > pg.pageBlock }">
			<a href="?currentPage=${pg.startPage-pg.pageBlock}"></a>
		</c:if>
		<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage}">
			<a href="?currentPage=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${pg.endPage < pg.totalPage }">
			<a href="?currentPage=${pg.startPage+pg.pageBlock}"></a>
		</c:if>
		</div>
	</div>
	


</body>
</html>