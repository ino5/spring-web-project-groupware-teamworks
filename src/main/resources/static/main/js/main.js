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

	$.ajax({
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
		}
	});
}

/* 모달창 관련 스크립트 */
//'새 결재 진행' 버튼 클릭시 모달창 띄우는 이벤트
let isAppendedNewSign = false;
$(document).on(
		"click", 
		"#button_new_sign", 
		e => {
			if (isAppendedNewSign == false) {
				$.ajax({
					type: "GET",
					url: _contextPath + "/sign/api/getListOfSignForm",
					success: function(res) {
						//결재 양식 가져오기
						let listOfCommonGroup = res.listOfCommonGroup;
						let listOfSignForm = res.listOfSignForm;
						let indexOfListOfSignForm = 0;
						let stringAppended = "";
						stringAppended += ('<ul class="common_group">');
						for (let i = 0; i < listOfCommonGroup.length; i++) {
						    console.log(listOfCommonGroup[i].cg_name);
						    stringAppended += (
						    	'<li class="common_group">'
						    	+ '<span class="common_group_title">' +listOfCommonGroup[i].cg_name + '</span>'
						    	+ '<ul class="sign_form">'
						    );
						    for (let j = indexOfListOfSignForm; j < listOfSignForm.length; j++) {
								if (listOfSignForm[j].cg_num == listOfCommonGroup[i].cg_num) {
									console.log(listOfSignForm[j].sgf_name);
									stringAppended += (
										'<li class="sign_form">'
										+ '<button type="button" class="button_new_sign_form" onclick="moveSignForm(\''+ listOfSignForm[j].sgf_id +'\')">'
										+ listOfSignForm[j].sgf_name
										+ '</button>'
										+ '</li>'
									);
								} else {
									indexOfListOfSignForm = j;
									break;
								}
						    }
						    stringAppended += ('</ul></li>');
						}
						stringAppended += ('</ul>');
						$('#sign_form_list').append(stringAppended);			
						//반복 방지
						isAppendedNewSign = true;				
					}				
				});
			}
			//모달창 보여주기
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_new_sign').css('display', 'block');
		});

//'새 결재 진행' 모달창 닫기 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		"#modal_close_new_sign", 
		e => { 
			$('.black_bg').css('display', 'none');
			$('#modal_wrap_new_sign').css('display', 'none');
		});
		
		
//새 전자 결재 창 이동
function moveSignForm(sgf_id) {
	form_new_sign.sgf_id.value = sgf_id;
	form_new_sign.submit();
	
}
/* End of 모달창 관련 스크립트 */

//다운로드 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		".button_download_file", 
		e => { 
			let dv_id = $(e.currentTarget).data('dv_id');
			window.location = _contextPath + '/drive/download/' + dv_id;
		});
