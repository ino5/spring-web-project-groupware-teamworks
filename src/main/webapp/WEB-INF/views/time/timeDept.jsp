<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet"
	href="${pageContext.request.contextPath}/time/css/timeDept.css">
<script src="${pageContext.request.contextPath}/time/js/time.js"></script>
<title>Insert title here</title>
</head>
<style>
.test {
	width: 200px;
	height: 200px;
	background: gray;
}
</style>
<script type="text/javascript">
	// div side 시간 띄우기
	var global_now;
	var global_date;
	var global_nowTime;
	function printTime() {
		var now = new Date(); // 현재시간
		var month = ("0" + (now.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
		var day2 = ("0" + now.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
		var hour = ("0" + now.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
		var minute = ("0" + now.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
		var second = ("0" + now.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

		var nowMonth = now.getFullYear() + "." + month;
		var nowDate = now.getFullYear() + "-" + month + "-" + day2;
		var nowTime = hour + ":" + minute + ":" + second;
		global_now = nowDate + " " + nowTime;
		global_date = now.getFullYear() + "-" + month + "-" + day2;
		global_nowTime = nowTime;
		clock1.innerHTML = nowDate; // 현재시간을 출력
		clock2.innerHTML = nowTime;
		setTimeout("printTime()", 1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}
	window.onload = function() { // 페이지가 로딩되면 실행
		printTime();
	}
	
	var start_text;
	var HHH;
	var MMM;
	var SSS;
	
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
						start_text = new Date(global_now);
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
				var end_text = new Date(global_now);
				var end_start = end_text - start_text;
				HHH = Math.floor((end_start % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				MMM = Math.floor((end_start % (1000 * 60 * 60)) / (1000 * 60));				
				SSS = Math.floor((end_start % (1000 * 60)) / 1000);		
				document.getElementById('endTime').innerHTML = global_nowTime;
				document.getElementById('btn2').style.color = '#CFCFCF';
				document.getElementById('btn2').style.pointerEvents = 'none';
			}
		});
		
		
	}
	
	//	==============================================================================================
		
	// 일주일 씩 끊어서 보여주기
	var day = new Date();
	day.setDate(day.getDate() - day.getDay());

	function week_calandar(week) {
		day.setDate(day.getDate() + week * 7);
		var title = day.getFullYear() + "-" + ("0" + (day.getMonth() + 1)).slice(-2);
		var data = "";
		for (var i = 0; i < 7; i++) {
			data += "<td id='"+ day.getFullYear() + "-" + ("0" + (day.getMonth() + 1)).slice(-2) + "-" + ("0" + day.getDate()).slice(-2) + "'>" + day.getDate() + "</td>";
			if (day.getDate() == 1)
				title += " ~ " + day.getFullYear() + "-" + ("0" + (day.getMonth() + 1)).slice(-2);
			day.setDate(day.getDate() + 1);
		}
		day.setDate(day.getDate() - 7);
		document.getElementById("calendar").innerHTML = "<tr id='td_find' style='font-weight:bold;'><td>이름</td><td>누적 근무시간</td>"
				+ data + "</tr>";
		document.getElementById("title").innerHTML = title;
		
		// 초기화
		$('.td_span1').html("-");
		$('.td_span2').html("0h 0m 0s");
		$('.add_time').html("0h 0m 0s");
		$('.hidden_value').val("");
			

	    var tr = $('#td_find');
    	var td = tr.children();
		<c:forEach var="time" items="${listDeptGroupTime }">
	    	var td2 = $("#${time.m_id}").children();
	    	for(tr_i = 0; tr_i < td.length; tr_i++){
	    		if(td.eq(tr_i).attr('id') == '${time.tm_edate_date}'){
	    			if(("#${time.m_id}").length > 0){
	    				var time1 = new Date("${time.tm_sdate}");  // 시작시간
	    				var time2 = new Date("${time.tm_edate}");  // 종료시간
	    				var time3 = time2 - time1;				  // 간격
	    				HHH = Math.floor((time3 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
	    				MMM = Math.floor((time3 % (1000 * 60 * 60)) / (1000 * 60));				// 분
	    				SSS = Math.floor((time3 % (1000 * 60)) / 1000);							// 초
	    				var work_time = HHH +"h "+ MMM+"m "+ SSS +"s";	
	    				td2.eq(tr_i).html("<input type='hidden' value='"+ time3 +"' id='${time.m_id}_" + tr_i + "' class='hidden_value'><span class='td_span1'>${time.tm_sdate_time} ~ ${time.tm_edate_time}</span><span class='td_span2'>" + work_time + "</span>");
	    			}
	    		}
	    	}
		</c:forEach>
		
		var time5 = 0;
		var work_time2 ="";
		<c:forEach var="time2" items="${listDeptGroupTime }">
		var td3 = $('#${time2.m_id}').children();
		time5 = 0;
		for(i=2; i<8; i++){
			if(Number($('#${time2.m_id}_'+i).val()) > 0){
			   time5 += Number($('#${time2.m_id}_'+i).val());
			}
		}
		HHH = Math.floor((time5 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
		MMM = Math.floor((time5 % (1000 * 60 * 60)) / (1000 * 60));				// 분
		SSS = Math.floor((time5 % (1000 * 60)) / 1000);							// 초
		work_time2 = HHH +"h "+ MMM+"m "+ SSS +"s";	
		td3.eq(1).html("<span class='add_time'>"+work_time2+"</span>");
		</c:forEach>
	}

	function set_day() {
		day = new Date();
		day.setDate(day.getDate() - day.getDay());

		week_calandar(0);
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
				id="week_clock" class="clock4">0h 0m 0s</span>
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
				<li class="li"><a
					href="${pageContext.request.contextPath}/time">내 근태 현황</a></li>
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
					style="width: 16px; height: 12px;" id="img2"></span> 부서 근태관리</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="listDeptGroup" items="${listDeptGroup }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/time/timeDept?dpt_code=${listDeptGroup.dpt_code}">${listDeptGroup.dpt_name}</a></li>
				</c:forEach>
			</ol>
		</div>

	</div>
	<div id="content" style="height: 1000px;">
		<p id="content1" style="font-weight: bold;">근태현황</p>
		<div id="calendar_head">
			<!-- label은 마우스로 클릭을 편하게 해줌 -->
			<label onclick="week_calandar(-1)"
				style="padding-right: 20px; float: left;"><</label>
			<h4 id="title" style="width: 240px; float: left; text-align: center;"></h4>
			<label onclick="week_calandar(1)" style="padding-left: 20px;">>
			</label> <span onclick="set_day()"
				style="font-size: 18px; cursor: pointer; font-weight: normal;">오늘
			</span>
		</div>
		<table id="calendar">
		</table>
		<table id="calendar_member">
			<c:forEach var="member" items="${listDeptGroupMember }">
				<tr id="${member.m_id}" style="height: 100px;">
					<td>
					<img style="width: 40px; height: 40px; border-radius: 70%; margin-top: 10px;" src="${pageContext.request.contextPath}/resource/member/photo/${member.m_id}.jpg" onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'"/>
					<span style="font-size: 18px; font-weight: bold;">${member.m_name } </span>
					<span class="td_span" style="font-size: 18px; font-weight: bold;">${member.pt_name }</span>
						<p style="color: #888; font-size: 14px; padding-left: 70px;">${member.dpt_name }</p></td>

					<td><span class='add_time'>0h 0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
					<td><span class='td_span1'>-</span><span class="td_span2">0h
							0m 0s</span></td>
				</tr>

			</c:forEach>
		</table>
		<div id="pg">
				<c:if test="${pg.startPage > pg.pageBlock }">
					<a href="timeDept?dpt_code=${dpt_code}&currentPage=${pg.startPage-pg.pageBlock}">[이전]</a>
				</c:if>
				<c:if test="${pg.total > 20}">
					<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
						<a href="timeDept?dpt_code=${dpt_code}&currentPage=${i}">[${i}]</a>
					</c:forEach>
				</c:if>
				<c:if test="${pg.endPage < pg.totalPage }">
					<a href="timeDept?dpt_code=${dpt_code}&currentPage=${pg.startPage+pg.pageBlock}">[다음]</a>
				</c:if>
			</div>
		<script type="text/javascript">
			set_day();
		</script>
	</div>
</body>
</html>