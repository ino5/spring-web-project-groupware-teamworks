let global_res;
let global_room;
let isMyMessage = 0;
let isClickedGroupchat = false;
let isClickEventKeypressEnter = false;
let isClickedOnebyOneChat = false;
let isClickedGroupRoomList = false;
let isClickedOnebyOneTalkList = false;
let isClickedJoinGroupMember = false;


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
   					 	+ memberList[i].m_id + '"'
   					 	+ '><sec:authorize access="isAuthenticated()"><sec:authentication property="principal.username" var="sec_m_id" /><img src="' + _contextPath + '/resource/member/photo/' + memberList[i].m_id + '.jpg" onerror=this.src="' + _contextPath + '/resource/member/photo/default.jpg" style="width: 50px; height: 50px"></sec:authorize><button type="button"  id="chat" onclick="getRoomOfApi('
   					 	+ '\''
   					 	+ memberList[i].m_id
   					 	+ '\''
   					 	+ ')">'
   					 	+ memberList[i].m_name
   					 	+ '</button></td></tr>'
   					 ); 
					}					
				$('.chatModal').show();
				$('#content2').hide();
				$('#chatting_wrap').hide();
				$('#groupRoomlist').hide();
				$('#Test').hide();
				$('#TestCircle').hide();			
				
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

// 1:1버튼 : 모든 멤버 다 보이기
$(document).ready(function() {
 	//멤버리스트 보이기
	$(".onebyone").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
/*
				//멤버리스트 가져오기
				let memberList = res.memberList;
				
				if(!isClickedOnebyOneChat) {
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
					isClickedOnebyOneChat = true;
				}
*/					
				$('.chatModal').show();
				$('#content2').hide();
				$('#chatting_wrap').hide();
				$('#groupRoomlist').hide();
				$('#memberlist').show();
				
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
		$('#roomName').text(room.tkrm_name);
		for(var i = 0; i < talkList.length; i++) {
			if(talkList[i].tk_type == 1) {
				if(talkList[i].m_id != m_id){				
	   					 $('#chating').append(
	   					 	'<div id="memo"><p class="others">'
	   					 	+ talkList[i].m_name + ':' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
	   					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p></div>'
	   					 ); 
					}
				else if(talkList[i].m_id == m_id){
						$('#chating').append(
	   					 	'<div id="memo"><p class="me">'
	   					 	+ '나 :' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
	   					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p></div>'
	   					 );
	   				}	
   				} else if(talkList[i].tk_type == 2) {
				if(talkList[i].m_id != m_id){				
	   					 $('#chating').append(
	   					 	'<div id="memo2"><p class="others2">'
	   					 	+ talkList[i].m_name + ':'  + '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
	   					 	+'</p><p class="date4">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p></div>'
	   					 ); 
					}
				else if(talkList[i].m_id == m_id){
						$('#chating').append(
	   					 	'<div id="memo2"><p class="me2">'
	   					 	+ '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
	   					 	+'</p><p class="date3">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p></div>'
	   					 );
	   				}	
   				}
   			}				
		
		//멤버리스트창 끄고 채팅창 보여주기
		$('#content1').hide();
		$('#chatting_wrap').show();
		$('#content2').hide();
		$('#back2').hide();

	},
	err: function(err){}
	});

}

