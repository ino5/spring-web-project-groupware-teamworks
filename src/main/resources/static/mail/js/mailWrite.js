/* 썸머노트 */
$('#summernote').summernote({
	height : 600, // 에디터 높이
	width: 1100,
	fontSize: 16,
	
	minHeight : null, // 최소 높이
	maxHeight : null, // 최대 높이
	focus : true, // 에디터 로딩후 포커스를 맞출지 여부
	lang : "ko-KR", // 한글 설정
	placeholder : '내용을 입력하세요.', //placeholder 설정
	callbacks: {	//이미지 첨부하는 부분
               onImageUpload : function(files) {
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
            $(editor).summernote('insertImage', _contextPathWithDomain+data.url);
        }
    });
}
/* End of 썸머노트  */