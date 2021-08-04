//다운로드 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		".button_download_file", 
		e => { 
			let dv_id = $(e.currentTarget).data('dv_id');
			window.location = _contextPath + '/drive/download/' + dv_id;
		});

//삭제 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		".button_delete_file", 
		e => { 
			let dv_id = $(e.currentTarget).data('dv_id');
			$.ajax({
				type: "POST",
				url: _contextPath + '/drive/delete/' + dv_id,
				success: result => {
							console.log('result code of delete_file:' + result);
							if (result > 0) {
								alert('삭제 완료');
								$("#row_dv_id_"+dv_id).remove();
							} else {
								alert('삭제 실패');
							}
						}
			});
		});
		
//업로드 버튼 클릭 시 이벤트 (모달창 띄우기)
$(document).on(
		"click", 
		"#button_upload_file", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_upload_file').css('display', 'block');
		});

//업로드 모달창 닫기 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		"#modal_close_upload_file", 
		e => { 
			$('.black_bg').css('display', 'none');
			$('#modal_wrap_upload_file').css('display', 'none');
		});



		