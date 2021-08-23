	let sampleWs;
	let sampleAlertTimer;
	
	function sampleWsOpen(){
		sampleWs = new WebSocket("ws://" + location.host + _contextPath +"/socket/sample");
		sampleWsEvt();
	}
		
	function sampleWsEvt() {
		sampleWs.onopen = function(data){
			sampleSend('m_id');
		}
		
		sampleWs.onmessage = function(data) {
			console.log('onmessage');
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var jsonMsg = JSON.parse(msg);
				// 이미지 전송 받을 때
				if (jsonMsg.type == 'beforeFile') {
					jsonMsg.type = 'message';
					jsonMsg.msg = '(이미지)';
				}
				if (jsonMsg.type == 'message') {
					if (jsonMsg.m_id != $('#sec_m_id').val()) {				
						// html, css 초기화 
						clearTimeout(sampleAlertTimer);
						$('#sample_alert_wrapper').css('transition', '0s');
						$('#sample_alert_wrapper').hide();
						$('#sample_alert_wrapper').height('0px');
						$('#sample_alert_photo').html('');
						$('#sample_alert_userName').html('');
						$('#sample_alert_msg').html('');
						$('#sample_alert_wrapper').css('border', '1px solid black');
						
						// 메세지 삽입
						$('#sample_alert_photo').append(''		
							+ '<img id="sample_alert_img_photo" onclick="showHeaderRightModal();"'
							+ ' src="' + _contextPath + '/resource/member/photo/' + jsonMsg.m_id + '.jpg"'
							+ ' onerror="this.src=\'' + _contextPath + '/resource/member/photo/default.jpg\'">'
						);
						$('#sample_alert_userName').append(jsonMsg.userName);
						$('#sample_alert_msg').append(jsonMsg.msg);
						
						// 알림창 보여주기
						$('#sample_alert_wrapper').show();
						$('#sample_alert_wrapper').css('transition', '0.5s');
						$('#sample_alert_wrapper').height('100px');
						
						// 안읽은 메세지 수 초기화하기
						refreshNumOfAllUnread();
						
						// 알림창 사라지기
						sampleAlertTimer = setTimeout(function() {
							$('#sample_alert_wrapper').height('0px');
							$('#sample_alert_wrapper').css('border', 'none');
						}, 2000);
					}
				}
			}
		}
	}

	function sampleSend(type) {
		if (!type) {
			type = 'message';
		}
		var option = {
				type : type,
				m_id : $('#sec_m_id').val()
		}
		sampleWs.send(JSON.stringify(option));
		
	}
	
	$(document).ready(function() {
		sampleWsOpen();
	});