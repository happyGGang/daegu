<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(function() {

	$('input#member_pw_tmp').val('');
	$('a#save-btn').on('click', function(e) {
		e.preventDefault();

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#member').attr('onsubmit', '');
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
 		$('form#member').submit();
	});

	$('input#member_pw_tmp').on('keyup', function(e) {
		if (e.keyCode == 13) {
			$('a#save-btn').click();
		}
	});

	$('input#member_pw_tmp').focus();

});
</script>

<div class="join-wrap" style="padding: 0;text-align:center;">
	<form:form modelAttribute="member" action="modifyForm.do" method="post" onsubmit="return false;">
	<form:password path="member_pw" cssStyle="display:none;"/>
	<form:hidden path="menu_idx"/>
		<b class='title'>비밀번호 확인</b>
		<div class="inputWrap">
			<input type="password" id="member_pw_tmp" maxlength="20" class="txt" value="" placeholder="비밀번호를 입력해주세요" style="border:1px solid #ccc;padding:5px 10px;border-radius:3px"/>
		</div>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">확인</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
