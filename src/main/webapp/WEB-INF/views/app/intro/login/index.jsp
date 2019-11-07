<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
if (!String.prototype.trim) {
	String.prototype.trim = function () {
		return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
	};
}

$(function() {
	
	if (location.href.indexOf('www') == -1) {
//  		location.href = 'https://www.gbelib.kr' + location.pathname + location.search;
	}
	
	$('input#member_pw_tmp').val('');
	$('input#member_name_tmp').val('');
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

		$('form#member').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
		$('input#member_name').val(encrypt($('input#member_name_tmp').val()));
 		$('form#member').submit();
	});
	
	$('input[name=loginType2]').on('click', function(e) {
		var val = $(this).val();
		if (val == 'id') {
			$('p#pwp').show();
			$('p#namep').hide();
		} else {
			$('p#pwp').hide();
			$('p#namep').show();
		}
	});
	
// 	$('input#loginType21').val('');
// 	$('input#loginType22').val('');
	
	if ($('input#loginType22').is(':checked')) {
		$('p#pwp').show();
		$('p#namep').hide();
	}
	if ($('input#loginType21').is(':checked')) {
		$('p#pwp').hide();
		$('p#namep').show();
	}
	
	
	//RFID 회원증 로그인
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
		/* document.onmousemove = dragIt;
		document.onmousedown = MouseDown;
		document.onmouseup  = MouseUp;
		$("#login_id").focus();
		getUpdateState(); */
	});
	
});
</script>
<style>
	.loginBox1 {margin: 0 auto!important;}
	dd.call {margin: 0 auto!important;}
</style>
<div class="login-box">
	<div class="login-head">
		<p>
			<b>
				<c:choose>
				<c:when test="${homepage.homepage_code eq '00147046'}">
					경상북도교육청정보센터
				</c:when>
				<c:otherwise>
				 	${homepage.homepage_name}
				</c:otherwise>
				</c:choose>
			</b> 
			<span>방문을 환영합니다.</span>
		</p>
	</div>
	<div class="login-area">
		<div class="login-body2">
			<div class="tab">
				<dl class="tcon t1">
					<dt class="blind">통합도서관 로그인</dt>
					<div class="loginBox1">
					<div class="tit"><i class="fa fa-chevron-circle-right"></i> 아이디/비밀번호 로그인</div>
					<dd class="login">
						<fieldset>
							<legend class="blind">로그인</legend>
							<c:choose>
							<c:when test="${pageContext.request.localAddr == '127.0.0.1' || pageContext.request.localAddr == '0:0:0:0:0:0:0:1'|| pageContext.request.localAddr == '192.168.0.118'}">
							<c:set var="_action" value="/intro/${homepage.context_path}/login/loginProc.do"/>
							</c:when>
							<c:otherwise>
							<c:set var="_action" value="/intro/${homepage.context_path}/login/loginProc.do"/>
							</c:otherwise>
							</c:choose>
							<form:form modelAttribute="member" action="${_action}" onsubmit="return false;">
								<form:hidden path="before_url" htmlEscape="true"/>
								<form:password path="member_pw" cssStyle="display:none;"/>
								<form:hidden path="member_name"/>
								<div class="login-type">
								<form:radiobutton path="loginType2" id="loginType22" value="id" class="blind"/>
								</div>
								<div class="form-box">
									<p><label class="blind" for="member_id"></label>
									<form:hidden path="member_id" class="txt" placeholder="아이디" maxlength="15" />
									<input type="text" id="member_id_tmp" class="txt" placeholder="아이디" maxlength="15" /></p>
									
									<p id="pwp" ><label class="blind" for="member_pw_tmp">비밀번호</label>
									<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" maxlength="20"/></p>
									
									<p id="namep" style="display: none;"><label class="blind" for="member_name">이름</label>
									<input type="text" id="member_name_tmp" class="txt" placeholder="이름" maxlength="50" style="ime-mode:active;"/></p>	
								</div>
								<button id="save-btn">
									<i class="fa fa-unlock-alt"></i>
									<span class="logBtn">로그인</span>
								</button>
							</form:form>
							<div class="form-etc">
								<div class="find">
	<!-- 								<a href="/intro/join/index.do"><span>회원가입</span><i class="fa fa-caret-right"></i></a> -->
	<!-- 								<a href="javascript:alert('준비중입니다.');"><span>아이디/대출회원번호 찾기</span><i class="fa fa-caret-right"></i></a> -->
	<!-- 								<a href="javascript:alert('준비중입니다.');"><span>비밀번호 찾기</span><i class="fa fa-caret-right"></i></a> -->
								</div>
							</div>
						</fieldset>
					</dd>
					</div>
					<dd class="call" style="padding: 17.7% 0% 8% 0%;">
						<ul>
							<li class="first">
								<img src="/resources/common/img/mem_login02.png" alt="" class="callImg"/>
								<span style="line-height: 25px;padding: 13px 10px 7px 0px;">
									아이디가 없는 정회원(도서대출회원)은<br/>
									회원가입을 통해 아이디 생성 후 로그인하시기<br/>
									바랍니다.
								</span>
								<div class="joinBtn"><a href="/intro/${homepage.context_path}/join/index.do">회원가입</a></div>
							</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		
		<div class="login-body2">
			<div class="tab">
				<dl class="tcon t1">
					<dt class="blind">통합도서관 로그인</dt>
					<div class="loginBox1" style="border-left: 1px solid #eeee;">
					<div class="tit"><i class="fa fa-chevron-circle-right"></i> RFID회원증 로그인</div>
						<a href="/intro/${homepage.context_path}/rfLogin/index.do">
							<img style="margin:15px 0 0 0; width: 130px;" src="/resources/common/img/ccr-nfc2.png" alt="카드 리더기">
						</a>
					</div>
					<!--로그인레이어-->
					<div id="login_layer">
						<form name="loginForm" method="post" action="loginProc.do" autocomplete="off" accept-charset="utf-8" >
						<div id="login-form2" style="z-index:100000;position:absolute;top:-100px;left:150px">
							<p class="ment"><input style="ime-mode:disabled" id="login_id" type="text" name="member_id" size="30" title="아이디" autocomplete="off"></p>
						</div>
						</form>
					</div>
					<dd class="call" style="padding: 17.7% 0%;">
						<ul>
							<li class="first">
								<a href="/intro/${homepage.context_path}/rfLogin/index.do">
									<img src="/resources/common/img/mem_login01.png" alt="" class="callImg"/>
									<span style="line-height: 25px;">
										RFID회원증을 키보드 좌측 리더기에 터치해서<br/> 로그인할 수 있습니다.
									</span>
								</a>
							</li>
	
						</ul>
					</dd>
				</dl>
			</div>
		</div>
	</div>
</div>


	

