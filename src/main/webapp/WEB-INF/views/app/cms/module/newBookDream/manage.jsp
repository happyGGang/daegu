<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	var $form = $('form#bookDreamManage');
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($form);
	});

});
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script>
<form:form modelAttribute="bookDreamManage" method="POST" action="saveConfig.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>

<h3>도서신청 설정</h3>
<table class="type1 center" summary="서점명, 대표자, 전화번호, 등록일, 관리에 대해 서점관리 부분을 안내하는 표입니다.">
	<caption class="blind">서점관리</caption>
	<colgroup>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th width="150">구분</th>
			<th width="">내용</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" varStatus="status" items="${bookDreamConfig}">
			<c:if test="${i.c_no < 9 or i.c_no >= 23}">
		<tr>
			<td width="50">${i.c_name}</td>
			<td style="text-align: left;">
				<form:hidden path="innerList[${status.index}].c_no" value="${i.c_no}"/>
				<form:input path="innerList[${status.index}].c_value" cssClass="text"  numberOnly="true" value="${i.c_value}"/> *숫자만 입력 가능합니다.
			</td>
		</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>
<br/>

<h3>SMS문구 설정</h3>
<table class="type1 center" summary="SMS관리">
	<caption class="blind">SMS관리</caption>
	<colgroup>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th width="150">구분</th>
			<th width="">내용</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" varStatus="status" items="${bookDreamConfig}">
			<c:if test="${(i.c_no > 8 and i.c_no <= 13) or (17 <= i.c_no and i.c_no <= 22)}">
		<tr>
			<td width="50">${i.c_name}</td>
			<td style="text-align: left;">
				<form:hidden path="innerList[${status.index}].c_no" value="${i.c_no}"/>
				<form:input path="innerList[${status.index}].c_value" cssClass="text"  value="${i.c_value}" cssStyle="width:70%;"/>
			</td>
		</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>
</form:form>
<div class="infodesk">
	<div class="button">
		<a href="" class="btn btn5 left" id="dialog-add"><span>저장</span></a>
	</div>
</div>
<div id="dialog-1" class="dialog-common" title="베너 정보">
</div>
