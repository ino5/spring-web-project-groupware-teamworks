<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.sample_container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.sample_container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.sample_chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.sample_chating p{
			color: #fff;
			text-align: left;
		}
		sample_input{
			width: 330px;
			height: 25px;
		}
		#sample_yourMsg{
			display: none;
		}
	</style>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">
		<div id="sample_container" class="sample_container">
			<h1>채팅</h1>
			<div id="sample_chating" class="sample_chating">
			</div>
			
			<div id="sample_yourName">
				<table class="sample_inputTable">
					<tr>
						<th>사용자명</th>
						<th><input type="text" name="userName" id="sample_userName"></th>
						<th><button onclick="sampleChatName()" id="sample_startBtn">이름 등록</button></th>
					</tr>
				</table>
			</div>
			<div id="sample_yourMsg">
				<table class="sample_inputTable">
					<tr>
						<th>메시지</th>
						<th><input id="sample_chatting" placeholder="보내실 메시지를 입력하세요."></th>
						<th><button onclick="sampleSend()" id="sample_sendBtn">보내기</button></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
<script type="text/javascript">
	var sampleWs;

	function sampleWsOpen(){
		sampleWs = new WebSocket("ws://" + location.host + _contextPath +"/socket/sample");
		sampleWsEvt();
	}
		
	function sampleWsEvt() {
		sampleWs.onopen = function(data){
			//소켓이 열리면 초기화 세팅하기
		}
		
		sampleWs.onmessage = function(data) {
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				$("#sample_chating").append("<p>" + msg + "</p>");
			}
		}

// 		document.addEventListener("keypress", function(e){
// 			if(e.keyCode == 13){ //enter press
// 				send();
// 			}
// 		});
	}

	function sampleChatName(){
		var sampleUserName = $("#sample_userName").val();
		if(sampleUserName == null || sampleUserName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#sample_userName").focus();
		}else{
			sampleWsOpen();
			$("#sample_yourName").hide();
			$("#sample_yourMsg").show();
		}
	}

	function sampleSend() {
		var uN = $("#sample_userName").val();
		var msg = $("#sample_chatting").val();
		sampleWs.send(uN+" : "+msg);
		$('#sample_chatting').val("");
	}
</script>
</html>