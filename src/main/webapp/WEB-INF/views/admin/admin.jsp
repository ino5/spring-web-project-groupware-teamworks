<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/header/headerHead.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/admin/css/admin.css">
<script src="${pageContext.request.contextPath}/admin/js/admin.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	width: 650px; /* Could be more or less, depending on screen size */
	height: 950px;
	border: 2px solid #ddd;
	border-radius: 4px;
	box-shadow: 0px 5px 8px rgb(0 0 0/ 20%);
}
</style>
<title>Insert title here</title>
<script type="text/javascript">

function adminGroup() {
    var delchk = []; // key 값을 담을 배열
     var pt_code = $("#modal_form_pt_select option:selected").val();
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('.chk_1:checked').each(function(){
        delchk.push($(this).val());
    });
    
   $.ajax({
      type : 'POST',
      url : _contextPath + "/admin/adminGroup",
      data : {checkArray : delchk, pt_code : pt_code},
         success: function pageReload(){
               location.href= "${pageContext.request.contextPath}/admin/admin";
           }
      });
}
function DeleteBoardGroupOfAdmin() {
    var delchk = []; // key 값을 담을 배열
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    
    $('.chk_1:checked').each(function(){
        delchk.push($(this).val());
    });
    if(delchk.length>0){
    	swal({
    		  title: "",
    		  text: "정말 삭제하시겠습니까?",
    		  icon: "warning",
    		  buttons: true,
    		  dangerMode: true,
    		})
    		.then((willDelete) => {
    		  if (willDelete) {
    		    swal("삭제되었습니다.", {
    		      icon: "success",
    		    });
           	 	$.ajax({
         	 	   type : 'POST',
         	 	   url : _contextPath + "/admin/admindDeleteGroup",
         	 	   data : {checkArray : delchk},
         	 	      success: function pageReload(){
         	 	            location.href= "${pageContext.request.contextPath}/admin/admin";
         	 	        }
         	 	}); 
    		  } else {
    		    swal("삭제 취소");
    		  }
    		});

    }
    else{
    	swal ("하나 이상 선택해주세요.");
    }
}
function select_PositionList() {
	var pt_code = $("#ex_select option:selected").val();
    
	$.ajax({
		type : 'POST',
		url : _contextPath + "/admin/member_PositionList",
		data : {'pt_code' : pt_code},
		success: function (res){
 	  		$( '#list_table > tbody').empty();
 	  		for (let i = 0; i< res.length; i++) {
				let member = res[i];
				//자바스크립트 -> html을 조작
				$("#list_table > tbody").append(''
					+ '<tr>'
						+ '<td style="text-align: center;"><input type="checkbox"'
						+	'name="check" class="chk_1" value="' + member.m_id + '"></td>'
						+ '<td><div id="profile">'
						+		'<img style="border-radius: 70%; width: 40px; height: 40px;"'
						+			'src="' + _contextPath + '/resource/member/photo/' + member.m_id + '.jpg"'
						+			'onerror="this.src=\'' + _contextPath + '/resource/member/photo/default.jpg\'" />'
						+	'</div>'
						+	'<div id="profile_name">' + member.m_name + '</div></td>'
						+ '<td>' + member.pt_name + '</td>'
						+ '<td>' + member.m_empnum + '</td>'
						+ '<td>' + member.m_phone + '</td>'
						+ '<td>' + member.m_email + '</td>'
						+ '<td>' + member.dpt_name + '</td>'
					+ '</tr>'
				);    		    	    
			}
		}
	});
	
	$('.pageNum').remove();
}

