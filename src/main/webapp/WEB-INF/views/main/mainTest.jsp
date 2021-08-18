<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<script src="${pageContext.request.contextPath}/main/js/main.js"></script>
<link rel="styleSheet" href="${pageContext.request.contextPath}/main/css/mainTest.css">
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
						var a = "<div id='div_"+ i +"_1' class='div_cal'>" + "<span class='span_cal'>${item.cl_name}</span>" + "</div>";
						var a1 = "<div id='div_"+ i +"'>" + "<span class='span_cal'>${item.cl_name}</span>" + "</div>";
						var a2 = "<div id='div_"+ i +"_2' class='div_cal'>" + "<span class='span_cal'>${item.cl_name}</span>" + "</div>";
					if ( ${item.cl_term} > 0 && rowPlace[i] < 7 && document.getElementById('cell_' + i + '_1').parentNode == document.getElementById('cell_' + (i+${item.cl_term}) + '_1').parentNode){
						document.getElementById('cell_' + i + '_' + rowPlace[i]).setAttribute("colspan", ${item.cl_term} + 1);
						document.getElementById('cell_' + i + '_' + rowPlace[i]).innerHTML = a;
						for(k=1; k <= ${item.cl_term}; k++){
// 									$('#cell_' + (i+k) + '_1').remove();
							if(k>1 && rowPlace[i+k] != (rowPlace[i+k-1]-1)){
// 								console.log(i+k+"// 앞과 뒤가 다를 때");
// 								console.log("바뀌기 전"+rowPlace[i+k]);
								rowPlace[i+k] = (rowPlace[i+k-1]-1);
// 								console.log("바뀌기 후"+rowPlace[i+k]);
								$('#cell_' + (i+k) + '_' + rowPlace[i+k]).css("display", "none");
								++rowPlace[i+k];
							} else {
// 								console.log(i+k+"// 앞과 뒤가 같을 때");
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
</script>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
<div id="side">
		<div id="myInfo">
			<div id="img">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.username" var="sec_m_id" />
				<img id="img" src="${pageContext.request.contextPath}/resource/member/photo/${sec_m_id}.jpg" onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'" style="width: 50px; height: 50px"/>			
			</sec:authorize>
			</div>
			<div id="text">
					<div style="font-size: 15px;">안녕하세요!</div>
					<b style="font-size: 25px;">${m_name } ${pt_name }님</b> <br>
					<a style="text-decoration: none; color:black; font-size: " href="${pageContext.request.contextPath}/login/simpleMyProfile">내 프로파일>></a>
		 	</div>
 		</div>
 		<br>
 		<hr style="border-top: 3px dotted black; margin-left: 15px">
	<div id = "write2">
		<!-- 결재작성 -->
		<div class="write_button1"><button type="button" id="button_new_sign"><img alt="결재작성.png" src="main/img/결재작성.png" style="width: 100px; height: 100px"><br>
		<b style="margin-right: 13px;">결재작성</b></button></div>
	
		<!-- 새 결제 진행 모달창 -->
		<div id="modal_wrap_new_sign" class="modal_wrap">
			<button type="button" id="modal_close_new_sign" class="button_x"><span class="ic_gnb_x"></button>
			<h1>결재양식 선택</h1>
			<div class="modal_content">
				<form id="form_new_sign" action="${pageContext.request.contextPath}/sign/form" method="post" enctype="multipart/form-data">
					<sec:csrfInput/>
					<input type="hidden" name="sgf_id" value="">
					<div id="sign_form_list">
					</div>
				</form>
			</div>
		</div>
		
		<!-- 게시판작성 -->
		<div class="write_button2"><button type="button" id="btn1" onclick="location.href='${pageContext.request.contextPath}/board/write'"><img alt="게시판작성.png" src="main/img/게시판작성.png" style="width: 100px; height: 100px"><br>
		<b>게시판 작성</b></button></div>
	</div>
		<!-- 캘린더 -->
		<div class="calendar">
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
		</div>
		<script type="text/javascript">
			buildCalendar();
		</script>	
</div>
<div id="content">
	
	<div class="set1">
		<div class="box1">
			<div class="box1_1">
				<div class="text"><b>근태관리</b></div>
				<div class="img"><img alt="근태.png" src="main/img/출근.png"> </div>
			</div>
			<div class="box1_2">
				<!-- 시간 + 근태 -->
				<div id="clock">
					<span id="clock1"></span><br><span id="clock2"></span>
				</div>
				<div style="margin-bottom: 5px;">
					<span class="clock3">출근시간</span> <span class="clock4" id="startTime">
						<c:if test="${mainTime == null}">
						미등록
					</c:if> <c:if test="${mainTime.tm_sdate != null}">
						${mainTime.tm_sdate}
					</c:if>	</span> <br>
					<span class="clock3">퇴근시간</span> <span class="clock4"
						id="endTime"> <c:if test="${mainTime.tm_edate == null}">
						미등록
					</c:if> <c:if test="${mainTime.tm_edate != null}">
						${mainTime.tm_edate}
					</c:if>
					</span> 
				</div>
			</div>
		</div>
		<!-- 게시판 -->
		<div class="box2">
			<div class="box2_1">
				<table id="list_table">
					<tr>
						<td></td>
						<td colspan="3" rowspan="1" style="width: 550px; font-size: 25px; padding-top: 15px"><img alt="바람개비.png" src="main/img/바람개비.png" width="25px" height="25px">&nbsp;&nbsp;&nbsp;<b>게시판</b></td>
					</tr>
					<tr style="height: 10px"></tr>
					<c:forEach var="ps" items="${listPost}" begin="0" end="3">				
							<tr style="width: 550px">
								<td style="height: 40px; width: 50px; text-align: center">*</td>
								<td style="width: 200px"><a style="text-decoration: none; color: black" href='${pageContext.request.contextPath}/board/view?p_num=${ps.p_num}'>${ps.p_name}</a></td>
								<td style="width: 150px; text-align: center">${ps.m_name}${ps.pt_name}</td>
								<td style="width: 150px; text-align: center"><fmt:formatDate value="${ps.p_regdate}" pattern="yyyy/MM/dd"/></td>	
							</tr>
					</c:forEach>
				</table>
			</div>
			<div class="box2_2">
				<img alt="게시판.png" src="main/img/게시판3.png"> 
			</div>
		</div>
		<!-- 드라이브 -->
		<div class="box3">
			<div class="box3_1">
						<table>
								<tr>
									<td colspan="4" rowspan="1" style="width: 550px; font-size: 25px; padding-top: 15px; padding-left: 50px"><img alt="바람개비.png" src="main/img/바람개비.png" width="25px" height="25px">&nbsp;&nbsp;&nbsp;<b>드라이브</b></td>
								</tr>
								<tr style="height: 10px"></tr>		
							<c:forEach var= "driveFileInfo" items="${driveFileInfoListOfEnterprise}" begin="0" end="3">
								<tr id="row_dv_id_${driveFileInfo.dv_id}" style="width: 550px">									
									<td style="height: 40px; width: 150px; text-align: center">
										<fmt:formatDate value="${driveFileInfo.dv_regdate}" pattern="yyyy/MM/dd"/>
									</td>		
									<td style="width: 200px">
										<c:choose>
		                                 <c:when test="${fn:length(driveFileInfo.dv_filename) gt 20}">
		                                    <c:out value="${fn:substring(driveFileInfo.dv_filename, 0, 20)} ${'...'}"></c:out>
		                                 </c:when>
		                                 <c:otherwise>
		                                    <c:out value="${driveFileInfo.dv_filename}" />
		                                 </c:otherwise>
		                              </c:choose>
									</td>												
									<td style="width: 100px; text-align: center">
										${driveFileInfo.m_id}
									</td>
									<td style="width: 100px; text-align: center">
										<button type="button" class="button_download_file" data-dv_id="${driveFileInfo.dv_id}"><img alt="다운로드.png" src="main/img/다운로드.png" style="width: 20px; height: 20px"> </button>
									</td>
								</tr>
						</c:forEach>
						</table>
			</div>
			<div class="box3_2">
				<img alt="드라이브.png" src="main/img/드라이브1.png"> 
			</div>
		</div>
	</div>
	<div class="set2">
		<div class="box4">
			<div class="box4_1">
				<div class="text"><b>결재현황</b></div>
				<div class="img"><img alt="전자결재.png" src="main/img/전자결재.png"> </div>
			</div>
			<div class="box4_2">
				<div class="box4_2_1">
					<div class="box4_2_1_1">
						<div class="text1_1">기안진행</div>
						<div class="text1_2"><b>${num_processing }</b></div>
					</div>
					<div class="box4_2_1_2">
						<div class="text2_1">기안완료</div>
						<div class="text2_2"><b>${num_ProposalCompleted }</b></div>
					</div>
				</div>
				<div class="box4_2_2">
					<div class="box4_2_2_1">
						<div class="text3_1">결제대기</div>
						<div class="text3_2"><b>${num_Waited }</b></div>
					</div>
					<div class="box4_2_2_2">
						<div class="text4_1">결재처리</div>
						<div class="text4_2"><b>${num_ApprovalCompleted }</b></div>
					</div>
				</div>
			</div>
		</div>
		<div class="box5">
			<div class="box5_1">
				<table id="list_mail">
								<tr>
										<td colspan="4" rowspan="1" style="width: 550px; font-size: 25px; padding-top: 15px; padding-left: 50px"><img alt="바람개비.png" src="main/img/바람개비.png" width="25px" height="25px">&nbsp;&nbsp;&nbsp;<b>메일</b></td>
								</tr>
								<tr style="height: 10px"></tr>
							<c:forEach var="mail" items="${listOfMail}" begin="0" end="3">
								<tr
									<c:if test="${mail.ml_read == '1'}">
										class="tr_read"
									</c:if>
								style="width: 550px" >
									<td class="date" style="width: 150px; text-align: center">
									<fmt:formatDate value="${mail.ml_regdate}" pattern="yyyy/MM/dd hh:mm"></fmt:formatDate></td>		
									<td class="email" style="height: 40px; width: 200px; text-align: center">${mail.ml_email}</td>
									<td style="width: 200px">
										<a href="${pageContext.request.contextPath}/mail/view/${mail.ml_num}" style="text-decoration: none; color:black">
											<c:choose>
			                                 <c:when test="${fn:length(mail.ml_title) gt 15}">
			                                    <c:out value="${fn:substring(mail.ml_title, 0, 15)} ${'...'}"></c:out>
			                                 </c:when>
			                                 <c:otherwise>
			                                    <c:out value="${mail.ml_title}" />
			                                 </c:otherwise>
			                              </c:choose></a>
									</td>
								</tr>
							</c:forEach>
					</table>
			</div>
			<div class="box5_2">
				<img alt="메일.png" src="main/img/메일4.png"> 
			</div>		
		</div>
		<div class="box6">
			<div class="box6_1">
				<table id="list_table">	
						<tr>
							<td colspan="3" rowspan="1" style="width: 550px; font-size: 25px; padding-top: 15px; padding-left: 50px"><img alt="바람개비.png" src="main/img/바람개비.png" width="25px" height="25px">&nbsp;&nbsp;&nbsp;<b>커뮤니티</b></td>
						</tr>
						<tr style="height: 10px"></tr>			
					<c:forEach var="ps" items="${listPost2}" begin="0" end="3">					
						<tr style="width: 550px">
							<td style="height: 40px; width: 50px; text-align: center">*</td>
							<td style="width: 200px"><a style="color: black; text-decoration: none" href='${pageContext.request.contextPath}/community/view?p_num=${ps.p_num}'>${ps.p_name}</a></td>
							<td style="width: 150px; text-align: center">${ps.m_id}</td>						
							<td style="width: 150px; text-align: center"><fmt:formatDate value="${ps.p_regdate}" pattern="yyyy/MM/dd"/></td>	
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="box6_2">
				<img alt="커뮤니티.png" src="main/img/커뮤니티.png"> 
			</div>	
		</div>	
	</div>
</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>