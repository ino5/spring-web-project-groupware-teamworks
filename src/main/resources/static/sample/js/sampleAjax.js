$(document).on(
		"click", 
		"#ajaxButton", 
		e => {
				$.ajax({
				    url: _contextPath + '/sample/ajaxTest', //request 보낼 서버의 경로
				    type:'post', // 메소드(get, post, put 등)
				    data:{'data_content':'hiyo'}, //보낼 데이터
				    success: function(data) {
				        console.log(data)
				    },
				    error: function(err) {
				        //서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
				    }
				});
			});