<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('form#detailForm').submit();
	});
});
</script>
<form id="detailForm" action="/${homepage.context_path}/intro/search/detail.do" method="post">
	<input id="vLoca" name="vLoca" type="hidden" value="${newBookList.dsNewBookList[0].LOCA}">
	<input id="vCtrl" name="vCtrl" type="hidden" value="${newBookList.dsNewBookList[0].CTRLNO}">
	<input id="vImg" name="vImg" type="hidden" value="">
	<input id="detailMenuIdx" name="menu_idx" type="hidden" value="12">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
	<c:forEach var="i" begin="0" end="2">
	<li>
		<a href="" class="goDetail">
			<img src="${newBookList.dsNewBookList[i].COVER_SMALLURL ne '' ? newBookList.dsNewBookList[i].COVER_SMALLURL : '/resources/homepage/gw/img/noimg2.png' }" alt="${newBookList.dsNewBookList[i].TITLE}" width="80px" height="106px"/>
			<span>${newBookList.dsNewBookList[i].TITLE }</span>
		</a>
	</li>
	</c:forEach>