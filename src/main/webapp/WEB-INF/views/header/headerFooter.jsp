<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<div id="TestCircle">
	<button type="button" id="Test">
		<img alt="물풍선.png" src="${pageContext.request.contextPath}/header/img/물풍선.png" style="width: 100px; height: 100px">
		<div class="blue_circle"></div>
	</button>
	</div>
	<!-- Modal content -->
	<div id="talkModal" class="chatModal drag">
		<div class="phone_bg">	
			<img alt=" " src="${pageContext.request.contextPath}/header/img/핸드폰.png">
		</div>
		<div id="content1">
			<div id="room1">
				<div id="logo">
					<div class="img">
						<img alt="로고.jpg" src="${pageContext.request.contextPath}/header/img/바람개비 로고.png">
					</div>
					<div class="h5"><b>TEAM</b></div>
					<div class="h6"><b>works</b></div>
<!-- 				<span class="ic_gnb_x button_x3"></span> -->
					<div class="button_x3">
						<img alt="X" src="${pageContext.request.contextPath}/header/css/images/ic_gnb3.png" onmouseover="this.src='${pageContext.request.contextPath}/header/css/images/ic_gnb4.png'" onmouseout="this.src='${pageContext.request.contextPath}/header/css/images/ic_gnb3.png'">
					</div>
				</div>
				<div id="roomContainer" class="roomContainer">
					<table id="memberlist" class="memberlist">
<!-- 					<tr><th>이름</th></tr> -->
					</table>
					<table id="groupRoomlist">
<!-- 					<tr><th>방 이름</th></tr> -->
					</table>
				</div>
			<div id="button_bar"></div>
				<div id="member"><button type="button" class="onebyone">
					<img alt="회원" src="${pageContext.request.contextPath}/talk/img/회원.png">
				</button></div>
				<div id="group_circle">
					<div id="chat_button">
						<button type="button" class="group">
							<img alt="채팅" src="${pageContext.request.contextPath}/talk/img/채팅.png">
						</button>
					</div>
					<div class="blue_circle total"></div>
				</div>				
				<div id="makeGroupButton"><button type="button" class="groupchat">
					<img alt="방만들기" src="${pageContext.request.contextPath}/talk/img/방만들기.png">
				</button></div>
			</div>
		</div>
		<div id="content2">
			<div id="makegroup"></div>
			<button type="button" onclick="javascript:talkGroup()" class="insertroom">방만들기</button>
		</div>
		<div id="chatting_wrap">
			<div class="phone_bg2">	
				<img alt=" " src="${pageContext.request.contextPath}/header/img/핸드폰.png">
			</div>
			<div class="container">
<!-- 				<div id="logo2"> -->
<!-- 					<div class="img"> -->
<%-- 						<img alt="로고.jpg" src="${pageContext.request.contextPath}/header/img/바람개비 로고.png"> --%>
<!-- 					</div> -->
<!-- 					<div class="h5"><b>TEAM</b></div> -->
<!-- 					<div class="h6"><b>works</b></div> -->
<!-- <!-- 				<span class="ic_gnb_x button_x3"></span> --> -->
<!-- 					<div class="button_x3"> -->
<%-- 						<img alt="X" src="${pageContext.request.contextPath}/header/css/images/ic_gnb3.png" onmouseover="this.src='${pageContext.request.contextPath}/header/css/images/ic_gnb4.png'" onmouseout="this.src='${pageContext.request.contextPath}/header/css/images/ic_gnb3.png'"> --%>
<!-- 					</div> -->
<!-- 				</div> -->
				<div id="h1">
					<div id="h1_1">
						<h1 id="roomName"></h1>
<%-- 						<c:choose> --%>
<%--                             <c:when test="${fn:length($('#roomName').text()) gt 20}"> --%>
<%--                                <c:out value="${fn:substring($('#roomName').text(), 0, 10)} ${'...'}"></c:out> --%>
<%--                             </c:when> --%>
<%--                             <c:otherwise> --%>
<%--                                <c:out value="${$('#roomName').text()}" /> --%>
<%--                             </c:otherwise> --%>
<%-- 		                </c:choose>					 --%>
					</div>
					<div id="chatingRoom_icon">
						<div id="back_back"><button type="button" id="back" value="돌아가기">
							<img alt="이전" src="${pageContext.request.contextPath}/talk/img/돌아가기.png">
						</button></div>
						<div class="join_member_button"><button type="button" id="join_member" onclick="join_member($('#roomNumber').val())">
							<img alt="참가자" src="${pageContext.request.contextPath}/talk/img/참가자.png">
						</button></div>
					</div>	
				</div>
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
<!-- 							<th>메시지</th> -->
							<th style="padding-left: 25px;"><input id="chatting" placeholder="보내실 메시지를 입력하세요.">
							<button onclick="send()" id="sendBtn">전송</button></th>
						</tr>
						<tr>
<!-- 							<th>파일</th> -->
							<th class="file_uploadTh" style="padding-left: 20px; padding-left: 40px; padding-top: 5px;">
								<div id="target_file_wrap">
									<input type="file" id="fileUpload">							
									<a href="#" onclick="jQuery('#fileUpload').click()" class="btn btn-primary">첨부파일 선택</a>
								</div>
								<div id="fileSendButton"><button onclick="fileSend()" id="sendFileBtn"><img alt="다운.png" src="${pageContext.request.contextPath}/talk/img/다운.png"></button></div>				
							</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
				<div class="talkBox">
					<img alt="말풍선" src="${pageContext.request.contextPath}/talk/img/말풍선.png">				
					<table id="join_member_list"></table>
				</div>		
	</div>	
	
	<!-- 알림창 -->
	<div id="sample_alert_wrapper">
		<div id="sample_alert_photo">
		</div>
		<div id="sample_alert_userName">
		</div>
		<div id="sample_alert_msg">
		</div>
	</div>