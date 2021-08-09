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
	
	var mid = $('#m_id').val();
	var loginId = $('#loginId').val();
	console.log("mid",mid);
	console.log("loginId",loginId);
	if(mid == loginId){
		$('#summernote').summernote('enable');
		
	}else{
		$('#summernote').summernote('disable');
		$("#btnUpdete").remove();
		$("#btnDelete").remove();
	}
	console.log($("#btnUpdete"));
	
	
//이미지파일 업로드
function uploadSummernoteImageFile(file, editor) {
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data : data,
        type : "POST",
        url : _contextPath+"/board/uploadSummernoteImageFile",
        contentType : false,
        processData : false,
        success : function(data) {
            //항상 업로드된 파일의 url이 있어야 한다.
            $(editor).summernote('insertImage', _contextPath+data.url);
        }
    });
}
//댓글삭제
function clickDelete(rpNum){
	console.log(rpNum);
	
	$.ajax({
        type : "POST",
        url : _contextPath+"/board/reply_delete",   
        data : {'rp_num':rpNum},
        success : function(result) {
        	console.log(result);
             $(".rp_"+rpNum).remove();
        },
         error: function(err) {
         
	 
			console.log(err);
			
			//현재 통신후 404 에러가 나서 임의로 구현
			// 아이디가 rp_num td를 찾아서 remove
	      //  $("#"+rpNum).remove();
		}
        
    });
}
//아이디가 관리자인 사람만 보이게 
	var mid = $('#m_id').val();
	var loginId = $('#loginId').val();
	console.log("mid",mid);
	console.log("loginId",loginId);
	if(mid == loginId){
		$('#summernote').summernote('enable');
		
	}else{
		$('#summernote').summernote('disable');
		$("#btnUpdete").remove();
		$("#btnDelete").remove();
	}
	console.log($("#btnUpdete"));

