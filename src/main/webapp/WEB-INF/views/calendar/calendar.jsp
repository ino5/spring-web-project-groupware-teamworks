<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet"
	href="${pageContext.request.contextPath}/calendar/css/calendar.css">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date();//today의 Date를 세어주는 역할
	function prevCalendar() {//이전 달
		// 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); //달력 cell 만들어 출력 
	}
	function nextCalendar() {//다음 달
		// 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();//달력 cell 만들어 출력
	}
	function buildCalendar() {//현재 달 달력 만들기
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		//이번 달의 첫째 날,
		//new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
		//new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
		//왜냐면 getMonth()는 0~11을 반환하기 때문
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		//이번 달의 마지막 날
		//new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
		//day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
		//대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
		var tbCalendar = document.getElementById("calendar");
		//날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
		var tbCalendarYM = document.getElementById("tbCalendarYM");
		//테이블에 정확한 날짜 찍는 변수
		//innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
		//new를 찍지 않아서 month는 +1을 더해줘야 한다. 
		if (today.getMonth() < 9) {
			tbCalendarYM.innerHTML = today.getFullYear() + ".0"
					+ (today.getMonth() + 1);
		} else {
			tbCalendarYM.innerHTML = today.getFullYear() + "."
					+ (today.getMonth() + 1);
		}
		/*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
		while (tbCalendar.rows.length > 1) {
			//열을 지워줌
			//기본 열 크기는 body 부분에서 2로 고정되어 있다.
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
			//테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
			//30일 이후로 담을달에 순서대로 열이 계속 이어진다.
		}
		var row = null;
		row = tbCalendar.insertRow();
		//테이블에 새로운 열 삽입//즉, 초기화
		var cnt = 0;// count, 셀의 갯수를 세어주는 역할
		var cnt_global = 0;
		// 1일이 시작되는 칸을 맞추어 줌
		for (i = 0; i < doMonth.getDay(); i++) {
			/*이번달의 day만큼 돌림*/
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
			cnt_global = cnt_global + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		}
		/*달력 출력*/
		var weekend = 1;
		var i_day = 1;
		var i_today = -1;
		for (i = 1; i <= 294; i++) {
			//1일부터 마지막 일까지 돌림
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cell.id = "cell_" + i;
			cell.dataset.cell = i;
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
			if (cnt % 7 == 0) {
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
				++weekend;
			}
			row.id = "row_" + weekend;
			if ((weekend % 7 == 1 && cnt % 7 !== 0)
					|| ((weekend - 1) % 7 == 1 && cnt % 7 == 0)) {
				if (i_day <= lastDate.getDate()) {
					cell.innerHTML = "<span id='date'>" + i_day + "</span>";//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
					if (cnt % 7 == 1) {/*일요일 계산*/
						//1주일이 7일 이므로 일요일 구하기
						//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
						cell.innerHTML = "<font color=red>";
						cell.innerHTML = "<span id='date2'>" + i_day
								+ "</span>";
						//1번째의 cell에만 색칠
					}
					if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
						//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
						cell.innerHTML = "<font color=blue>";
						cell.innerHTML = "<span id='date3'>" + i_day
								+ "</span>";
						//7번째의 cell에만 색칠
						//row = calendar.insertRow();
						//토요일 다음에 올 셀을 추가
						//++weekend;
					}
					cell.dataset.day = i_day;
					++i_day;
				}
			}
			/*오늘의 날짜에 노란색 칠하기*/
