<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

onload = function(){

	document.loginform.submit();

}

</script>


<form name="loginform" method="post" action="http://aspservice.audien.com/inticube/front/NeoAspMain.do?paId=250b83610ee5d75621e4&userId=${sessionScope.member.member_id}">
</form>

