<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		
		if ($('input#price').val() != '') {
			var price = $('input#price').val();
			if (!parseInt(price)) {
				alert('가격은 숫자만 입력가능합니다.');
				$('input#price').focus();
				return false;
			}
		}
		
		if ( doAjaxPost($('#reqHopeForm')) ) {
			doGetLoad('index.do');
		}
		e.preventDefault();
	});
	
	doAjaxLoad('div#searchBox', 'search.do');
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<div id="searchBox">

</div>
<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">

<form:form id="reqHopeForm" modelAttribute="librarySearch" action="save.do" method="post">
	<form:hidden path="editMode" value="ADD"/>
	<form:hidden path="vLoca" value="${homepage.homepage_code}"/>
	<table class="edit">
		<tbody><tr>
			<th>제목 <em><font color="red">(*)</font></em></th>
			<td><form:input path="title" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>저자 <em><font color="red">(*)</font></em></th>
			<td><form:input path="author" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>출판사 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>연도 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer_year" style="width:10%" class="text" type="text" numberOnly="true" maxlength="4"/></td>
		</tr>
		<tr>
			<th>ISBN</th>
			<td><form:input path="isbn" style="width:40%" class="text" type="text" maxlength="24"/></td>
		</tr>
		<tr>
			<th>판차</th>
			<td><form:input path="editon" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><form:input path="user_remark" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>가격 <em><font color="red">(*)</font></em></th>
			<td><form:input path="price" style="width:20%" class="text" type="text" maxlength="10" numberOnly="true" /></td>
		</tr>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
	<a id="save-btn" href="" class="btn btn5"><span>신청하기</span></a>
</div>

