<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('div.year_select > a.next').on('click', function(e) {
		e.preventDefault();
		$('input#ageType').val($(this).attr('val'));
		$('form#newMember').submit();
	});
});
</script>
<div class="join-step" style="position: inherit;">
	<p class="blind">회원가입 단계</p>
	<ul>
		<li class="step1 active"><span>1</span> <em>회원유형확인</em></li>
		<li class="step2"><span>2</span> <em>이용약관동의</em></li>
		<li class="step3"><span>3</span> <em>본인확인 및 정보입력</em></li>
	</ul>
</div>

<div class="join-wrap" style="padding: 0">

	<div class="info">
	- 자신이 해당하는 회원의 종류를 선택해 주시기 바랍니다.<br/>
	- 회원유형에 따라 절차가 다르고. 실제정보와 차이가 있을 경우 인증이되지 않을 수 있습니다.
	</div>

	<div class="year_select">
		<a href="#" class="year_a next" val="more">
			<b>만 14세 이상</b>
			<span>일반회원</span>
		</a>
		<a href="#" class="year_b next" val="under">
			<b>만 14세 미만</b>
			<span>어린이, 학생회원</span>
		</a>
	</div>

</div>
<form:form modelAttribute="newMember" action="https://www.gbelib.kr/${homepage.context_path}/intro/join/step22.do" method="post">
<form:hidden path="ageType"/>
<form:hidden path="before_url"/>
<form:hidden path="menu_idx"/>
</form:form>
<div style="clear:both">
<br/>
</div>
