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
		clock1.innerHTML = nowDate; // 현재시간을 출력
		clock2.innerHTML = nowTime;
		month1.innerHTML = nowMonth;
		setTimeout("printTime()", 1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}
	window.onload = function() { // 페이지가 로딩되면 실행
		printTime();
	}
	
	$(document).ready(function() {
		$("#button1").click(function() {
			var submenu = $(this).next("#scroll");
			// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
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
			var submenu = $(this).next("#scroll");
			// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
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
	
		// div side 없애기
	function doShow() {
		if ($('#side').is(":visible")) {
			$('#side').hide();
			$('#content').css({
				"width" : "100%"
			});
		} else {
			$('#side').show();
			$('#content').css({
				"width" : "84%"
			});
		}
	}