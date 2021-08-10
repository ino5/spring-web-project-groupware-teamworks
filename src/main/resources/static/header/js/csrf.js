//csrf 토큰 값에 대해 js 변수 설정
let _token = $("meta[name='_csrf']").attr("content");
let _header = $("meta[name='_csrf_header']").attr("content");

//ajax마다 csrf 토큰 전송 
$(document).ready(function(){
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(_header, _token);
    });
});