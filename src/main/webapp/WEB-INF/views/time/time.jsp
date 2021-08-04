<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet"
	href="${pageContext.request.contextPath}/time/css/time.css">
<script src="${pageContext.request.contextPath}/time/js/time.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
	var global_now;
	var global_nowTime;
	function printTime() {
		var now = new Date(); // 현재시간
		var month = ("0" + (now.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
		var day = ("0" + now.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
		var hour = ("0" + now.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
		var minute = ("0" + now.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
		var second = ("0" + now.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

		var nowMonth = now.getFullYear() + "." + month;
		var nowDate = now.getFullYear() + "-" + month + "-" + day;
		var nowTime = hour + ":" + minute + ":" + second;
		global_now = nowDate + " " + nowTime;
		global_nowTime = nowTime;
		clock1.innerHTML = nowDate; // 현재시간을 출력
		clock2.innerHTML = nowTime;
		setTimeout("printTime()", 1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}
	window.onload = function() { // 페이지가 로딩되면 실행
		printTime();
	}

	function start() {

		$
				.ajax({
					type : 'POST',
					url : _contextPath + "/time/startTime",
					data : {
						tm_sdate : global_now
					},
					success : function(result) {
						// 				debugger;
						document.getElementById('startTime').innerHTML = global_nowTime;
						document.getElementById('btn1').style.color = '#CFCFCF';
						document.getElementById('btn1').style.pointerEvents = 'none';
					}
				});
	}

	function end() {

		$.ajax({
			type : 'POST',
			url : _contextPath + "/time/endTime",
			data : {
				tm_sdate : global_now
			},
			success : function(result) {
				// 				debugger;
				document.getElementById('endTime').innerHTML = global_nowTime;
				document.getElementById('btn2').style.color = '#CFCFCF';
				document.getElementById('btn2').style.pointerEvents = 'none';
			}
		});
	}

	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date();//today의 Date를 세어주는 역할
	function prevCalendar() {//이전 달
	// 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
	//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
	//getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		$('#calendar').html("");
		buildCalendar(); //달력 cell 만들어 출력 
	}
	function nextCalendar() {//다음 달
		// 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		$('#calendar').html("");
		buildCalendar();//달력 cell 만들어 출력
	}
    function buildCalendar(){//현재 달 달력 만들기
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
// 		var tbCalendar = document.getElementById("calendar");
		//날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
// 		var tbCalendarYM = document.getElementById("tbCalendarYM");
		//테이블에 정확한 날짜 찍는 변수
		//innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
		//new를 찍지 않아서 month는 +1을 더해줘야 한다. 
		if (today.getMonth() < 9) {
			$('#tbCalendarYM').html(today.getFullYear() + ".0"
					+ (today.getMonth() + 1));
		} else {
			$('#tbCalendarYM').html(today.getFullYear() + "."
					+ (today.getMonth() + 1));
		}
        var cnt = 0;// count, 셀의 갯수를 세어주는 역할
        // 1일이 시작되는 칸을 맞추어 줌
         for (i=0; i<doMonth.getDay(); i++) {
         /*이번달의 day만큼 돌림*/
              cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
         }
		var row_num = 1;
		var m = (today.getMonth() + 1 > 9 ? today.getMonth() + 1 : '0'+ Number(today.getMonth() + 1));
		for (i=1; i<=(lastDate.getDate()+cnt) /7 + 1; i++){
			$('#calendar').append("<div id='week_"+ row_num + "' class='div_week'><img id='week_img" + row_num + "' class='week_img' src='${pageContext.request.contextPath}/time/img/down.png' onclick='javascript:dayShow("+ row_num + ")'> &nbsp&nbsp&nbsp" + row_num + "주차</div>");
			row_num++;
		}
		for(i=1; i<=row_num; i++){
			$('#week_'+i).append("<table class = 'day_"+ i + "' class='tb_title'><tr><td>일자</td><td>업무시작</td><td>업무종료</td><td>총근무시간</td></tr></table>");
		}
		for(i=1; i<=lastDate.getDate(); i++){
			if(cnt + i <= 7){
				$('#week_1').append("<table id = '"+today.getFullYear() + "-" + m + "-" + "0" + i + "' class='day_1'><tr><td>" + i + "일</td></tr></table>");
			}
			else if(cnt + i <= 14){
				if(i < 10){
					$('#week_2').append("<table id = '"+today.getFullYear() + "-" + m + "-" + "0" + i + "' class='day_2'><tr><td>" + i + "일</td></tr></table>");
				}
				else {
					$('#week_2').append("<table id = '"+today.getFullYear() + "-" + m + "-" + i + "' class='day_2'><tr><td>" + i + "일</td></tr></table>");
				}
			}
			else if(cnt + i <= 21){
				$('#week_3').append("<table id = '"+today.getFullYear() + "-" + m + "-" + i + "' class='day_3'><tr><td>" + i + "일</td></tr></table>");
			}
			else if(cnt + i <= 28){
				$('#week_4').append("<table id = '"+today.getFullYear() + "-" + m + "-" + i + "' class='day_4'><tr><td>" + i + "일</td></tr></table>");
			}
			else if(cnt + i <= 35){
				$('#week_5').append("<table id = '"+today.getFullYear() + "-" + m + "-" + i + "' class='day_5'><tr><td>" + i + "일</td></tr></table>");
			}
		}
			<c:forEach items="${timeList_sdate}" var="start">
			$('#${start.tm_sdate } > tbody > tr:last').append('<td>${start.tm_sdate_time}</td>'); 
			</c:forEach>
			<c:forEach items="${timeList_edate}" var="end">
			$('#${end.tm_edate } > tbody > tr:last').append('<td>${end.tm_edate_time}</td>'); 
			</c:forEach>


    }
	
	
	function dayShow(i) {
		if ($('.day_' + i).is(":visible")) {
			$('.day_' + i).hide();
		} else {
			$('.day_' + i).show();
		}
	}
</script>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<section id="clock">
			<span id="clock1"></span> <br> <span id="clock2"></span>
		</section>
		<section style="margin-bottom: 5px;">
			<span class="clock3">출근시간</span> <span class="clock4" id="startTime">
				<c:if test="${mainTime == null}">
				미등록
			</c:if> <c:if test="${mainTime.tm_sdate != null}">
				${mainTime.tm_sdate}
			</c:if>
			</span> <br> <span class="clock3">퇴근시간</span> <span class="clock4"
				id="endTime"> <c:if test="${mainTime.tm_edate == null}">
				미등록
			</c:if> <c:if test="${mainTime.tm_edate != null}">
				${mainTime.tm_edate}
			</c:if>
			</span> <br> <span class="clock3">주간 누적 근무시간</span> <span
				class="clock4">0h 29m 0s</span>
		</section>
		<section style="margin-left: 20px;">
			<hr
				style="border: none; border: 1px dashed #BDBDBD; margin-bottom: 20px;">
		</section>
		<div>
			<c:if test="${mainTime == null}">
				<button type="button" id="btn1" class="btn1"
					onclick="javascript:start()">출근하기</button>
			</c:if>
			<c:if test="${mainTime.tm_sdate != null}">
				<button type="button" class="btn3">출근하기</button>
			</c:if>
			<c:if test="${mainTime.tm_edate == null}">
				<button type="button" id="btn2" class="btn1"
					onclick="javascript:end()">퇴근하기</button>
			</c:if>
			<c:if test="${mainTime.tm_edate != null}">
				<button type="button" class="btn3">퇴근하기</button>
			</c:if>
			<button type="button" id="btn3" class="btn2">업무종료</button>
		</div>
		<div style="margin-top: 50px;">
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/time/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/time/img/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 근태관리</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li">내 근태 현황</li>
				<li class="li">내 연차 내역</li>
				<li class="li">내 인사정보</li>
			</ol>
		</div>
		<div id="div2">
			<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/time/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/time/img/white.png"
					style="width: 16px; height: 12px;" id="img2"></span> 전사 근태관리</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li">전사 근태현황</li>
				<li class="li">전사 근태통계</li>
				<li class="li">전사 인사정보</li>
				<li class="li">전사 연차현황</li>
				<li class="li">전사 연차 사용내역</li>
			</ol>
		</div>

	</div>
	<div id="content" style="height: 1000px;">
		<p id="content1">근태현황</p>
		<div id="calendar_head">
			<!-- label은 마우스로 클릭을 편하게 해줌 -->
			<label onclick="prevCalendar()" style="padding-right: 20px;"><</label>
			<a align="center" id="tbCalendarYM" style="padding-right: 20px;">yyyy년
				m월</a> <label onclick="nextCalendar()">> </label>
		</div>
		<div id="calendar" style="position: absolute;"></div>
		<script type="text/javascript">
			buildCalendar();
		</script>
		<br>

	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>