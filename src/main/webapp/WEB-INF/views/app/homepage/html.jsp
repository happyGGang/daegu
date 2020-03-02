<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function copyToClipboard(s) {
    var $temp = jQuery("<input>");
    jQuery("body").append($temp);
    $temp.val(s).select();
    document.execCommand("copy");
    $temp.remove();
    alert('복사되었습니다.');
}
</script>
<c:choose>
<c:when test="${html ne null}">
${html.html}
</c:when>
<c:otherwise>
<div class="comming-soon">
	<p class="t1">이용에 불편을 드려 죄송합니다.</p>
	<strong>페이지 <em>준비중</em>입니다.</strong>
	<p class="t2">COMMING SOON</p>
</div>
</c:otherwise>
</c:choose>
