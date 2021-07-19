let _token = $("meta[name='_csrf']").attr("content");
let _header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function(){
    $(document).ajaxSend(function(e, xhr, options) {
    	//console.log("-- in header/js/csrf.js : " + "_token: " + _token + " " + "_header: " + _header);
        xhr.setRequestHeader(_header, _token);
    });
});