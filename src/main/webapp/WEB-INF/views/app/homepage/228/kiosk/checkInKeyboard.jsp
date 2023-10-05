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

$(function() {
	$('input#member_pw_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#member_id_tmp').val() == '') {
			$('input#member_id_tmp').focus();
			$.alert("아이디를 입력해주세요.",{title:'228기념학생도서관',confirmButton:'확인'});
			return false;
		}

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			$.alert("비밀번호를 입력해주세요.",{title:'228기념학생도서관',confirmButton:'확인'});
			return false;
		}

		$('form#loginProc').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
		
 		$('form#loginProc').submit();
	});
});
</script>

<div class="checkinlogin-wrap">
	<div class="header">
		<img src="https://library.daegu.go.kr/resources/common/img/kiosk/checkin-logo.png" alt=""/>
	</div>
	<div class="contents">
		<div class="loginFormbox">
			<form:form id="loginProc" modelAttribute="member" action="/intro/${homepage.context_path}/checkInOut/checkInProc.do" onsubmit="return false;">
				<form:hidden path="member_pw" cssStyle="display:none;" />
				<form:hidden path="member_id"/>
				<form:hidden path="before_url"/>
				<div class="id-sec">
					<label class="blind" for="member_id_tmp">아이디</label>
					<input id="member_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="20" />
				</div>
				<div class="pwssword-sec">
					<label for="member_pw_tmp" class="blind" >비밀번호</label>
					<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20"/>
				</div>
				<div class="login-btn-sec">
				<button id="save-btn">
					<i class="fa fa-unlock-alt"></i>
					<c:set var="checkIn_Yn" value="${checkInOut.checkIn_Yn eq 'Y' ? '체크인' : '체크아웃'}"/>
					<span>${checkIn_Yn}</span>
				</button>
				</div>
			</form:form>
		</div>
	</div>
	<div class="footer">
		Memorial Library for 2.28 Students' Movement
	</div>

	<div class="backbutton-sec">
		<a href="javascript:void(0);" onclick="history.back();"><img src="/resources/common/img/kiosk/btn_Prev.png" alt=""></a>
	</div>
</div>

<tiles:insertAttribute name="footer" />