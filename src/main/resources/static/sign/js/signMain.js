//'새 결재 진행' 버튼 클릭시 모달창 띄우는 이벤트
$(document).on(
		"click", 
		"#button_new_sign", 
		e => { 
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