<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
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

		$('form#member').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
 		$('form#member').submit();
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
						<form:form modelAttribute="member" action="loginProc.do" onsubmit="return false;">
							<form:hidden path="member_pw" cssStyle="display:none;" />
							<form:hidden path="member_id"/>
							<div class="form-box">
								<label class="blind" for="member_id_tmp">아이디</label>
								<input id="member_id_tmp" class="txt" placeholder="아이디" title="아이디" maxlength="20" /></p>
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
								<a href="/${homepage.context_path}/intro/join/findIdForm.do?menu_idx=${menuIdxId}"><span>아이디 찾기</span><i class="fa fa-caret-right"></i></a>
								<a href="/${homepage.context_path}/intro/join/findPwForm.do?menu_idx=${menuIdxPw}"><span>비밀번호 찾기</span><i class="fa fa-caret-right"></i></a>
							</div>
						</div>
					</fieldset>
					<div class="" style="color:#3f70bc;font-weight:bold;font-size: 14px;padding: 15px 0 15px 18px;">
						※ 기존 회원은 통합회원 인증 후 로그인할 수 있습니다.
					</div>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>

