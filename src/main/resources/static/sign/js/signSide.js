/* 모달창 관련 스크립트 */
//'새 결재 진행' 버튼 클릭시 모달창 띄우는 이벤트
$(document).on(
		"click", 
		"#button_new_sign", 
		e => {
			$.ajax({
				type: "GET",
				url: _contextPath + "/sign/api/getListOfSignForm",
				success: function(res) {				
					let listOfCommonGroup = res.listOfCommonGroup;
					let listOfSignForm = res.listOfSignForm;
					let indexOfListOfSignForm = 0;
					let stringAppended = "";
					stringAppended += ('<ul class="common_group">');
					for (let i = 0; i < listOfCommonGroup.length; i++) {
					    console.log(listOfCommonGroup[i].cg_name);
					    stringAppended += (
					    	'<li class="common_group">'
					    	+ listOfCommonGroup[i].cg_name
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
					//모달창 보여주기
					$('.black_bg').css('display', 'block');
					$('#modal_wrap_new_sign').css('display', 'block');
					//debugger;
				}
			});
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


/* 메뉴 스크립트 */
$(document).ready(function() {
	$("#button1").click(function() {
		var submenu = $(this).next("#scroll1");
		if (submenu.is(":visible")) {
			$('#img1').css({
				'transform' : 'rotate(0deg)'
			});
			submenu.slideUp("fast");
		} else {
			$('#img1').css({
				'transform' : 'rotate(90deg)'
			});
			submenu.slideDown("fast");
		}
	})
});
$(document).ready(function() {
	$("#button2").click(function() {
		var submenu = $(this).next("#scroll2");
		if (submenu.is(":visible")) {
			$('#img2').css({
				'transform' : 'rotate(0deg)'
			});
			submenu.slideUp("fast");
		} else {
			$('#img2').css({
				'transform' : 'rotate(90deg)'
			});
			submenu.slideDown("fast");
		}
	})
});
/* End of 메뉴 스크립트 */