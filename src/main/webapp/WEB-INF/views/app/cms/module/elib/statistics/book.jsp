<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	jQuery.fn.monthYearPicker = function (options) {
		options = $.extend({
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim: "",
			closeText: "선택",
			onChangeMonthYear: writeSelectedDate,
			beforeShow: pickupDate
		}, options);

		function writeSelectedDate(year, month, inst) {
			var thisFormat = jQuery(this).datepicker("option", "dateFormat");
			var d = jQuery.datepicker.formatDate(thisFormat, new Date(year, month - 1, 1));
			inst.input.val(d);
		}

		function hideDaysFromCalendar() {
			var thisCalendar = $(this);
			jQuery('.ui-datepicker-calendar').detach();
			jQuery('.ui-datepicker-close').click(function () {
				var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
				var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
				thisCalendar.datepicker('setDate', new Date(year, month, 1));
				thisCalendar.datepicker("hide");
			});
		}

		function pickupDate() {
			if (this.id === 'search_edt') {
				var startDate = $('#search_sdt').datepicker('getDate');
				$(this).datepicker('option', 'minDate', startDate);
			} else if (this.id === 'search_sdt') {
				$(this).datepicker('option', 'maxDate', new Date());
			}
		}

		jQuery(this).datepicker(options);
	}
	
function formatDate(date, withoutDay) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    
    if(withoutDay)
    	return [year, month].join('-');
    else
    	return [year, month, day].join('-');
}

$(function() {
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(elibStatisticsList)}' > 0) {
			$('input#hiddenForm_library_code').val($('#library_code').val());
			$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
			$('input#hiddenForm_type').val($('select#type').val());
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(elibStatisticsList)}' > 0) {
			$('input#hiddenForm_library_code').val($('#library_code').val());
			$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
			$('input#hiddenForm_type').val($('select#type').val());
			$('#hiddenForm').attr('action', 'csvDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	var search_sdt = $('input#search_sdt');
	if(search_sdt.val() == '') {
		var d = new Date();
		d.setMonth(d.getMonth()-1);
		search_sdt.val(formatDate(d));
	}
	
	var search_edt = $('input#search_edt');
	if(search_edt.val() == '') search_edt.val(formatDate(new Date()));
	
	$('a#search').on('click', submit);
	$('select#rowCount').on('change', submit);
});

function submit(e) {
	e.preventDefault();
	if($('select#library_code option:selected').val() == '0') {
		alert('도서관을 선택해주세요.');
		return;
	}
	
	if($('input#search_sdt').val() == '') {
		alert('조회 시작일을 선택해주세요.');
		return;
	}
	if($('input#search_edt').val() == '') {
		alert('조회 종료일을 선택해주세요.');
		return;
	}
	$('#elibStatisticsListForm').submit();
}
</script>

<form:form id="hiddenForm" modelAttribute="elibStatistics" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="library_code" id="hiddenForm_library_code"/>
<form:hidden path="com_code" id="hiddenForm_com_code"/>
<form:hidden path="search_sdt" id="hiddenForm_search_sdt"/>
<form:hidden path="search_edt" id="hiddenForm_search_edt"/>
<form:hidden path="type" id="hiddenForm_type"/>
<form:hidden path="menu" id="hiddenForm_menu"/>
</form:form>
<form:form id="elibStatisticsListForm"  modelAttribute="elibStatistics" action="index.do" >
<form:hidden path="menu"/>
<c:if test="${!member.admin}">
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden path="library_code" value="${library_code}"/>
</c:if>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
<%-- 			<c:if test="${member.admin}"> --%>
<%-- 			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/> --%>
<%-- 			</c:if> --%>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${elibStatisticsCnt}" pattern="#,###" />건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="150"/>
			<col width="80"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
			<col width="50"/>
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" colspan="1">전자책명</th>
				<th rowspan="2" colspan="1">소장도서관</th>
				<th rowspan="2" colspan="1">PC 대출 수</th>
				<th rowspan="1" colspan="4">스마트폰 대출 수</th>
				<th rowspan="2" colspan="1">기타(불명) 대출 수</th>
				<th rowspan="2" colspan="1">전체 대출 수</th>
				<th rowspan="2" colspan="1">예약 누적 수</th>
				<th rowspan="2" colspan="1">서평 수</th>
				<th rowspan="2" colspan="1">현재 예약 수</th>
			</tr>
			<tr>
				<th>Android</th>
				<th>iOS</th>
				<th>(구 스마트폰 대출 수)</th>
				<th>스마트폰 합계</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(elibStatisticsList) < 1}">
				<tr style="height:100%">
					<td colspan="12" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
				<tr>
					<th>합계(검색 조건 전체)</th>
					<th></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.p_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.a_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.i_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.s_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.a_cnt + getStatisticsByBookTotal.i_cnt + getStatisticsByBookTotal.s_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.e_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.p_cnt + getStatisticsByBookTotal.a_cnt + getStatisticsByBookTotal.i_cnt + getStatisticsByBookTotal.s_cnt + getStatisticsByBookTotal.e_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.total_reserves_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.comments_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByBookTotal.reserves_cnt}" pattern="#,###" /></th>
				</tr>
			<c:forEach var="i" varStatus="status" items="${elibStatisticsList}">
				<tr>
					<td>${i.book_name}</td>
					<td>${i.library_name}</td>
					<td><fmt:formatNumber value="${i.p_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.a_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.i_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.s_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.a_cnt + i.i_cnt + i.s_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.e_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.p_cnt + i.a_cnt + i.i_cnt + i.s_cnt + i.e_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.total_reserves_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.comments_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.reserves_cnt}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#elibStatisticsListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>

</form:form>
