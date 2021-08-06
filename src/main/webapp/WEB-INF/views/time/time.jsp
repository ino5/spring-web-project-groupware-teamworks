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
	var global_date;
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
		global_date = now.getFullYear() + "-" + month + "-" + day;
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
						document.getElementById(global_date).rows[0].insertCell(-1).innerText=global_nowTime;
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
				document.getElementById(global_date).rows[0].insertCell(-1).innerText=global_nowTime;
				document.getElementById(global_date).rows[0].insertCell(-1).innerText= HHH + "h " + MMM + "m " + SSS + "s";
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
			$('#calendar').append("<div id='week_"+ row_num + "' class='div_week'><img id='week_img" + row_num + "' class='week_img' src='${pageContext.request.contextPath}/time/img/down.png' onclick='javascript:dayShow("+ row_num + ")'> &nbsp&nbsp&nbsp" + row_num + "주차<span id='week_time" + row_num + "' class='week_time'></span></div>");
			row_num++;
		}
		for(i=1; i<=row_num; i++){
			$('#week_'+i).append("<table class = 'day_"+ i + "' id='tb_title'><tr><td>일자</td><td>업무시작</td><td>업무종료</td><td>총근무시간</td></tr></table>");
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
			else if(cnt + i <= 42){
				$('#week_6').append("<table id = '"+today.getFullYear() + "-" + m + "-" + i + "' class='day_6'><tr><td>" + i + "일</td></tr></table>");
			}
		}
		var time1;
		var time2;
		var time3;
