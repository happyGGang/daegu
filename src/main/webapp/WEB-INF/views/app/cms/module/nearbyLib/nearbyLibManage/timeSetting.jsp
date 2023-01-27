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
						'manage_code' : $('#manage_code').val()
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

	for (let i = 0; i < 7; i++) {
		if (i > 0) {
			findNode(i, 'startHour').addEventListener('focus', (e) => {
				hourOrMin = e.target.value;
			});
			findNode(i, 'startHour').addEventListener('change', (e) => {
				const targetTime = findNode(i, 'startHour').value + findNode(i, 'startMin').value;
				const compareTime = findNode(i - 1, 'endHour').value + findNode(i - 1, 'endMin').value;
				if (parseInt(targetTime) < parseInt(compareTime)) {
					alert('시작 시간은 이전 요일 종료 시간보다 빠를 수 없습니다.');
					e.target.value = hourOrMin;
				}
				hourOrMin = e.target.value;
			});

			findNode(i, 'startMin').addEventListener('focus', (e) => {
				hourOrMin = e.target.value;
			});
			findNode(i, 'startMin').addEventListener('change', (e) => {
				const targetTime = findNode(i, 'startHour').value + findNode(i, 'startMin').value;
				const compareTime = findNode(i - 1, 'endHour').value + findNode(i - 1, 'endMin').value;
				if (parseInt(targetTime) < parseInt(compareTime)) {
					alert('시작 시간은 이전 요일 종료 시간보다 빠를 수 없습니다.');
					e.target.value = hourOrMin;
				}
				hourOrMin = e.target.value;
			});
		}

		if (i < 6) {
			findNode(i, 'endHour').addEventListener('focus', (e) => {
				hourOrMin = e.target.value;
			});
			findNode(i, 'endHour').addEventListener('change', (e) => {
				const targetTime = findNode(i, 'endHour').value + findNode(i, 'endMin').value;
				const compareTime = findNode(i + 1, 'startHour').value + findNode(i + 1, 'startMin').value;
				if (parseInt(compareTime) < parseInt(targetTime)) {
					alert('종료 시간은 시작 다음 요일 시간보다 늦을 수 없습니다.');
					e.target.value = hourOrMin;
				}
				hourOrMin = e.target.value;
			});

			findNode(i, 'endMin').addEventListener('focus', (e) => {
				hourOrMin = e.target.value;
			});
			findNode(i, 'endMin').addEventListener('change', (e) => {
				const targetTime = findNode(i, 'endHour').value + findNode(i, 'endMin').value;
				const compareTime = findNode(i + 1, 'startHour').value + findNode(i + 1, 'startMin').value;
				if (parseInt(compareTime) < parseInt(targetTime)) {
					alert('종료 시간은 다음 요일 시작 시간보다 늦을 수 없습니다.');
					e.target.value = hourOrMin;
				}
				hourOrMin = e.target.value;
			});
		}
	}

    findNode(0, 'startHour').addEventListener('focus', (e) => {
        hourOrMin = e.target.value;
    });
    findNode(0, 'startHour').addEventListener('change', (e) => {
        const targetTime = findNode(0, 'startHour').value + findNode(0, 'startMin').value;
        const compareTime = findNode(6, 'endHour').value + findNode(6, 'endMin').value;
        if (parseInt(targetTime) < parseInt(compareTime)) {
            alert('시작 시간은 이전 요일 종료 시간보다 빠를 수 없습니다.');
            e.target.value = hourOrMin;
        }
        hourOrMin = e.target.value;
    });

    findNode(0, 'startMin').addEventListener('focus', (e) => {
        hourOrMin = e.target.value;
    });
    findNode(0, 'startMin').addEventListener('change', (e) => {
        const targetTime = findNode(0, 'startHour').value + findNode(0, 'startMin').value;
        const compareTime = findNode(6, 'endHour').value + findNode(6, 'endMin').value;
        if (parseInt(targetTime) < parseInt(compareTime)) {
            alert('시작 시간은 이전 요일 종료 시간보다 빠를 수 없습니다.');
            e.target.value = hourOrMin;
        }
        hourOrMin = e.target.value;
    });

    findNode(6, 'endHour').addEventListener('focus', (e) => {
        hourOrMin = e.target.value;
    });
    findNode(6, 'endHour').addEventListener('change', (e) => {
        const targetTime = findNode(6, 'endHour').value + findNode(6, 'endMin').value;
        const compareTime = findNode(0, 'startHour').value + findNode(0, 'startMin').value;
        if (parseInt(compareTime) < parseInt(targetTime)) {
            alert('종료 시간은 시작 다음 요일 시간보다 늦을 수 없습니다.');
            e.target.value = hourOrMin;
        }
        hourOrMin = e.target.value;
    });

    findNode(6, 'endMin').addEventListener('focus', (e) => {
        hourOrMin = e.target.value;
    });
    findNode(6, 'endMin').addEventListener('change', (e) => {
        const targetTime = findNode(6, 'endHour').value + findNode(6, 'endMin').value;
        const compareTime = findNode(0, 'startHour').value + findNode(0, 'startMin').value;
        if (parseInt(compareTime) < parseInt(targetTime)) {
            alert('종료 시간은 다음 요일 시작 시간보다 늦을 수 없습니다.');
            e.target.value = hourOrMin;
        }
        hourOrMin = e.target.value;
    });
});

let hourOrMin;

function findNode(index, className) {
	return document.querySelectorAll('tbody[id=reserveOfWeekend] tr .' + className)[index];
}
</script>
<form:form modelAttribute="nearbyLibReserveConfig" id="nearbyLibReserveConfig_edit" action="timeSettingSave.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="manage_code"/>
	<table class="type1 center">
		<colgroup>
			<col />
			<col />
			<col />
		</colgroup>
		<thead>
		<tr>
			<th>기준요일</th>
			<th>예약시작(금일) ~ 예약종료(익일)</th>
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
				<input type="radio" value="Y" name="${status.index}" <c:if test="${i.use_yn eq 'Y'}">checked</c:if>/>예
				<input type="radio" value="N" name="${status.index}" <c:if test="${i.use_yn eq 'N'}">checked</c:if>/>아니오
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
</form:form>
