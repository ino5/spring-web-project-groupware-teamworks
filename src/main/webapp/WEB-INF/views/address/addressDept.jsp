<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet"
	href="${pageContext.request.contextPath}/address/css/address.css">
<script src="${pageContext.request.contextPath}/address/js/address.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<button type="button" id="btn1">연락처 추가</button>
		<div>
			<a href="${pageContext.request.contextPath}/address" class="button1"><span><img alt="image"
					src="${pageContext.request.contextPath}/address/img/white.png"
					style="width: 16px; height: 12px;" id="img"></span> 전체 주소록</a>
		</div>
		<br>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/address/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/address/img/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 개인 주소록</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="listAddressGroup" items="${listAddressGroup}">
					<li class="li"><a href="${pageContext.request.contextPath}/address/personal?adg_num=${listAddressGroup.adg_num}">${listAddressGroup.adg_name}</a></li>
				</c:forEach>
				<li class="li"><span id="addGroup">연락처 주소록 추가</span></li>
			</ol>
			<div id="div2">
				<a id="button2" class="button1"><span id="span_hover"><img
						alt="image"
						src="${pageContext.request.contextPath}/address/img/right.png"
						style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
					<span id="span_none"><img alt="image"
						src="${pageContext.request.contextPath}/address/img/white.png"
						style="width: 16px; height: 12px;" id="img2"></span> 공용 주소록</a>
				<ol id="scroll" style="display: none; list-style: none;">
					<li class="li">인사부</li>
					<li class="li">총무부</li>
					<li class="li">회계부</li>
					<li class="li">기획부</li>
					<li class="li">영업부</li>
					<li class="li">개발부</li>
				</ol>
			</div>
		</div>
	</div>
	<div id="content">
		<div style="height: 150px;">
			<h2>
				<span id="content1">전체 주소록</span><span
					style="color: #8C8C8C; font-size: 15px;">&nbsp;&nbsp;&nbsp;in
					개인 주소록(총 <span style="color:black">${total}</span>&nbsp건)</span>
			</h2>

			<form action="">
				<table id="searchBox">
					<tr>
						<td><select id="option" name="standard">
								<option ${(param.standard == "clvalue1")?"selected":"" }
									value='clvalue1'>주소록
								<option ${(param.standard == "clvalue2")?"selected":"" }
									value='clvalue2'>통합검색
						</select></td>
						<td><input id="search" type="text" name="name"
							value="${param.name}" placeholder="검색" size="100"></td>
						<td><img
							src="${pageContext.request.contextPath}/address/img/search.png"
							width="14px" height="13px"></td>
					</tr>
				</table>
			</form>
		</div>
		<div style="display: block;">
			<section class="tool_bar">
				<ul class="tool_ul">
					<li><button type="button" class="btn2" id="speed_btn"
							onclick="javascript:doShow2()">
							<img alt=""
								src="${pageContext.request.contextPath}/address/img/plus.png"
								width="17px" height="17px">&nbsp;빠른 등록
						</button></li>
					<li><button type="button" class="btn2">
							<img alt=""
								src="${pageContext.request.contextPath}/address/img/mail.png"
								width="17px" height="17px">&nbsp;메일발송
						</button></li>
					<li><button type="button" class="btn2">
							<img alt=""
								src="${pageContext.request.contextPath}/address/img/group.png"
								width="17px" height="17px">&nbsp;그룹지정
						</button></li>
					<li><button type="button" class="btn2">
							<img alt=""
								src="${pageContext.request.contextPath}/address/img/delete.png"
								width="17px" height="17px">&nbsp;삭제
						</button></li>
				</ul>
			</section>
		</div>
		<br>
		<div id="speed" style="display: none">
			<input type="text" class="speed" placeholder="이름(표시명)"> <input
				type="text" class="speed" placeholder="이메일"> <input
				type="text" class="speed" placeholder="휴대폰">
			<button type="button" class="speed_plus_btn">
				<img alt=""
					src="${pageContext.request.contextPath}/address/img/plus.png"
					width="17px" height="17px">
			</button>
		</div>
		<div>
			<ul class="search_ul">
				<li data-param = "all"><a href="#">전체</a></li>
				<li data-param = "ㄱ"><a href="#">ㄱ</a></li>
				<li data-param = "ㄴ"><a href="#">ㄴ</a></li>
				<li data-param = "ㄷ"><a href="#">ㄷ</a></li>
				<li data-param = "ㄹ"><a href="#">ㄹ</a></li>
				<li data-param = "ㅁ"><a href="#">ㅁ</a></li>
				<li data-param = "ㅂ"><a href="#">ㅂ</a></li>
				<li data-param = "ㅅ"><a href="#">ㅅ</a></li>
				<li data-param = "ㅇ"><a href="#">ㅇ</a></li>
				<li data-param = "ㅈ"><a href="#">ㅈ</a></li>
				<li data-param = "ㅊ"><a href="#">ㅊ</a></li>
				<li data-param = "ㅋ"><a href="#">ㅋ</a></li>
				<li data-param = "ㅌ"><a href="#">ㅌ</a></li>
				<li data-param = "ㅍ"><a href="#">ㅍ</a></li>
				<li data-param = "ㅎ"><a href="#">ㅎ</a></li>
				<li data-param = "a-z"><a href="#">a-z</a></li>
				<li data-param = "0-9"><a href="#">0-9</a></li>
			</ul>
		</div>


		<div id="board_table">
			<c:set var="num" value="${pg.total-pg.start+1}"></c:set>
			<table id="list_table"
				style="margin-top: 4%; border-top: 2px solid #EAEAEA;">
				<tr>
					<td
						style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
						<input type="checkbox" name="check" id="chk_1"
						onclick='selectAll(this)'> <label for="chk_1"></label>
					</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">이름</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">사번</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">휴대폰</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">이메일</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">부서</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">직급</td>
					<td
						style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">그룹</td>

				</tr>

				<c:forEach var="member" items="${listPersonalGroup }">
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>${member.m_name }</td>
						<td>${member.m_empnum }</td>
						<td>${member.m_phone }</td>
						<td>${member.m_email }</td>
						<td>${member.dpt_name }</td>
						<td>${member.pt_name }</td>
						<td>그룹</td>
					</tr>
					<c:set var="num" value="${num - 1 }"></c:set>
				</c:forEach>
			</table>
		<c:if test="${pg.startPage > pg.pageBlock }">
			<a href="address?currentPage=${pg.startPage-pg.pageBlock}">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
			<a href="address?currentPage=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${pg.endPage < pg.totalPage }">
			<a href="address?currentPage=${pg.startPage+pg.pageBlock}">[다음]</a>
		</c:if>

		</div>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>