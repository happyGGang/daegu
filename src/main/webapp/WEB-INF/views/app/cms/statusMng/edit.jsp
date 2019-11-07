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
// 	        $(this).dialog('destroy');
	        location.reload();
	    },
		buttons: [
			{
				text: "완료",
				"class": 'btn',
				click: function() {
// 					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 380
	});
	
	$('a#div-add').on('click', function(e) {
		if(doAjaxPost($('form#statusDiv'))) {
			$('a#dialog-add').click();
		}
	});
	
	$('a.div-mod').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('MODIFY');
		$('input#div_idx_div_u').val($(this).attr('keyValue'));
		var key_id = 'input#' + $(this).attr('keyValue2');
		$('input#div_name_u').val($(key_id).val());
		var print_id = 'input#' + $(this).attr('keyValue3');
		$('input#print_seq_u').val($(print_id).val());
		 
		if(doAjaxPost($('form#statusDivMod'))) {
			$('a#dialog-add').click();
		};
	});
	
	$('a.div-del').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제시 하위 조직현황 내용들이 함께 삭제됩니다.\n삭제하시겠습니까?')) {
			$('input#div_idx_div_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#statusDivDel'))) {
				$('a#dialog-add').click();
			}
		}
	});
	
});
</script>
<form:form modelAttribute="statusMng" id="statusDivDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_div_d"/>
	<form:hidden path="div_idx" id="div_idx_div_d"/>
</form:form>
<form:form modelAttribute="statusMng" id="statusDivMod" action="save.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_div_u"/>
	<form:hidden path="div_idx" id="div_idx_div_u"/>
	<form:hidden path="div_name" id="div_name_u"/>
	<form:hidden path="div_print_seq" id="print_seq_u"/>
	<form:hidden path="editMode" id="editMode_u" value="MODIFY"/>
</form:form>
<form:form modelAttribute="statusMng" id="statusDiv" action="save.do" method="POST">
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
					<form:input path="div_name" cssClass="text" size="26"/>
					<a href="#" id="div-add" class="btn btn1">추가</a>
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
			<c:forEach items="${statusDivList}" var="i">
			<tr>
				<td>
					<input type="text" id="div_${i.div_idx}" value="${i.div_name}" class="text"/>
				</td>
				<td>
					<input type="text" id="print_${i.div_idx}" value="${i.div_print_seq}" style="width:30px;" class="text spinner"/>
				</td>
				<td>
					<a href="#" class="btn div-mod" keyValue="${i.div_idx}" keyValue2="div_${i.div_idx}" keyValue3="print_${i.div_idx}">수정</a>
					<a href="#" class="btn div-del" keyValue="${i.div_idx}">삭제</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(statusDivList) < 1}">
			<tr>
				<td colspan="3">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	
</form:form>