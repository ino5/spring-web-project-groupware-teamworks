<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/admin.css">
<script src="${pageContext.request.contextPath}/admin/js/admin.js"></script>
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	width: 650px; /* Could be more or less, depending on screen size */
	height: 850px; 
	border: 2px solid #ddd;
	border-radius: 4px;
	box-shadow: 0px 5px 8px rgb(0 0 0/ 20%);

}
</style>
<title>Insert title here</title>
</head>
<!-- 바디 태그 더블 클릭 시 블록 선택 방지 -->
<body onselectstart="return false" ondragstart="return false">
	<div class="container">
		<div class="side" id="hide" style="background-color: black;">
			<div>
				<div
					style="color: #37d2e7; font-size: 20px; font-weight: bold; margin-left: 5%; cursor: pointer;"
				>site Admin</div>
				<div id="text">
					<h3>관리자 페이지</h3>
				</div>
				<div></div>
				<div class="menu_hover">
					<a id="button1" class="button1" style="color: white;">
						<span id="span_hover"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img1"
						></span> <span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png" style="width: 16px; height: 12px;"
							id="img1"
						></span> 개인 주소록
					</a>
					<ol id="scroll" style="display: none; list-style: none;">
						<li class="li">전체 주소록</li>
						<li class="li">개인</li>
						<li class="li">연락처 주소록 추가</li>
					</ol>
				</div>
				<div id="div2" class="menu_hover">
					<a id="button2" class="button1" style="color: white;">
						<span id="span_hover"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img2"
						></span> <span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png" style="width: 16px; height: 12px;"
							id="img2"
						></span> 부서 주소록
					</a>
					<ol id="scroll" style="display: none; list-style: none;">
						<li class="li">새글쓰기</li>
						<li class="li">이동</li>
						<li class="li">복사</li>
						<li class="li">삭제</li>
						<li class="li">공지로 등록</li>
						<li class="li">목록다운로드</li>
					</ol>
				</div>
			</div>
		</div>
		<div id="content">
			<h2>
				<span style="color: #8C8C8C; font-size: 20px; font-weight: bold; margin-top: 20px;">메뉴관리/게시판</span>
			</h2>
			<br>
			<div style="z-index: 2; padding-top: 20px; margin-left: 50px;">
				<h2>
					<span id="content1" style="font-weight: bold; font-size: 35px;">게시판</span>
				</h2>
			</div>
			<div id="right2" style="margin-top: 20px;">
				<a class="button3" onclick="javascript:doShow()">
					<img alt="" src="${pageContext.request.contextPath}/admin/img/right2.png" width="30px"
						height="30px" style="margin-top: 10px;" id="img3"
					>
				</a>
			</div>
			<div id="wrap">
				<table id="admin_board">
					<tr>
						<td>총게시판 수</td>
						<td>
							20 <span style="color: #8C8C8C;">&nbsp;개</span>
						</td>
					</tr>
					<tr>
						<td>총게시판 수</td>
						<td>
							20 <span style="color: #8C8C8C;">&nbsp;개</span>
						</td>
					</tr>
				</table>
			</div>
			<div id="board_table">
				<section class="tool_bar">
					<ul class="tool_ul">
						<li><button type="button" class="btn2" id="add">
								<img alt="" src="${pageContext.request.contextPath}/admin/img/plus.png" width="17px"
									height="17px"
								>&nbsp;멤버 생성
							</button></li>
 
						<li><button type="button" class="btn2">
								<img alt="" src="${pageContext.request.contextPath}/admin/img/group.png" width="17px"
									height="17px"
								>&nbsp;직위변경
							</button></li>
						<li><button type="button" class="btn2">
								<img alt="" src="${pageContext.request.contextPath}/admin/img/delete.png" width="17px"
									height="17px"
								>&nbsp;멤버삭제
							</button></li>
						<li><button type="button" class="btn2">
								<img alt="" src="${pageContext.request.contextPath}/admin/img/mail.png" width="17px"
									height="17px"
								>&nbsp;비밀번호 초기화
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
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">이름</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">사번</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
						<div class="wrap" >
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
						</div></td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
							<select name="m_state" required="required">
								<option>계정상태</option>
								<option value="1">정상</option>
								<option value="2">메일휴면</option>
								<option value="3">중지</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
					</tr>
				</table>
			</div>
			<div id="myModal" class="modal">
			
			<!-- Modal content -->
		<div class="modal-content">
<img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					onclick="close_pop2();" id="x_icon" />
			<br>
			<p style="text-align: center; line-height: 1.5;">
			</p>
			<h2>멤버 생성</h2>
			<p>
			<form id="modal_form" action="${pageContext.request.contextPath}/login/join" method="post">
				<table id="modal_tb" style="font-size: 20px; font-weight: bold; margin: 0 auto;">
					<tr>
						<td><span style="color: red;"> * </span>이름 (한글)</td>
						<td colspan="3"><input type="text" class="input" name=m_name></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>아이디</td>
						<td colspan="3"><input type="text" class="input" name="m_id"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>비밀번호</td>
						<td colspan="3"><input type="password" name="m_password" class="input"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>사번</td>
						<td colspan="3"><input type="text" name="m_empnum" class="input"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>직위</td>
						 <td><select id="admin_select"style="none;">
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
						<tr>
						<td><span style="color: red;"> * </span>부서</td>
						<td colspan="3"><input type="text" class="input"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>생일</td>
						<td colspan="3"><input type="text" name="m_birth" class="input"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>전화번호</td>
						<td colspan="3"><input type="text" name="m_phone" class="input"></td>
					</tr>
					<tr>
						<td><span style="color: red;"> * </span>이메일</td>
						<td colspan="3"><input type="text" name="m_email" class="input"></td>
					</tr>
				</table>
				<br>
				<div id="modal_wrap">
				<div id="modal_btn"><input type="submit" value="저장" class="modal_btn"></div>
				<div id="modal_btn"><input type="button" value="취소" id="close_btn" class="modal_btn" /></div>
			
				</div>
				<sec:csrfInput/>
			</form>
		</div>

	</div>
	</div>
	<!--End Modal-->
			
		</div>
</body>
</html>