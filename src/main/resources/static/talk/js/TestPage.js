let global_res;
let global_room;
let isMyMessage = 0;
let isClickedGroupchat = false;
let isClickEventKeypressEnter = false;
let isClickedOnebyOneChat = false;
let isClickedGroupRoomList = false;
let isClickedOnebyOneTalkList = false;
let isClickedJoinGroupMember = false;
let nowTk_num = 0;

// 전체 안읽은 메세지 가져오기
$(document).ready(function() {
	refreshNumOfAllUnread();
});
function refreshNumOfAllUnread() {
	$.ajax({
		url: _contextPath + '/talk/AllChatCount',
		type: 'get',
		success: function (res) {
			if(res == 0) {
				$('.blue_circle').hide();
			}else {
				$('.blue_circle').show();
				$('.blue_circle').text(res);
			}
		}
	});
}

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
   					 	'<tr><td style="padding: 5px;"><input type="hidden" id="m_id2" value="'
   					 	+ memberList[i].m_id + '"'
   					 	+ '><sec:authorize access="isAuthenticated()"><sec:authentication property="principal.username" var="sec_m_id" /><img src="' + _contextPath + '/resource/member/photo/' + memberList[i].m_id + '.jpg" onerror=this.src="' + _contextPath + '/resource/member/photo/default.jpg" style="width: 50px; height: 50px; border-radius: 30%; margin-left: 10px;"></sec:authorize></td><td><button type="button"  id="chat2" onclick="getRoomOfApi('
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
				$('.phone_bg2').hide();
				$('.phone_bg').show();
				$('#groupRoomlist').hide();
				$('#Test').hide();
				$('#TestCircle').hide();
				$('.talkBox').hide();
				$('#insertRoom').hide();
								
				
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
				$('#memberlist').html('');
				//멤버리스트 가져오기
				let memberList = res.memberList;
				
				for(var i = 0; i<memberList.length; i++) {
   					 $('#memberlist').append(
   					 	'<tr><td style="padding: 5px;"><input type="hidden" id="m_id2" value="'
   					 	+ memberList[i].m_id + '"'
   					 	+ '><sec:authorize access="isAuthenticated()"><sec:authentication property="principal.username" var="sec_m_id" /><img src="' + _contextPath + '/resource/member/photo/' + memberList[i].m_id + '.jpg" onerror=this.src="' + _contextPath + '/resource/member/photo/default.jpg" style="width: 50px; height: 50px; border-radius: 30%; margin-left: 10px;"></sec:authorize></td><td><button type="button"  id="chat2" onclick="getRoomOfApi('
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
				$('#memberlist').show();
				$('.phone_bg2').hide();
				$('.phone_bg').show();
				$('.talkBox').hide();
				$('#insertRoom').hide();		
				
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
		$('#roomName').text((room.tkrm_name.length > 6 ? room.tkrm_name.substring(0,7) + '...' : room.tkrm_name));
		for(var i = 0; i < talkList.length; i++) {
			if(talkList[i].tk_type == 1) {
				if(talkList[i].m_id != m_id){				
	   					 $('#chating').append(
	   					 	'<div id="memo"><p class="others">'
	   					 	+ talkList[i].m_name + ':' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
	   					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p><p class="unReadNum2" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
	   					 ); 
					}
				else if(talkList[i].m_id == m_id){
						$('#chating').append(
	   					 	'<div id="memo"><p class="me">'
	   					 	+ '나 :' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
	   					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p><p class="unReadNum1" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
	   					 );
	   				}	
   				} else if(talkList[i].tk_type == 2) {
				if(talkList[i].m_id != m_id){				
	   					 $('#chating').append(
	   					 	'<div id="memo2"><p class="others2">'
	   					 	+ talkList[i].m_name + ':'  + '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
	   					 	+'</p><p class="date4">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p><p class="unReadNum2" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
	   					 ); 
					}
				else if(talkList[i].m_id == m_id){
						$('#chating').append(
	   					 	'<div id="memo2"><p class="me2">'
	   					 	+ '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
	   					 	+'</p><p class="date3">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
	   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
	   					 	+'</p><p class="unReadNum1" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
	   					 );
	   				}	
   				}
   			}				
		
		//멤버리스트창 끄고 채팅창 보여주기
		$('#content1').hide();
		$('#chatting_wrap').show();
		$('#content2').hide();
		$('#back2').hide();
		$('#groupRoomlist').hide();
		$('.phone_bg').hide();
		$('.phone_bg2').show();
		$('.talkBox').hide();
		$('#insertRoom').hide();		

	},
	err: function(err){}
	});

}

