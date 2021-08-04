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
		month1.innerHTML = nowMonth;
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
		// 1일이 시작되는 칸을 맞추어 줌
		for (i = 0; i < doMonth.getDay(); i++) {
			/*이번달의 day만큼 돌림*/
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		}
		/*달력 출력*/
		for (i = 1; i <= lastDate.getDate(); i++) {
			//1일부터 마지막 일까지 돌림
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cell.innerHTML = "<span id='date'>"+i+"</span>";//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
			cell.dataset.day = i;
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
			if (cnt % 7 == 1) {/*일요일 계산*/
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<font color=red>";
				cell.innerHTML = "<span id='date2'>" +i+"</span>";
				//1번째의 cell에만 색칠
			}
			if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
				//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
				cell.innerHTML = "<font color=blue>";
				cell.innerHTML = "<span id='date3'>" +i+"</span>";
				//7번째의 cell에만 색칠
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
			}
			/*오늘의 날짜에 노란색 칠하기*/
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			}
			/*일정 등록된 날짜에 제목 띄우기*/
			<c:forEach items="${calendarList}" var="item">
			if (today.getFullYear() == Number('${item.cl_sdate}'.substr(0, 4))
					&& today.getMonth() + 1 == Number('${item.cl_sdate}'.substr(5, 2))
					&& i >= Number('${item.cl_sdate}'.substr(8, 2))
					&& Number('${item.cl_edate}'.substr(8, 2)) >= i) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				var a = "<div class='div1'>" + '${item.cl_name}' + "</div>";
				cell.innerHTML = cell.innerHTML + a;
			}
			</c:forEach>
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
		<br>
	</div>
	<%@include file="/WEB-INF/views/header/headerFooter.jsp"%>
</body>
</html>