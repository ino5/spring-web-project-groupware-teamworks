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
		
		
	$('#summernote').summernote({
		height : 600, // 에디터 높이
		width:1300,

		minHeight : null, // 최소 높이
		maxHeight : null, // 최대 높이
		focus : true, // 에디터 로딩후 포커스를 맞출지 여부
		lang : "ko-KR", // 한글 설정
		placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
		callbacks: {	//이미지 첨부하는 부분
	               onImageUpload : function(files) {
	            	   	alert("onImageUpload : function");
	                    uploadSummernoteImageFile(files[0],this);
	                }
	            }

	});	
	

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

