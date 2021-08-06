<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<link rel="styleSheet" href="${pageContext.request.contextPath}/board/css/board.css">
<script src="${pageContext.request.contextPath}/board/js/board.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
function boardGroup() {
    var delchk = []; // key 값을 담을 배열
     var bd_num = modal_form.bd_num.value;
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('.chk_1:checked').each(function(){
        delchk.push($(this).val());
    });
    
   $.ajax({
      type : 'POST',
      url : _contextPath + "/board/boardGroup",
      data : {checkArray : delchk, bd_num : bd_num},
         success: function pageReload(){
               location.href= "${pageContext.request.contextPath}/board";
           }
      });
}
function boardDeleteGroup() {
    var delchk = []; // key 값을 담을 배열
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('.chk_1:checked').each(function(){
        delchk.push($(this).val());
    });
    
   $.ajax({
      type : 'POST',
      url : _contextPath + "/board/boardDeleteGroup",
      data : {checkArray : delchk},
         success: function pageReload(){
               location.href= "${pageContext.request.contextPath}/board";
           }
      });
}
function boardNoticeGroup() {
    var delchk = []; // key 값을 담을 배열
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('.chk_1:checked').each(function(){
        delchk.push($(this).val());
    });
    
   $.ajax({
      type : 'POST',
      url : _contextPath + "/board/boardNoticeGroup",
      data : {checkArray : delchk},
         success: function pageReload(){
               location.href= "${pageContext.request.contextPath}/board";
           }
      });
}
$(document).ready(function() {
	// 달력 클릭 시 모달창 열기
$("#boardSet").on("click", function () {
	$('#myModal').show();
});
//모달창 Close 기능
	$("#close_btn").unbind('click').on('click', function() {
		$('#myModal').hide();
	});
//모달창 Close 기능
	$("#x_icon").unbind('click').on('click', function() {
		$('#myModal').hide();
	});
});
</script>
<body>
	<%@include file="/WEB-INF/views/header/headerBody.jsp"%>
	<div id="side">
		<button type="button" id="btn1"
			onclick="location.href='${pageContext.request.contextPath}/board/write'">글쓰기</button>
		<div>

			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
				<span id="span_none"> <img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img1">
			</span>전사게시판</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="as" items="${boardListOfAll }">
					<li class="li"><a
						href="${pageContext.request.contextPath}/board/sideboard_list?bd_num=${as.bd_num}">${as.bd_name}</a></li>
				</c:forEach>

			</ol>
			<ol id="scroll" style="display: none; list-style: none;">
				<c:forEach var="bs" items="${boardListOfAll }">
					<li class="li">${bs.bd_name}</li>
				</c:forEach>

			</ol>
		</div>
		<div>
			<a id="button2" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/board/img/right.png"
					style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
				<span id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/board/img/white.png"
					style="width: 16px; height: 12px;" id="img2"></span>부서게시판</a>
			<ol id="scroll" style="display: none; list-style: none; ">
				<c:forEach var="bs" items="${boardListOfDept }">
					<li class="li"><a style="color: black;"
						href="${pageContext.request.contextPath}/board/sideboard_list?bd_num=${bs.bd_num}">${bs.bd_name}</a></li>
				</c:forEach>

			</ol>
		</div>
	</div>

	<div id="content">
			<div id="board_table">
				<section class="tool_bar">
				 <h2>게시글 목록</h2>
<form action="${pageContext.request.contextPath}/board/BoardSearchList" method="post">
<sec:csrfInput/>


				<table id="searchBox">
					<tr>
						<td>
		<select name="searchOption">
            <!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
          			  <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/> >제목+이름+제목</option>
           			 <option value="m_id" <c:out value="${map.searchOption == 'm_id'?'selected':''}"/> >이름</option>
           			  <option value="p_content" <c:out value="${map.searchOption == 'p_content'?'selected':''}"/> >내용</option>
          			 <option value="p_name" <c:out value="${map.searchOption == 'p_name'?'selected':''}"/> >제목</option>
          			 <option value="m_id">진짜이름</option>
       	</select></td>
						<td><input id="search" type="text" name="keyword"
							value="${map.p_name}" placeholder="검색" size="20"><button type="submit" onclick="location.href='${pageContext.request.contextPath}/board/BoardSearchList'">버튼</button></td>
						<td><img
							src="${pageContext.request.contextPath}/board/img/search.png"
							width="14px" height="13px"></td>
					</tr>
				</table>
				 
				 
        </select>
        			</form>
