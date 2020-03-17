<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
$(function(){
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화
	for(var i = 2016; i <= year; i++) {
		var selectedAttr = '';
		if(i == year) {
			selectedAttr = 'selected="selected"';
		}
		
		$('select#year').append('<option ' + selectedAttr + ' value="' + i + '">' + i + '년</option>');
	}
	// 월 초기화
	for(var j = 1; j < 13; j++) {
		var valueMonth = j < 10 ? '0'+j : j;
		var selectedAttr = '';
		if(j == month) {
			selectedAttr = 'selected="selected"';
		}
		
		$('select#month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	
	$('input#search_date').datepicker();
	
	$('#searchBtn').on('click', function (e) {
		e.preventDefault();
		$('div#accessTable').load('accessTable.do?' + serializeCustom($('#archiveStatistics')), function(response, status, xhr) {});
	});
	
	
	$('select#year, select#month').hide();
	$('select#year, select#month').attr('disabled', true);
	$('select#date_type').on('change', function() {
		var type = $(this).val();
		if(type == 'TIME') {
			$('input#search_date').show();
			$('input#search_date').removeAttr('disabled');
			
			$('select#year, select#month').hide();
			$('select#year, select#month').attr('disabled', true);
		} else if(type == 'DAY' || type == 'WEEK') {
			$('select#year, select#month').show();
			$('select#year, select#month').removeAttr('disabled');
			
			$('input#search_date').hide();
			$('input#search_date').attr('disabled', true);
		} else if(type == 'MONTH') {
			$('select#year').show();
			$('select#year').removeAttr('disabled');
			
			$('select#month').hide();
			$('select#month').attr('disabled', true);
			$('input#search_date').hide();
			$('input#search_date').attr('disabled', true);
		}
	});
	
});
</script>
<div class="search">
	<form:form modelAttribute="archiveStatistics" action="/cms/archiveStatistics/index.do" method="post">
		<form:hidden path="homepage_id"/>
		<label class="blind">검색</label>
		<c:choose>
			<c:when test="${member.admin}">
				<form:select path="homepage_id" class="selectmenu-search" style="width:250px">
					<option disabled >홈페이지 선택</option>
					<option value="ALL" selected="selected">전체</option>
					<c:forEach var="i" varStatus="status" items="${homepageList}">
						<option value="${i.homepage_id}">${i.homepage_name}</option>
					</c:forEach>
				</form:select>
			</c:when>
			<c:otherwise>
				<form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
			</c:otherwise>
		</c:choose>
		<form:select path="date_type" class="selectmenu-search" style="width:200px">
			<option disabled >날짜 분류 선택</option>
			<option value="TIME">시간별</option>
			<option value="DAY">일별</option>
			<option value="WEEK">요일별</option>
			<option value="MONTH">월별</option>
		</form:select>
		<b>
			<form:input type="text" path="search_date" class="text ui-calendar"/>
			<form:select path="year"></form:select>
			<form:select path="month"></form:select>
		</b>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	</form:form>
</div>

<div id="accessTable">
</div>

<!-- 자료 테이블 여기까지 -->