<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
function checkAll($this) { 
	$('input:checkbox[name=locker_number_arr]').prop('checked', $this.is(':checked'));
}

function changeStatus($this) {
	var number = $this.data('number');
	var type = $this.val();
	var editMode = '';
	$.ajax({
		type: "POST",
		url: 'save.do',
		data: {'locker_number':number, 'locker_type':type, 'editMode':editMode},
		success: function(response) {
			if (response.valid) {
				alert('수정되었습니다.');
			}
		},
		error : function() {
			alert('수정에 실패했습니다. 관리자에게 문의해 주세요.')
		}
	});
}

function allChange() {
	var ajaxData = {
		'locker_number_arr' : '1,2,3,4',
		'locker_type':$('#locker_all_change').val(), 
		'editMode':'MODIFY_ALL'
	};

	$.ajax({
		type: "POST",
		url: 'save.do',
		data: ajaxData,
		success: function(response) {
			if(response.valid) {
				alert('수정 되었습니다.');
			}
		},
		error : function() {
			alert('수정에 실패했습니다.\n\n관리자에게 문의해 주세요.');
		}
	});
}
</script>

<form:form id="untactLockerSetting_1" modelAttribute="untactLockerSetting" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="homepage_id" path="homepage_id"/>
<form:hidden path="locker_number"/>
<div id="editDisable" class="disableBox">
	<div class="infodesk">
		<div class="button">
			<c:if test="${authD}">
				<a href="" class="btn btn1 right" id="dialog-change" data-key="일반사물함"><span>일반사물함</span></a>
				<!-- <a href="" class="btn btn2 right" id="dialog-change"><span>도서대출</span></a>
				<a href="" class="btn btn5 right" id="dialog-change"><span>사용안함</span></a> -->
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="20"><input type="checkbox" onchange="checkAll($(this));"></th>
				<th width="30">사물함번호</th>
				<th width="50">사물함용도</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(untactLockerSettingList) < 1}">
			<tr style="height:100%">
				<td colspan="10" style="background:#f8fafb;">비대면 사물함 도서관리 -> 사물함 기본설정에서 사물함 갯수를 설정해주세요.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${untactLockerSettingList}">
			<tr>
				<td width="20"><form:checkbox path="locker_number_arr" value="${i.locker_number}"/></td>
				<td width="30">${i.locker_number}번</td>
				<td width="50">
					<select class="changeStatus" data-number="${i.locker_number}" onchange="changeStatus($(this));">
						<option value="일반사물함" <c:if test="${i.locker_type eq '일반사물함'}">selected</c:if>>일반사물함</option>
						<option value="도서대출" <c:if test="${i.locker_type eq '도서대출'}">selected</c:if>>도서대출</option>
						<option value="사용안함" <c:if test="${i.locker_type eq '사용안함'}">selected</c:if>>사용안함</option>
					</select>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		-- 변경할 xxx 
		<select id="locker_all_change">
			<option>선택하세요.</option>
			<option value="일반사물함">일반사물함</option> 
			<option value="도서대출">도서대출</option>
			<option value="사용안함">사용안함</option>
		</select>
		<button id="search_btn" type="button" onclick="allChange();"><span>수정하기</span></button>
	</fieldset>
</div>
</form:form>