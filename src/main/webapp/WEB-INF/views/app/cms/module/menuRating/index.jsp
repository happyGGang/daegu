<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	var $form = $('form#menuRating');
	
	$('button#searchBtn').on('click', function(e) {
		e.preventDefault();
		$('#search-table').load('searchTable.do?'+$form.serialize());
	});
	
	$('#excelDownload').on('click', function(e) {
		e.preventDefault();
		$('form#menuRatingExcel').attr('action', 'excelDownload.do');
		$('form#menuRatingExcel').attr('method', 'POST');
		$('#homepage_id_excel').val($('#homepage_id').val());
		
		var date_type = $('#search_date_type').val();
		var start_date;
		var end_date;
		if(date_type == 'DAY') {
			start_date = $('#start_date_day').val();
			end_date = $('#end_date_day').val();
		} else if(date_type == 'MONTH') {
			start_date = $('#start_date_month').val();
		} else if(date_type == 'YEAR') {
			start_date = $('#start_date_year').val();
			end_date = $('#end_date_year').val();
		}
		
		$('#date_type_excel').val(date_type);
		$('#start_date_excel').val(start_date);
		$('#end_date_excel').val(end_date);
		$('form#menuRatingExcel').submit();
	});
	
	$('#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('form#menuRatingExcel').attr('action', 'csvDownload.do');
		$('form#menuRatingExcel').attr('method', 'POST');
		$('#homepage_id_excel').val($('#homepage_id').val());
		excelDataSerialize();
		$('form#menuRatingExcel').submit();
	});
	
	$('#search_date_type').on('change', function(e) {
		e.preventDefault();
		var date_type = $(this).val();
		
		$('.start_date').attr('disabled', true);
		$('.end_date').attr('disabled', true);
		
		$('#select-date-year').hide();
		$('#select-date-month').hide();
		$('#select-date-day').hide();
		
		if(date_type == 'DAY') {
			$('#select-date-day').show();
			$('#select-date-day').children('.start_date, .end_date').removeAttr('disabled');
		} else if(date_type == 'MONTH') {
			$('#select-date-month').show();
			$('#select-date-month').children('.start_date').removeAttr('disabled');
		} else if(date_type == 'YEAR') {
			$('#select-date-year').show();
			$('#select-date-year').children('.start_date, .end_date').removeAttr('disabled');
		}
	});
	
	var currYear = new Date().getUTCFullYear();
	// 연도 초기화
	for ( var i = currYear; i >= 2019; i-- ) {
		$('select.start_date, select.end_date').append('<option value="' + i + '">' + i + '</option>');
	}
	
	$('input#start_date_day').datepicker({
		maxDate: $('input#end_date_day').val(),
		onClose: function(selectedDate){
			$('input#end_date_day').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date_day').datepicker({
		minDate: $('input#start_date_day').val(),
		onClose: function(selectedDate){
			$('input#start_date_day').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});

function excelDataSerialize() {
	var date_type = $('#search_date_type').val();
	var start_date;
	var end_date;
	if(date_type == 'DAY') {
		start_date = $('#start_date_day').val();
		end_date = $('#end_date_day').val();
	} else if(date_type == 'MONTH') {
		start_date = $('#start_date_month').val();
	} else if(date_type == 'YEAR') {
		start_date = $('#start_date_year').val();
		end_date = $('#end_date_year').val();
	}
	
	$('#date_type_excel').val(date_type);
	$('#start_date_excel').val(start_date);
	$('#end_date_excel').val(end_date);
}
</script>
<style type="text/css">
#select-date-day, #select-date-month, #select-date-year {display: inline;}
</style>
<form:form modelAttribute="menuRating" id="menuRatingExcel" action="excelDownload.do" method="POST">
<form:hidden path="homepage_id" id="homepage_id_excel"/>
<form:hidden path="search_date_type" id="date_type_excel"/>
<form:hidden path="search_start_date" id="start_date_excel"/>
<form:hidden path="search_end_date" id="end_date_excel"/>
</form:form>

<form:form modelAttribute="menuRating" action="index.do" method="GET" onsubmit="return false;">
<div class="infodesk search">
	<form:select class="selectmenu-search" style="width:220px" path="homepage_id">
		<form:option value="" label="홈페이지를 선택하세요." />
		<form:options items="${homepageList}" itemValue="homepage_id" itemLabel="homepage_name"/>
	</form:select>
	<form:select path="search_date_type" cssClass="selectmenu-search">
		<option disabled >날짜 분류 선택</option>
		<form:option value="DAY">일간별</form:option>
		<form:option value="MONTH">월간별</form:option>
		<form:option value="YEAR">연간별</form:option>
	</form:select>
	<div id="select-date-day">
		<form:input path="search_start_date" id="start_date_day" cssClass="start_date text ui-calendar"/>
		<span>~</span>
		<form:input path="search_end_date" id="end_date_day" cssClass="end_date text ui-calendar"/>
	</div>
	<div id="select-date-month" style="display: none;">
		<form:select path="search_start_date" id="start_date_month" cssClass="start_date selectmenu-search" disabled="true"></form:select>
	</div>
	<div id="select-date-year" style="display: none;">
		<form:select path="search_start_date" id="start_date_year" cssClass="start_date selectmenu-search" disabled="true"></form:select>
		<span>~</span>
		<form:select path="search_end_date" id="end_date_year" cssClass="end_date selectmenu-search" disabled="true"></form:select>
	</div>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
	<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
</div>
</form:form>

<div id="search-table"></div>