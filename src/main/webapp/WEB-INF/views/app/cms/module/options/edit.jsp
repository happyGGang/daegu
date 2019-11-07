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
					doAjaxPost($('form#optionsForm'));
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
		width: 600,
		height: 600
	});
	
	$('input#str_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#str_date').val(),
		onClose: function(selectedDate){
			$('input#str_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});

</script>
<form:form modelAttribute="options" id="optionsForm" method="post" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>기능</th>
				<td>
					<form:select path="ilus_req_code">
						<form:options items="${optionCode}" itemLabel="code_name" itemValue="code_id"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>소장위치</th>
				<td>${homepage.homepage_name}
					<form:hidden path="loca_name"/>
					<form:hidden path="loca_code"/>
				</td>
			</tr>
			<tr>
				<th>자료실</th>
				<td>
					<form:select path="sub_loca_code" multiple="true" cssStyle="width:300px;height:300px;">
						<c:forEach items="${subLocation}" var="i">
							<form:option value="${i.SUB_LOCATION_CODE}" label="${i.SUB_LOCATION_NAME}" />
						</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>사용기간</th>
				<td>
					<form:input path="str_date" class="text ui-calendar"/>
<%-- 					<form:input path="str_time" maxlength="5" cssClass="text" cssStyle="width:50px;"/> --%>
					<span id="tilde" style="font-size:12px">~</span>
					<form:input path="end_date" class="text ui-calendar"/>
<%-- 					<form:input path="end_time" maxlength="5" cssClass="text" cssStyle="width:50px;"/> --%>
<!-- 					<div class="ui-state-highlight"> -->
<!-- 						<em>* 시간 입력 ex) 10:30</em> -->
<!-- 					</div> -->
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" label="사용" value="Y"/>
					<form:radiobutton path="use_yn" label="미사용" value="N"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
