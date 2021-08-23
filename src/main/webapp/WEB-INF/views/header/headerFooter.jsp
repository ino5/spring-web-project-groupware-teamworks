<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="TestCircle">
	<button type="button" id="Test">
		<img alt="물풍선.png" src="${pageContext.request.contextPath}/header/img/물풍선.png" style="width: 100px; height: 100px">
		<div class="blue_circle"></div>
	</button>
	</div>
	<!-- Modal content -->
	<div id="talkModal" class="chatModal drag">
		<div id="content1">
			<div id="room1">
				<div id="logo">
					<div class="img">
						<img alt="로고.jpg" src="${pageContext.request.contextPath}/talk/img/로고.png">
					</div>
					<div class="h5"><b>TEAM</b></div>
					<div class="h6"><b>works</b></div>
					<span class="ic_gnb_x button_x3"></span>
				</div>
				<div id="roomContainer" class="roomContainer">
					<table id="memberlist" class="memberlist">
					<tr><th>이름</th></tr>
					</table>
					<table id="groupRoomlist">
<!-- 					<tr><th>방 이름</th></tr> -->
					</table>
				</div>
			<div id="button_bar"></div>
				<div id="member"><button type="button" class="onebyone">회원</button></div>
				<div id="group_circle"><button type="button" class="group">채팅</button><div class="blue_circle total"></div></div>
				<div id="makeGroupButton"><button type="button" class="groupchat">그룹 방만들기</button></div>
			</div>
		</div>
		<div id="content2">
			<div id="makegroup"></div>
			<button type="button" onclick="javascript:talkGroup()" class="insertroom">방만들기</button>
		</div>
		<div id="chatting_wrap">
			<div class="container">
				<h1 id="roomName" style="color: black"></h1>
				<input type="hidden" id="sessionId" value="">
				<input type="hidden" id="m_id">
				<input type="hidden" id="m_name">
				<input type="hidden" id="roomNumber">
				<div id="meName"></div>
				<div id="chating" class="chating">				
				<input type="hidden" id="read_Number">
				</div>
				<div id="yourMsg">
					<table class="inputTable">
						<tr>
							<th>메시지</th>
							<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
							<th><button onclick="send()" id="sendBtn">전송</button></th>
						</tr>
						<tr>
							<th>파일</th>
							<th><input  type="file" id="fileUpload"></th>
							<th><button onclick="fileSend()" id="sendFileBtn"><img alt="다운.png" src="${pageContext.request.contextPath}/talk/img/다운.png"></button></th>
						</tr>
					</table>
				</div>
				<button type="button" id="back" value="돌아가기">돌아가기</button>
				<button type="button" id="join_member" onclick="join_member($('#roomNumber').val())">참여자</button>
				<table id="join_member_list"></table>
			</div>
		</div>
	</div>