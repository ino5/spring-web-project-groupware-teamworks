<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet" href="${pageContext.request.contextPath}/calendar/css/calendar.css">
<script src="${pageContext.request.contextPath}/calendar/js/calendar.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<button type="button" id="btn1">일정등록</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/calendar/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/calendar/img/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 내 캘린더</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li"><input type="checkbox" name="check" id="chk_1"><label
					for="chk_1">내 일정(기본)</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_2"><label
					for="chk_2">내 일정(중요)</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_3"><label
					for="chk_3">연차</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_4"><label
					for="chk_4">aa</label></li>
			</ol>
		</div>
	</div>
	<div id="content">
		<h2>
			<span id="content1">일정목록</span>
		</h2>

		<form action="">
			<table id="searchBox">
				<tr>
					<td><select id="option" name="standard">
							<option ${(param.standard == "clvalue1")?"selected":"" }
								value='clvalue1'>캘린더
							<option ${(param.standard == "clvalue2")?"selected":"" }
								value='clvalue2'>통합검색
					</select></td>
					<td><input id="search" type="text" name="name"
						value="${param.name}" placeholder="검색" size="100"></td>
					<td><img
						src="${pageContext.request.contextPath}/calendar/img/search.png"
						width="14px" height="13px"></td>
				</tr>
			</table>
		</form>

		<div id="calendar_head">
			<!-- label은 마우스로 클릭을 편하게 해줌 -->
			<label onclick="prevCalendar()" style="padding-right: 20px;"><</label>
			<a align="center" id="tbCalendarYM" style="padding-right: 20px;">yyyy년
				m월</a> <label onclick="nextCalendar()">> </label>
		</div>
		<table id="calendar">
			<tr>
				<th><font color="red">일</font></th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th><font color="blue">토</font></th>
			</tr>
		</table>
	<script type="text/javascript">
    	buildCalendar();
	</script>
	
	</div>
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<p>
				<span>일정등록 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					onclick="close_pop2();" id="x_icon" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form">
				<table style="font-size: 17px;">
					<tr>
						<td>일정명</td>
						<td colspan="3"><input type="text" class="input"></td>
					</tr>
					<tr>
						<td>일시</td>
						<td><input type="date" id="dd"></td>
					</tr>
					<tr>
						<td>내 캘린더</td>
						<td><input type="text" class="input"></td>
					</tr>
					<tr>
						<td>장소</td>
						<td colspan="3"><input type="text" class="input"></td>
					</tr>
				</table>
				<br>
				<div style="margin-left: 500px;">
					<input type="submit" value="확인" class="modal_btn"> <input
						type="button" value="취소" id="close_btn" class="modal_btn" />

				</div>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>