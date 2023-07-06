<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="/resources/common/js/jquery.cookie.js"></script>
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
</script>
<div class="login-wrap">
	<div class="header">
		<h1>국채보상운동기념도서관</h1>
		<p>The National Debt Compensation Movement Memorial Library</p>
	</div>
	<div class="contents">

		<div class="title-sec" style="letter-spacing:-1.5px;font-size:45px;text-align:center;">
			회원증을 RFID 리더기에 터치해주세요.
		</div>
		<div style="position:relative;width:100%;height:700px;text-align:center">
			<div class="contents">
				<div style="text-align:center;">
					<img src="/resources/common/img/kiosk/bc_sample.png" alt="카드 리더기">
				</div>
				<form:form modelAttribute="member" action="/intro/${homepage.context_path}/login/loginProc.do" onsubmit="return false;">
					<div id="login-form2" style="z-index:100000;position:absolute;top:-100px;left:-150000px">
						<p class="ment"><input style="ime-mode:disabled" id="login_id" type="text" name="member_id" size="30" title="아이디" autocomplete="off"></p>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />