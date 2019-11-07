<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('div#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#rsupport_result'))) {
						$(this).dialog('destroy');
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			},{
				text: "삭제",
				"class": 'btn btn1',
				"id": 'del_btn',
				click: function() {
					if ( confirm("정말 삭제 하시겠습니까?") ) {
						$('input#editMode').val('DELETE');
						if(doAjaxPost($('#rsupport_result'))) {
							$(this).dialog('destroy');
							location.reload();
						}	
					}
				}
			}
		]
	});
	
	if($('input#editMode').val() == 'ADD'){
		$('#del_btn').hide();
	} else {
		$('#del_btn').show();
	}
	
	$("div#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 700
	});
	

});
</script>
<form:form modelAttribute="support" id="rsupport_result" action="result.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="seq"/>
<em><strong>신청내역</strong></em>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청기관명</th>
			<td>${support.req_name}</td>
		</tr>
		<tr>
			<th>신청자성명</th>
			<td>${support.requer_name}</td>
		</tr>
		<tr>
			<th>신청자휴대폰</th>
			<td>${support.requer_tel}</td>
		</tr>
		<tr>
			<th>지원희망일자</th>
			<td>${support.hope_req_dt}</td>			
		</tr>
		<tr>
			<th>*제목</th>
			<td>${support.req_title}</td>
		</tr>
		<tr>
			<th>신청내용</th>
			<td>${support.req_content}</td>
		</tr>		
	</tbody>
</table>
<br/>
<em><strong>현장지원결과등록</strong></em>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>*지원구분</th>
			<td>
				<form:radiobutton path="support_div" value="1"/>&nbsp;방문지원&nbsp;
				<form:radiobutton path="support_div" value="2"/>&nbsp;원격지원&nbsp;
				<form:radiobutton path="support_div" value="3"/>&nbsp;전화지원&nbsp;
			</td>
		</tr>
		<tr>
			<th>*지원자</th>
			<td><form:input path="supporter" class="text" cssStyle="width:80%"/></td>			
		</tr>
		<tr>
			<th>협력업체</th>
			<td><form:input path="subcontractor" class="text" cssStyle="width:80%"/></td>
		</tr>
		<tr>
			<th>*지원내용</th>
			<td><form:textarea path="support_content" class="text" cssStyle="width:100%; height:150px"/></td>
		</tr>		
	</tbody>
</table>
<em>*항목은 반드시 기록 하셔야 합니다.</em>
</form:form>

