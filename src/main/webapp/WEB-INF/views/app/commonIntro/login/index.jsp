<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">


$(function() {

	if (location.href.indexOf('www') == -1) {
//   		location.href = 'https://www.gbelib.kr' + location.pathname + location.search;
	}

	$('input#member_pw_tmp').val('');
	$('input#member_name_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#member_id_2').val() == '') {
			$('input#member_id_2').focus();
			alert('아이디를 입력해주세요.');
			return false;
		}

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#member').attr('onsubmit', '');
		if ($('p.idtype').is(':visible')) {
			$('input#member_id').val($('input#member_id_2').val());
		} else {
			$('input#member_id').val($('input#member_id_1').val());
		}
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
		$('input#member_name').val(encrypt($('input#member_name_tmp').val()));
		$('input#member_id').val(encrypt($('input#member_id').val().trim()));
 		$('form#member').submit();
	});

	$('input[name=loginType2]').on('click', function(e) {
		var val = $(this).val();
		if (val == 'id') {
			$('p.idtype').show();
			$('p.numtype').hide();
			$('p.numtype input').each(function() {
				$(this).val('');
			});
		} else {
			$('p.numtype').show();
			$('p.idtype').hide();
			$('p.idtype input').each(function() {
				$(this).val('');
			});
		}
	});


	if ($('input#loginType21').is(':checked')) {
		$('p#pwp').hide();
		$('p.idtype').hide();
		$('p#namep').show();
		$('p.numtype').show();
	}
	if ($('input#loginType22').is(':checked')) {
		$('p#namep').hide();
		$('p.numtype').hide();
		$('p#pwp').show();
		$('p.idtype').show();
	}

	<c:if test="${sessionScope.userIdLoginFail}">
	$('div#loginDenied').dialog({
		title: '로그인 안내',
		resizable: false,
		width: 500,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	        $('.ui-dialog-titlebar').hide();
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn btn1',
				click: function(){
					$(this).dialog('destroy');
				}
			}
		]
	});
	<% request.getSession().invalidate(); %>
	</c:if>

	$('a#closeDialog').on('click', function(e) {
		e.preventDefault();
		$('div#loginDenied').dialog('destroy');
		$('input#loginType22').click();
		$('input#member_id_2').focus();
	});

});
</script>

<div class="login-box">
	<div class="login-head">
		<p><b>${homepageName}</b> <span>방문을 환영합니다.</span></p>
	</div>
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">통합도서관 로그인</dt>
				<div class="loginBox1">
				<dd class="login">
					<div class="loginImgBox">
						<img src="/resources/common/img/mem_loginimg.png" alt="" class="loginImg">
					</div>
					<fieldset>
						<legend class="blind">로그인</legend>
						<c:choose>
						<c:when test="${pageContext.request.localAddr == '127.0.0.1' || pageContext.request.localAddr == '0:0:0:0:0:0:0:1'}">
						<c:set var="_action" value="/${homepage.context_path}/intro/login/loginProc.do"/>
						</c:when>
						<c:otherwise>
						<c:set var="_action" value="https://www.gbelib.kr/${homepage.context_path}/intro/login/loginProc.do"/>
						</c:otherwise>
						</c:choose>
						<form:form modelAttribute="member" action="${_action}" onsubmit="return false;">
<%-- 						<form:form modelAttribute="member" action="loginProc.do" onsubmit="return false;"> --%>
							<c:choose>
							<c:when test="${empty param.before_url}">
							<form:hidden path="before_url" htmlEscape="true"/>
							</c:when>
							<c:otherwise>
							<input type="hidden" id="before_url" name="before_url" value="${fn:escapeXml(param.before_url)}"/>
							</c:otherwise>
							</c:choose>
							<form:hidden path="menu_idx"/>
							<form:hidden path="member_pw" cssStyle="display:none;" />
							<form:hidden path="member_name"/>
							<form:hidden path="member_id"/>
							<div class="login-type">
							</div>
							<div class="form-box">
								<p class="idtype" class="blind"><label class="blind" for="member_id_2">아이디</label>
								<input id="member_id_2" class="txt" placeholder="아이디" title="아이디" maxlength="20" /></p>
								<p id="pwp" class="idtype" class="blind">
								<label for="member_pw_tmp" class="blind" >비밀번호</label>
								<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" title="비밀번호" maxlength="20"/></p>
							</div>
							<button id="save-btn">
								<i class="fa fa-unlock-alt"></i>
								<span>로그인</span>
							</button>
						</form:form>
						<div class="form-etc">
							<div class="find">
								<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=${menuIdxJoin}"><span>회원가입</span><i class="fa fa-caret-right"></i></a>
								<a href="/${homepage.context_path}/intro/join/findMemberIdForm.do?menu_idx=${menuIdxId}"><span>아이디 찾기</span><i class="fa fa-caret-right"></i></a>
								<a href="/${homepage.context_path}/intro/join/findMemberPwForm.do?menu_idx=${menuIdxPw}"><span>비밀번호 찾기</span><i class="fa fa-caret-right"></i></a>
							</div>
						</div>
					</fieldset>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>

<div id="loginDenied" style="display: none;">
	<div style="text-align: center; font-size: 15px;">
		<br/>
		<br/>
		<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 해당 회원은 아이디가 존재합니다. 아이디로 로그인 하시기 바랍니다.
		<br/>
		<br/>
		<a href="#" id="closeDialog">아이디로 로그인하기 <i class="fa fa-caret-right"></i></a>&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/findMemberIdForm.do?menu_idx=${menuIdxId}" >아이디 찾기 <i class="fa fa-caret-right"></i></a>
		<br/>
	</div>
</div>
