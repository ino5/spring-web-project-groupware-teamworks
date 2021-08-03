let global_res;
let global_room;
let isMyMessage = 0;
let is_clicked_groupchat = false;

$(document).ready(function() {
 	//멤버리스트 보이기
	$("#Test").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				//멤버리스트 가져오기
				let memberList = res.memberList;
				for(var i = 0; i<memberList.length; i++) {
   					 $('#memberlist').append(
   					 	'<tr><td><input type="hidden" id="m_id2" value="'
   					 	+ memberList[i].m_id
   					 	+ '"><button type="button"  id="chat" onclick="getRoomOfApi('
   					 	+ '\''
   					 	+ memberList[i].m_id
   					 	+ '\''
   					 	+ ')">'
   					 	+ memberList[i].m_name
   					 	+ '</button></td></tr>'
   					 ); 
					}					
				$('.modal').show();
				$('#content2').hide();
				$('#chatting_wrap').hide();
				
				//input에 m_id, m_name 정보 넣기
				$('#m_id').val(res.m_id);
				$('#m_name').val(res.m_name);
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});

$(document).ready(function() {
// 그룹채팅멤버보이기
	$(".groupchat").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				//멤버리스트 가져오기
				let memberList = res.memberList;
				
				if(!is_clicked_groupchat) {
					for(var i = 0; i<memberList.length; i++) { 
	   					 $('#makegroup').append(
	   					 	'<input type="hidden" id="m_id2" value="'
	   					 	+ memberList[i].m_id
	   					 	+ '"><input type="checkbox"  id="group" value="'
	   					 	+ memberList[i].m_name
	   					 	+ '">'
	   					 	+ memberList[i].m_name
	   					 ); 
					}
					is_clicked_groupchat = true;			
				}	
				$('.modal').show();
				$('#content2').show();
				$('#chatting_wrap').hide();
				
				//input에 m_id, m_name 정보 넣기
				$('#m_id').val(res.m_id);
				$('#m_name').val(res.m_name);
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});


function getRoomOfApi(m_id2) {
	$.ajax({
	url : _contextPath + '/talk/getRoomOfApi',
	data: {'m_id2' : m_id2},
	type : 'get',
	success: function(res) {
		//서버에서 방 정보와 이전 채팅 기록 가져오기
		global_res = res; //콘솔 확인용
		let room = res.room;
		let m_id = res.m_id;
		let talkList = res.talkList;
		let Tkrm_name = res.Tkrm_name;
		
		//소켓열기
		wsOpen(room.tkrm_num);
		$('#roomNumber').val(room.tkrm_num);
		for(var i = 0; i < talkList.length; i++) {
			if(talkList[i].m_id != m_id){				
   					 $('#chating').append(
   					 	'<div id="memo"><p class="others">'
   					 	+ talkList[i].m_name + ':' + talkList[i].tk_content
   					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 ); 
				}
			else if(talkList[i].m_id == m_id){
					$('#chating').append(
   					 	'<div id="memo"><p class="me">'
   					 	+ '나:' + talkList[i].tk_content
   					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 );
   				}
   			} 					
		
		//멤버리스트창 끄고 채팅창 보여주기
		$('#content1').hide();
		$('#chatting_wrap').show();
		$('#content2').hide();

	},
	err: function(err){}
	});

}

$(document).ready(function() {
// 돌아오기
	$("#back").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				//멤버리스트 가져오기
				let memberList = res.memberList;
				for(var i = 0; i<memberList.length; i++) {
   					 $('#memberlist').append(
   					 	'<tr><td><input type="hidden" id="m_id2" value="'
   					 	+ memberList[i].m_id
   					 	+ '"><button type="button"  id="chat" onclick="getRoomOfApi('
   					 	+ '\''
   					 	+ memberList[i].m_id
   					 	+ '\''
   					 	+ ')">'
   					 	+ memberList[i].m_name
   					 	+ '</button></td></tr>'
   					 ); 
					}					
				$('#content1').show();
				$('#chatting_wrap').hide();
				
				//input에 m_id, m_name 정보 넣기
				$('#m_id').val(res.m_id);
				$('#m_name').val(res.m_name);
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});

//웹소켓 열기
function wsOpen(roomNumber) {
	console.log("wsOpen  location.host: " + location.host);
    var wsUri  = "ws://" + location.host + _contextPath + "/taking/"+roomNumber;
	ws = new WebSocket(wsUri);
	wsEvt();
}

