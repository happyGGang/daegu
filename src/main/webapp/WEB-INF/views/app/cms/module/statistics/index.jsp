<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	var now = new Date();
	//달력(통계 기간 선택 오류 방지)
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', new Date(now.getUTCFullYear(), (now.getUTCMonth()), 1));
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', new Date(now.getUTCFullYear(), (now.getUTCMonth()+1), 0));
	
	$('#searchBtn').on('click', function (e) {
		var searchUrl = '';
		var searchModuleType = $('select#module_type').val();
		
		if ( searchModuleType == 'LOCKER' ) {
			searchUrl = 'locker.do';
		}
		else if ( searchModuleType == 'EXCURSIONS' ) {
			searchUrl = 'excursions.do';
		}
		else if ( searchModuleType == 'FACILITY' ) {
			searchUrl = 'facility.do';
		}
		else {
			alert('조회할 프로그램을 선택해주세요.');
			return false;
		}
		
		$('div#resultTableLayer').load(searchUrl, serializeCustom($('#searchForm')));
		
		e.preventDefault();
	});
	
	$('select#module_type').change(function() {
		var searchModuleType = $('select#module_type').val();
		$('div#search_date_div').show();
		$('div#search_teach_div').hide();
		if ( searchModuleType == 'LOCKER' ) {
			$('div#search_date_div').hide();
		}
	}).trigger('change');
	
	$('a#excelDownload').on('click', function(e) {
		$('#searchForm').attr('action', 'excelDownload.do').submit();
		$('#searchForm').attr('action', 'index.do')
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#searchForm').attr('action', 'csvDownload.do').submit();
		$('#searchForm').attr('action', 'index.do')
		e.preventDefault();
	});

	$('select#homepage_id').change(function() {
		$('#searchForm').submit();
	});
	
	$('select.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용
	});
	
});
</script>

<div class="search">
	<form:form id="searchForm" modelAttribute="moduleStatistics" action="index.do" style="display:inline-flex" method="get">
		<c:choose>
			<c:when test="${member.admin}">
				<div style="margin-bottom:5px">
					홈페이지 : 
					<form:select path="homepage_id" style="width:230px;" cssClass="selectmenu">
						<form:options items="${homepageList}" itemValue="homepage_id" itemLabel="homepage_name"/>
					</form:select>
				</div>
			</c:when>
			<c:otherwise>
				<form:hidden path="homepage_id"/>
			</c:otherwise>
		</c:choose>
		
		<div style="display:inline-block">
			프로그램 : <form:select path="module_type" style="width:100px;" cssClass="selectmenu">
				<form:option value="" label="선택"/>
				<form:option value="LOCKER" label="사물함"/>
				<form:option value="FACILITY" label="시설물"/>
				<form:option value="EXCURSIONS" label="견학"/>
			</form:select>
		</div>
				
		<div id="search_date_div" style="display:inline-block">
			기간 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		</div>
		
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</form:form>
</div>

<div id="resultTableLayer"></div>