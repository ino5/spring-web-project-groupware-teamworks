$(document).ready(function(){
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
    	console.log("token: "+token);
    	console.log("header: "+header);
        xhr.setRequestHeader(header, token);
    });
});