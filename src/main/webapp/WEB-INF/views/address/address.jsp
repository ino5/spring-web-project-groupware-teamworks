<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet" href="${pageContext.request.contextPath}/address/css/address.css">
<script src="${pageContext.request.contextPath}/address/js/address.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<button type="button" id="btn1">연락처 추가</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/address/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/address/img/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 개인 주소록</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li">전체 주소록</li>
				<li class="li">개인</li>
				<li class="li">연락처 주소록 추가</li>
			</ol>
			<div id="div2">
				<a id="button2" class="button1"><span id="span_hover"><img
						alt="image"
						src="${pageContext.request.contextPath}/address/img/right.png"
						style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
					<span id="span_none"><img alt="image"
						src="${pageContext.request.contextPath}/address/img/white.png"
						style="width: 16px; height: 12px;" id="img2"></span> 부서 주소록</a>
				<ol id="scroll" style="display: none; list-style: none;">
					<li class="li">신입사원 주소록</li>
					<li class="li">전체 주소록</li>
					<li class="li">연락처 주소록 추가</li>
				</ol>
			</div>
		</div>
		</div>
		<div id="content">
			<div style="height: 150px;">
				<h2>
					<span id="content1">전체 주소록</span><span
						style="color: #8C8C8C; font-size: 15px;">&nbsp;&nbsp;&nbsp;in
						개인 주소록(총 2건)</span>
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
					<li><a href="#">전체</a></li>
					<li><a href="#">ㄱ</a></li>
					<li><a href="#">ㄴ</a></li>
					<li><a href="#">ㄷ</a></li>
					<li><a href="#">ㄹ</a></li>
					<li><a href="#">ㅁ</a></li>
					<li><a href="#">ㅂ</a></li>
					<li><a href="#">ㅅ</a></li>
					<li><a href="#">ㅇ</a></li>
					<li><a href="#">ㅈ</a></li>
					<li><a href="#">ㅊ</a></li>
					<li><a href="#">ㅋ</a></li>
					<li><a href="#">ㅌ</a></li>
					<li><a href="#">ㅍ</a></li>
					<li><a href="#">ㅎ</a></li>
					<li><a href="#">a-z</a></li>
					<li><a href="#">0-9</a></li>
				</ul>
			</div>
			<div id="board_table">
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
							style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
							<div class="wrap">
								<select id="ex_select" name="m_grade" required="required">
									<option>직위</option>
									<option value="1">사장</option>
									<option value="2">이사</option>
									<option value="3">부장</option>
									<option value="4">차장</option>
									<option value="5">과장</option>
									<option value="6">대리</option>
									<option value="7">사원</option>
									<option value="8">인턴</option>
								</select>
							</div>
						</td>
						<td
							style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
							<select name="m_state" required="required">
								<option>계정상태</option>
								<option value="1">정상</option>
								<option value="2">메일휴면</option>
								<option value="3">중지</option>
						</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;"><input type="checkbox"
							name="check" id="chk_1"></td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
				</table>
			</div>
		</div>
		<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>