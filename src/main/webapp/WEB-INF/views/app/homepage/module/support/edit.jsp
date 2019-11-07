<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {

	$('a#btn_search').on('click', function(event) {
		window.open('/${homepage.context_path}/module/support/searchDept.do?code_name='+encodeURIComponent($('#req_name').val()), 'survey_quest', 'width=600, height=550, status=no, menubar=no, toolbar=no. scrollbars=yes');
		event.preventDefault();
	});	
	
	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/support/index.do';
		var formData = serializeParameter(['menu_idx']);
		
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('/${homepage.context_path}/module/support/index.do?menu_idx=' + $('#menu_idx').val()+'&pageType=ajax');
		} else {
			doGetLoad(url, formData);	
		}
	});
	
	$('#save-delete').on('click', function() {
		$('#editMode').val("DELETE");
		$.ajax({
			url : '/${homepage.context_path}/module/support/save.do',
			async : false,
			data : serializeObject($('#support_edit')),
			method : 'POST',
			dataType : 'json',
			success : function(data) {				
				if(data.valid) {
					alert(data.message);
					if($('#pageType').val() == 'ajax') {
						$('#tabCon1').load('/${homepage.context_path}/module/support/index.do?menu_idx=' + $('#menu_idx').val()+'&pageType=ajax');
					} else {
						doGetLoad('/${homepage.context_path}/module/support/index.do', 'menu_idx=' + $('#menu_idx').val());
					}
				} else {
					if (data.message != null && data.message.replace(/\s/g, '').length != 0) {
						alert(data.message);
					} else {
						for (var i = 0; i < data.result.length; i++) {
							alert(data.result[i].code);
							$('#' + data.result[i].field).focus();
							break;
						}
					}
				}
			}
		});
	});	
	
	$('#save-btn').on('click', function() {
		$('#requer_tel').val($('#requer_tel1').val()+'-'+$('#requer_tel2').val()+'-'+$('#requer_tel3').val());
		$.ajax({
			url : '/${homepage.context_path}/module/support/save.do',
			async : false,
			data : serializeObject($('#support_edit')),
			method : 'POST',
			dataType : 'json',
			success : function(data) {				
				if(data.valid) {
	                 if(data.message != null && data.message.replace(/\s/g,'').length!=0) {
	                	 alert(data.message);
	                 }
    				if(data.targetOpener) {
    					window.open(data.url, '', 'width=500,height=510');
    					return false;
    				}
					if($('#pageType').val() == 'ajax') {
						$('#tabCon1').load('/${homepage.context_path}/module/support/index.do?menu_idx=' + $('#menu_idx').val()+'&pageType=ajax');
					} else {
						doGetLoad('/${homepage.context_path}/module/support/index.do', 'menu_idx=' + $('#menu_idx').val());
					}
				} else {
	   				if(data.targetOpener) {
						window.open(data.url, '', 'width=500,height=510');
						return false;
					}
					if (data.message != null && data.message.replace(/\s/g, '').length != 0) {
						alert(data.message);
					} else {
						for (var i = 0; i < data.result.length; i++) {
							alert(data.result[i].code);
							$('#' + data.result[i].field).focus();
							break;
						}
					}
				}
			}
		});
	});
	
	if('${support.requer_tel}' == '') {		
		$('#requer_tel1').val("010");	
	} else {
		var requer_tel = '${support.requer_tel}'.split('-');
		$('#requer_tel1').val(requer_tel[0]);
		$('#requer_tel2').val(requer_tel[1]);
		$('#requer_tel3').val(requer_tel[2]);	
	}
});
function setReqData(req_organ_code, req_name){
	$('#req_organ_code').val(req_organ_code);
	$('#req_name').val(req_name);
}
</script>
<form:form modelAttribute="support" id="support_edit" action="save.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="seq"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pageType"/>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>*신청기관명</th>
			<td>
				<form:hidden path="req_organ_code"/>
				<form:input path="req_name" class="text" cssStyle="width:50%" />
				<a href="" class="btn" id="btn_search"><span>기관검색</span></a>
			</td>
		</tr>
		<tr>
			<th>*신청자성명</th>
			<td><form:input path="requer_name" class="text" cssStyle="width:50%"/></td>
		</tr>
		<tr>
			<th>*신청자휴대폰</th>
			<td>
				<form:hidden path="requer_tel"/>
				<form:select path="requer_tel1" cssStyle="width:50px;height:30px;">
					<form:options items="${cellPhoneCode}" itemLabel="code_name" itemValue="code_id"/>
				</form:select> -
				<form:input path="requer_tel2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
				<form:input path="requer_tel3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>
			</td>
		</tr>
		<tr>
			<th>*지원희망일자</th>
			<td>${support.plan_date}<form:hidden id="hope_req_dt" path="hope_req_dt" value="${support.plan_date}"/></td>			
		</tr>
		<tr>
			<th>*제목</th>
			<td><form:input path="req_title" class="text" cssStyle="width:80%"/></td>
		</tr>
		<tr>
			<th>신청내용</th>
			<td><form:textarea path="req_content" class="text" cssStyle="width:100%; height:150px"/></td>
		</tr>		
	</tbody>
</table>
<em>*항목은 반드시 기록 하셔야 합니다.</em>
</form:form>
<div class="txt-right">
	<c:if test="${support.editMode eq 'ADD' }">
		<button id="save-btn" class="btn btn2">신청하기</button>
	</c:if>
	<c:if test="${support.editMode eq 'MODIFY' }">
		<button id="save-btn" class="btn btn2">수정하기</button>
		<button id="save-delete" class="btn btn1">삭제하기</button>
	</c:if>
	
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