//그룹채팅 버튼 클릭
$(document).ready(function() {
 	//그룹채팅방 리스트 보이기
	$(".group").on("click", function () {
		getGroupRoomList();
		$('#content2').hide();
		$('#insertRoom').hide();
	});
});

// 채팅 방 목록 보여주기
function getGroupRoomList() {
	$.ajax({
		url: _contextPath + '/talk/getGroupRoomList',
		type: 'get',
		success: function (res) {
            // 채팅방 목록 가져오는 일반적인 경우
            if ($('#groupRoomlist').css('display') == 'none') {
                $('#groupRoomlist').html('');
                // $('#groupRoomlist').append('<tr><th colspan="2">방 이름</th></tr>');
                //멤버리스트 가져오기
                let roomList = res.roomList;
                for(var i = 0; i<roomList.length; i++) {
                     $('#groupRoomlist').append(
                         '<tr><td><input type="hidden" id="m_id2" value="'
                         + roomList[i].m_id + '"'
                        + '><td id="img_set">'
                        +  (roomList[i].talkerList[3] == null ? (roomList[i].talkerList[2] == null ? '<img id="img1_1" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[0]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg">' : '<img id="img1_2" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[0]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg">') : '<img id="img1_3" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[0]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg"><br>')
                        +  (roomList[i].talkerList[2] != null ? (roomList[i].talkerList[3] != null ? '<img id="img2_1" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[2]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg">' : '<img id="img2_2" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[2]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg">') : '')
                        +  (roomList[i].talkerList[3] != null ? '<img id="img3" src="'+_contextPath+'/resource/member/photo/'+roomList[i].talkerList[3]+'.jpg" onerror=this.src="'+_contextPath+'/resource/member/photo/default.jpg">': '')	
                        + '</td><td style="width:150px;"><button type="button"  id="chat" onclick="getRoomOfApi2('
                         + '\''
                         + roomList[i].tkrm_num
                         + '\''
                         + ')">'
                         + (roomList[i].tkrm_name.length > 9 ? roomList[i].tkrm_name.substring(0,10) + '...' : roomList[i].tkrm_name)
                         + '</button></td><td style="width:70px; padding-bottom: 25px">'
                         + (roomList[i].rnUnreadNum != 0 ? '<div class="circle3"><div class="rnUnreadNum_'+ roomList[i].tkrm_num +'">'+ roomList[i].rnUnreadNum : '')
                         +'</div></div></td></tr>'
                     ); 
                }			
                $('.chatModal').show();
                $('#content2').hide();
                $('#chatting_wrap').hide();
                $('#memberlist').hide();
                $('#groupRoomlist').show();
                $('.phone_bg2').hide();
				$('.phone_bg').show();
				$('.talkBox').hide();
				$('#insertRoom').hide();		
                
                //input에 m_id, m_name 정보 넣기
                $('#m_id').val(res.m_id);
                $('#m_name').val(res.m_name);                
            }
            // 방마다 읽지 않은 메시지 수만 갱신하기
            else if ($('#groupRoomlist').css('display') != 'none') {
                let roomList = res.roomList;
                for(var i = 0; i<roomList.length; i++) {
                    $('.rnUnreadNum_'+roomList[i].tkrm_num).html((roomList[i].rnUnreadNum != 0 ? roomList[i].rnUnreadNum : ''));
                }
            }
		},
		error : function(err){
			console.log('error');
		}
	});
}

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
		$('#roomName').text((room.tkrm_name.length > 6 ? room.tkrm_name.substring(0,7) + '...' : room.tkrm_name));
		for(var i = 0; i < talkList.length; i++) {
		if(talkList[i].tk_type == 1) {
			if(talkList[i].m_id != m_id){				
   					 $('#chating').append(
   					 	'<div id="memo"><p class="others">'
   					 	+ talkList[i].m_name + ':' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
   					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p><p class="unReadNum2" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
   					 ); 
				}
			else if(talkList[i].m_id == m_id){
					$('#chating').append(
   					 	'<div id="memo"><p class="me">'
   					 	+ '나:' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content) 
   					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p><p class="unReadNum1" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
   					 );
   				}
   		} else if(talkList[i].tk_type == 2) {
   			if(talkList[i].m_id != m_id){				
   					 $('#chating').append(
   					 	'<div id="memo2"><p class="others2">'
   					 	+ talkList[i].m_name + ':' + '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
   					 	+'</p><p class="date4">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p><p class="unReadNum2" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
   					 ); 
				}
			else if(talkList[i].m_id == m_id){
					$('#chating').append(
   					 	'<div id="memo2"><p class="me2">'
   					 	+ '<img src = "' + _contextPath + '/' + (talkList[i].tk_content === undefined ? "" : talkList[i].tk_content)  + '" ' + ' style="width: 150px; height: 150px">'
   					 	+'</p><p class="date3">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
   					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
   					 	+'</p><p class="unReadNum1" id="unReadNum'+ talkList[i].tk_num + '"></p></div>'
   					 );
   				}
   		 	}
   		}		
		
		//멤버리스트창 끄고 채팅창 보여주기
		$('#content1').hide();
		$('#chatting_wrap').show();
		$('#content2').hide();
		$('#bakc1').hide();
		$('#groupRoomlist').hide();
		$('.phone_bg').hide();
		$('.phone_bg2').show();
		$('.talkBox').hide();
		$('#insertRoom').hide();		

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
	   					 	+ '"><input type="checkbox" name="group" class="groupCheckbox" id="groupCheckbox" value="'
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
				$('.phone_bg2').hide();
				$('.phone_bg').show();	
				$('.talkBox').hide();
				$('#insertRoom').show();
				$('#makegroup').show();		
				
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
    $('.groupCheckbox:checked').each(function(){
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
		$('#roomName').text((room.tkrm_name.length > 6 ? room.tkrm_name.substring(0,7) + '...' : room.tkrm_name));
			
				$('#content1').hide();
				$('#content2').hide();
				$('#chatting_wrap').show();
				$('#back1').hide();
				$('.phone_bg').hide();
				$('.phone_bg2').show();	
				$('.talkBox').hide();
				$('#insertRoom').show();		
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
				$('.phone_bg2').hide();
				$('.phone_bg').show();
				$('.talkBox').hide();
				$('#insertRoom').hide();		
				
				//input에 m_id, m_name 정보 넣기
				$('#m_id').val(res.m_id);
				$('#m_name').val(res.m_name);
				
				//채팅 기록 지우기(변경됨)
				$('#chating').html('');
				$('#roomName').html('');
				$('.groupCheckbox').removeAttr('checked');
				$('#join_member_list').html('');
				$('#groupRoomlist').html('');
				//$('#groupRoomlist').append('<tr><th colspan="2">방 이름</th></tr>');
				$('#join_member_list').html('');
				
				// 안읽은 메시지 숫자 가져오기
				refreshNumOfAllUnread();
				
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
				$('.phone_bg').hide();
				$('.phone_bg2').show();
				$('.talkBox').show();	
				$('#insertRoom').hide();		
				
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
		var option = {
			type : 'm_id',
			m_id : $('#sec_m_id').val()
		}
		ws.send(JSON.stringify(option));
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
				readMember();
			}else if(jsonMsg.type == "message"){
			// type이 message인 경우엔 채팅이 발생한 경우.
            // 상대방과 자신을 구분하기 위해 여기서 sessionId값을 사용
            // 최초 이름을 입력하고 연결되었을때, 발급받은 sessionId값을 비교하여 같다면 자기 자신이 발신한
            // 메시지이므로 오른쪽으로 정렬하는 클래스를 처리하고 메시지를 출력.     
            // 비교하여 같지 않다면 타인이 발신한 메시지이므로 왼쪽으로 정렬하는 클래스를 처리하고 메시지를 출력
            	nowTk_num = jsonMsg.tk_num;
				if(jsonMsg.sessionId == $("#sessionId").val()){
					isMyMessage = 1;
					$("#chating").append('<div id="memo"><p class="me">' + '나 : ' + jsonMsg.msg + '</p><br><p class="date">' + moment(date).format('HH:mm') + '</p><p class="unReadNum1" id="unReadNum'+ jsonMsg.tk_num + '"></p></div>');
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}else{
					isMyMessage = 0;
					$("#chating").append('<div id="memo"><p class="others">' + jsonMsg.userName + ' : ' + jsonMsg.msg + '</p><br><p class="date2">' + moment(date).format('HH:mm') + '</p><p class="unReadNum2" id="unReadNum'+ jsonMsg.tk_num + '"></p></div>');
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}
				// 읽었다고 알려주기
				readMember();						
			}else if(jsonMsg.type == "updateOfSession"){ // 현재 방에 세션 관련 업데이트 필요할 때
				console.log(jsonMsg.type);
				console.log("numOfAllMember: " + jsonMsg.numOfAllMember);
				console.log("numOfSessionMember: " + jsonMsg.numOfSessionMember);
				countUnread($("#roomNumber").val());
			}else if(jsonMsg.type == 'beforeFile'){ // 파일 보내기 전에 보내는 메세지
				nowTk_num = jsonMsg.tk_num;
				nowUserName = jsonMsg.userName;
				nowDate = moment(date).format('HH:mm');
				if(jsonMsg.sessionId == $("#sessionId").val()) {
					isMyMessage = 1;
				} else {
					isMyMessage = 0;
				}
				console.log(jsonMsg.type);
				
				// 읽었다고 알려주기
				readMember();
			}
			else{
				console.warn("unknown type!" + jsonMsg.type);
			}


		}else{
			// 파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다
			var url = URL.createObjectURL(new Blob([msg]));
			if(isMyMessage == 1){
				// '<div class="img"><p class="unReadNum1" id="unReadNum'+ nowTk_num + '"></p><img class="msgImg" src='+url+'></div><div class="clearBoth"></div>'
				$("#chating").append(
		            '<div id="memo2"><p class="me2">'
		            + '<img src = "' + url + '" ' + ' style="width: 150px; height: 150px">'
		            + '</p><p class="date3">'
		            + '<br>' + nowDate
		            + '</p><p class="unReadNum1" id="unReadNum' + nowTk_num + '"></p></div>'			            			
				);
				$("#chating").scrollTop($("#chating")[0].scrollHeight);
			} else{
				// '<div class="img2"><p class="unReadNum2" id="unReadNum'+ nowTk_num + '"></p><img class="msgImg2" src='+url+'></div><div class="clearBoth"></div>'
				$("#chating").append(		
		            '<div id="memo2"><p class="others2">'
		            + nowUserName + ':' + '<img src = "' + url + '" ' + ' style="width: 150px; height: 150px">'
		            + '</p><p class="date4">'
		            + '<br>' + nowDate
		            + '</p><p class="unReadNum2" id="unReadNum' + nowTk_num + '"></p></div>'				
				);
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

// 특정 방번호의 모든 메세지에 대한 읽지 않은 수를 가져와서 메세지 옆에 업데이트
function countUnread(tkrm_num) {
	$.ajax({
        url : _contextPath + '/talk/countUnread',
        data: {'roomNumber' : $("#roomNumber").val()},
        type : 'get',
        success: function(res) {
            let numOfUnreadList = res.numOfUnreadList;
            for(var i = 0; i<numOfUnreadList.length; i++) {
                let tk_num = numOfUnreadList[i].tk_num;
                let unread_num = numOfUnreadList[i].unread_num;
                $('#unReadNum' + tk_num).text(unread_num);
                if (unread_num == 0) {
                    $('#unReadNum' + tk_num).text('');
                }
            }
        },
        error : function(err){
            console.log('error');
        }        
	});
}
		

function send(type) {
	if (!type) {
		type = 'message';
	}
	var option ={
		type: type,
		roomNumber : $("#roomNumber").val(),  
		sessionId : $("#sessionId").val(),
		userName : $("#m_name").val(),
		msg : $("#chatting").val(),
		m_id : $("#m_id").val()
	}  //roomNumber는 방의 번호를 보내줌으로써 소켓서버는 어느방에서 메시지를 보냈는지 구분
	ws.send(JSON.stringify(option))
	if (type == 'message') {
		$('#chatting').val("");
	}
}

function fileSend() {
	console.log("파일전송 시작");
	// 파일 보낼 것이라는 것을 알려주기
	send('beforeFile');
	
	// 파일 보내기
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

// 메세지 읽었다고 알려주기
function readMember() {
	$.ajax({
		url: _contextPath + '/talk/readMember',
		data: {	'roomNumber' : $("#roomNumber").val(),
				'm_id' : $("#m_id").val()
		},
		type: 'get',
		success: function (res) {
			send('readMember');
		},
		error : function(err){
			console.log('error');
		}
	});
}

// 메신저창 닫기
$(document).ready(function() {
	$(".button_x3").on("click", function () {
		$('#groupRoomlist').hide();
		$('.chatModal').hide();
		$('#TestCircle').show();
		$('#Test').show();
		// 안읽은 메시지 숫자 가져오기
		refreshNumOfAllUnread();
	});
});
































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