// 			if (today.getFullYear() == date.getFullYear()
// 					&& today.getMonth() == date.getMonth()
// 					&& i_day - 1 == date.getDate()) {
// 				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
// 				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
// 				i_today = i;
// 			}
// 			if (i_today > 0 && (i - i_today) % 7 == 0 && i > i_today
// 					&& i < i_today + 7 * 7) {
// 				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
// 				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
// 			}
		}
			
		var j = 0;
		
		for(i=1; i<=6; i++){
			for(j=1; j<=7; j++){
				if((7 * i + j) + cnt_global <= 49){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}
			
			j = 50 - cnt_global;
			
			for(j=50 - cnt_global; j + cnt_global<=56; j++){
				if((7 * i + j) + cnt_global > 49 && (7 * i + j) + cnt_global <= 98){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}
			for(j=99 - cnt_global; j + cnt_global <=105; j++){
				if((7 * i + j) + cnt_global > 99 && (7 * i + j) + cnt_global <= 147){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}
			for(j=148 - cnt_global; j + cnt_global <=154; j++){
				if((7 * i + j) + cnt_global > 148 && (7 * i + j) + cnt_global <= 196){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}
			for(j=197 - cnt_global; j + cnt_global <=203; j++){
				if((7 * i + j) + cnt_global > 197 && (7 * i + j) + cnt_global <= 245){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}
			for(j=246 - cnt_global; j + cnt_global <=252; j++){
				if((7 * i + j) + cnt_global > 247 && (7 * i + j) + cnt_global <= 294){
					document.getElementById('cell_'+ (7 * i + j)).dataset.day = document.getElementById('cell_' + j).dataset.day;
					document.getElementById('cell_'+ (7 * i + j)).setAttribute("id", "cell_" + document.getElementById('cell_' + j).dataset.day + "_" + i);
				}
			}

// 			for(j=1; j<32; j++){
// 				if($('#cell_'+j+'_'+i).length > 0){
// 					document.getElementById('cell_'+j+'_'+i).className = 'td_date';
// 				}
// 				if($('#cell_'+j).length > 0){
// 					document.getElementById('cell_'+j).className = 'td_date';
// 				}
// 			}
		}

		var diff = 0;
		var diff1 = 0;	// 줄바꿈 전까지의 colspan 크기
		/*일정 등록된 날짜에 제목 띄우기*/
		var rowPlace = [];
		for (i = 0; i < 32; i++) {
			rowPlace[i] = 1;
		}
		for(i=1; i<=lastDate.getDate(); i++){
			<c:forEach items="${calendarList}" var="item">
				if (today.getFullYear() == Number('${item.cl_sdate}'.substr(0, 4))
						&& today.getMonth() + 1 == Number('${item.cl_sdate}'.substr(5, 2))
						&& Number('${item.cl_sdate}'.substr(8, 2)) == Number(document.getElementById('cell_' + i + '_1').dataset.day)) {
					//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
					console.log('${item.cl_name}');
						var a =  "<div id='div_"+ i +"_1' class='div_cal' onclick='javascript:modal_div(event, ${item.cl_num});' style='background-color:${item.cl_color};'>" + "<span class='span_cal'><input type='hidden' name='cl_num' value='${item.cl_num}'>${item.cl_name}</span></div>";	// 2 주 일정의 앞에 일정
						var a1 = "<div id='div_"+ i +"'>" + "<span class='span_cal_day' onclick='javascript:modal_span(event, ${item.cl_num});'><div class='div_color' style='background-color:${item.cl_color};'></div>${item.cl_name}</span>" + "</div>";						// 당일
						var a2 = "<div id='div_"+ i +"_2' class='div_cal' onclick='javascript:modal_div(event, ${item.cl_num});' style='background-color:${item.cl_color};'>" + "<span class='span_cal'>${item.cl_name}</span></div>";	// 2 주 일정의 뒤에 일정 	
// 						var a2 = "<div id='div_"+ i +"_2' class='div_cal_2' style='background-color:${item.cl_color};'>" + "<span class='span_cal'>${item.cl_name}</span><img alt='image' src='${pageContext.request.contextPath}/calendar/img/second_date.png' class='date_img2'></div>";	// 2 주 일정의 뒤에 일정
						var a3 = "<div id='div_"+ i +"_2' class='div_cal' onclick='javascript:modal_div(event, ${item.cl_num});' style='background-color:${item.cl_color};'>" + "<span class='span_cal'>${item.cl_name}</span></div>"; // 1 주 안에 일정
						if ( ${item.cl_term} > 0 && rowPlace[i] < 7 && document.getElementById('cell_' + i + '_1').parentNode == document.getElementById('cell_' + (i+${item.cl_term}) + '_1').parentNode){
							document.getElementById('cell_' + i + '_' + rowPlace[i]).setAttribute("colspan", ${item.cl_term} + 1);
							document.getElementById('cell_' + i + '_' + rowPlace[i]).innerHTML = a;
							for(k=1; k <= ${item.cl_term}; k++){
//	 									$('#cell_' + (i+k) + '_1').remove();
								if(k>1 && rowPlace[i+k] != (rowPlace[i+k-1]-1)){
//	 								console.log(i+k+"// 앞과 뒤가 다를 때");
//	 								console.log("바뀌기 전"+rowPlace[i+k]);
									rowPlace[i+k] = (rowPlace[i+k-1]-1);
//	 								console.log("바뀌기 후"+rowPlace[i+k]);
									$('#cell_' + (i+k) + '_' + rowPlace[i+k]).css("display", "none");
									++rowPlace[i+k];
								} else {
//	 								console.log(i+k+"// 앞과 뒤가 같을 때");
									$('#cell_' + (i+k) + '_' + rowPlace[i+k]).css("display", "none");
									++rowPlace[i+k];
									}
								}
							++rowPlace[i];
						} else if(${item.cl_term} > 0 && rowPlace[i] < 7 && document.getElementById('cell_' + i + '_1').parentNode != document.getElementById('cell_' + (i+${item.cl_term}) + '_1').parentNode) {
							diff1 = 0;
							diff = 0;
							for(diff; diff <= ${item.cl_term}; diff++){
								if(document.getElementById('cell_' + i + '_1').parentNode == document.getElementById('cell_' + (i+ diff) + '_1').parentNode){
									++diff1;	// 줄바꿈 전까지의 colspan 크기
								}
							}
							document.getElementById('cell_' + i + '_' + rowPlace[i]).setAttribute("colspan", diff1);
							document.getElementById('cell_' + i + '_' + rowPlace[i]).innerHTML = a;
							
							for(k=1; k <= diff1-1; k++){
								$('#cell_' + (i+k) + '_' + rowPlace[i+k]).css("display", "none");
								++rowPlace[i+k];
							}
							// 줄바꿈 후의 colspan
							document.getElementById('cell_' + (i+diff1) + '_' + rowPlace[i]).setAttribute("colspan", (${item.cl_term}+1) - diff1);
							document.getElementById('cell_' + (i+diff1) + '_' + rowPlace[i]).innerHTML = a2;
							for(k=diff1 + 1; k <= ${item.cl_term}; k++){
								$('#cell_' + (i+k) + '_' + rowPlace[i+k]).css("display", "none");
								++rowPlace[i+k];	
							}
							++rowPlace[i];
							++rowPlace[i+diff1];
						} else if ( ${item.cl_term} == 0){
							document.getElementById('cell_' + i + '_' + rowPlace[i]).innerHTML = a1;
							++rowPlace[i];
						}
					}
				</c:forEach>
		}
	}
	$(document).ready(function() {
		$("#button1").click(function() {
			var submenu = $(this).next("#scroll");
			// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
			if (submenu.is(":visible")) {
				$('#img1').css({
					'transform' : 'rotate(0deg)'
				});
				submenu.slideUp("fast");
			} else {
				$('#img1').css({
					'transform' : 'rotate(90deg)'
				});
				submenu.slideDown("fast");
			}
		})
		// 달력 클릭 시 모달창 열기
		$("#calendar").on("click","td",function() {
			var td = $(this);
			var year = today.getFullYear();
			var month = today.getMonth() + 1;
			var day = td.context.dataset.day;
			if (month < 10) {
				month = "0" + month;
			}
			if (day < 10) {
				day = "0" + day;
			}
			$("input[type=date]").val(year + "-" + month + "-" + day);
			if(td.context.dataset.day>0){
				$('#Modal').show();
			}
		});
		
		$("#btn1").on("click", function() {
			$('#Modal').show();
		});
		//모달창 Close 기능
		$("#close_btn").unbind('click').on('click', function() {
			$('#Modal').hide();
		});
		//모달창 Close 기능
		$("#x_icon").unbind('click').on('click', function() {
			$('#Modal').hide();
		});//모달창 Close 기능
		$("#close_btn2").unbind('click').on('click', function() {
			$('#Modal2').hide();
		});
		//모달창 Close 기능
		$("#x_icon2").unbind('click').on('click', function() {
			$('#Modal2').hide();
		});
	});
	
	function modal_div(event, cl_num) {
		$.ajax({
			type: 'POST',
			url : _contextPath + "/calendar/calendarSelect",
			data : { 
				cl_num : cl_num
			},
			dataType : 'json',
			success : function(result) {
				var jsonResult = JSON.stringify(result);
				$('#modal_title').html(result[0].cl_name);
				$('#modal_sdate').html(result[0].cl_sdate);
				$('#modal_edate').html(result[0].cl_edate);
				$('#modal_content').html(result[0].cl_content);
				$('#modal_group').html(result[0].cl_groupname);
				event.stopPropagation();
				$('#Modal').hide();
				$('#Modal2').show();
			}  
	});
	}
	
	function modal_span(event, cl_num) {
		$.ajax({
			type: 'POST',
			url : _contextPath + "/calendar/calendarSelect",
			data : { 
				cl_num : cl_num
			},
			dataType : 'json',
			success : function(result) {
				var jsonResult = JSON.stringify(result);
				$('#modal_title').html(result[0].cl_name);
				$('#modal_sdate').html(result[0].cl_sdate);
				$('#modal_edate').html(result[0].cl_edate);
				$('#modal_content').html(result[0].cl_content);
				$('#modal_group').html(result[0].cl_groupname);
				event.stopPropagation();
				$('#Modal').hide();
				$('#Modal2').show();
			}  
	});
	}
// 	function modal_open(e){
// 		e.stopPropagation();
// 	}
	// div side 없애기
	function doShow() {
		if ($('#side').is(":visible")) {
			$('#side').hide();
			$('#content').css({
				"width" : "100%"
			});
			$('#img11').css({
				"display" : "none"
			});
			$('#img22').css({
				"display" : "inline"
			});
		} else {
			$('#side').show();
			$('#content').css({
				"width" : "84%"
			});
			$('#img11').css({
				"display" : "inline"
			});
			$('#img22').css({
				"display" : "none"
			});
		}
	}
	
	// li 만들기 (groupAdd)
	function doShow3() {
		if ($('#group').is(":visible")) {
			$('#group').fadeOut(150);
		} else {
			$('#group').fadeIn(150);
			$('#group').show();
		}
	}
</script>
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
				<c:forEach items="${calendarGroupList}" var="calendarGroupList">
					<li class="li"><input type="checkbox" name="check"
						id="chk_${calendarGroupList.cl_group}"><label
						for="chk_${calendarGroupList.cl_group}">${calendarGroupList.cl_groupname}</label><span
						class="span_color"
						style="background-color:${calendarGroupList.cl_color};"></span></li>
				</c:forEach>
				<li class="li"><span class="groupAdd"
					onclick="javascript:doShow3()">캘린더 그룹 추가</span></li>
				<li class="li" id="group">
					<form action="${pageContext.request.contextPath}/calendar/groupAdd">
						<sec:csrfInput />
						<div style="display: block; margin-bottom: 20px;">
							<input type="text" name="cl_groupname" placeholder="그룹 명"
								required="required" id="groupName"
								style="width: 150px; margin-right: 15px;"><input
								type="image"
								src="${pageContext.request.contextPath}/address/img/plus.png"
								name="Submit" value="Submit" id="groupAdd"> <img alt=""
								src="${pageContext.request.contextPath}/address/img/gear.png"
								width="19px" height="19px" style="margin-top: 2px;"
								class="groupAdd" id="groupSet">
						</div>
						<input type="hidden" name="cl_color" id="cl_color">
						<c:forEach items="${color_cal}" var="item">
							<span class="span_color2" id="color_${item.color_num}"
								style="cursor: pointer; background-color: ${item.color_name};"></span>

							<script type="text/javascript">
							$("#color_${item.color_num}").on("click", function() {
								$("#cl_color").val('${item.color_name}');
								$(".span_color2").css({"border" : "0px"});
								$("#color_${item.color_num}").css({"border" : "2px solid black"});
							});
							</script>
						</c:forEach>
					</form>
				</li>
			</ol>
		</div>
	</div>
	<div id="content" style="height: 1000px;">
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
		<table id="calendar" style="position: absolute;">
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
	<div id="Modal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<p>
				<span>일정등록 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					id="x_icon" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form"
				action="${pageContext.request.contextPath}/calendar/scheduleAdd">
				<table style="font-size: 17px;">
					<tr>
						<td>일정명</td>
						<td colspan="3"><input type="text" class="input"
							name="cl_name"></td>
					</tr>
					<tr>
						<td>일시</td>
						<td><input type="date" name="cl_sdate">&nbsp~ <input
							type="date" name="cl_edate"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3"><input type="text" class="input"
							name="cl_content"></td>
					</tr>
					<tr>
						<td>그룹</td>
						<td colspan="3">						
							<select name="cl_group">
								<c:forEach items="${calendarGroupList}" var="calendarGroupList">
									<option value="${calendarGroupList.cl_group}">${calendarGroupList.cl_groupname}</option>
								</c:forEach>
							</select></td>
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
	<!-- 	========================================================================================== -->
	<div id="Modal2" class="modal2">

		<!-- Modal content -->
		<div class="modal-content2">
			<p>
				<span>일정상세 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					id="x_icon2" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form" action="">
				<table style="font-size: 17px;">
					<tr>
						<td>제목</td>
						<td id="modal_title"></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>시작일</td>
						<td id="modal_sdate"></td>
						<td>종료일</td>
						<td id="modal_edate"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3" id="modal_content"></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>그룹</td>
						<td id="modal_group"></td>
						<td></td>
						<td></td>
					</tr>

				</table>
				<br>
				<div style="margin-left: 500px;">
					<input type="submit" value="확인" class="modal_btn"> <input
						type="button" value="취소" id="close_btn2" class="modal_btn" />

				</div>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>