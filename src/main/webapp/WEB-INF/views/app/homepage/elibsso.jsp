<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
//<![CDATA[

onload = function(){

	$('#goEbookTest').submit();
/*
<c:choose>
	<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
		alert("대출회원(정회원)으로 로그인 후 사용하세요.");
		window.opener = 'nothing';
		window.open('','_parent','');
		window.close();
	</c:when>
	<c:otherwise>
		$('#goEbookTest').submit();
	</c:otherwise>
</c:choose>
*/
}

//]]>
</script>


	<form id="goEbookTest" action="http://e-lib.tglnet.or.kr/elib_sso.asp" method="post" accept-charset="utf-8"> 
	<input type="hidden"  name="lib_code" value="122003" />
	<input type="hidden"  name="user_id" value="hsbhj116" />
	<input type="hidden"  name="name" value="변혜주" />
	<input type="hidden"  name="next" value="default" />
	</form>





