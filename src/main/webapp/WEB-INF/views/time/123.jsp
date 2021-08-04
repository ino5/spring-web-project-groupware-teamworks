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
var day = new Date();
day.setDate(day.getDate()-day.getDay());

function week_calandar(week) {
day.setDate(day.getDate()+week*7);
var title = day.getFullYear() + "/" + (day.getMonth()+1);
var data = ""
for(var i=0 ; i<7 ; i++) {
data += day.getDate() + "|";
if(day.getDate() == 1)
title += " ~ " + day.getFullYear() + "/" + (day.getMonth()+1);
day.setDate(day.getDate()+1);
}
day.setDate(day.getDate()-7);
document.getElementById("calandar").innerHTML = title + "<br />" + data;
}

function set_day() {
day = new Date();
day.setDate(day.getDate()-day.getDay());

week_calandar(0);
}
</script>

<p id="calandar"></p>
<input type="button" value="&lt;" onclick="week_calandar(-1)" />
<input type="button" value="today" onclick="set_day()" />
<input type="button" value=">" onclick="week_calandar(1)" />
</body>
</html>