<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
</head>
<style>
.test{
  width: 200px;
  height: 200px;
  background: gray;
}
</style>
<body>
<script src="scripts/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $('.test').hover(function(){
    $(this).css('background','yellow');
  }, function(){
    $(this).css('background','gray');
  });
  $('.unbind_hover').click(function(){
    $('.test').unbind('hover');
  });
  $('.unbind_mouse').click(function(){
    $('.test').unbind('mouseenter mouseleave');
  });
});
</script>

<div class="test">

</div>
<input type="button" class="unbind_hover" value="unbind hover!"/>
<input type="button" class="unbind_mouse" value="unbind mouse!"/>
</body>
</html>