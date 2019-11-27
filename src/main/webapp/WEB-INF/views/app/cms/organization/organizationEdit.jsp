<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function() {
	$('#dialog-4').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
// 	        $(this).dialog('destroy');
	        location.reload();
	    },
		buttons: [
			{
				text: "확인",
				"class": 'btn',
				click: function() {
// 					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});

	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700
	});

	$('a#organization-add').on('click', function(e) {
		if($('input#organization_name').val() == '') {
			alert('\'부서\' 필수 입력항목입니다.');
			$('input#organization_name').focus();
			return false;
		}

		if('${fn:length(organizationList) >= 1}' == 'true' && ($('select#above_idx').val() == null || $('select#above_idx').val() == '')) {
			alert('상위부서를 선택하세요.');
			$('select#above_idx').focus();
			return false;
		}

		if(doAjaxPost($('form#organizationEdit'))) {
			$('a#dialog-organization').click();
		}
	});

	$('a.organization-mod').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('MODIFY');
		$('input#div_idx_organization_u').val($(this).attr('keyValue'));
		var key_id = 'input#' + $(this).attr('keyValue2');
		$('input#organization_name_u').val($(key_id).val());
		var parent_idx = 'select#above_' + $(this).attr('keyValue');
		$('input#above_idx_u').val($(parent_idx).val());
		var print_id = 'input#' + $(this).attr('keyValue3');
		$('input#print_seq_u').val($(print_id).val());

		if(doAjaxPost($('form#organizationMod'))) {
			$('a#dialog-organization').click();
		}
	});

	$('a.organization-del').on('click', function(e) {
		e.preventDefault();

		if($('tr.organization_tr').length == 2 && $('input#chart_yn1').is(':checked')) {
			alert('부서 목록이 1개인 경우 조직도 표시여부를 사용할 수 없습니다.\n조직도 표시여부를 미사용으로 변경 후 삭제하시기 바랍니다.');
			return false;
		}

		var organization_work_cnt = $(this).attr('keyValue2');
		var message = "";
		if(organization_work_cnt > 0) {
			message = "부서 삭제시, 등록된 하위 업무 및 내용도 삭제됩니다.\n삭제하시겠습니까?";
		} else {
			message = "삭제하시겠습니까?";
		}

		if(confirm(message)) {
			$('input#div_idx_organization_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#organizationDel'))) {
				$('a#dialog-organization').click();
			}
		}
	});

	var organization_n = $('.organization_tr').length;
	if(organization_n < 2) {
		$('input[type="radio"]').attr('disabled', 'disabled');
	}

	$('input[type="radio"]').on('change', function(e) {
		var data = 'homepage_id=${organization.homepage_id}&chart_yn=' + $('input[type="radio"]:checked').val();
		$('form#organizationEdit').attr('action', 'chartModify.do');
		doAjaxPost($('form#organizationEdit'));
	});

});
</script>
<style>
select {
    border: 1px solid #ccd2dc;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    background: #fafafa;
    line-height: 27px;
    height: 27px;
    padding: 0 5px;
    vertical-align: middle;
}
em {font-style: normal;}
</style>
<form:form modelAttribute="organization" id="organizationDel" action="organizationDelete.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_organization_d"/>
	<form:hidden path="organization_idx" id="div_idx_organization_d"/>
</form:form>
<form:form modelAttribute="organization" id="organizationMod" action="organizationSave.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_organization_u"/>
	<form:hidden path="organization_idx" id="div_idx_organization_u"/>
	<form:hidden path="organization_name" id="organization_name_u"/>
	<form:hidden path="above_idx" id="above_idx_u"/>
	<form:hidden path="print_seq" id="print_seq_u"/>
	<form:hidden path="editMode" id="editMode_u" value="MODIFY"/>
</form:form>
<form:form modelAttribute="organization" id="organizationEdit" action="organizationSave.do" method="POST">
	<form:hidden path="homepage_id"/>
	<table class="type2">
		<colgroup>
			<col width="140"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>부 서</th>
				<td>
					<form:input path="organization_name" cssClass="text" size="26"/>
					<form:select path="above_idx" cssClass="select2-selection__rendered">
						<form:option label="상위부서를 선택하세요." value="-1" disabled="true"/>
						<form:options items="${organizationList}" itemLabel="organization_name" itemValue="organization_idx"/>
					</form:select>
					<a href="#" id="organization-add" class="btn btn1">추가</a>
				</td>
			</tr>
			<tr>
				<th>조직도 표시여부</th>
				<td>
					<form:radiobutton path="chart_yn" label="사용" value="Y"/>
					<form:radiobutton path="chart_yn" label="미사용" value="N"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i><em>부서가 2개 이상인 경우만 조직도가 표시됩니다.</em>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<br>
<table class="center">
	<colgroup>
		<col>
		<col width="120">
		<col>
		<col width="120">
	</colgroup>
	<thead>
		<tr>
			<th>부 서</th>
			<th>상위부서</th>
			<th>순서</th>
			<th>비고</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${organizationList}" var="i">
		<tr class="organization_tr">
			<td>
				<input type="text" id="organization_${i.organization_idx}" value="${i.organization_name}" class="text"/>
			</td>
			<td>
				<select id="above_${i.organization_idx}" style="width: 100px;">
					<c:if test="${i.organization_idx == 1}">
					<option label="최상위" value="0" />
					</c:if>
					<c:if test="${i.organization_idx != 1}">
						<c:forEach items="${organizationList}" var="j" varStatus="status">
						<c:if test="${i.organization_idx != j.organization_idx}">
						<option label="${j.organization_name}" value="${j.organization_idx}" <c:if test="${i.above_idx == j.organization_idx}">selected="selected"</c:if>/>
						</c:if>
						</c:forEach>
					</c:if>
				</select>
			</td>
			<td>
				<input type="text" id="print_${i.organization_idx}" value="${i.print_seq}" style="width:30px; text-align:center;" class="text spinner"/>
			</td>
			<td>
				<a href="#" class="btn organization-mod" keyValue="${i.organization_idx}" keyValue2="organization_${i.organization_idx}" keyValue3="print_${i.organization_idx}">수정</a>
				<c:if test="${i.organization_idx != 1}">
				<a href="#" class="btn organization-del" keyValue="${i.organization_idx}" keyValue2="${i.in_cnt}">삭제</a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<table class="type2">
<div class="ui-state-highlight">
	<i class="fa fa-question-circle"></i><em>수정시 수정버튼을 클릭하여야 적용됩니다.</em>
</div>
