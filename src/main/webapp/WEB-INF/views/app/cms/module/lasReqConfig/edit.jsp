<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					
					var form = $('form#lasReqConfigForm');
					jQuery.ajaxSettings.traditional = true;
					var formData = serializeObject(form);
					var responseValid = false;
					
				    $.ajax({
				        type: "POST",
				        url: form.attr('action'),
				        async: false,
				        data: formData,
				        dataType:'json',
				        success: function(response) {
				        	response = eval(response);
				        	responseValid = response.valid;
				            if(response.valid) {            	
				                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
				                	 alert(response.message);
				                 }
				                 if(response.reload) {
				                	 location.reload();
				                 }
				                 if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
				                	 /**
				                	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
				                	  */
				                	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
				                		 doAjaxLoad(ajaxBody, response.url, response.data);
				                		 
				                	 } else {
				                		 doGetLoad(response.url, response.data);
				                	 }
				                 }
							} else {
								if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
									alert(response.message);
				                } else {
				                	if (response.result != null && response.result.length > 0) {
				                		for(var i =0 ; i < response.result.length ; i++) {
				                			alert(response.result[i].code);
				                			$('[name="'+response.result[i].field+'"]').focus();
				                			$('[name="'+response.result[i].field+'"]', $(form)).css('border-color', 'red');
				                			$('[name="'+response.result[i].field+'"]', $(form)).on('change', function() {
				                				$(this).css('border-color', '');
				                			});
				                			
				                			break;
				                		}
				                	}
				                }
								
								if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
									if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
										doAjaxLoad(ajaxBody, response.url, response.data);
									} else {
										doGetLoad(response.url, response.data);
				               	 	}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown + ', ' + jqXHR.status);
				         }
				    });
					
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});	

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 640,
		height: 600
	});
	
	
	$('input#str_date_0').datepicker({
		maxDate: $('input#end_date_0').val(),
		onClose: function(selectedDate){
			$('input#end_date_0').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date_0').datepicker({
		minDate: $('input#str_date_0').val(),
		onClose: function(selectedDate){
			$('input#str_date_0').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#str_date_1').datepicker({
		maxDate: $('input#end_date_1').val(),
		onClose: function(selectedDate){
			$('input#end_date_1').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date_1').datepicker({
		minDate: $('input#str_date_1').val(),
		onClose: function(selectedDate){
			$('input#str_date_1').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#str_date_2').datepicker({
		maxDate: $('input#end_date_2').val(),
		onClose: function(selectedDate){
			$('input#end_date_2').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date_2').datepicker({
		minDate: $('input#str_date_2').val(),
		onClose: function(selectedDate){
			$('input#str_date_2').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#str_date_3').datepicker({
		maxDate: $('input#end_date_3').val(),
		onClose: function(selectedDate){
			$('input#end_date_3').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date_3').datepicker({
		minDate: $('input#str_date_3').val(),
		onClose: function(selectedDate){
			$('input#str_date_3').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});

</script>
<style type="text/css">
	div.locaChkBox {display: inline-block;width: 220px;}
	textarea {border: 1px solid #ccd2dc;border-radius: 7px;}
</style>
<form:form modelAttribute="lasReqConfig" id="lasReqConfigForm" method="post" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="las_req_idx"/>
	<form:hidden path="sub_loca_code"/>
	<table class="type2">
		<colgroup>
			<col width="50" />
			<col width="80" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th class="center" colspan="2">소장위치</th>
				<td>${homepage.homepage_name}
					<form:hidden path="loca_name"/>
					<form:hidden path="loca_code"/>
				</td>
			</tr>
			<tr>
				<th class="center" colspan="2">자료실</th>
				<td>
					<c:forEach items="${subLocation}" var="i">
					<c:if test="${lasReqConfig.editMode eq 'ADD'}">
						<c:if test="${fn:contains(subLacaList, i.CODE) eq false}">
						<div class="locaChkBox">
							<form:checkbox path="sub_loca_codes" label="${i.DESCRIPTION}" value="${i.CODE}" />
						</div>
						</c:if>
					</c:if>
					<c:if test="${lasReqConfig.editMode eq 'MODIFY'}">
						<c:if test="${i.CODE eq lasReqConfig.sub_loca_code}">
						${i.DESCRIPTION}
						</c:if>
					</c:if>
					</c:forEach>
					<c:if test="${lasReqConfig.editMode eq 'ADD'}">
					<div class="ui-state-highlight">
						<em>* 기능제한이 가능한 자료실에 대해서 등록됩니다.</em><br>
						<em>* 등록된 자료실의 사용기간은 목록에서 수정버튼을 이용해 수정이 가능합니다.</em>
					</div>
					</c:if>
				</td>
			</tr>
			<c:forEach items="${lasReqCode}" var="i" varStatus="status">
			<tr>
				<th rowspan="3">${i.code_name} 기능 제한</th>
				<form:hidden path="las_config_list[${status.index}].las_req_code" value="${i.code_id}"/>
				<th>사용여부</th>
				<td>
					<form:radiobutton path="las_config_list[${status.index}].use_yn" label="사용" value="Y"/>
					<form:radiobutton path="las_config_list[${status.index}].use_yn" label="미사용" value="N"/>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<form:input path="las_config_list[${status.index}].str_date" id="str_date_${status.index}" class="text ui-calendar str_date"/>
					<form:input path="las_config_list[${status.index}].str_time" class="text" cssStyle="width:50px;" maxlength="5"/>
					<span id="tilde" style="font-size:12px">~</span>
					<form:input path="las_config_list[${status.index}].end_date" id="end_date_${status.index}" class="text ui-calendar end_date"/>
					<form:input path="las_config_list[${status.index}].end_time" class="text" cssStyle="width:50px;" maxlength="5"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>메세지</th>
				<td>
					<form:textarea path="las_config_list[${status.index}].res_msg" rows="4" cols="68"/>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
