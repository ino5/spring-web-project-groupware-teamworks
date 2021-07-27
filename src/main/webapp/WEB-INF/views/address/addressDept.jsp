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
			<a href="${pageContext.request.contextPath}/address" class="button1"><span><img
					alt="image"
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
					<li class="li"><a
						href="${pageContext.request.contextPath}/address/personal?adg_num=${listAddressGroup.adg_num}">${listAddressGroup.adg_name}</a></li>
				</c:forEach>
				<li class="li"><span class="groupAdd"
					onclick="javascript:doShow3()">연락처 주소록 추가</span></li>
				<li class="li" id="group">
					<form action="${pageContext.request.contextPath}/address/groupAdd">
						<input type="text" name="adg_name" placeholder="그룹 명"
							required="required" id="groupName"><input type="image" 
							src="${pageContext.request.contextPath}/address/img/plus.png" name="Submit" value="Submit" id="groupAdd">
							 <img alt="" src="${pageContext.request.contextPath}/address/img/gear.png"
							width="19px" height="19px" style="margin-top: 2px;" class="groupAdd" id="groupSet">
					</form>
				</li>
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
					<c:forEach var="listDeptGroup" items="${listDeptGroup }">
						<li class="li"><a
							href="${pageContext.request.contextPath}/address/dept?dpt_code=${listDeptGroup.dpt_code}">${listDeptGroup.dpt_name}</a></li>
					</c:forEach>
				</ol>
			</div>
		</div>
	</div>
	<div id="content">
		<div style="height: 150px;">
			<h2>
				<span id="content1">전체 주소록</span><span
					style="color: #8C8C8C; font-size: 15px;">&nbsp;&nbsp;&nbsp;in
					개인 주소록(총 <span style="color: black">${total}</span>&nbsp건)
				</span>
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
				</ul>
			</section>
		</div>
		<br>
		<div id="speed" style="display: none">
			<form action="${pageContext.request.contextPath}/address/simpleAdd">
				<input type="text" class="speed" placeholder="이름(표시명)" name="m_name"
					required="required"> <input type="email" class="speed"
					placeholder="이메일" name="m_email" required="required"> <input
					type="text" class="speed" placeholder="휴대폰" name="m_phone"
					required="required">
				<button type="submit" class="speed_plus_btn">
					<img alt=""
						src="${pageContext.request.contextPath}/address/img/plus.png"
						width="17px" height="17px">
				</button>
			</form>
		</div>
		<div>
			<ul class="search_ul">
				<li><a href="javascript:addressSearchListDept(65, 55203,'${dpt_code }');"
					class="click_a">전체</a></li>
				<li><a href="javascript:addressSearchListDept(44032, 45207,'${dpt_code }');"
					class="click_a">ㄱ</a></li>
				<li><a href="javascript:addressSearchListDept(45208, 45795,'${dpt_code }')"
					class="click_a">ㄴ</a></li>
				<li><a href="javascript:addressSearchListDept(45796, 46971,'${dpt_code }');"
					class="click_a">ㄷ</a></li>
				<li><a href="javascript:addressSearchListDept(46972, 47559,'${dpt_code }');"
					class="click_a">ㄹ</a></li>
				<li><a href="javascript:addressSearchListDept(47560, 48147,'${dpt_code }');"
					class="click_a">ㅁ</a></li>
				<li><a href="javascript:addressSearchListDept(48148, 49323,'${dpt_code }');"
					class="click_a">ㅂ</a></li>
				<li><a href="javascript:addressSearchListDept(49324, 50499,'${dpt_code }');"
					class="click_a">ㅅ</a></li>
				<li><a href="javascript:addressSearchListDept(50500, 51087,'${dpt_code }');"
					class="click_a">ㅇ</a></li>
				<li><a href="javascript:addressSearchListDept(51088, 52263,'${dpt_code }');"
					class="click_a">ㅈ</a></li>
				<li><a href="javascript:addressSearchListDept(52264, 52851,'${dpt_code }');"
					class="click_a">ㅊ</a></li>
				<li><a href="javascript:addressSearchListDept(52852, 53439,'${dpt_code }');"
					class="click_a">ㅋ</a></li>
				<li><a href="javascript:addressSearchListDept(53440, 54027,'${dpt_code }');"
					class="click_a">ㅌ</a></li>
				<li><a href="javascript:addressSearchListDept(54028, 54615,'${dpt_code }');"
					class="click_a">ㅍ</a></li>
				<li><a href="javascript:addressSearchListDept(54616, 55203,'${dpt_code }');"
					class="click_a">ㅎ</a></li>
				<li><a href="javascript:addressSearchListDept(65, 90,'${dpt_code }');"
					class="click_a">A-Z</a></li>
				<li><a href="javascript:addressSearchListDept(97, 123,'${dpt_code }');"
					class="click_a">a-z</a></li>
			</ul>
		</div>
		<div id="board_table">
			<table id="list_table"
				style="margin-top: 4%; border-top: 2px solid #EAEAEA;">
				<thead>
					<tr>
						<td
							style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
							<input type="checkbox" name="check"
							onclick='selectAll(this)'>
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

					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${listDeptGroupMember }">
						<tr>
							<td style="text-align: center;"><input type="checkbox"
								name="check" value="${member.m_id }" class="chk"></td>
							<td>${member.m_name }</td>
							<c:if test="${member.m_empnum > 0}">
								<td>${member.m_empnum }</td>
							</c:if>
							<c:if test="${member.m_empnum == 0}">
								<td></td>
							</c:if>
							<td>${member.m_phone }</td>
							<td>${member.m_email }</td>
							<td>${member.dpt_name }</td>
							<td>${member.pt_name }</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
			<div id="pg">
				<c:if test="${pg.startPage > pg.pageBlock }">
					<a href="address?currentPage=${pg.startPage-pg.pageBlock}">[이전]</a>
				</c:if>
				<c:if test="${pg.total > 20}">
					<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
						<a href="address?currentPage=${i}">[${i}]</a>
					</c:forEach>
				</c:if>
				<c:if test="${pg.endPage < pg.totalPage }">
					<a href="address?currentPage=${pg.startPage+pg.pageBlock}">[다음]</a>
				</c:if>
			</div>
			<div id="pg1"></div>
		</div>
	</div>
	
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<p>
				<span>그룹관리 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					onclick="close_pop2();" id="x_icon" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form">
				<table>
					<tr>
						<td>그룹선택</td>
						<td>
							<select name="adg_num">
								<c:forEach var="listAddressGroup" items="${listAddressGroup}">
									  <option value="${listAddressGroup.adg_num}">${listAddressGroup.adg_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>이름변경</td>
						<td colspan="3"><input type="text" name="adg_name"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="이름변경" formaction="${pageContext.request.contextPath}/address/groupNameUpdate" class="modal_btn">
						<input type="submit" value="그룹삭제" formaction="${pageContext.request.contextPath}/address/groupDelete" class="modal_btn">
						<input type="button" value="취소" id="close_btn" class="modal_btn"></td>
				</table>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>