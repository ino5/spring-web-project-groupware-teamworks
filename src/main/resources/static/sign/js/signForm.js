/* 결재라인 추가 모달창 */
//'결재라인 추가' 버튼 클릭시 모달창 띄우는 이벤트
$(document).on(
		"click", 
		"#button_new_sign_line", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_new_sign_line').css('display', 'block');
		});

//'결재라인 추가' 모달창 닫기 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		"#modal_close_new_sign_line", 
		e => { 
			closeModalOfNewSignLine();
		});
		
		
//모달창 닫기
function closeModalOfNewSignLine() {
	$('.black_bg').css('display', 'none');
	$('#modal_wrap_new_sign_line').css('display', 'none');
}

//결재라인 추가하기
function addSignLine(m_id, m_name, dpt_name, pt_name) {
	$('#sortable').append(''
		+ '<li class="ui-state-default">'
			+ '<span class="ic ic_drag"></span>'
			+ '<input type="hidden" name="sgl_m_id" value= "' + m_id + '">'
			+ '<input type="hidden" name="sgl_type" value= "1">'
			+ '<span class="sign_line_txt">'
			+ m_name + ' '
			+ dpt_name + ' '
			+ pt_name
			+ '</span>'										
		+ '</li>'
	);
	//content_top 높이 늘이기
	$('#content_top').height($('#content_top').height() + $('.ui-state-default').outerHeight(true));
}
/* End of 결재라인 추가 모달창 */

/* 결재하기 */
//결재하기 모달창 띄우기
$(document).on(
		"click", 
		"#button_approval", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_approval').css('display', 'block');
		});
//결재하기 모달창 닫기
$(document).on(
		"click", 
		"#button_approval_no", 
		e => { 
			$('.black_bg').css('display', 'none');
			$('#modal_wrap_approval').css('display', 'none');
		});
/* End of 결재하기 */

/* 반려하기 */
//반려하기 모달창 띄우기
$(document).on(
		"click", 
		"#button_return", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_return').css('display', 'block');
		});
//반려하기 모달창 닫기
$(document).on(
		"click", 
		"#button_return_no", 
		e => { 
			$('.black_bg').css('display', 'none');
			$('#modal_wrap_return').css('display', 'none');
		});
/* End of 반려하기 */

/* 오늘 날짜 가져오기 */
let today = new Date();   
let today_year = today.getFullYear();
let today_month = today.getMonth() + 1;
let today_date = today.getDate();
let today_day = today.getDay();
let today_format = today_year + "/" + (today_month>9 ? today_month : "0" + today_month) + "/" + (today_day>9 ? today_day : "0" + today_day);

$('.today').text(today_format);
/* End of 오늘 날짜 가져오기 */

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
            $(editor).summernote('insertImage', _contextPath+data.url);
        }
    });
}
/* End of 썸머노트  */