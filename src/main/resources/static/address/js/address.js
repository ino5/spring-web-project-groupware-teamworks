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
		
		var div2 = document.getElementsByClassName('click_a');

	    for (var i = 0; i < div2.length; i++) {
	      div2[i].addEventListener('click', function(){
	        for (var j = 0; j < div2.length; j++) {
	          div2[j].style.color = "#8C8C8C";
	          div2[j].style.fontWeight = "normal";
	          div2[j].style.borderBottom = "none";
	        }
	        this.style.color = "black";
	        this.style.fontWeight = "bold";
	        this.style.borderBottom = "2px solid black";
	      })
	    }	    	
	    
	    // 달력 클릭 시 모달창 열기
		$("#bbb").on("click", function () {
			$('#myModal2').show();
		});
	    
	    	// 달력 클릭 시 모달창 열기
		$("#groupSet").on("click", function () {
			$('#myModal').show();
		});
		//모달창 Close 기능
		$("#close_btn").unbind('click').on('click', function() {
			$('#myModal').hide();
		});
		//모달창 Close 기능
		$("#x_icon").unbind('click').on('click', function() {
			$('#myModal').hide();
		});
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
			})
			$('#board_table').css({"width": "97%"}); 
			$('#list_table').css({"width": "97%"}); 
		} else {
			$('#side').show();
			$('#content').css({
				"width" : "84%"
			})
			$('#board_table').css({"width": "95%"}); 
		    $('#list_table').css({"width": "100%"}); 
		}
	}
	// li 만들기 (groupAdd)
	function doShow3() {
		if ($('#group').is(":visible")) {
			$('#group').fadeOut(150);
		} else {
			$('#group').fadeIn(150);
			$('#group').show();
		}
	}
	// div speed 만들기
	function doShow2() {
		if ($('#speed').is(":visible")) {
			$('#speed').fadeOut(150);
		} else {
			$('#speed').fadeIn(150);
			$('#speed').show();
		}
	}
	
	function selectAll(selectAll)  {
		const checkboxes 
		       = document.getElementsByName('check');
		  
		checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  })
		}

		
		var globalResult;
	function addressSearchList(start, end) {
		var str = "";

		$.ajax({
				url : _contextPath + "/address/addressSearchList",
				data : {
					start_num : start,
					end_num : end
				},
				dataType : 'json',
				success : function(result) {
					console.log("ajax success");
					console.log(result);
					var jsonResult = JSON.stringify(result);
					$('#list_table > tbody').empty();
					$('#pg').empty();
					$.each(
								result,
									function(i) {
										if (result[i].m_empnum == 0) {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										} else {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ result[i].m_empnum
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										}
									});
					$("#list_table").append(str);
					}
				});
	}
		function addressSearchListDept(start, end, code) {
		var str = "";

		$.ajax({
				url : _contextPath + "/address/addressSearchListDept",
				data : {
					start_num : start,
					end_num : end,
					dpt_code : code
				},
				dataType : 'json',
				success : function(result) {
					console.log("ajax success");
					console.log(result);
					var jsonResult = JSON.stringify(result);
					$('#list_table > tbody').empty();
					$('#pg').empty();
					$.each(
								result,
									function(i) {
										if (result[i].m_empnum == 0) {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										} else {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ result[i].m_empnum
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										}
									});
					$("#list_table").append(str);
					}
				});
	}
	
	
		function addressSearchListPersonal(start, end, num) {
		var str = "";

		$.ajax({
				url : _contextPath + "/address/addressSearchListPersonal",
				data : {
					start_num : start,
					end_num : end,
					adg_num : num
				},
				dataType : 'json',
				success : function(result) {
					console.log("ajax success");
					console.log(result);
					var jsonResult = JSON.stringify(result);
					$('#list_table > tbody').empty();
					$('#pg').empty();
					$.each(
								result,
									function(i) {
										if (result[i].m_empnum == 0) {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										} else {
											str += "<TR><td style=\"text-align: center;\"><input type=\"checkbox\" name=\"check\" id=\"chk_1\"></td><TD>"
													+ result[i].m_name
													+ '</TD><TD>'
													+ result[i].m_empnum
													+ '</TD><TD>'
													+ result[i].m_phone
													+ '</TD><TD>'
													+ result[i].m_email
													+ '</TD><TD>'
													+ result[i].dpt_name
													+ '</TD><TD>'
													+ result[i].pt_name;
											str += '</TR>';
										}
									});
					$("#list_table").append(str);
					}
				});
	}
	