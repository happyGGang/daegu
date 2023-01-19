<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/jquery.timepicker.min.js"></script>
<script>
$(function() {
	let reserveList = [];
	let trList = [];
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
					jQuery.ajaxSettings.traditional = true;
					trList = document.querySelectorAll('tbody[id=reserveOfWeekend] tr');
					trList.forEach(item => {
						let rowList = [];
						rowList.push(item.querySelector('.startHour').value + item.querySelector('.startMin').value);
						rowList.push(item.querySelector('.endHour').value + item.querySelector('.endMin').value);
						rowList.push(item.querySelector('input[type=radio]:checked').value);
						reserveList.push(rowList);
					})
					const formData = {
						'reserveList' : reserveList,
						'homepage_id' : $('#homepage_id').val()
					}
					$.ajax({
						type : 'POST',
						dataType : 'json',
						url : 'timeSettingSave.do',
						async : false,
						data : formData,
						success : function(response) {
							if (response.valid) {
								if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
									alert(response.message);
								}
								location.reload();
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
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

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 660,
		height: 465
	});

	$('.selectmenu').on('change', function () {
		const newSelectList = document.querySelectorAll('tbody[id=reserveOfWeekend] tr');
		newSelectList.forEach(item => {
			let startTime = item.querySelector('.startHour').value + item.querySelector('.startMin').value;
			let endTime = item.querySelector('.endHour').value + item.querySelector('.endMin').value;
			console.log(parseInt(startTime));
			if (parseInt(startTime) > parseInt(endTime)) {
				alert("예약시작시간이 예약종료시간보다 늦습니다.");
				return false;
			}
		})
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
<form:form modelAttribute="nearbyLibReserveConfig" id="nearbyLibReserveConfig_edit" action="timeSettingSave.do" method="post" onsubmit="return false;">
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
		<tbody id="reserveOfWeekend">
		<c:forEach var="i" varStatus="status" items="${reserveConfigList}">
		<tr>
			<th>${i.day_of_week}</th>
			<td>
				<select class="selectmenu startHour">
					<c:forEach var="hour" items="${nearbyLibReserveConfig.hour}">
						<c:choose>
							<c:when test="${fn:substring(i.reserve_start_time, 0, 2) eq hour}">
								<option value="${hour}" selected>${hour}</option>
							</c:when>
							<c:otherwise>
								<option value="${hour}">${hour}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<select class="selectmenu startMin">
					<c:forEach var="minute" items="${nearbyLibReserveConfig.minute}">
						<c:choose>
							<c:when test="${fn:substring(i.reserve_start_time, 2, 4) eq minute}">
								<option value="${minute}" selected>${minute}</option>
							</c:when>
							<c:otherwise>
								<option value="${minute}">${minute}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				~
				<select class="selectmenu endHour">
					<c:forEach var="hour" items="${nearbyLibReserveConfig.hour}">
						<c:choose>
							<c:when test="${fn:substring(i.reserve_end_time, 0, 2) eq hour}">
								<option value="${hour}" selected>${hour}</option>
							</c:when>
							<c:otherwise>
								<option value="${hour}">${hour}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<select class="selectmenu endMin">
					<c:forEach var="minute" items="${nearbyLibReserveConfig.minute}">
						<c:choose>
							<c:when test="${fn:substring(i.reserve_end_time, 2, 4) eq minute}">
								<option value="${minute}" selected>${minute}</option>
							</c:when>
							<c:otherwise>
								<option value="${minute}">${minute}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</td>
			<td>
				<input type="radio" value="Y" <c:if test="${i.use_yn eq 'Y'}">checked</c:if>/>예
				<input type="radio" value="N" <c:if test="${i.use_yn eq 'N'}">checked</c:if>/>아니오
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</form:form>
