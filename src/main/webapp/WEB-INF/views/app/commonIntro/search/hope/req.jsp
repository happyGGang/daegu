<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {

		<c:if test="${fn:indexOf(homepage.homepage_code, '00147006') > 0}">
		if ($('input[name=vLoca]:checked').length < 1) {
			alert('신청하실 도서관을 선택하세요.');
			$('input#vLoca1').focus();
			return false;
		}
		</c:if>

		if ( doAjaxPost($('#reqHopeForm')) ) {
			location.href = '/${homepage.context_path}/intro/search/hope/index.do?menu_idx=${librarySearch.menu_idx}';
		}
		e.preventDefault();
	});

	doAjaxLoad('div#searchBox', 'search.do');
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<form:form id="reqHopeForm" modelAttribute="librarySearch" action="save.do" method="post">
	<input id="editMode" name="editMode" type="hidden" value="ADD"/>
	<c:choose>
		<c:when test="${fn:indexOf(homepage.homepage_code, '00147006') > 0}">
			<div class="inline">
			<form:radiobutton path="vLoca" value="00147020" cssStyle="vertical-align: middle; " />
			<label for="vLoca1" style="font-size: 20px;">경상북도교육청 점촌도서관</label>
			<form:radiobutton path="vLoca" value="00147006" cssStyle="vertical-align: middle;"/>
			<label for="vLoca2" style="font-size: 20px;">경상북도교육청 점촌공공도서관 가은분관</label>
			</div>
		</c:when>
		<c:otherwise>
			<form:hidden path="vLoca" value="${homepage.homepage_code}"/>
		</c:otherwise>
	</c:choose>
	<table class="edit">
		<tbody><tr>
			<th>제목 <em><font color="red">(*)</font></em></th>
			<td><form:input path="title" style="width:90%" class="text" type="text" title="제목" /></td>
		</tr>
		<tr>
			<th>저자 <em><font color="red">(*)</font></em></th>
			<td><form:input path="author" style="width:90%" class="text" type="text" title="저자" /></td>
		</tr>
		<tr>
			<th>출판사 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer" style="width:90%" class="text" type="text" title="출판사" /></td>
		</tr>
		<tr>
			<th>연도 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer_year" style="width:10%" class="text" type="text" numberOnly="true" maxlength="4"  title="연도, 입력예시 2017" /></td>
		</tr>
		<tr>
			<th>ISBN</th>
			<td><form:input path="isbn" style="width:40%" class="text" type="text" maxlength="24"  title="ISBN" /></td>
		</tr>
		<tr>
			<th>판차</th>
			<td><form:input path="editon" class="text" type="text"  title="판차" /></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><form:input path="user_remark" style="width:90%" class="text" type="text" title="비고" /></td>
		</tr>
		<tr>
			<th>가격 <em><font color="red">(*)</font></em></th>
			<td><form:input path="price" style="width:20%" class="text" type="text" maxlength="10" numberOnly="true"  title="가격"  /></td>
		</tr>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
	<a id="save-btn" href="" class="btn btn5"  title="신청하기" ><span>신청하기</span></a>
</div>

