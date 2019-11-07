<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	if (location.href.indexOf('www') == -1) {
//   		location.href = 'https://www.gbelib.kr' + location.pathname + location.search;
	}
	
	$('input#member_pw_tmp').val('');
	$('input#member_name_tmp').val('');
	$('button#save-btn').on('click', function(e) {
		$('form#member').attr('onsubmit', '');
		if ($('p.idtype').is(':visible')) {
			$('input#member_id').val($('input#member_id_2').val());
		} else {
			$('input#member_id').val($('input#member_id_1').val());
		}
		$('input#member_pw').val($('input#member_pw_tmp').val());
		$('input#member_name').val($('input#member_name_tmp').val());
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
	
	$('input#loginType21').val('');
	$('input#loginType21').val('');
	
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
				<dd class="login">
					<fieldset>
						<legend class="blind">로그인</legend>
<%-- 						<form:form modelAttribute="member" action="https://www.gbelib.kr/${homepage.context_path}/intro/login/loginProc2.do" onsubmit="return false;"> --%>
						<form:form modelAttribute="member" action="loginProc2.do" onsubmit="return false;">
							<form:hidden path="before_url"/>
							<label for="member_pw"/>
							<form:password path="member_pw" cssStyle="display:none;"/>
							<form:hidden path="member_name"/>
							<form:hidden path="member_id"/>
							<div class="login-type">
							<form:radiobutton path="loginType2" id="loginType21" value="num" label="대출회원번호/이름 로그인"/>
							<form:radiobutton path="loginType2" id="loginType22" value="id" label="아이디/비밀번호 로그인"/>
							</div>
							<div class="form-box">
								<p class="numtype"><label class="blind" for="member_id_1">대출회원번호</label> 
								<input id="member_id_1" class="txt" placeholder="대출회원번호" maxlength="15" /></p>
								<p id="namep" class="numtype"><label class="blind" for="member_name_tmp">이름</label>
								<input type="text" id="member_name_tmp" class="txt" placeholder="이름" maxlength="50"/></p>
								
								<p class="idtype" style="display: none;"><label class="blind" for="member_id_2">아이디</label> 
								<input id="member_id_2" class="txt" placeholder="아이디" maxlength="20" /></p>
								<p id="pwp" class="idtype" style="display: none;">
								<label for="member_pw_tmp"/>
								<input type="password" id="member_pw_tmp" class="txt" placeholder="비밀번호" maxlength="20"/></p>
							</div>
							<button id="save-btn">
								<i class="fa fa-unlock-alt"></i>
								<span>로그인</span>
							</button>
						</form:form>
						<div class="form-etc">
							<div class="find">
								<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/index.do?menu_idx=${menuIdxJoin}"><span>회원가입</span><i class="fa fa-caret-right"></i></a>
								<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/findMemberIdForm.do?menu_idx=${menuIdxId}"><span>아이디 찾기</span><i class="fa fa-caret-right"></i></a>
								<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/findMemberPwForm.do?menu_idx=${menuIdxPw}"><span>비밀번호 찾기</span><i class="fa fa-caret-right"></i></a>
							</div>
						</div>
					</fieldset>
				</dd>
				<dd class="call">
					<ul>
						<li class="first">
							<span style="line-height: 25px;">
								아이디가 없는 기존회원은 대출회원번호/이름으로 로그인하시고<br />
								신규가입 회원은 아이디/비밀번호로 로그인 하시기 바랍니다.
<!-- 								개인정보보호를 위해 내정보에서 아이디를 생성해서 이용하시기 바랍니다. -->
							</span>
						</li>
					</ul>
				</dd>
			</dl>
		</div>
	</div>
</div>
