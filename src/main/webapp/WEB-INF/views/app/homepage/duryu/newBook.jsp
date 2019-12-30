<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('form#detailForm #vLoca').val($(this).attr('keyValue1'));
		$('form#detailForm #vCtrl').val($(this).attr('keyValue2'));
		$('form#detailForm').submit();
	});
});
</script>
<form id="detailForm" action="/${homepage.context_path}/intro/search/detail.do" method="post">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input id="vLoca" name="vLoca" type="hidden" value="">
	<input id="vCtrl" name="vCtrl" type="hidden" value="">
	<input id="vImg" name="vImg" type="hidden" value="">
	<input id="detailMenuIdx" name="menu_idx" type="hidden" value="12">
</form>
<c:forEach var="i" items="${newBookList.dsNewBookList}" end="2">
	<li>
		<a class="goDetail" href="" keyValue1="${i.LOCA}" keyValue2="${i.CTRLNO}">
			<img src="${i.COVER_SMALLURL ne '' ? i.COVER_SMALLURL : '/resources/homepage/cs/img/noimg1.png' }" alt="${i.TITLE}" width="80px" height="105px">
			<span>${i.TITLE}</span>
		</a>
	</li>
</c:forEach>
