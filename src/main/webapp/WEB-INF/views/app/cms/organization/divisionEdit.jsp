<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function() {
	$('#dialog-1').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "완료",
				"class": 'btn',
				click: function() {
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 380
	});
	
	$('a#division-add').on('click', function(e) {
		if(doAjaxPost($('form#statusDivision'))) {
			$('a#dialog-division').click();
		}
	});
	
	$('a.division-modify').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('MODIFY');
		$('input#division_idx_div_u').val($(this).attr('keyValue'));
		var key_id = 'input#' + $(this).attr('keyValue2');
		$('input#division_name_u').val($(key_id).val());
		var print_id = 'input#' + $(this).attr('keyValue3');
		$('input#print_seq_u').val($(print_id).val());
		 
		if(doAjaxPost($('form#statusDivisionMod'))) {
			$('a#dialog-division').click();
		};
	});
	
	$('a.division-delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제시 하위 조직현황 내용들이 함께 삭제됩니다.\n삭제하시겠습니까?')) {
			$('input#division_idx_div_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#statusDivisionDel'))) {
				$('a#dialog-division').click();
			}
		}
	});
	
});
</script>
<form:form modelAttribute="organization" id="statusDivisionDel" action="devisionDelete.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_div_d"/>
	<form:hidden path="division_idx" id="division_idx_div_d"/>
</form:form>
<form:form modelAttribute="organization" id="statusDivisionMod" action="divisionSave.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_div_u"/>
	<form:hidden path="division_idx" id="division_idx_div_u"/>
	<form:hidden path="division_name" id="division_name_u"/>
	<form:hidden path="print_seq" id="print_seq_u"/>
	<form:hidden path="editMode" id="editMode_u" value="MODIFY"/>
</form:form>
<form:form modelAttribute="organization" id="statusDivision" action="divisionSave.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
			<col width="70"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>직&nbsp;&nbsp;&nbsp;렬</th>
				<td>
					<form:input path="division_name" cssClass="text" size="26"/>
					<a href="#" id="division-add" class="btn btn1">추가</a>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<table class="center">
		<colgroup>
			<col>
			<col>
			<col width="120">
		</colgroup>
		<thead>
			<tr>
				<th>직렬</th>
				<th>순서</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${statusDivisionList}" var="i">
			<tr>
				<td>
					<input type="text" id="div_${i.division_idx}" value="${i.division_name}" class="text"/>
				</td>
				<td>
					<input type="text" id="print_${i.division_idx}" value="${i.print_seq}" style="width:30px;" class="text spinner"/>
				</td>
				<td>
					<a href="#" class="btn division-modify" keyValue="${i.division_idx}" keyValue2="div_${i.division_idx}" keyValue3="print_${i.division_idx}">수정</a>
					<a href="#" class="btn division-delete" keyValue="${i.division_idx}">삭제</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(statusDivisionList) < 1}">
			<tr>
				<td colspan="3">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	
</form:form>