</script>
</head>
<!-- 바디 태그 더블 클릭 시 블록 선택 방지 -->
<body onselectstart="return false" ondragstart="return false">
	<div class="container">
		<div class="side" id="hide">
			<div>
				<div
					style="color: #37d2e7; font-size: 20px; font-weight: bold; margin-left: 5%; cursor: pointer;">site
					Admin</div>
				<div id="text">
				<button style="background-color: transparent; border: none;" type="button" id="text" 
			onclick="location.href='${pageContext.request.contextPath}/admin'"><h3>관리자 페이지</h3></button>
					
				</div>
				<div></div>
				<div class="menu_hover">
					<a id="button1" class="button1" style="color: white;"> <span
						id="span_hover"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
						<span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png"
							style="width: 16px; height: 12px;" id="img1"></span> 개인 주소록
					</a>
					<ol id="scroll" style="display: none; list-style: none;">
						<li class="li">전체 주소록</li>
						<li class="li">개인</li>
						<li class="li">연락처 주소록 추가</li>
					</ol>
				</div>
				<div id="div2" class="menu_hover">
					<a id="button2" class="button1" style="color: white;"> <span
						id="span_hover"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/right2.png"
							style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
						<span id="span_none"><img alt="image"
							src="${pageContext.request.contextPath}/admin/img/white.png"
							style="width: 16px; height: 12px;" id="img2"></span> 부서 주소록
					</a>
				</div>
			</div>
		</div>
		<div id="content">
			<h2>
				<span
					style="color: #8C8C8C; font-size: 20px; font-weight: bold; margin-top: 20px;">메뉴관리/게시판</span>
			</h2>
			<br>
			<div style="z-index: 2; padding-top: 20px; margin-left: 50px;">
				<h2>
					<span id="content1" style="font-weight: bold; font-size: 35px;">게시판</span>
				</h2>
			</div>
			<div id="right2" style="margin-top: 20px;"></div>
			<div id="wrap">
				<table id="admin_board">
					<tr>
						<td style="font-size: 26px;">현재 사원 수</td>
						<td style="font-size: 26px;">${total}<span
							style="color: #8C8C8C; font-size: 26px;">&nbsp;명</span>
						</td>
					</tr>
				</table>
			</div>
			<div id="board_table">
				<section class="tool_bar">
					<ul class="tool_ul">
						<li><button type="button" class="btn2" id="add">
								<img alt=""
									src="${pageContext.request.contextPath}/admin/img/plus.png"
									width="17px" height="17px">&nbsp;멤버 생성
							</button></li>

						<li><button type="button" id="boardSet"
								class="btn2 btn_admin">
								<img alt=""
									src="${pageContext.request.contextPath}/admin/img/group.png"
									width="17px" height="17px">&nbsp;직위변경
							</button></li>
						<li><button type="button" class="btn2"
								onclick="javascript:DeleteBoardGroupOfAdmin()">
								<img alt=""
									src="${pageContext.request.contextPath}/admin/img/delete.png"
									width="17px" height="17px">&nbsp;멤버삭제
							</button></li>
						<li><button type="button" class="btn2" id="reset">
								<img alt=""
									src="${pageContext.request.contextPath}/admin/img/mail.png"
									width="17px" height="17px">&nbsp;비밀번호 초기화
							</button></li>
					</ul>
				</section>
				<table id="list_table"
					style="margin-top: 4%; border-top: 2px solid #EAEAEA; margin-left: 122px;">
					<thead>
						<tr>
							<td
								style="text-align: center; border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">
								<input type="checkbox" name="check" class="chk_1"
								onclick='selectAll(this)'> <label for="chk_1"></label>
							</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">이름</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">직위
								<select id="ex_select" class="select_position" name="pt_code" required="required" onchange="javascript:select_PositionList();">
									<option>직위</option>
									<option value="SJ">사장</option>
									<option value="IS">이사</option>
									<option value="BJ">부장</option>
									<option value="CJ">차장</option>
									<option value="DL">대리</option>
									<option value="SW">사원</option>
									<option value="IT">인턴</option>
							</select>
							</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">휴대폰</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">이메일</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">부서</td>
							<td
								style="border-bottom: 2px solid #EAEAEA; border-top: 2px solid solid #EAEAEA;">직급</td>

						</tr>
					</thead>

					<tbody>
						<c:forEach var="member" items="${listMember}">
							<tr>
								<td style="text-align: center;"><input type="checkbox"
									name="check" class="chk_1" value="${member.m_id}"></td>
								<td><div id="profile">
										<img style="border-radius: 70%; width: 40px; height: 40px;"
											src="${pageContext.request.contextPath}/resource/member/photo/${member.m_id}.jpg"
											onerror="this.src='${pageContext.request.contextPath}/resource/member/photo/default.jpg'" />
									</div>
									<div id="profile_name">${member.m_name }</div></td>
								<td>${member.pt_name }</td>
								<c:if test="${member.m_empnum > 0}">
									<td>${member.m_empnum }</td>
								</c:if>
								<c:if test="${member.m_empnum == 0}">
									<td></td>
								</c:if>
								<td>${member.m_phone }</td>
								<td>${member.m_email }</td>
								<td>${member.dpt_name }</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>
			</div>
			<div id="myModal" class="modal">

				<!-- Modal content -->
				<div class="modal-content">
					<img
						src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
						style="width: 35px; height: 25px; float: right; cursor: pointer;"
						id="x_icon" /> <br>
					<p style="text-align: center; line-height: 1.5;"></p>
					<h3>멤버 생성</h3>
					<p>
					<form id="modal_form"
						action="${pageContext.request.contextPath}/login/join"
						method="post">
						<sec:csrfInput />
						<table id="modal_tb"
							style="font-size: 20px; font-weight: bold; margin: 0 auto;">
							<tr>
								<td><span style="color: red;"> * </span>이름</td>
								<td colspan="3"><input type="text" class="input"
									name=m_name></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>아이디</td>
								<td colspan="3"><input type="text" class="input" id="mid"
									oninput="javascript:checkID()" name="m_id"> <span
									class="id_ok">사용 가능한 아이디입니다.</span> <span class="id_already">누군가
										이 아이디를 사용하고 있어요.</span></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>비밀번호</td>
								<td colspan="3"><input type="password" name="m_password"
									class="input"></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>사번</td>
								<td colspan="3"><input type="text" name="m_empnum"
									class="input"></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>직위</td>
								<td><select id="admin_select" name="pt_code" style="">
										<option>직위</option>
										<option value="SJ">사장</option>
										<option value="IS">이사</option>
										<option value="BJ">부장</option>
										<option value="CJ">차장</option>
										<option value="DL">대리</option>
										<option value="SW">사원</option>
										<option value="IT">인턴</option>
								</select>
							<tr>
								<td><span style="color: red;"> * </span>부서</td>
								<td colspan="3"><select id="admin_select" name="dpt_code"
									style="">
										<option>직위</option>
										<option value="IS">인사부</option>
										<option value="CM">총무부</option>
										<option value="HG">회계부</option>
										<option value="GH">기획부</option>
										<option value="YU">영업부</option>
										<option value="GB">개발부</option>
								</select></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>생일</td>
								<td colspan="3"><input type="text" name="m_birth"
									class="input"></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>전화번호</td>
								<td colspan="3"><input type="text" name="m_phone"
									class="input"></td>
							</tr>
							<tr>
								<td><span style="color: red;"> * </span>이메일</td>
								<td colspan="3"><input type="text" name="m_email"
									class="input"></td>
							</tr>
						</table>
						<br>
						<div id="modal_wrap">
							<div id="modal_btn">
								<input type="submit" value="저장" class="modal_btn">
							</div>
							<div id="modal_btn">
								<input type="button" value="취소" id="close_btn" class="modal_btn" />
							</div>

						</div>
						<sec:csrfInput />
					</form>
				</div>

			</div>
			<div class="pageNum">
				<c:if test="${pg.startPage > pg.pageBlock }">
					<a href="?currentPage=${pg.startPage-pg.pageBlock}"></a>
				</c:if>
				<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage}">
					<c:if test="${i > 0 }">
						<a id="page_num_button" href="?currentPage=${i}">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pg.endPage < pg.totalPage }">
					<a href="?currentPage=${pg.startPage+pg.pageBlock}"></a>
				</c:if>

			</div>
		</div>
	</div>

	<!--End Modal-->

	<script type="text/javascript">
