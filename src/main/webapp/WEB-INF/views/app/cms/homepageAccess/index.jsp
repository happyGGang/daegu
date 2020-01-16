<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
$(function(){
	var curYear = new Date().getUTCFullYear();
	// 연도 초기화
	$('#start_year,#end_year').append('<option value="' + (curYear) + '">' + (curYear) + '</option>');
	for ( var i = curYear; i > 2019; i-- ) {
		$('#start_year,#end_year').append('<option value="' + (i - 1) + '">' + (i - 1) + '</option>');
	}

	//달력(통계 기간 선택 오류 방지)
	$('input#dateStart').datepicker({
		maxDate: $('input#dateEnd').val(),
		onClose: function(selectedDate){
			$('input#dateEnd').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#dateEnd').datepicker({
		minDate: $('input#dateStart').val(),
		onClose: function(selectedDate){
			$('input#dateStart').datepicker('option', 'maxDate', selectedDate);
		}
	});

	function initGraph() {
		//그래프 관련 (x축 값의 개수에 맞게 width값 자동 계산, 마우스 오버 시 addClass)
		$('.graph').each(function(){
			var gN = $(this).children('li').length;
			var gW = 100/gN;
			$(this).children('li').each(function(e){
				$(this).css('width',gW+'%');
				$(this).on('mouseover',function(){
					$(this).addClass('on');
				});
				$(this).on('mouseleave',function(){
					$(this).removeClass('on');
				});
			});

			//가장 큰 수 addClass most
			var gaugeH = $(this).find('.gauge').map(function(){
				return $(this).height();
			}).get(),
			maxH = Math.max.apply(null, gaugeH);
			$(this).addClass('a'+maxH);
			$(this).find('.gauge').each(function(){
				var thisH = $(this).height();
				if(thisH == maxH){
					$(this).addClass('most');
				}
			});
		});
	}

	$('#searchBtn').on('click', function (e) {
		if ( $('#homepageId').val() && $('#dateType').val() && $('#searchType').val() ) {
			if ( $('#dateType').val() === 'YEAR' ) {
				var yearCount = $('#end_year').val() == $('#start_year').val()? 1 : $('#end_year').val() - $('#start_year').val();
				$('#year_count').val(yearCount);
			}

			$('div#graph1').load('accessGraph.do?' + serializeCustom($('#homepageAccessSearch')), function( response, status, xhr ) {
				initGraph();
			});
			$('table#accessTableData').load('accessTable.do?' + serializeCustom($('#homepageAccessSearch')), function( response, status, xhr ) {
			});
		}
		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(e) {
		if ( $('#homepageId').val() && $('#dateType').val() && $('#searchType').val() ) {
			$('#homepageName').val($('#homepageId option:selected').text());
			$('#homepageAccessSearch').attr('action', '/cms/homepageAccess/excelDownload.do');
			$('#homepageAccessSearch').submit();
		}
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		if ( $('#homepageId').val() && $('#dateType').val() && $('#searchType').val() ) {
			$('#homepageName').val($('#homepageId option:selected').text());
			$('#homepageAccessSearch').attr('action', '/cms/homepageAccess/csvDownload.do');
			$('#homepageAccessSearch').submit();
		}
		e.preventDefault();
	});

	$('select#dateType').change(function(e) {
		var dateType = this.value;
		$('#dateStart').show();
		$('#tilde').show();
		$('#dateEnd').show();
		$('#startMonthBox').show();
		$('#endMonthBox').show();
		$('#startYearBox').show();
		$('#endYearBox').show();

		if ( dateType === 'TIME' ) {
			$('#tilde').hide();
			$('#dateEnd').hide();
			$('#startYearBox').hide();
			$('#endYearBox').hide();
		}
		else if ( dateType === 'DAY') {
			$('#startYearBox').hide();
			$('#endYearBox').hide();
		}
		else if ( dateType === 'MONTH' ) {
			$('#dateStart').hide();
			$('#tilde').hide();
			$('#dateEnd').hide();
			$('#endYearBox').hide();
		}
		else if ( dateType === 'YEAR' ) {
			$('#monthBox').hide();
			$('#dateStart').hide();
			$('#tilde').hide();
			$('#dateEnd').hide();
		}
	});

	$('select#dateType').trigger('change');
});
</script>
<div class="search">
	<form:form id="homepageAccessSearch" modelAttribute="homepageAccess" action="/cms/homepageAccess/excelDownload.do" method="post" style="display:inline-flex">
		<form:hidden id="homepageName" path="homepage_name"/>
		<form:hidden path="year_count"/>
		<label class="blind">검색</label>
		<c:choose>
			<c:when test="${member.admin}">
				<form:select id="homepageId" path="homepage_id" class="selectmenu-search" style="width:250px">
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
		<form:select id="dateType" path="date_type" class="selectmenu-search" style="width:200px">
			<option disabled >날짜 분류 선택</option>
			<option value="DAY" >일간별</option>
			<option value="MONTH">월간별</option>
			<option value="YEAR">연간별</option>
		</form:select>
		<b>
			<form:input type="text" id="dateStart" path="start_date" class="text ui-calendar"/>
			<span id="tilde" style="font-size:12px">~</span>
			<form:input type="text" id="dateEnd" path="end_date" class="text ui-calendar"/>
		</b>
		<b id="startYearBox">
			<form:select path="start_year" class="selectmenu" style="width:80px">
			</form:select>
		</b>
		<b id="endYearBox">
			<span id="yearTilde" style="font-size:12px">~</span>
			<form:select path="end_year" class="selectmenu" style="width:80px"></form:select>
		</b>
		<form:select id="searchType" path="search_type" class="selectmenu-search" style="width:200px">
			<option disabled >접속자 수 기준 선택</option>
			<option value="ALL" selected="selected">접속자수</option>
			<option value="PC">PC 접속자수</option>
			<option value="MOBILE">모바일 접속자수</option>
		</form:select>
<!-- 		아이디(대출번호) : -->
<%-- 		<form:input path="member_id" cssClass="text" placeholder="" maxlength="20"/> --%>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</form:form>
</div>

<div id="graph1" class="graphArea">
</div>

<!-- 자료 테이블 여기까지 -->