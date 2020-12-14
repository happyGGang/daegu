<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

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
		$('div#resultTableLayer').load('statistics.do', serializeCustom($('#searchForm')));
		
		e.preventDefault();
	});
	 
	
	$('select#large_category_idx').on('change', function() {
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/category/getCategoryGroupList.do?homepage_id=' + $('#homepage_id').val() + '&large_category_idx=' + $(this).val(), function(response) {
				$('select#group_idx option').remove();
				$('select#group_idx').append('<option value="0">전체</option>');
				$.each(response, function(i, v) {
					$('select#group_idx').append('<option value="' + v.group_idx + '">' + v.group_name + '</option>');
				});
			});	
		}
		else {
			$('select#group_idx option').remove();
			$('select#group_idx').append('<option value="0">전체</option>');
			$('select#category_idx option').remove();
			$('select#category_idx').append('<option value="0">전체</option>');
			// 0일때는 강좌 전체를 가져온다.
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id').val() + '&large_category_idx=' + $('select#large_category_idx').val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
		$('select#teach_idx option').remove();
		$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" value="0">전체</option>');
	}).trigger('change');
	
	
	$('select#group_idx').change(function() {
		$.get('/cms/module/category/getCategoryList.do?homepage_id=' + $('#homepage_id').val() + '&group_idx=' + $(this).val()+ '&large_category_idx=' + $('select#large_category_idx').val(), function(response) {
			$('select#category_idx option').remove();
			$('select#category_idx').append('<option value="0" >전체</option>');
			if ( response.categoryList.length > 0 ) {
				$.each(response.categoryList, function(i, v) {
					$('select#category_idx').append('<option value="' + v.category_idx + '">' + v.category_name + '</option>');
				});	
			}
		});	
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
	
});
</script>

<div class="search">
	<form:form id="searchForm" modelAttribute="teachStatistics" action="index.do" style="display:inline-flex">
		<c:choose>
			<c:when test="${fn:length(subHomepageList) > 0}">
				<div style="margin-bottom:5px">
			도서관 : <form:select id="homepage_id" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
				</div>
			</c:when>
			<c:otherwise>
				<form:hidden path="homepage_id"/>
			</c:otherwise>
		</c:choose>

		기간 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		대분류 : <form:select path="large_category_idx" style="width:200px">
				<form:option class="all" value="0" label="전체" />
				<form:options itemValue="teach_code" itemLabel="code_name" items="${teachLargeCategoryList}"/>
			   </form:select>
		중분류 : <form:select path="group_idx" style="width:200px">
				<form:option value="0" label="전체"/>
				<form:options items="${groupList}" itemValue="group_idx" itemLabel="group_name"/>
			  </form:select>
		소분류 : <form:select path="category_idx" style="width:200px"></form:select>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</form:form>
</div>

<div id="resultTableLayer"></div>