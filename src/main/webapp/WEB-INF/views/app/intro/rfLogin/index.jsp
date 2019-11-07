<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">

$(document).on("keydown", function(e) {
	if (e.keyCode == 21) {
		return false;
	}
});

function MouseDown() {
	if($("#login_layer").css("display") == "block")
	$('#login_id').focus();
}

function MouseUp() {
	if($("#login_layer").css("display") == "block")
    $('#login_id').focus();
}

function dragIt() {
	if($("#login_layer").css("display") == "block")
    $('#login_id').focus();
}

function getUpdateState() {
	window.setTimeout("getUpdateState()", 3000);
	$("#login_id").focus();
}


$(document).ready(function(){
	document.onmousemove = dragIt;
	document.onmousedown = MouseDown;
	document.onmouseup  = MouseUp;
	$("#login_id").focus();
	getUpdateState();
});
//-->
</script>

<div style="position:relative;width:100%;height:700px;text-align:center">
	<div style="padding:70px 0 0 0">
		<img src="/resources/common/img/books_text.png" alt="RFID 회원증을 키보드 옆 우측 리더기에 터치해주세요.">
	</div>
	<div>
		<img style="margin:30px 0 0 0" src="/resources/common/img/ccr-nfc.png" alt="카드 리더기">
	</div>


		<!--로그인레이어-->
	<div id="login_layer">
		<form name="loginForm" method="post" action="loginProc.do" autocomplete="off" accept-charset="utf-8" >
		<div id="login-form2" style="z-index:100000;position:absolute;top:-100px;left:150px">
			<p class="ment"><input style="ime-mode:disabled" id="login_id" type="text" name="member_id" size="30" title="아이디" autocomplete="off"></p>
		</div>
		</form>
	</div>
</div>