//직위변경 모달창
function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('check');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  }) 
	}
	
	//모달창
		jQuery(document).ready(function() {
			$("#boardSet").click(function() {
				$('#myModal2').show();
			})
		});
		//팝업 Close 기능
		$(document).ready(function() {
			$("#close_btn2").unbind('click').on('click', function() {
				$('#myModal2').hide();
			});
			$("#x_icon2").unbind('click').on('click', function() {
				$('#myModal2').hide();
			});
		$("#x_icon").unbind('click').on('click', function() {
			$('#myModal').hide();
			});
			$("#x_icon3").unbind('click').on('click', function() {
			$('#myModal3').hide();
		});
	});
</script>

	<div id="myModal2" class="modal">
		<!-- Modal content -->
		<div class="modal-content2">
			<p>
				<span style="20px;">사원 정보 수정<img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					id="x_icon2" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>

			<form id="modal_form_pt" name="modal_form_pt" method="post">
				<sec:csrfInput />
				<table>
					<tr>
						<td><select id="modal_form_pt_select" name="pt_code" style="">
								<option>직위변경</option>
								<option value="SJ">사장</option>
								<option value="IS">이사</option>
								<option value="BJ">부장</option>
								<option value="CJ">차장</option>
								<option value="DL">대리</option>
								<option value="SW">사원</option>
								<option value="IT">인턴</option>

						</select></td>
					</tr>
					<tr>
						<td></td>
						<td><input id="button_save" type="button" value="저장"
							onclick="javascript:adminGroup()"></td>
						<td><input  id="button_cancle"  type="button" value="취소" id="close_btn2"></td>
				</table>
			</form>
		</div>
	</div>
	<!-- 	비밀번호 변경 -->

	<div id="myModal3" class="modal">
		<!-- Modal content -->
		<div class="modal-content2">
			<p>
				<span id="text_password">비밀번호 초기화 <img
					src="https://img.icons8.com/fluent-systems-regular/48/000000/x.png"
					style="width: 35px; height: 25px; float: right; cursor: pointer;"
					id="x_icon3" />
				</span>
			</p>
			<br>
			<p style="text-align: center; line-height: 1.5;"></p>

			<form id="modal_form_pass" name="modal_form_pass" method="post">
				<sec:csrfInput />
				<table>
					<tr>
						<td>선택된 사용자 1명에 대해서<br>
						 비밀번호를 초기화 하시겠습니까?</td>
					</tr>
					<tr>
						<td></td>
						<td><input  id="button_save"  type="button" value="저장"
							onclick="javascript:adminPassWordChangeGroup()"></td>
						<td><input  id="button_cancle" type="button" value="취소" id="close_btn3"></td>
				</table>
			</form>
		</div>
	</div>

	<!-- //회원가입시 아이디 중복확인	 -->
	<script type="text/javascript">

