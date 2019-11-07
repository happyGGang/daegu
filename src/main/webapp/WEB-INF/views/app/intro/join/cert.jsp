<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
$(function() {
	if ('${empty param.certType}' == 'true') {
		alert('잘못된 경로로 접근 하였습니다.');
		window.close();
	}
	
	<c:choose>
	<c:when test="${result['return'] ne 0}">
	alert("${result['message']}");
	window.close();
	</c:when>
	<c:when test="${fn:contains(fn:toLowerCase(param.certType), 'sms')}">
	document.form_chk.action = 'https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb';
	document.form_chk.submit();
	</c:when>
	<c:when test="${fn:contains(fn:toLowerCase(param.certType), 'gpin')}">
	document.form_ipin.action = 'https://cert.vno.co.kr/ipin.cb';
	document.form_ipin.submit();
	</c:when>
	<c:otherwise>
	</c:otherwise>
	</c:choose>
});
</script>
<c:if test="${fn:contains(fn:toLowerCase(param.certType), 'sms')}">
<form name="form_chk" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" name="m" value="checkplusSerivce">
<input type="hidden" name="EncodeData" value="${result['encData']}">
</form>
</c:if>

<c:if test="${fn:contains(fn:toLowerCase(param.certType), 'gpin')}">
<form name="form_ipin" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" name="m" value="pubmain">
<input type="hidden" name="enc_data" value="${result['encData']}">
<input type="hidden" name="param_r1" value="">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>
</c:if>



