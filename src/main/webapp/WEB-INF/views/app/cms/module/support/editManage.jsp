<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('div#dialog-4.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	if($('input#editMode').val() == 'ADD'){
		$('#del_btn').hide();
	} else {
		$('#del_btn').show();
	}
	
	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 700
	});
	
	$('input#start_date.ui-calendar').datepicker({
		maxDate: $('input#end_date.ui-calendar').val(), 
		onClose: function(selectedDate) {
			$('input#end_date.ui-calendar').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date.ui-calendar').datepicker({
		minDate: $('input#start_date.ui-calendar').val(), 
		onClose: function(selectedDate) {
			$('input#start_date.ui-calendar').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a.add-btn').on('click', function(e) {
		if(doAjaxPost($('#supportManage_edit'))) {
			location.reload();
		}
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		$('#hiddenForm #editMode').val('DELETE');
		$('#hiddenForm #support_manage_idx').val($(this).attr('keyValue'));
		if ( doAjaxPost($('#hiddenForm')) ) {
			location.reload();
		}
		
		e.preventDefault();
	});
	
	$('a.modify-btn').on('click', function(e) {
		var support_manage_idx = $(this).attr('keyValue');
		var $tr = $('tr.manage_' + support_manage_idx);
		
		$tr.find('.viewMode').hide();
		$tr.find('.editMode').show();
		
		$('input#start_date_' + support_manage_idx).datepicker({
			maxDate: $('input#end_date_' + support_manage_idx).val(), 
			onClose: function(selectedDate) {
				$('input#end_date_' + support_manage_idx).datepicker('option', 'minDate', selectedDate);
			}
		});
		
		$('input#end_date_' + support_manage_idx).datepicker({
			minDate: $('input#start_date_' + support_manage_idx).val(), 
			onClose: function(selectedDate) {
				$('input#start_date_' + support_manage_idx).datepicker('option', 'maxDate', selectedDate);
			}
		});
		
		e.preventDefault();
	});
	
	$('a.save-modify-btn').on('click', function(e) {
		var support_manage_idx = $(this).attr('keyValue');
		
		$('#hiddenForm #editMode').val('MODIFY');
		$('#hiddenForm #support_manage_idx').val(support_manage_idx);
		$('#hiddenForm #hidden_start_date').val($('input#start_date_' + support_manage_idx).val());
		$('#hiddenForm #hidden_end_date').val($('input#end_date_' + support_manage_idx).val());
		$('#hiddenForm #limit_req_count').val($('input#limit_req_count_' + support_manage_idx).val());

		if ( doAjaxPost($('#hiddenForm')) ) {
			location.reload();
		}
		e.preventDefault();
	});
});
</script>
<form:form modelAttribute="supportManage" id="hiddenForm" action="saveManage.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden id="hidden_start_date" path="start_date"/>
	<form:hidden id="hidden_end_date" path="end_date"/>
	<form:hidden path="support_manage_idx"/>
	<form:hidden path="limit_req_count"/>
</form:form>

<form:form modelAttribute="supportManage" id="supportManage_edit" action="saveManage.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="support_manage_idx"/>
	<table class="type2">
		<colgroup>
			<col width="100"/>
			<col width="80"/>
			<col width="100"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>신청 제한 수</th>			
	         	<td>
	  				<form:input path="limit_req_count" class="text" style="width:50px"/>	
	       		</td>
				<th>신청 가능 기간</th>
				<td>
					<form:input type="text" path="start_date" class="text ui-calendar"/> ~ <form:input type="text" path="end_date" class="text ui-calendar"/>
				</td>
				<td><a href="" class="btn btn5 add-btn" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>저장</span></a></td>
			</tr>
		</tbody>
	</table>
	<div class="ui-state-highlight">
		* 신청 제한 수는 설정 기간의 하루당 제한 수 입니다.
	</div>
</form:form>
<br/>
<table class="type1 center">
	<thead>
		<tr>
		    <th>번호</th>
		    <th>시작일</th>
		    <th>종료일</th>
		    <th>신청 제한 수</th>
		    <th>기능</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${supportManageList}" var="i">
			<tr class="manage_${i.support_manage_idx}">
			    <td>
			    	${i.support_manage_idx}
			    </td>
			    <td>
			    	<span class="viewMode">${i.start_date}</span>
			    	<input id="start_date_${i.support_manage_idx}" class="editMode text ui-calendar" type="text" style="display:none" value="${i.start_date}">
			    </td>
			    <td>
			    	<span class="viewMode">${i.end_date}</span>
			    	<input id="end_date_${i.support_manage_idx}" class="editMode text ui-calendar" type="text" style="display:none" value="${i.end_date}">
		    	</td>
			    <td>
			    	<span class="viewMode">${i.limit_req_count}</span>
			    	<input id="limit_req_count_${i.support_manage_idx}" class="editMode text" type="text" style="display:none;width:50px" value="${i.limit_req_count}"/>
		    	</td>
			    <td>
			    	<a class="btn editMode save-modify-btn" style="display:none" keyValue="${i.support_manage_idx}">저장</a>
			    	<a class="btn viewMode modify-btn" keyValue="${i.support_manage_idx}">수정</a>
			    	<a class="btn viewMode delete-btn" keyValue="${i.support_manage_idx}">삭제</a>
		    	</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
