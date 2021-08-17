// 사이드바 가리기/보여주기
function doShow() {
	if ($('#side').is(":visible")) {
		$('#side').hide();
		$('#content').css({
			"width" : "100%"
		});
		$('#hide_changeSideDisplay').hide();
		$('#show_changeSideDisplay').show();		
	} else {
		$('#side').show();
		$('#content').css({
			"width" : "84%"
		});
		$('#show_changeSideDisplay').hide();
		$('#hide_changeSideDisplay').show();			
	}
}

// 로딩 화면 띄우기
function waitLoading() {
	$('#loading_modal').show();
}

// 헤더 오른쪽에 프로필 사진 눌렀을 때 메뉴 띄우기/가리기
function showHeaderRightModal() {
	if ($('#header_right_modal').is(":visible")) {
		$('#header_right_modal').hide();
	} else {
		$('#header_right_modal').show();
	}
}


	$(function() {
		// jquery-ui sortable
		$( ".sortable" ).sortable();
	    $( ".sortable" ).disableSelection();
		
		// jquery-ui draggable
		$('.drag').draggable({ 
		}); 	    
	});