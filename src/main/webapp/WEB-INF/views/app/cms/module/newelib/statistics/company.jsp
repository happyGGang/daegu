<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
table tr.strong th{background:#adb5c0;color:#fff;border-color:#ced8da;border-bottom-color:#ced8da;border-top-color:#adb5c0}
</style>
<script src="/resources/common/js/moment.min.js"></script>
<script type="text/javascript">
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm-dd",
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
	  jQuery(this).datepicker(options);
	}

function exportTableToCSV($table, header) {

    var $rows = $table.find('tbody').find('tr:has(td),tr:has(th)'),

        // Temporary delimiter characters unlikely to be typed by keyboard
        // This is to avoid accidentally splitting the actual contents
        tmpColDelim = String.fromCharCode(11), // vertical tab character
        tmpRowDelim = String.fromCharCode(0), // null character

        // actual delimiter characters for CSV format
        colDelim = '","',
        rowDelim = '"\r\n"',

        // Grab text from table into CSV formatted string
        csv = header + "\r\n" + '"' + $rows.map(function (i, row) {
            var $row = $(row), $cols = $row.find('td,th');

            return $cols.map(function (j, col) {
                var $col = $(col), text = $col.text();

                return text.replace(/"/g, '""'); // escape double quotes

            }).get().join(tmpColDelim);

        }).get().join(tmpRowDelim)
            .split(tmpRowDelim).join(rowDelim)
            .split(tmpColDelim).join(colDelim) + '"',



        // Data URI
        csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

        if (window.navigator.msSaveBlob) { // IE 10+
            //alert('IE' + csv);
//             window.navigator.msSaveOrOpenBlob(new Blob([csv], {type: "text/plain;charset=utf-8;"}), "csvname.csv")
        } 
        else {
//             $(this).attr({ 'download': filename, 'href': csvData, 'target': '_blank' }); 
        }
        
        return csv;
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
		$('input#hiddenForm_library_code').val($('#library_code').val());
		$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
		$('input#hiddenForm_search_edt').val($('input#search_edt').val());
		$('#hiddenForm').attr('action', 'index_excel.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		var data_table = $('#data-table').clone();
		data_table.find('td[rowspan]').each(function(i) {
		    var text = $(this).text();
			var rowspan = $(this).prop('rowspan');
			var siblings = $(this).parent().nextAll();
			$(this).prop('rowspan', 1);
			siblings.each(function(j) {
		    	if(j < rowspan-1) {
					$(this).prepend('<td>'+text+'</td>');
		        }
			});
		});
		var csv = exportTableToCSV(data_table,'구분,공급사,소장자료수,PC 대출 수,Android,iOS,(구 스마트폰 대출 수),스마트폰 합계,기타(불명) 대출 수,소계');
		$('#csv_string').val(csv);
		$('#csv_filename').val('전자도서관_공급사별별통계_'+formatDate(new Date())+'.csv');
		$('#csvForm').submit();
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
});

function submit(e) {
	e.preventDefault();
	e.preventDefault();
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
<form id="csvForm" method="POST" action="index_csv.do">
<input type="hidden" id="csv_string" name="csv_string" value="">
<input type="hidden" id="csv_filename" name="filename" value="전자도서관_공급사별통계.csv">
</form>
<form:form id="elibStatisticsListForm"  modelAttribute="elibStatistics" action="index.do" >
<form:hidden path="menu"/>
<c:if test="${!member.admin}">
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden path="library_code" value="${library_code}"/>
</c:if>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<c:if test="${member.admin}">
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			</c:if>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/app/cms/module/elib/statistics/company_included.jsp" flush="false"/>
</form:form>
 