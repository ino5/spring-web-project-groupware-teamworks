<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="black_bg"></div>
<button type="button" id="button_new_sign">새 결재 진행</button> <br>
<%-- <a href="${pageContext.request.contextPath}/drive?cg_num=1">전사 자료실</a> <br> --%>
<%-- <a href="${pageContext.request.contextPath}/drive?cg_num=3">개인 자료실</a> <br> --%>



<!-- 새 결제 진행 모달창 -->
<div id="modal_wrap_new_sign">
	<button type="button" id="modal_close_new_sign">x</button>
	<div>
		<form id="form_new_sign" action="${pageContext.request.contextPath}/sign/form" method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<input type="hidden" name="tb_code" value="sgf">
			<select name="cg_num">
				<optgroup label="일반">
				<option value="101">업무기안</option>
				</optgroup>
			</select>
			<input type="submit">
		</form>
	</div>
</div>

<!-- 모달창 관련 스타일 -->
<style>
/* 모달창 뒤 배경 */
.black_bg {
	display: none;
	position: absolute;
	content: "";
	width: 100%;
	height: 100%;
	background-color:rgba(0,0,0, 0.3);
	top: 0;
	left: 0;
	z-index: 1;
}

/* 모달창 업로드 */
#modal_wrap_new_sign {
	display: none;
	width: 500px;
	height: 500px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -250px 0 0 -250px;
	background: #eee;
	z-index: 2;
}
</style>

<!-- 모달창 관련 스크립트 -->
<script>
//'새 결재 진행' 버튼 클릭시 모달창 띄우는 이벤트
$(document).on(
		"click", 
		"#button_new_sign", 
		e => { 
			$('.black_bg').css('display', 'block');
			$('#modal_wrap_new_sign').css('display', 'block');
		});

//'새 결재 진행' 모달창 닫기 버튼 클릭 시 이벤트
$(document).on(
		"click", 
		"#modal_close_new_sign", 
		e => { 
			$('.black_bg').css('display', 'none');
			$('#modal_wrap_new_sign').css('display', 'none');
		});
</script>



<!-- 메뉴 -->
기안 문서
<ul>
	<li><a href="${pageContext.request.contextPath}/sign/list/proposalProcessing">기안 진행 문서</a></li>
	<li>기안 완료 문서</li>
</ul>

결재 문서
<ul>
	<li>결재 대기 문서</li>
	<li>결재 처리 문서</li>
</ul>