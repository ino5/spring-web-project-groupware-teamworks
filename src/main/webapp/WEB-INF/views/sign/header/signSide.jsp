<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="black_bg"></div>
<button type="button" id="button_new_sign">새 결재 진행</button> <br>

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
<div>
<a id="button1" class="menu_button">
	<span id="span_hover"><img alt="image" src="${pageContext.request.contextPath}/time/img/right.png" style="width: 16px; height: 12px; transition: 0.5s;" id="img1"></span>
	<span id="span_none"><img alt="image" src="${pageContext.request.contextPath}/time/img/white.png" style="width: 16px; height: 12px;" id="img1"></span>
	기안 문서
</a>
<ol id="scroll1" class="scroll" style="display: none; list-style: none;">
		<li class="li"><p class="menu_title">
			<a href="${pageContext.request.contextPath}/sign/list/proposalProcessing">기안 진행 문서</a>
		</p></li>
		<li class="li"><p class="menu_title">
			<a href="${pageContext.request.contextPath}/sign/list/proposalCompleted">기안 완료 문서</a>
		</p></li>
	
</ol>
</div>
<div style="margin-top: 30px;">
<a id="button2" class="menu_button"><span id="span_hover"><img
		alt="image"
		src="${pageContext.request.contextPath}/time/img/right.png"
		style="width: 16px; height: 12px; transition: 0.5s;" id="img2"></span>
	<span id="span_none"><img alt="image"
		src="${pageContext.request.contextPath}/time/img/white.png"
		style="width: 16px; height: 12px;" id="img1"></span> 결재 문서</a>
<ol id="scroll2" class="scroll" style="display: none; list-style: none;">
	<li class="li"><p class="menu_title">
		<a href="${pageContext.request.contextPath}/sign/list/proposalProcessing">결재 대기 문서</a>
		</p></li>
	<li class="li"><p class="menu_title">
		<a href="${pageContext.request.contextPath}/sign/list/proposalCompleted">결재 처리 문서</a>
		</p></li>
</ol>
</div>




<!-- 메뉴 자바스크립트 -->
<script>
$(document).ready(function() {
	$("#button1").click(function() {
		var submenu = $(this).next("#scroll1");
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
$(document).ready(function() {
	$("#button2").click(function() {
		var submenu = $(this).next("#scroll2");
		if (submenu.is(":visible")) {
			$('#img2').css({
				'transform' : 'rotate(0deg)'
			});
			submenu.slideUp("fast");
		} else {
			$('#img2').css({
				'transform' : 'rotate(90deg)'
			});
			submenu.slideDown("fast");
		}
	})
});
</script>