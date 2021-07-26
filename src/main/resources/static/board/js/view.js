	$(document).ready(function() {
		//여기 아래 부분
		
		$('#summernote').summernote({
			height : 300, // 에디터 높이
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
	});
	$('.summernote').summernote({
		height : 300,
		lang : "ko-KR"
	});
	
	
	
	////////////////////////
	var mid = $('#m_id').val();
	var loginId = $('#loginId').val();
	console.log("mid",mid);
	console.log("loginId",loginId);
	if(mid != loginId){
		alert(true);
		$('#summernote').summernote('enable');
		
	}else{
		alert(false)
		$('#summernote').summernote('disable');
		$("#btnUpdete").remove();
		$("#btnDelete").remove();

	}
	console.log($("#btnUpdete"));
	
	function uploadSummernoteImageFile(file, editor) {
        data = new FormData();
        data.append("file", file);
        $.ajax({
            data : data,
            type : "POST",
            url : "/uploadSummernoteImageFile",
            contentType : false,
            processData : false,
            success : function(data) {
                //항상 업로드된 파일의 url이 있어야 한다.
                $(editor).summernote('insertImage', data.url);
            }
        });
    }