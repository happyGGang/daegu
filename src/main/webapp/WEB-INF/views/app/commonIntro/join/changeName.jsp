<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	
	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('form#newMember'));
	});
	
	$('a#cancel').on('click', function(e) {
		e.preventDefault();
		location.href = '/${homepage.context_path}/index.do';
	});
});
</script>

<div class="join-wrap" style="padding: 0">

	<h4>성명변경 안내</h4>
	<div>
		- 개명하신 경우 본인인증을 통한 성명 변경이 가능합니다.<br/>
		- 변경될 성명을 확인 후 변경버튼을 통해 성명이 변경됩니다.<br/>
		- 변경 시 자동으로 로그아웃 되며 재 로그인 후 변경한 성명으로 이용 가능합니다.<br/>
	</div>
	
	<form:form modelAttribute="newMember" action="cName.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="before_url"/>
	<form:hidden path="ageType"/>
	<form:hidden path="menu_idx"/>
	<br/>
	<br/>
	<h4>성명확인</h4>
	<table>
		<colgroup>
			<col width="7%">
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
		<tr>
			<th class="center"></th>
			<th class="center">이전 성명</th>
			<th class="center">변경 성명</th>
		</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td class="center">${sessionScope.oldName}</td>
				<td class="center" style="font-weight: bold;">${sessionScope.newName}</td>
			</tr>
		</tbody>
	</table>
	
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">성명 변경</a>
		<a href="#" id="cancel" class="btn btn">취소</a>
	</div>
	
</div>