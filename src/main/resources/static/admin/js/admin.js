 $(document).ready(function(){
        $("#button1").click(function(){
            var submenu = $(this).next("#scroll");
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
            	$('#img1')
                .css({'transform': 'rotate(0deg)'});
                submenu.slideUp("fast");
            }else{
            	$('#img1')
                .css({'transform': 'rotate(90deg)'});
                submenu.slideDown("fast");
            }
        })
        $("#button2").click(function(){
            var submenu = $(this).next("#scroll");
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
            	$('#img2')
                .css({'transform': 'rotate(0deg)'});
                submenu.slideUp("fast");
            }else{
            	$('#img2')
                .css({'transform': 'rotate(90deg)'});
                submenu.slideDown("fast"); 	
            }
        })
    });

function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('check');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	
	//모달창
		jQuery(document).ready(function() {
			$("#add").click(function() {
				$('#myModal').show();
			})
		});
		//팝업 Close 기능
		$(document).ready(function() {
			$("#close_btn").unbind('click').on('click', function() {
				$('#myModal').hide();
			});
		});
		//팝업 Close 기능
		$(document).ready(function() {
			$("#x_icon").unbind('click').on('click', function() {
				$('#myModal').hide();
			});
		});
		