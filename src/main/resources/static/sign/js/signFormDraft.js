//'결재라인 추가' 버튼 클릭시 모달창 띄우는 이벤트
$(document).on(
		"click", 
		"#button_new_sign_line", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_new_sign_line').css('display', 'block');
		});

//'결재라인 추가' 모달창 닫기 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		"#modal_close_new_sign_line", 
		e => { 
			closeModalOfNewSignLine();
		});
		
		
//모달창 닫기
function closeModalOfNewSignLine() {
	$('.black_bg').css('display', 'none');
	$('#modal_wrap_new_sign_line').css('display', 'none');
}

//결재라인 추가하기
function addSignLine(m_id, m_name, dpt_name, pt_name) {
	$('#sortable').append(''
		+ '<li class="ui-state-default">'
			+ '<span class="ic ic_drag"></span>'
			+ '<input type="hidden" name="sgl_m_id" value= "' + m_id + '">'
			+ '<input type="hidden" name="sgl_type" value= "1">'
			+ m_name + ' '
			+ dpt_name + ' '
			+ pt_name											
		+ '</li>'
	)
}