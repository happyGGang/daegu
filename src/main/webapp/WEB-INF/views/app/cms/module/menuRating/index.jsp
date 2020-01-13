<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	var $form = $('form#menuRating');
	
	$('button#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $form.serialize());
	});
	
	$('#search_date_type').on('change', function(e) {
		e.preventDefault();
		var date_type = $(this).val();
		
		$('#search_start_date').attr('disabled', true);
		$('#search_end_date').attr('disabled', true);
		
		if(date_type == 'DAY') {
			$('#select-date-year').hide();
			$('#select-date-month').hide();
			$('#select-date-day').show();
			$('#select-date-day').children('#search_start_date, #search_end_date').removeAttr('disabled');
		} else if(date_type == 'MONTH') {
			$('#select-date-year').hide();
			$('#select-date-day').hide();
			$('#select-date-month').show();
			$('#select-date-month').children('#search_start_date').removeAttr('disabled');
		} else if(date_type == 'YEAR') {
			$('#select-date-month').hide();
			$('#select-date-day').hide();
			$('#select-date-year').show();
			$('#select-date-year').children('#search_start_date, #search_end_date').removeAttr('disabled');
		}
	});
	
	var currYear = new Date().getUTCFullYear();
	// 연도 초기화
// 	$('#start_year,#end_year').append('<option value="' + (curYear) + '">' + (curYear) + '</option>');
	for ( var i = currYear; i >= 2019; i-- ) {
		$('select#search_start_date, select#search_end_date').append('<option value="' + i + '">' + i + '</option>');
	}
	
	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(),
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(),
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});
</script>
<style type="text/css">
#select-date-day, #select-date-month, #select-date-year {display: inline;}
</style>
<form:form modelAttribute="menuRating" action="index.do" method="GET" onsubmit="return false;">
<form:hidden path="homepage_id"/>
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
		<form:input path="search_start_date" cssClass="text ui-calendar"/>
		<span>~</span>
		<form:input path="search_end_date" cssClass="text ui-calendar"/>
	</div>
	<div id="select-date-month" style="display: none;">
		<form:select path="search_start_date" cssClass="selectmenu-search" disabled="true"></form:select>
	</div>
	<div id="select-date-year" style="display: none;">
		<form:select path="search_start_date" cssClass="selectmenu-search" disabled="true"></form:select>
		<span>~</span>
		<form:select path="search_end_date" cssClass="selectmenu-search" disabled="true"></form:select>
	</div>
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${menuRating.search_date_type eq 'DAY'}"> --%>
<%-- 			<form:input path="search_start_date" cssClass="text ui-calendar"/> --%>
<!-- 			<span>~</span> -->
<%-- 			<form:input path="search_end_date" cssClass="text ui-calendar"/> --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 			<form:select path="search_start_date"> --%>
		
<%-- 			</form:select> --%>
<!-- 			<span>~</span> -->
<%-- 			<form:select path="search_end_date"> --%>
			
<%-- 			</form:select> --%>
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
	<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
</div>
</form:form>

<table id="averageTable" class="chartData">
	<thead>
		<tr>
			<th>순서</th>
			<th>홈페이지</th>
			<th>메뉴</th>
			<th>점수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${menuRatingAverageList}" var="i" varStatus="status">
		<tr>
			<td class="num">${paging.listRowNum - status.index}</td>
			<td>${i.homepage_id}</td>
			<td>${i.menu_name}</td>
			<td>${i.rating_average_score}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>