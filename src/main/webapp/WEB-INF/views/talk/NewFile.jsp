<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
for(var i = 0; i < talkList.length; i++) {
	if(talkList[i].tk_type == 1) {
		if(talkList[i].m_id != m_id){				
					 $('#chating').append(
					 	'<div id="memo"><p class="others">'
					 	+ talkList[i].m_name + ':' + talkList[i].tk_content
					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
					 	+'</p></div>'
					 ); 
			}
		else if(talkList[i].m_id == m_id){
				$('#chating').append(
					 	'<div id="memo"><p class="me">'
					 	+ '나:' + talkList[i].tk_content
					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
					 	+'</p></div>'
					 );
				}
			}else if {
				if(talkList[i].m_id != m_id){				
					 $('#chating').append(
					 	'<div id="memo"><p class="others">'
					 	+ talkList[i].m_name + ':' + talkList[i].tk_content
					 	+'</p><p class="date2">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
					 	+'</p></div>'
					 ); 
			}
		else if(talkList[i].m_id == m_id){
				$('#chating').append(
					 	'<div id="memo"><p class="me">'
					 	+ '나:' + talkList[i].tk_content
					 	+'</p><p class="date">'+ moment(talkList[i].tk_time_sent).format("YY-MM-DD")
					 	+'<br>' + moment(talkList[i].tk_time_sent).format("HH:mm")
					 	+'</p></div>'
					 );
				}
			}				
</script>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
	<div id="side">

	</div>
	<div id="content">

	</div>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>