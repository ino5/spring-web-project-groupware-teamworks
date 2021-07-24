	function button_click() {
				document.getElementById("container").style.display = "block";
	}
	var ws;

	window.onload = function(){   
		// window.onload라는 메서드를 오버라이딩(재정의) 해주면 되는데, 해당 함수 내의 코드 스크립트는 웹브라우저 내의 모든 요소가 준비가 되어야 실행이 되도록 할수 있다.
		// (웹브라우저 자체를 담당하는 window라는 객체가, 웹 문서를 불러올때, 문서가 사용되는 시점에 실행되는 onload라는 함수를 내가 다시 재정의 한다는 개념이다.)
		console.log("window.onload start...");
		getRoom();
		createRoom();
	}

	function getRoom(){
		console.log("getRoom start...");
		commonAjax(_contextPath+'/talk/getRoom', "", 'post', function(result){
			createChatingRoom(result);
		});
	}
	
	function createRoom(){
		console.log("createRoom start...");
		$("#createRoom").click(function(){
			var msg = {	roomName : $('#roomName').val()	};
			commonAjax(_contextPath+'/talk/createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}

	function goRoom(number, name){
		console.log("goRoom");
		location.href=_contextPath+"/talk/moveChating?roomName="+name+"&"+"roomNumber="+number;
	}
	

	function createChatingRoom(res){
		console.log("createChatingRoom");
		if(res != null){
			var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'></th></tr>";
			res.forEach(function(d, idx){
				var rn = d.roomName.trim();
				var roomNumber = d.roomNumber;
				tag += "<tr>"+
							"<td class='num'>"+(idx+1)+"</td>"+
							"<td class='room'>"+ rn +"</td>"+
							"<td class='go'><button type='button' class='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\"); button_click();'>참여</button></td>" +
						"</tr>";	
			});
			$("#roomList").empty().append(tag);
		}
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}

	var isMyMessage = 0;
	function wsOpen(){
		console.log("wsOpen  location.host: " + location.host);
        var wsUri  = "ws://" + location.host + _contextPath + "/taking/"+$("#roomNumber").val();
 		ws = new WebSocket(wsUri);
		wsEvt();
	}
		
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
			alert("ws.onmessage->"+msg)
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
						$("#chating").append("<p class='me'>" + jsonMsg.msg + "</p>");	
					}else{
						isMyMessage = 0;
						$("#chating").append("<p class='others'>" + jsonMsg.userName + " : " + jsonMsg.msg + "</p>");
					}						
				}else{
					console.warn("unknown type!")
				}
			}else{
				// 파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다
				var url = URL.createObjectURL(new Blob([msg]));
				if(isMyMessage == 1){
					$("#chating").append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div>");	
				} else{
					$("#chating").append("<div class='img2'><img class='msgImg2' src="+url+"></div><div class='clearBoth'></div>");
				}	
			}
		}
		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

	function chatName(){
		var userName = $("#userName").val();
		console.log("chatName userName: " + userName);
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#meName").append('나의이름:'+userName); 
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {
		var option ={
			type: "message",
			roomNumber : $("#roomNumber").val(),  
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
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
				userName : $("#userName").val()
			}
			ws.send(JSON.stringify(param)); // 파일 보내기전 메시지를 보내서 파일을 보냄을 명시
			$('chatting').val("");
		
			arrayBuffer = this.result;
				ws.send(arrayBuffer); // 파일 소켓 전송
		};
		fileReader.readAsArrayBuffer(file);	
	}