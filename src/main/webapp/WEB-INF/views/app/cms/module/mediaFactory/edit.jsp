<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#editMode').val("${editMode}");
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#mediaFactory_edit'))) {
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
						if(doAjaxPost($('#mediaFactory_edit'))) {
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
		width: 600,
		height: 520
	});
	
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input#apply_start_date').datepicker({
		maxDate: $('input#apply_end_date').val(), 
		onClose: function(selectedDate){
			$('input#apply_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#apply_end_date').datepicker({
		minDate: $('input#apply_start_date').val(), 
		onClose: function(selectedDate){
			$('input#apply_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});
</script>
<form:form modelAttribute="mediaFactory" id="mediaFactory_edit" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="mediaFactory_idx"/>
<div style="text-align: right">(<span style="color: red; font-weight: bold;">*</span>) 필수 항목입니다.</div>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청 종류(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<c:choose>
					<c:when test="${mediaFactory.editMode eq 'ADD'}">
						<form:select path="date_type" class="selectmenu">
							<form:options items="${dateTypeList}" itemValue="code_id" itemLabel="code_name"/>
						</form:select>	
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${dateTypeList}">
							<c:if test="${i.code_id eq mediaFactory.date_type}">${i.code_name}</c:if>
						</c:forEach>
							<form:hidden path="date_type"/>
						</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr>
			<th>대관일자(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input type="text" id="start_date" path="start_date" class="text ui-calendar"/>
					<span id="tilde" style="font-size:12px">~</span>
					<form:input type="text" id="end_date" path="end_date" class="text ui-calendar"/>
					<c:if test="${mediaFactory.editMode eq 'ADD'}">
						<div class="ui-state-highlight">
							매주 &nbsp;&nbsp;
							<form:checkbox path="weekday" value="2" label="월"/>&nbsp;
							<form:checkbox path="weekday" value="3" label="화"/>&nbsp;
							<form:checkbox path="weekday" value="4" label="수"/>&nbsp;
							<form:checkbox path="weekday" value="5" label="목"/>&nbsp;
							<form:checkbox path="weekday" value="6" label="금"/>&nbsp;
							<form:checkbox path="weekday" value="7" label="토"/>&nbsp;
							<form:checkbox path="weekday" value="1" label="일"/>
						</div> 
					</c:if>
					<div class="ui-state-highlight">
						<em>* 매주 요일 체크시 설정한 시작일 ~ 종료일 기간 사이 해당하는 요일만 등록됩니다.</em>
						<em>* 매주 요일 체크안하시면 해당하는 시작일 ~ 종료일 기간 모두 등록됩니다.</em>
					</div>
				</td>
		</tr>
		<c:choose>
		<c:when test="${mediaFactory.homepage_id ne 'h50'}">
		<tr>
			<th>대관시간(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="start_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<span id="tilde" style="font-size:12px">~</span>
				<form:input path="end_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<div class="ui-state-highlight">
					<em>* 이용 가능 시간 입력 ex) 10:30</em>
				</div>			
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<tr>
			<th>대관가능시간(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="use_time">
					<form:option value="am" label="오전"></form:option>
					<form:option value="pm" label="오후"></form:option>
				</form:select>					
			</td>
		</tr>
		</c:otherwise>
		</c:choose>
		<tr>
			<th>대관신청기간(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input type="text" id="apply_start_date" path="apply_start_date" class="text ui-calendar"/><form:input path="apply_start_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<span id="tilde" style="font-size:12px">~</span>
				<form:input type="text" id="apply_end_date" path="apply_end_date" class="text ui-calendar"/><form:input path="apply_end_time" maxlength="5" cssClass="text" cssStyle="width:50px;" />
				<div class="ui-state-highlight">
					<em>* 시간 입력 ex) 10:30<br/>* 설정된 기간에만 이용자가 신청을 할 수 있습니다.</em>
				</div>			
			</td>
		</tr>
		<tr>
			<th>최대신청팀수(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="max_apply" class="text" cssStyle="width:30px"/>
				<em>* 신청수에 제한이 없다면 0을 입력해주세요.</em>
			</td>
		</tr>
	</tbody>
</table>
</form:form>