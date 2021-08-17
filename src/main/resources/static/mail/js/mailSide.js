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