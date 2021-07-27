
$('#summernote').summernote({
	height : 300, // 에디터 높이
	minHeight : null, // 최소 높이
	maxHeight : null, // 최대 높이
	focus : true, // 에디터 로딩후 포커스를 맞출지 여부
	lang : "ko-KR", // 한글 설정
	placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
	callbacks: {	//이미지 첨부하는 부분
               onImageUpload : function(files) {
               		var maxImageSize = 10 * 1024 * 1024;
                    uploadSummernoteImageFile(files[0],this);
                }
            }

});
$('.summernote').summernote({
	height : 300,
	lang : "ko-KR"
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
function clickDelete(rpNum){
	console.log(rpNum);
	
	$.ajax({
        type : "POST",
        url : _contextPath+"/board/reply_delete",   
        data : {'rp_num':rpNum},
        success : function(result) {
        	console.log(result);
             $("#rp_"+rpNum).remove();
        },
         error: function(err) {
         
	        //서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
	        //서버로 가는 경로를 못찾아서 404가 나는게 아니라
			//서버로는 정상적으로 찾아 갔는데 success function(data) 여기로 들어오지를 않음
			console.log(err);
			
			//현재 통신후 404 에러가 나서 임의로 구현
			// 아이디가 rp_num td를 찾아서 remove
	      //  $("#"+rpNum).remove();
		}
        
    });
}
//댓글삽입 아작스
function clickinsert(rpNum2){
	console.log(rpNum2);
	
	$.ajax({
        type : "POST",
        url : _contextPath+"/board/rereply_insert",   
        data : {'rp_num':rpNum2},
        success : function(result) {
        	console.log(result);
             $("#rp_"+rpNum2).remove();
        },
         error: function(err) {
         
			console.log(err);
			
		}
        
    });
}
$(document).ready(function() {
	//여기 아래 부분					
	////////////////////////
	var mid = $('#m_id').val();
	var loginId = $('#loginId').val();
	console.log("mid",mid);
	console.log("loginId",loginId);
	if(mid == loginId){
		//alert(true);
		$('#summernote').summernote('enable');
		
	}else{
		alert(false)
		$('#summernote').summernote('disable');
		$("#btnUpdete").remove();
		$("#btnDelete").remove();

	}
	console.log($("#btnUpdete"));
	
});
