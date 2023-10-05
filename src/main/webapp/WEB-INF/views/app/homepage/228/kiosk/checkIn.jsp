<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"/>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="/resources/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
$(document).on("keydown", function(e) {
	if (e.keyCode == 21 || e.keyCode == 229 || e.isComposing) {
		return false;
	}
});

$(document).on("submit", function(e) {
	var regexp =/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*/gi;
	var worknum = $("#login_id").val();
	var i;
	var worknumcon = '';

	var text = worknum.match(regexp);

	if (text != null) 
	{
		for (i = 0; i < worknum.length; i++)
		{
			switch(worknum.charAt(i))
			{
				case "ㅁ":
					worknumcon += worknum.charAt(i).replace('ㅁ','a');
					break;
				case "ㅠ":
					worknumcon += worknum.charAt(i).replace('ㅠ','b');
					break;
				case "ㅊ":
					worknumcon += worknum.charAt(i).replace('ㅊ','c');
					break;
				case "ㅇ":
					worknumcon += worknum.charAt(i).replace('ㅇ','d');
					break;
				case "ㄷ":
					worknumcon += worknum.charAt(i).replace('ㄷ','e');
					break;
				case "ㄹ":
					worknumcon += worknum.charAt(i).replace('ㄹ','f');
					break;
				case "ㅎ":
					worknumcon += worknum.charAt(i).replace('ㅎ','g');
					break;
				case "ㅗ":
					worknumcon += worknum.charAt(i).replace('ㅗ','h');
					break;
				case "ㅑ":
					worknumcon += worknum.charAt(i).replace('ㅑ','i');
					break;
				case "ㅓ":
					worknumcon += worknum.charAt(i).replace('ㅓ','j');
					break;
				case "ㅏ":
					worknumcon += worknum.charAt(i).replace('ㅏ','k');
					break;
				case "ㅣ":
					worknumcon += worknum.charAt(i).replace('ㅣ','l');
					break;
				case "ㅡ":
					worknumcon += worknum.charAt(i).replace('ㅡ','m');
					break;
				case "ㅜ":
					worknumcon += worknum.charAt(i).replace('ㅜ','n');
					break;
				case "ㅐ":
					worknumcon += worknum.charAt(i).replace('ㅐ','o');
					break;
				case "ㅔ":
					worknumcon += worknum.charAt(i).replace('ㅔ','p');
					break;
				case "ㅂ":
					worknumcon += worknum.charAt(i).replace('ㅂ','q');
					break;
				case "ㄱ":
					worknumcon += worknum.charAt(i).replace('ㄱ','r');
					break;
				case "ㄴ":
					worknumcon += worknum.charAt(i).replace('ㄴ','s');
					break;
				case "ㅅ":
					worknumcon += worknum.charAt(i).replace('ㅅ','t');
					break;
				case "ㅕ":
					worknumcon += worknum.charAt(i).replace('ㅕ','u');
					break;
				case "ㅍ":
					worknumcon += worknum.charAt(i).replace('ㅍ','v');
					break;
				case "ㅈ":
					worknumcon += worknum.charAt(i).replace('ㅈ','w');
					break;
				case "ㅌ":
					worknumcon += worknum.charAt(i).replace('ㅌ','x');
					break;
				case "ㅛ":
					worknumcon += worknum.charAt(i).replace('ㅛ','y');
					break;
				case "ㅋ":
					worknumcon += worknum.charAt(i).replace('ㅋ','z');
					break;
				default:
					worknumcon += worknum.charAt(i);
					break;
			}
		}
	}

	$("#login_id").val(worknumcon);
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

function onlyAlphabet(ele) {
	ele.value = ele.value.replace(/[^\\!-z]/gi,"");
}

$(document).ready(function(){
	document.onmousemove = dragIt;
	document.onmousedown = MouseDown;
	document.onmouseup  = MouseUp;
	$("#login_id").focus();
});

$(function() {
	$('input#member_pw_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#member_id_tmp').val() == '') {
			$('input#member_id_tmp').focus();
			alert('아이디를 입력해주세요.');
			return false;
		}

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#loginProc').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
		
 		$('form#loginProc').submit();
	});
});

function checkYn() {
// 	var upid=$('#login_id').toUpperCase();
// 	$('#login_id').val(upid); 
	$('form#checkInOut').submit();
}
</script>

<div class="checkinlogin-wrap">
	<div class="header">
		<img src="https://library.daegu.go.kr/resources/common/img/kiosk/checkin-logo.png" alt=""/>
	</div>
	<div class="contents">
		<div style="text-align:center;">
			<img src="https://library.daegu.go.kr/resources/common/img/kiosk/bc_sample.png" alt="카드 리더기">
		</div>

		<form:form modelAttribute="member" action="/intro/${homepage.context_path}/checkInOut/checkInProc.do" autocomplete="off" accept-charset="utf-8">
			<form:hidden path="before_url"/>
			<form:hidden path="loginType" value="card"/>
			<div id="login-form2" style="z-index:100000;position:absolute;top:-100px;left:-150000px">
				<p class="ment"><input id="login_id" type="text" name="login_id" size="30" title="RFID시리얼값" autocomplete="off"></p>
			</div>
		</form:form>
		
		<div class="commentarea">
			모바일회원증 혹은 대출증을 리더기에 인식시켜주세요
		</div>
		<div class="commentarea">
			<a href="javascript:void(0);" onclick="checkYn();" return false;>아이디/패스워드로 체크인하기</a>
		</div>
		<form:form modelAttribute="checkInOut" action="/${homepage.context_path}/kiosk/checkInKeyboard.do" autocomplete="off" accept-charset="utf-8">
			<form:hidden path="checkIn_Yn" value="Y"/>
		</form:form>
	</div>
	<div class="footer">
		Memorial Library for 2.28 Students' Movement
	</div>

	<div class="backbutton-sec">
		<a href="javascript:void(0);" onclick="history.back();"><img src="/resources/common/img/kiosk/btn_Prev.png" alt=""></a>
	</div>
</div>

<tiles:insertAttribute name="footer" />