</table>
					<ul class="tool_ul">
						<li><button type="button" class="btn2"onclick="location.href='${pageContext.request.contextPath}/board/write'">
								<img style=" width: 20px; height: 20px;" alt="image" src="${pageContext.request.contextPath}/board/img/pencil.png"><span style="font-weight: bold;"> 새글쓰기</span>
							</button></li>
			<c:if test="${sessionId =='admin'}">
						<li><button type="button" id="boardSet" class="btn2 btn_admin" >
								<img style=" width: 20px; height: 20px;" alt="image" src="${pageContext.request.contextPath}/board/img/move.png"><span style="font-weight: bold;"> 이동</span>
							</button></li>
						<li><button type="button" class="btn2 btn_admin" onclick="javascript:boardDeleteGroup()">
								<img style=" width: 20px; height: 20px;" alt="image" src="${pageContext.request.contextPath}/board/img/delete.png"><span style="font-weight: bold;"> 삭제</span>
							</button></li>
						<li><button type="button" class="btn2 btn_admin" onclick="javascript:boardNoticeGroup()">
									<img style=" width: 25px; height: 25px;" alt="image" src="${pageContext.request.contextPath}/board/img/megaphone.png"><span style="font-weight: bold;"> 공지로 등록</span>
							</button></li>
							  </c:if>
					</ul>
				</section>

				<table id="list_table" style="margin-top: 4%; border-top: 2px solid #EAEAEA;">
					<tr>
						<td
							style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;"
						>
							<input type="checkbox" name="check" onclick='selectAll(this)'>
						</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">번호</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">제목</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성자</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성일</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">조회</td>
					
					</tr>
						<c:forEach var="ps_notice" items="${listNoticePost}" begin="0" end="2">			
					<tr style="background-color: #F6F6F6;">
						<td style="text-align: center;">
							<input type="checkbox" name="check" class="chk_1" value="${ps.ps_notice}">
						</td>
						<td><img style=" width: 50px; height: 50px;" alt="image" src="${pageContext.request.contextPath}/board/img/공지1.png"></td>
						<td ><a style="color:#0f91e6; font-weight: bold; font-size: 20px;" href='${pageContext.request.contextPath}/board/view?p_num=${ps_notice.p_num}'>${ps_notice.p_name}</a></td>
						<td style="color:#0f91e6; font-weight: bold; font-size: 20px;">${ps_notice.m_id}</td>
						<td style="color:#0f91e6; font-weight: bold; font-size: 20px;"><fmt:formatDate value="${ps_notice.p_regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td style="color:#0f91e6; font-weight: bold; font-size: 20px;">${ps_notice.p_view}</td>		
					</tr>
						</c:forEach>					
					<c:forEach var="ps" items="${listPost}">
				
					<tr>
						<td style="text-align: center; ">
							<input type="checkbox" name="check" id="chk_1" class="chk_1" value="${ps.p_num}">
						</td>
						<td>${ps.p_num}</td>
						<td><a href='${pageContext.request.contextPath}/board/view?p_num=${ps.p_num}'>${ps.p_name}</a></td>
						<td>${ps.m_id}</td>
						<td><fmt:formatDate value="${ps.p_regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>${ps.p_view}</td>		
					</tr>
						</c:forEach>

				</table>
			</div>
			<div class="pageNum">
		<c:if test="${pg.startPage > pg.pageBlock }">
			<a href="?currentPage=${pg.startPage-pg.pageBlock}"></a>
		</c:if>
		<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage}">
			<c:if test="${i > 0 }">
				<a href="?currentPage=${i}">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pg.endPage < pg.totalPage }">
			<a href="?currentPage=${pg.startPage+pg.pageBlock}"></a>
		</c:if>
		
		</div>
	</div>
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<p>
				<span>게시판 관리 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					onclick="close_pop2();" id="x_icon" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>
			<form id="modal_form" name="modal_form">
			<sec:csrfInput/>
				<table>
					<tr>
						<td>게시판선택</td>
						<td colspan="3">
							<select name="bd_num">
								<c:forEach var="boardListOfAll" items="${boardListOfAll}">
									  <option value="${boardListOfAll.bd_num}">${boardListOfAll.bd_name}</option>
								</c:forEach>
								<c:forEach var="boardListOfDept" items="${boardListOfDept}">
									  <option value="${boardListOfDept.bd_num}">${boardListOfDept.bd_name}</option>
								</c:forEach>								
							</select>
						</td>
							

					<tr>
						<td>이름변경</td>
						<td colspan="3"><input type="text" name="adg_name"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="button" value="그룹지정" onclick="javascript:boardGroup()"></td>
						<td><input type="submit" value="그룹삭제" formaction="${pageContext.request.contextPath}/board/groupDelete"></td>
						<td><input type="button" value="취소" id="close_btn"></td>
				</table>
			</form>
		</div>
	</div>


</body>
</html>