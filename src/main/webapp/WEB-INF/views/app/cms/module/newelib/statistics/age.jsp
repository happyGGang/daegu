<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="lendName" value="대출횟수"/>
<c:if test="${elibStatistics.type != 'EBK'}">
<c:set var="lendName" value="이용횟수"/>
</c:if>

<script type="text/javascript">
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    showAnim: "",
	    closeText: "선택",
	    onChangeMonthYear: writeSelectedDate
// 	    beforeShow: pickupDate
	  }, options);
	  function writeSelectedDate(year, month, inst ){
	   var thisFormat = jQuery(this).datepicker("option", "dateFormat");
	   var d = jQuery.datepicker.formatDate(thisFormat, new Date(year, month-1, 1));
	   inst.input.val(d);
	  }
	  function hideDaysFromCalendar() {
	    var thisCalendar = $(this);
	    jQuery('.ui-datepicker-calendar').detach();
	    jQuery('.ui-datepicker-close').click(function() {
	      var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	      var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	      thisCalendar.datepicker('setDate', new Date(year, month, 1));
	      thisCalendar.datepicker("hide");
	    });
	  }
// 	  function pickupDate() {
// 		  var thisCalendar = $(this);
// 		  if(thisCalendar.val() != '') {
// 			  var date = thisCalendar.val().split('-');
// 			  thisCalendar.datepicker('setDate', new Date(date[0], date[1]-1, 1));
// 		  }
// 	  }
	  jQuery(this).datepicker(options).focus(hideDaysFromCalendar);
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
			$('input#hiddenForm_com_code').val($('select#com_code').val());
			$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
			$('input#hiddenForm_type').val($('select#type').val());
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#search').on('click', submit);
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	var search_sdt = $('input#search_sdt');
	if(search_sdt.val() == '') {
		var d = new Date();
		d.setMonth(d.getMonth()-1);
		search_sdt.val(formatDate(d, true));
	}
	
	var search_edt = $('input#search_edt');
	if(search_edt.val() == '') search_edt.val(formatDate(new Date(), true));
	
});

function submit(e) {
	e.preventDefault();
	
	if($('input#search_sdt').val() == '') {
		alert('조회 시작일을 선택해주세요.');
		return;
	}
	<c:if test="${elibStatistics.menu == 'PERIOD'}">
	if($('input#search_edt').val() == '') {
		alert('조회 종료일을 선택해주세요.');
		return;
	}
	</c:if>
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
			<c:if test="${member.admin}">
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			</c:if>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp"/>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50"/>
			<col width="50"/>
		</colgroup>
		<thead>
			<tr>
				<th>연령대</th>
				<th>${lendName}</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(elibStatisticsList) < 1}">
				<tr style="height:100%">
					<td colspan="2" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${elibStatisticsList}">
				<c:set var="age" value="${i.age}대"/>
				<c:if test="${i.age < 10}">
				<c:set var="age" value="1세 ~ 10세"/>
				</c:if>
				<tr>
					<td>${age}</td>
					<td><fmt:formatNumber value="${i.lend_cnt}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
