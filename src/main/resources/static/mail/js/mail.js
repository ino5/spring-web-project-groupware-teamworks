// 체크한 메일 삭제
function deleteMails() {
	let chkArr = [];
	$('.checkbox_mail:checked').each(function() {
		chkArr.push($(this).val());
	});
	$.ajax({
		type: "POST",
		data: {'chkArr' : chkArr},
		url: _contextPath + "/mail/delete",
		success : function (res) {
			$('.checkbox_mail:checked').each(function() {
				$('#tr_mail_' + $(this).val()).remove();
			});
		}
	})
}

// 체크박스 전체 선택
$(document).on('click', '.all_checkbox_mail',
	e => {
		if (e.target.checked) {
			$('.checkbox_mail').prop("checked", true);
		} else {
			$('.checkbox_mail').prop("checked", false);
		}
	});