function checkID(){
    var m_id = $('#mid').val();
$.ajax({
    url:_contextPath + "/admin/checkID",
    type:'post',
    data:{m_id:m_id},
    success:function(result){
        if(result != 1){ //result가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
            $('.id_ok').css("display","inline-block"); 
            $('.id_already').css("display", "none");
        } else { // result가 1일 경우 -> 이미 존재하는 아이디
            $('.id_already').css("display","inline-block");
            $('.id_ok').css("display", "none");
        }
    },
    error:function(){
        alert("에러입니다");
    }
});
};

</script>
	<script type="text/javascript">
	//모달창 -> 비밀번호 초기화
	jQuery(document).ready(function() {
		$("#reset").click(function() {
			$('#myModal3').show();
		})
	});
	//팝업 Close 기능
	$(document).ready(function() {
		$("#close_btn3").unbind('click').on('click', function() {
			$('#myModal3').hide();
		});
	});
	//비밀번호 초기화
	function adminPassWordChangeGroup() {
	    var delchk = []; // key 값을 담을 배열
	    //삭제 key value
	    // chk라는 클래스를 가진 체크박스 중에 체크가 된
	    // object들을 찾아서 delchk라는 배열에 담는다.
	    $('.chk_1:checked').each(function(){
	        delchk.push($(this).val());
	    });
	    
	   $.ajax({
	      type : 'POST',
	      url : _contextPath + "/admin/adminPassWordChangeGroup",
	      data : {checkArray : delchk},
	         success: function pageReload(){
	               location.href= "${pageContext.request.contextPath}/admin/admin";
	           }
	      });
	}
	</script>

</body>
</html>