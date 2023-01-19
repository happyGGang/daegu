<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${nearbyLibManage.plan_date}'.split('-');
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';

		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}

	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		event.preventDefault();
	});

	$('a#dialog-setting').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-2').load('timeSetting.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		event.preventDefault();
	});

	//모달창 링크 버튼
	$('a#dialog-add-las').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		var date = $('select#plan_year option:selected').val() + '년 ' + $('select#plan_month option:selected').val() + '월';
		if (confirm(date + '\n자료관리에서 휴관일정보를 가져오시겠습니까?\n\n* 자료관리에서 가져온 휴관일은 자동 등록되며 기존 등록된 데이터와 중복 될 수 있습니다.')) {
			$('form#nearbyLibManage').attr('action', 'getLasHolidays.do');
			$('form#nearbyLibManage').attr('method', 'POST');
			if (doAjaxPost($('form#nearbyLibManage'))) {
				location.reload();
			}
		}

		event.preventDefault();
	});

	//모달창 링크 버튼
	$('a#dialog-add-las-year').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		var date = $('select#plan_year option:selected').val() + '년 ';
		if (confirm(date + '\n자료관리에서 휴관일정보를 가져오시겠습니까?\n\n* 자료관리에서 가져온 휴관일은 자동 등록되며 기존 등록된 데이터와 중복 될 수 있습니다.')) {
			$('form#nearbyLibManage').attr('action', 'getLasHolidaysYear.do');
			$('form#nearbyLibManage').attr('method', 'POST');
			if (doAjaxPost($('form#nearbyLibManage'))) {
				location.reload();
			}
		}

		event.preventDefault();
	});

	<%--수정--%>
	$('a.modify').on('click', function(event) {
		if($(this).attr('type') == 'calendar') {
			<c:if test="${authU}">
			$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id_1').val()+'&cm_idx=' + $(this).attr('keyValue') + '&date_type=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
			</c:if>
			<c:if test="${!authU}">
			alert('권한이 없습니다.');
			return false;
			</c:if>
		}

		event.preventDefault();
	});

	$('#plan_year,#plan_month').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#nearbyLibManage')));
	});

	$('select#homepage_id_1').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('#nearbyLibManage')));
		}

		e.preventDefault();
	});

	$('a#before-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').val();
		var month = $('#plan_month').val();

		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}
		month = month < 10 ? "0"+month : month;
		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#nearbyLibManage')));

	});

	$('a#next-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').val();
		var month = $('#plan_month').val();

		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}

		month = month < 10 ? "0"+month : month;

		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#nearbyLibManage')));

	});

	$('a#changeView').on('click', function(e) {
		e.preventDefault();
		doGetLoad('indexList.do', serializeCustom($('#nearbyLibManage')));
	});

	$('#manage_code').on('change',function(e){
		$('#viewPage').val(1);
		$('#nearbyLibManage').submit();
		e.preventDefault();
	});
});
</script>
<c:set var="plan_date" value="${fn:split(nearbyLibManage.plan_date, '-')}" />
<form:form modelAttribute="nearbyLibManage">
	<form:hidden path="plan_date"/>
	<div class="infodesk">
		<c:choose>
			<c:when test="${asideHomepageId eq 'h90'}">
				<form:select id="manage_code" path="manage_code" class="selectmenu">
					<form:option value="">전체</form:option>
					<form:option value="AA">대구2·28기념학생도서관</form:option>
					<form:option value="BA">북구구수산도서관</form:option>
					<form:option value="AH">대구광역시립 동부도서관</form:option>
					<form:option value="CA">동구통합 안심도서관</form:option>
					<form:option value="CB">동구통합 신천도서관</form:option>
				</form:select>
			</c:when>
			<c:otherwise>
				<form:hidden id="homepage_id_1" path="homepage_id"/>
			</c:otherwise>
		</c:choose>
		<div class="monthYear">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달1</span></a>
			<form:select path="plan_year" class="selectmenu" style="width:100px;"></form:select>
	        <form:select path="plan_month" class="selectmenu" style="width:100px;"></form:select>
	        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	    </div>
		<div class="button btn-group inline">
			<a href="" class="btn btn3 left" id="changeView"><i class="fa fa-list"></i><span>리스트형 전환</span></a>
		</div>
		<c:if test="${authC}">
		<div class="button btn-group inline">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>예약불가능일등록</span></a>
		</div>
		<div class="button btn-group inline">
			<a href="" class="btn btn1 left" id="dialog-setting"><i class="fa fa-plus"></i><span>예약가능시간등록</span></a>
		</div>
		</c:if>
	</div>
</form:form>
	<div class="table-wrap" id="calTable">
		<table class="type1 center">
			<colgroup>
				<col width="100px" span="7"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일요일</th>
					<th scope="col">월요일</th>
					<th scope="col">화요일</th>
					<th scope="col">수요일</th>
					<th scope="col">목요일</th>
					<th scope="col">금요일</th>
					<th scope="col">토요일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="i" varStatus="status" items="${calendarList}">
				<tr>
					<c:choose>
					<c:when test="${i.sun eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.sun}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}"  mode="admin" dayCode="1"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.mon eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.mon}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}"  mode="admin" dayCode="2"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.tue eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.tue}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}" mode="admin" dayCode="3"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.wed eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.wed}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}" mode="admin" dayCode="4"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.thu eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.thu}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}" mode="admin" dayCode="5"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.fri eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.fri}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}" mode="admin" dayCode="6"/>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.sat eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top">
							<p class="date">${i.sat}</p>
							<c:set var="plan_date" value="${nearbyLibManage.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<tag:nearbyLibManage plan_date="${plan_date}" nearbyLibManageList="${nearbyLibManageList}" nearbyLibReserveConfigList="${nearbyLibReserveConfigList}" mode="admin" dayCode="7"/>
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>


<div id="dialog-1" class="dialog-common" title="얘약불가일등록">
</div>
<div id="dialog-2" class="dialog-common" title="얘약가능시간등록">
</div>