//웹소켓 열기 안에 있는 어떠한 함수
function wsEvt() {
	console.log("wsEvt  start... ");
	//소켓이 열리면 동작
	ws.onopen = function(data){
		console.log("wsEvt  소켓이 열리면 초기화 세팅하기..");
		}
	
	//메시지를 받으면 동작
	console.log("메세지를 받다")
	ws.onmessage = function(data) {
		
		var msg = data.data;
		var date = new Date();
		//alert("ws.onmessage->"+msg)
		if(msg != null && msg.type != ''){
			// 파일 업로드가 아닌 경우 메시지 뿌려준다
			var jsonMsg = JSON.parse(msg);
			// 파싱한 객체의 type값을 확인하여 getId값이면 초기 설정된 값이므로 채팅창에 값을 입력하는게 아니라
			// 추가한 태그 sessionId에 값을 세팅
			if(jsonMsg.type == "getId"){
				var sid = jsonMsg.sessionId != null ? jsonMsg.sessionId : "";
				if(sid != ''){
					$("#sessionId").val(sid); 
				}
			}else if(jsonMsg.type == "message"){
			// type이 message인 경우엔 채팅이 발생한 경우.
            // 상대방과 자신을 구분하기 위해 여기서 sessionId값을 사용
            // 최초 이름을 입력하고 연결되었을때, 발급받은 sessionId값을 비교하여 같다면 자기 자신이 발신한
            // 메시지이므로 오른쪽으로 정렬하는 클래스를 처리하고 메시지를 출력.     
            // 비교하여 같지 않다면 타인이 발신한 메시지이므로 왼쪽으로 정렬하는 클래스를 처리하고 메시지를 출력
				if(jsonMsg.sessionId == $("#sessionId").val()){
					isMyMessage = 1;
					$("#chating").append("<div id='memo'><p class='me'>" + "나 : " + jsonMsg.msg + "</p><br><p class='date'>" + moment(date).format("HH:mm") + "</p></div>");
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}else{
					isMyMessage = 0;
					$("#chating").append("<div id='memo'><p class='others'>" + jsonMsg.userName + " : " + jsonMsg.msg + "</p><br><p class='date2'>" + moment(date).format("HH:mm") + "</p></div>");
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}						
			}else{
				console.warn("unknown type!")
			}
		}else{
			// 파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다
			var url = URL.createObjectURL(new Blob([msg]));
			if(isMyMessage == 1){
				$("#chating").append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div>");
				$("#chating").scrollTop($("#chating")[0].scrollHeight);
			} else{
				$("#chating").append("<div class='img2'><img class='msgImg2' src="+url+"></div><div class='clearBoth'></div>");
				$("#chating").scrollTop($("#chating")[0].scrollHeight);
			}	
		}			
	}
	document.addEventListener("keypress", function(e){
		if(e.keyCode == 13){ //enter press
			send();
		}
	});
}

function send() {
	var option ={
		type: "message",
		roomNumber : $("#roomNumber").val(),  
		sessionId : $("#sessionId").val(),
		userName : $("#m_name").val(),
		msg : $("#chatting").val(),
		m_id : $("#m_id").val()
	}  //roomNumber는 방의 번호를 보내줌으로써 소켓서버는 어느방에서 메시지를 보냈는지 구분
	ws.send(JSON.stringify(option))
	$('#chatting').val("");
}

function fileSend() {
	console.log("파일전송 시작");
	send();
	var file = document.querySelector("#fileUpload").files[0];
	var fileReader = new FileReader();
	fileReader.onload = function() {
		var param = {
			type: "fileUpload",
			file: file,
			roomNumber: $("#roomNumber").val(),
			sessionId: $("#sessionId").val(),
			msg: $("#chatting").val(),
			userName : $("#m_name").val()
		}
		ws.send(JSON.stringify(param)); // 파일 보내기전 메시지를 보내서 파일을 보냄을 명시
		$('chatting').val("");
	
		arrayBuffer = this.result;
			ws.send(arrayBuffer); // 파일 소켓 전송
	};
	fileReader.readAsArrayBuffer(file);	
}































/*
$("#Test").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				for(var i = 0; i<res.length; i++) {
   					 $('#memberlist').append(
   					 	'<tr><td><input type="hidden" id="m_id2" value="'
   					 	+ res[i].m_id
   					 	+ '"><button type="button"  id="chat" onclick="location.href=\''
   					 	+ _contextPath
   					 	+ '/talk/moveChating?m_id2='
   					 	+ res[i].m_id
   					 	+ '\'">'
   					 	+ res[i].m_name
   					 	+ '</button></td></tr>'
   					 ); 
					}					
				$('.modal').show();
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});
*/