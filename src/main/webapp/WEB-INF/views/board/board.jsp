<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/board.css">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		$("#button1").click(function() {
			var submenu = $(this).next("#scroll");
			// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
			if (submenu.is(":visible")) {
				$('#img1').css({
					'transform' : 'rotate(0deg)'
				});
				submenu.slideUp("fast");
			} else {
				$('#img1').css({
					'transform' : 'rotate(90deg)'
				});
				submenu.slideDown("fast");
			}
		})
	});
	//체크박스 전체선택
	function selectAll(selectAll)  {
		  const checkboxes 
		       = document.getElementsByName('check');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  })
		}
</script>
<title>Insert title here</title>
</head>
<!-- 바디 태그 더블 클릭 시 블록 선택 방지 -->
<body onselectstart="return false" ondragstart="return false">
	<header>
		<%-- 	<img alt="" src="${pageContext.request.contextPath}/images/11.JPG" style="width: 20%;"> --%>
		<nav class="head_nav">
			<ul>
				<li><a href="${pageContext.request.contextPath}/main.jsp">홈</a></li>
				<li><a href="#">메일</a></li>
				<li><a href="${pageContext.request.contextPath}/time.jsp">근태관리</a></li>
				<li><a href="#">전자결재</a></li>
				<li><a href="${pageContext.request.contextPath}/calendar.jsp"
					>캘린더</a></li>
				<li><a href="${pageContext.request.contextPath}/board.jsp" style="background-color: #4374d9">게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/juso.jsp">주소록</a></li>
				<li><a href="#">드라이브</a></li>
				<li><a href="#">예약</a></li>
				<li><a href="#">설문</a></li>
			</ul>
		</nav>
	</header>
	<div id="side">
		<button type="button" id="btn1">일정등록</button>
		<div>
			<a id="button1" class="button1"><span id="span_hover"><img
					alt="image"
					src="${pageContext.request.contextPath}/images/right.png"
					style="width: 16px; height: 12px; transition:0.5s;" id="img1"></span> <span
				id="span_none"><img alt="image"
					src="${pageContext.request.contextPath}/images/white.png"
					style="width: 16px; height: 12px;" id="img1"></span> 내 캘린더</a>
			<ol id="scroll" style="display: none; list-style: none;">
				<li class="li"><input type="checkbox" name="check" id="chk_1"><label
					for="chk_1">전체일정</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_2"><label
					for="chk_2">개인일정</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_3"><label
					for="chk_3">AI개발팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_4"><label
					for="chk_4">SW개발팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_5"><label
					for="chk_5">기획팀</label></li>
				<li class="li"><input type="checkbox" name="check" id="chk_6"><label
					for="chk_6">경영지원팀</label></li>
			</ol>
		</div>

	</div>

	<div id="content">
	
		<form action="${pageContext.request.contextPath}/searching.do">
			<table id="searchBox">
				<tr>
					<td><select id="option" name="standard">
							<option ${(param.standard == "clvalue1")?"selected":"" }
								value='clvalue1'>게시판 <option ${(param.standard == "clvalue2")?"selected":"" }
								value='clvalue2'>통합검색
				
					</select></td>
				<td><input id="search" type="text" name="name"
						value="${param.name}" placeholder="검색" size="100"></td>
				<td><img
						src="${pageContext.request.contextPath}/images/search.png"
						width="14px" height="13px"></td>
			</tr>
		</table>
	</form>
			<div id="board_table">
				<section class="tool_bar">
					<ul class="tool_ul">
						<li><button type="button" class="btn2">
								새글쓰기
							</button></li>

						<li><button type="button" class="btn2">
								이동
							</button></li>
						<li><button type="button" class="btn2">
								삭제
							</button></li>
						<li><button type="button" class="btn2">
								공지로 등록
							</button></li>
					</ul>
				</section>
				<table id="list_table" style="margin-top: 4%; border-top: 2px solid #EAEAEA;">
					<tr>
						<td
							style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;"
						>
							<input type="checkbox" name="check" id="chk_1" onclick='selectAll(this)'>
							<label for="chk_1"></label>
						</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">번호</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">제목</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성자</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">작성일</td>
						<td style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">조회</td>
					
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>		
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>안민현</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>정민희</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>백인호</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="checkbox" name="check" id="chk_1">
						</td>
						<td>임다솔</td>
						<td>1234567</td>
						<td>부장</td>
						<td>정상</td>
						<td>10</td>
					</tr>
				</table>
			</div>
		</div>
	


</body>
</html>