// 		var work_time_All = 0;
		var work_time;
		var work_day;
			<c:forEach items="${timeList_sdate}" var="start">
			$('#${start.tm_sdate_date } > tbody > tr:last').append('<td>${start.tm_sdate_time}</td>'); 
			</c:forEach>
			<c:forEach items="${timeList_edate}" var="end">
				time1 = new Date("${end.tm_sdate}");  // 시작시간
				time2 = new Date("${end.tm_edate}");  // 종료시간
				time3 = time2 - time1;				  // 간격
				HHH = Math.floor((time3 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
				MMM = Math.floor((time3 % (1000 * 60 * 60)) / (1000 * 60));				// 분
				SSS = Math.floor((time3 % (1000 * 60)) / 1000);							// 초
				work_time = HHH +"h "+ MMM+"m "+ SSS +"s";								// 총 근무시간
				work_day = Number(${end.tm_edate_day });
				$('#${end.tm_edate_date } > tbody > tr:last').append('<td>${end.tm_edate_time}</td>'); 
				$('#${end.tm_edate_date } > tbody > tr:last').append("<td><input type='hidden' id='"+ work_day +"' value='"+ time3 +"'>" + work_time + "</td>"); 
			</c:forEach>		
			 
			
			// 주간 누적 근무시간 구하기
			var week_time1;
			var week_time2;
			var week_time3;
			var week_time4;
			var week_time5;
			var week_time6;
			var work_week_val1 = 0;
			var work_week_val2 = 0;
			var work_week_val3 = 0;
			var work_week_val4 = 0;
			var work_week_val5 = 0;
			var work_week_val6 = 0;
			
			var cnt2 = 0;
			
			cnt2 = cnt + 1;
			for(cnt2; cnt2 <= 7; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val1 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val1 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val1 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val1 % (1000 * 60)) / 1000);							// 초
			week_time1 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time1').text("누적 근무시간 " + week_time1);
			
			for(cnt2 = 7; cnt2 <= 14; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val2 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val2 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val2 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val2 % (1000 * 60)) / 1000);							// 초
			week_time2 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time2').text("누적 근무시간 " + week_time2);
			
			for(cnt2 = 14; cnt2 <= 21; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val3 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val3 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val3 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val3 % (1000 * 60)) / 1000);							// 초
			week_time3 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time3').text("누적 근무시간 " + week_time3);
			
			for(cnt2 = 21; cnt2 <= 28; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val4 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val4 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val4 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val4 % (1000 * 60)) / 1000);							// 초
			week_time4 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time4').text("누적 근무시간 " + week_time4);
			
			for(cnt2= 28; cnt2 <= 35; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val5 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val5 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val5 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val5 % (1000 * 60)) / 1000);							// 초
			week_time5 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time5').text("누적 근무시간 " + week_time5);
			
			for(cnt2=35; cnt2 <= 42; cnt2++){
			    if($('#'+cnt2).length > 0){
			    	work_week_val6 += Number($('#'+cnt2).val());
			    }
			}
			HHH = Math.floor((work_week_val6 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val6 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val6 % (1000 * 60)) / 1000);							// 초
			week_time6 = HHH + "h " + MMM + "m " + SSS + "s"
			$('#week_time6').text("누적 근무시간 " + week_time6);
			
			// 이번 달 누적
			var work_week_val_month = work_week_val1 + work_week_val2 + work_week_val3 + work_week_val4 + work_week_val5 + work_week_val6;
			
			HHH = Math.floor((work_week_val_month % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((work_week_val_month % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((work_week_val_month % (1000 * 60)) / 1000);							// 초
			var week_time_month = HHH + "h " + MMM + "m " + SSS + "s"			
			$('#div_p2_month').text(week_time_month);
			
			var week_remain1 = 144000000 - work_week_val1;
			var week_remain2 = 144000000 - work_week_val2;
			var week_remain3 = 144000000 - work_week_val3;
			var week_remain4 = 144000000 - work_week_val4;
			var week_remain5 = 144000000 - work_week_val5;
			var week_remain6 = 144000000 - work_week_val6;
			
			var week_over1 = work_week_val1 - 144000000;
			var week_over2 = work_week_val2 - 144000000;
			var week_over3 = work_week_val3 - 144000000;
			var week_over4 = work_week_val4 - 144000000;
			var week_over5 = work_week_val5 - 144000000;
			var week_over6 = work_week_val6 - 144000000;
			
			HHH = Math.floor((week_over1 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over1 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over1 % (1000 * 60)) / 1000);							// 초
			var week_time_over1 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_over2 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over2 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over2 % (1000 * 60)) / 1000);							// 초
			var week_time_over2 = HHH + "h " + MMM + "m " + SSS + "s";
			
			
			HHH = Math.floor((week_over3 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over3 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over3 % (1000 * 60)) / 1000);							// 초
			var week_time_over3 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_over4 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over4 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over4 % (1000 * 60)) / 1000);							// 초
			var week_time_over4 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_over5 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over5 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over5 % (1000 * 60)) / 1000);							// 초
			var week_time_over5 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_over6 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_over6 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_over6 % (1000 * 60)) / 1000);							// 초
			var week_time_over6 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_remain1 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시 
			MMM = Math.floor((week_remain1 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain1 % (1000 * 60)) / 1000);							// 초
			var week_time_remain1 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_remain2 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((week_remain2 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain2 % (1000 * 60)) / 1000);							// 초
			var week_time_remain2 = HHH + "h " + MMM + "m " + SSS + "s";

			HHH = Math.floor((week_remain3 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((week_remain3 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain3 % (1000 * 60)) / 1000);							// 초
			var week_time_remain3 = HHH + "h " + MMM + "m " + SSS + "s";

			HHH = Math.floor((week_remain4 % (1000 * 60 * 60 * 100)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((week_remain4 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain4 % (1000 * 60)) / 1000);							// 초
			var week_time_remain4 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_remain5 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((week_remain5 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain5 % (1000 * 60)) / 1000);							// 초
			var week_time_remain5 = HHH + "h " + MMM + "m " + SSS + "s";
			
			HHH = Math.floor((week_remain6 % (1000 * 60 * 60 * 1000)) / (1000 * 60 * 60));	// 시
			MMM = Math.floor((week_remain6 % (1000 * 60 * 60)) / (1000 * 60));				// 분
			SSS = Math.floor((week_remain6 % (1000 * 60)) / 1000);							// 초
			var week_time_remain6 = HHH + "h " + MMM + "m " + SSS + "s";
			
			// 현재 날짜 테이블 펼치기
			if(today.getDate() + cnt <= 7){
				$('.day_1').css('display', 'table');
				$('#week_img1').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time1);
				$('#div_p2_week').text(week_time1);
				if(week_remain1 > 0) {
					$('#div_p2_remain').text(week_time_remain1);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				
				if(week_over1 > 0) {
					$('#div_p2_over').text(week_time_over1);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			} else if(today.getDate() + cnt <= 14){
				$('.day_2').css('display', 'table');
				$('#week_img2').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time2);
				$('#div_p2_week').text(week_time2);
				if(week_remain2 > 0) {
					$('#div_p2_remain').text(week_time_remain2);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				if(week_over2 > 0) {
					$('#div_p2_over').text(week_time_over2);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			} else if(today.getDate() + cnt <= 21){
				$('.day_3').css('display', 'table');
				$('#week_img3').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time3);
				$('#div_p2_week').text(week_time3);
				if(week_remain3 > 0) {
					$('#div_p2_remain').text(week_time_remain3);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				if(week_over3 > 0) {
					$('#div_p2_over').text(week_time_over3);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			} else if(today.getDate() + cnt <= 28){
				$('.day_4').css('display', 'table');
				$('#week_img4').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time4);
				$('#div_p2_week').text(week_time4);
				if(week_remain4 > 0) {
					$('#div_p2_remain').text(week_time_remain4);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				if(week_over4 > 0) {
					$('#div_p2_over').text(week_time_over4);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			} else if(today.getDate() + cnt <= 35){
				$('.day_5').css('display', 'table');
				$('#week_img5').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time5);
				$('#div_p2_week').text(week_time5);
				if(week_remain5 > 0) {
					$('#div_p2_remain').text(week_time_remain5);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				if(week_over5 > 0) {
					$('#div_p2_over').text(week_time_over5);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			} else if(today.getDate() + cnt <= 42){
				$('.day_6').css('display', 'table');
				$('#week_img6').css({
					'transform' : 'rotate(180deg)'
				});
				$('#week_clock').text(week_time6);
				$('#div_p2_week').text(week_time6);
				if(week_remain6 > 0) {
					$('#div_p2_remain').text(week_time_remain6);
				}else {
					$('#div_p2_remain').text("0h 0m 0s");
				}
				if(week_over6 > 0) {
					$('#div_p2_over').text(week_time_over6);
				}else {
					$('#div_p2_over').text("0h 0m 0s");
				}
			}
			
    }
	
	
	function dayShow(i) {
		if ($('.day_' + i).is(":visible")) {
			$('#week_img' + i).css({
				'transform' : 'rotate(0deg)'
			});
			$('.day_' + i).hide();
		} else {
			$('#week_img' + i).css({
				'transform' : 'rotate(180deg)'
			});
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
		<p style="margin-left: 30px; font-size: 18px">(기본근태) B형 자유출퇴근</p>
		<div style="width: 95%; height: 150px; border: 1px solid #E7E7E7; margin-left: 30px; margin-top: 30px;">
			<div class="div_head">
				<p class="div_p1">이번주 누적</p>
				<p id="div_p2_week" class="div_p2">0h 0m 0s</p>
			</div>
			<div class="div_head">
				<p class="div_p1">이번주 초과</p>
				<p id="div_p2_over" class="div_p2">0h 0m 0s</p>
			</div>
			<div class="div_head">
				<p class="div_p1">이번주 잔여</p>
				<p id="div_p2_remain" class="div_p2">40h 0m 0s</p>
			</div>
			<div class="div_head">
				<p class="div_p1">이번달 누적</p>
				<p id="div_p2_month" class="div_p2">0h 0m 0s</p>
			</div>
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