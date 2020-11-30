<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('button#ok_btn').on('click', function(e) {
		e.preventDefault();
		
		var passwordOk = $('#password_ok').val();
		var encodedPasswordOk = btoa(passwordOk);
		
		if (encodedPasswordOk == '${getBestPracticesContest.password}') {
			doGetLoad('view.do', $('form#bestPracticesContestViewPw').serialize());
		} else {
			alert('비밀번호가 일치하지 않습니다.');
			$('#password_ok').focus();
			$('#password_ok').val('');
		}
	});
	
	$('input#password_ok').on('keyup', function(e) {
		if (e.keyCode == 13) {
			$('button#ok_btn').click();
		}
	});
	
	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bestPracticesContestViewPw').serialize());
	});
	
});
</script>

<form:form modelAttribute="bestPracticesContest" id="bestPracticesContestViewPw" >
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="best_practices_idx"/>

	<div class="wrapper-bbs center">
		<p>참여신청 시 등록한 비밀번호를 입력해 주세요.</p>
		<input type="password" id="password_ok" cssClass="text" />
		<button id="ok_btn" class="btn btn1">확인</button>
	</div>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