//그룹채팅 버튼 클릭
$(document).ready(function() {
 	//그룹채팅방 리스트 보이기
	$(".group").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getGroupRoomList',
			type: 'get',
			success: function (res) {
				$('#groupRoomlist').html('');
				$('#groupRoomlist').append('<tr><th colspan="2">방 이름</th></tr>');
				//멤버리스트 가져오기
				let roomList = res.roomList;
				for(var i = 0; i<roomList.length; i++) {
   					 $('#groupRoomlist').append(
   					 	'<tr><td><input type="hidden" id="m_id2" value="'
   					 	+ roomList[i].m_id + '"'
						+ '><td><img src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[0]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg" style="width: 50px; height: 50px">'
						+  (roomList[i].talkerList[1] != null ? '<img src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[1]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg" style="width: 50px; height: 50px">': '')
						+  (roomList[i].talkerList[2] != null ? '<img src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[2]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg" style="width: 50px; height: 50px">': '')	
						+ '</td><td><button type="button"  id="chat" onclick="getRoomOfApi2('
   					 	+ '\''
   					 	+ roomList[i].tkrm_num
   					 	+ '\''
   					 	+ ')">'
   					 	+ roomList[i].tkrm_name
   					 	+ '</button></td></tr>'
   					 ); 
				}			
				$('.chatModal').show();
				$('#content2').hide();
				$('#chatting_wrap').hide();
				$('#memberlist').hide();
				$('#groupRoomlist').show();
				
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

// 그룹채팅 방이름 클릭시,
function getRoomOfApi2(tkrm_num) {
	$.ajax({
	url : _contextPath + '/talk/getRoomOfApi',
	data: {'tkrm_num' : tkrm_num},
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
		$('#roomName').text(room.tkrm_name);
		for(var i = 0; i < talkList.length; i++) {
		if(talkList[i].tk_type == 1) {
			if(talkList[i].m_id != m_id){				
   					 $('#chating').append(
   					 	'<div id="memo"><p class="others">'
   					 	+ talkList[i].m_name + ':' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
   					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 ); 
				}
			else if(talkList[i].m_id == m_id){
					$('#chating').append(
   					 	'<div id="memo"><p class="me">'
   					 	+ '나:' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
   					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 );
   				}
   		} else if(talkList[i].tk_type == 2) {
   			if(talkList[i].m_id != m_id){				
   					 $('#chating').append(
   					 	'<div id="memo2"><p class="others2">'
   					 	+ talkList[i].m_name + ':' + '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
   					 	+'</p><p class="date4">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 ); 
				}
			else if(talkList[i].m_id == m_id){
					$('#chating').append(
   					 	'<div id="memo2"><p class="me2">'
   					 	+ '나:' + '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
   					 	+'</p><p class="date3">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p></div>'
   					 );
   				}
   		 	}
   		}		
		
		//멤버리스트창 끄고 채팅창 보여주기
		$('#content1').hide();
		$('#chatting_wrap').show();
		$('#content2').hide();
		$('#bakc1').hide();

	},
	err: function(err){}
	});

}


$(document).ready(function() {
// 그룹채팅추가멤버보이기
	$(".groupchat").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				//멤버리스트 가져오기
				let memberList = res.memberList;
				
				if(!isClickedGroupchat) {
					for(var i = 0; i<memberList.length; i++) { 
	   					 $('#makegroup').append(
	   					 	'<input type="hidden" class="m_id2" value="'
	   					 	+ memberList[i].m_id
	   					 	+ '"><input type="checkbox" name="group" class="group" value="'
	   					 	+ memberList[i].m_id
	   					 	+ '">'
	   					 	+ memberList[i].m_name
	   					 ); 
					}
					isClickedGroupchat = true;			
				}	
				$('.chatModal').show();
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

// 체크박스 저장
function talkGroup() {
    var chk = []; // key 값을 담을 배열
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('.group:checked').each(function(){
        chk.push($(this).val());
    });
    
	$.ajax({
		type : 'get',
		url : _contextPath + "/talk/MakeGroupGetRoom",
		data : {checkArray : chk},
			success: function (res){
					global_res = res; //콘솔 확인용
					let room = res.room;
					let m_id = res.m_id;
		
		//소켓열기
		wsOpen(room.tkrm_num);
		$('#roomNumber').val(room.tkrm_num);
		$('#roomName').text(room.tkrm_name);
			
				$('#content1').hide();
				$('#content2').hide();
				$('#chatting_wrap').show();
				$('#back1').hide();
        	}
		});
	}


$(document).ready(function() {
// 돌아오기
	$("#back").on("click", function () {
   		$.ajax({
			url: _contextPath + '/talk/getMemberList',
			type: 'get',
			success: function (res) {
				ws.close();
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
				
				//채팅 기록 지우기(변경됨)
				$('#chating').html('');
				$('#roomName').html('');
				$('.group').removeAttr('checked');
				$('#join_member_list').html('');
				$('#groupRoomlist').html('');
				$('#groupRoomlist').append('<tr><th colspan="2">방 이름</th></tr>');
				
				// 그룹채팅 버튼 누른것과 같은 효과				
				$(".group").trigger("click");
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});
		

//그룹 참여하는 사람 이름 보이기
function join_member(tkrm_num) {
   		$.ajax({
			url: _contextPath + '/talk/joinGroupMemberList',
			data: {'tkrm_num' : tkrm_num},
			type: 'get',
			success: function (res) {
				//참여 멤버리스트 가져오기
				let memberList = res.memberList;
					for(var i = 0; i<memberList.length; i++) {
					$('#join_member_list').append(
   					 	'<tr><td><input type="hidden" id="m_id2" value="'
   					 	+ memberList[i].m_id
   					 	+ '">'
   					 	+ memberList[i].m_name
   					 	+ '</td></tr>'
   					 ); 
				}						
				$('#content1').hide();
				$('#chatting_wrap').show();
				
				//input에 m_id, m_name 정보 넣기
				$('#m_id').val(m_id);
				$('#m_name').val(m_name);
			},
			error : function(err){
				console.log('error');
			}
		});
}


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
	ws.onmessage = function(data) {
		console.log("메세지를 받다")
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
				$.ajax({
					url: _contextPath + '/talk/readNumber',
					data: {	'roomNumber' : $("#roomNumber").val()},
					type: 'get',
					success: function (res) {
						debugger;
						$('.readNumber').text(res);
					},
					error : function(err){
						console.log('error');
					}
				});	
				
				if(jsonMsg.sessionId == $("#sessionId").val()){
					isMyMessage = 1;
					$("#chating").append("<div id='memo'><p class='me'>" + "나 : " + jsonMsg.msg + "</p><br><p class='date'>" + moment(date).format("HH:mm") + "</p><p class='readNumber'>" + $('.readNumber').val() + "</p></div>");
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}else{
					isMyMessage = 0;
					$("#chating").append("<div id='memo'><p class='others'>" + jsonMsg.userName + " : " + jsonMsg.msg + "</p><br><p class='date2'>" + moment(date).format("HH:mm") + "</p></div>");
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}						
			}else{
				console.warn("unknown type!")
			}
			// 읽었다고 알려주기
	   		$.ajax({
				url: _contextPath + '/talk/readMember',
				data: {	'roomNumber' : $("#roomNumber").val(),
						'm_id' : $("#m_id").val()
				},
				type: 'get',
				success: function (res) {
				},
				error : function(err){
					console.log('error');
				}
			});
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
	if(!isClickEventKeypressEnter) {
		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
		isClickEventKeypressEnter = true;
	}
	

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
				$('.chatModal').show();
			},
			error : function(err){
				console.log('error');
			}
		});
	});
});
*/