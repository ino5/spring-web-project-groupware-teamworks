<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@include file = "/WEB-INF/views/header/headerHead.jsp" %>
<title>Insert title here</title>
</head>
<body>
<%@include file = "/WEB-INF/views/header/headerBody.jsp" %>
<table class="" id="tempList">

	<colgroup>

		<col width="">

		<col width="">

		<col width="">

	</colgroup>

	<thead>

		<tr>

			<th class="">컬럼헤더0</th>

			<th class="">컬럼헤더1</th>

		</tr>

	</thead>

	<tbody>

		<tr>

			<td>컬럼0</td>

			<td>컬럼1</td>

		</tr>		

	</tbody>

</table>

<script type="text/javascript">

$("#tempList tbody").on("click", "tr", function(){

	alert( $(this).find("td:eq(0)").text() );

	alert( $(this).find("td:eq(1)").text() );

});

</script>
<%@include file = "/WEB-INF/views/header/headerFooter.jsp" %>
</body>
</html>