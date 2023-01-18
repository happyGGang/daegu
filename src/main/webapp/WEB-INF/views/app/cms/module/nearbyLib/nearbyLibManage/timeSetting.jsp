<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#nearbyLibManage_edit'))) {
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
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 660,
		height: 465
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

});
</script>
<form:form modelAttribute="nearbyLibManage" id="nearbyLibManage_edit" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(nearbyLibManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="cm_idx"/>
<form:hidden path="group_idx"/>
<form:hidden path="date_type" value="1"/>
<table class="type1 center">
	<colgroup>
		<col width="60"/>
		<col width="*"/>
	</colgroup>
		<thead>
		<tr>
			<th>요일</th>
			<th>예약가능시간</th>
			<th>예약버튼 활성화여부</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<th>월</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>화</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>수</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>목</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>금</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>토</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>일</th>
			<td>
				<form:select path="start_date" id="start_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="start_time" id="start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="end_date" id="end_date" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="end_time" id="end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="individual_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="individual_yn" value="Y" label="아니오"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>