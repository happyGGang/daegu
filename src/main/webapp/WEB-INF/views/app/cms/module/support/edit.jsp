<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('div#dialog-1.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					if($('#requer_tel1').val() != "") {
						$('#requer_tel').val($('#requer_tel1').val() + "-" + $('#requer_tel2').val() + "-" + $('#requer_tel3').val());
					}

					if(doAjaxPost($('#support_edit'))) {
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
						if(doAjaxPost($('#support_edit'))) {
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 560,
		height: 550
	});
	
	$('a#btn_search').on('click', function(event) {
		$('#dialog-dept').load('searchDept.do?code_name='+encodeURIComponent($('#support_edit #req_name').val()), function( response, status, xhr ) {
			$('#dialog-dept').dialog('open');	
	    });
		event.preventDefault();
	});
	
	$('input#hope_req_dt').datepicker({
		onClose: function(selectedDate){
			$('input#req_title').focus();
		}
	});	
	
	if('${support.requer_tel}' == '') {		
		$('#requer_tel1').val("010");	
	} else {
		var requer_tel = '${support.requer_tel}'.split('-');
		$('#requer_tel1').val(requer_tel[0]);
		$('#requer_tel2').val(requer_tel[1]);
		$('#requer_tel3').val(requer_tel[2]);	
	}
	
	$('a.idCheck').on('click', function(e) {
		$('#support_edit #requer_name').val("");
		$.get('checkId.do?homepage_id=' + $('#homepage_id').val() + '&req_id='+ $('#req_id').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);	
			}
			else {
				$('#support_edit #member_key').val(response.memberInfo.SEQ_NO);
				$('#support_edit #requer_name').val(response.memberInfo.USER_NAME);
			}
		});
		e.preventDefault();
	});

});
</script>
<form:form modelAttribute="support" id="support_edit" action="save.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="member_key"/>
<form:hidden path="seq"/>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
<!-- 		<tr> -->
<!-- 			<th>*신청기관ID</th> -->
<!-- 			<td> -->
<%-- 				<form:input path="req_id" class="text" cssStyle="width:30%" readonly="true"/> --%>
<!-- 				<a href="" class="btn btn1" id="btn_search"><span>기관검색</span></a> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		<tr>
			<th>*신청기관명</th>
			<td>
				<form:hidden path="req_organ_code"/>
				<form:input path="req_name" class="text" cssStyle="width:50%" />
				<a href="" class="btn" id="btn_search"><span>기관검색</span></a>
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<th>*신청기관연락처</th> -->
<%-- 			<td><form:input path="req_tel" class="text" cssStyle="width:50%" readonly="true"/></td>			 --%>
<!-- 		</tr> -->
		<tr>
         	<th>신청자ID</th>			
         	<td>
         		<c:choose>
         			<c:when test="${support.editMode eq 'ADD' }">
         				<form:input path="req_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>	
         			</c:when>
         			<c:otherwise>
         				${support.req_id}
         			</c:otherwise>
         		</c:choose>
        		</td>
       	</tr>
		<tr>
			<th>*신청자성명</th>
			<td><form:input path="requer_name" class="text" cssStyle="width:50%" readonly="true"/></td>
		</tr>
		<tr>
			<th>*신청자휴대폰</th>
			<td>
				<form:hidden path="requer_tel"/>
				<form:select path="requer_tel1" cssClass="selectmenu">
					<form:options items="${cellPhoneCode}" itemLabel="code_name" itemValue="code_id"/>
				</form:select> -
				<form:input path="requer_tel2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
				<form:input path="requer_tel3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>
			</td>
		</tr>
		<tr>
			<th>*지원희망일자</th>
			<td>${support.hope_req_dt} 
				<form:hidden path="hope_req_dt"/> 
			</td>			
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

<div id="dialog-dept" class="common-dialog"></div>