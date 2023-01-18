<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/jquery.timepicker.min.js"></script>
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
					if(doAjaxPost($('#nearbyLibReserveConfig_edit'))) {
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
	
// 	$('input#reserve_start_time').timepicker({
//         timeFormat: 'HH:mm p',
//         interval: 60,
//         defaultTime: '9',
//         startTime: '00:00',
//         dynamic: false,
//         dropdown: true,
//         scrollbar: true
//     });

});
</script>
<form:form modelAttribute="nearbyLibReserveConfig" id="nearbyLibReserveConfig_edit" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
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
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>화</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>수</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>목</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>금</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>토</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
		<tr>
			<th>일</th>
			<td>
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_start_time" id="reserve_start_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
				~
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<c:forEach var="hour" begin="0" end="23">
						<option value="<c:if test='${hour < 10}'>0</c:if>${hour}"><c:if test='${hour < 10}'>0</c:if>${hour}</option>
					</c:forEach>
				</form:select> : 
				<form:select path="reserve_end_time" id="reserve_end_time" class="selectmenu">
					<form:option value="00">00</form:option>
					<form:option value="10">10</form:option>
					<form:option value="20">20</form:option>
					<form:option value="30">30</form:option>
					<form:option value="40">40</form:option>
					<form:option value="50">50</form:option>
				</form:select>
			</td>
			<td>
				<form:radiobutton path="use_yn" value="N" label="예"/>&nbsp;
				<form:radiobutton path="use_yn" value="Y" label="아니오"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>