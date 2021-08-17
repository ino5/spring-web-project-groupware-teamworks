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

// 첨부파일 추가
$('.multipartFile').on('change',addInputOfMultipartFile);
let indexOfTableOfWrite = 4;
function addInputOfMultipartFile(e) {
	let tableOfWrite = document.getElementById('table_write');
	let newRow = tableOfWrite.insertRow(indexOfTableOfWrite);
	let newCell1 = newRow.insertCell(0);
	let newCell2 = newRow.insertCell(1);
	newCell1.className += 'title txt';
	newCell2.innerHTML='<input class="multipartFile" type="file" name="multipartFile">';
	$('.multipartFile').on('change',addInputOfMultipartFile);
	++indexOfTableOfWrite;	
}