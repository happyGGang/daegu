<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

onload = function(){

	document.ssoLogin.submit();

}

function emulAcceptCharset(form) {
	if (form.canHaveHTML) { // detect IE
		document.charset = form.acceptCharset;
	}
	return true;
}

</script>


<form name="ssoLogin" action="http://digital.donggu-lib.kr/member_sso.asp" method="post" target="_self" accept-charset="utf-8" onsubmit="emulAcceptCharset(this)">
<input type="hidden" id="web_id" name="web_id" value="${sessionScope.member.member_id}">
<input type="hidden" name="user_nm" value="${sessionScope.member.member_name}">
<input type="hidden" name="target" value="/elearning/elearning_main.asp">
</form>