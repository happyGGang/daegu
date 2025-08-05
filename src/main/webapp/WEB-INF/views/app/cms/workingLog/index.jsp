<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

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

	$('a.dialog-view').on('click', function(e) {

		$('div#dialog-1').load('view.do?work_idx='+$(this).data('idx'), function( response, status, xhr ) {
			$('div#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('select#work_type, select#rowCount').on('change', function() {
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#workingLog').serialize());
	});

	$('#search_btn').on('click', function() {
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#workingLog').serialize());
	});

	$('#search_text').on('keyup', function(e) {
		$('#workingLog').attr('method', 'get');
		$('#workingLog').attr('action', 'index.do');
		if (e.keyCode == 13) {
			$('#search_btn').click();
		}
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		$('#workingLog').attr('method', 'post');
		$('#workingLog').attr('action', 'excelDownload.do').submit();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#workingLog').attr('method', 'post');
		$('#workingLog').attr('action', 'csvDownload.do').submit();
	});

});
</script>

<div class="container-box">
    <div class="page-header">
        <div>작업 이력 관리</div>
    </div>

    <div class="main-content">
        <form:form modelAttribute="workingLog" method="get" action="index.do" style="width: 100%">
        <c:if test="${asideHomepageId ne 'CMS'}">
        <form:hidden path="site_id"/>
        </c:if>

        <div class="center">
            <p class="total-count">총 ${paging.totalDataCount}건</p>
            <form:select path="rowCount" class="custom-filter" style="width:150px;">
                <form:option value="10">10개씩 보기</form:option>
                <form:option value="50">50개씩 보기</form:option>
                <form:option value="100">100개씩 보기</form:option>
                <form:option value="150">150개씩 보기</form:option>
                <form:option value="300">300개씩 보기</form:option>
                <form:option value="500">500개씩 보기</form:option>
            </form:select>
            <p class="total-count">작업구분</p>
		 <form:select path="work_type" cssClass="custom-filter">
			<form:option value="">전체</form:option>
			<form:option value="W">일반작업</form:option>
			<form:option value="P">개인정보</form:option>
		</form:select>
		<c:if test="${asideHomepageId eq 'CMS'}">
            <p class="total-count">사이트</p>
		 <form:select path="site_id" cssClass="custom-filter">
			<form:option value="">전체</form:option>
			<c:forEach items="${homepageList}" var="i" varStatus="status">
			<form:option value="${i.homepage_id}">${empty i.homepage_alias ? i.homepage_name : i.homepage_name}</form:option>
			</c:forEach>
		</form:select>
		</c:if>
        </div>

		<div class="search" style="margin-top: 4px">
			<fieldset class="btn-wrapper">
                <p class="total-count">검색</p>
				 <form:select path="search_type" cssClass="custom-filter">
					<form:option value="work_comment">작업내용</form:option>
					<form:option value="member_id">사용자ID</form:option>
					<form:option value="work_result">작업결과</form:option>
				</form:select>
                <p class="total-count">조회 기간</p>
				<form:input path="search_start_date" cssClass="custom-date ui-calendar" placeholder="조회시작일 선택"/>
				<form:input path="search_end_date" cssClass="custom-date ui-calendar" placeholder="조회종료일 선택"/>
                <a id="search_btn" class="icon-btn navy" href="#" id="search">조회</a>

				<div>
					<a href="#" id="excelDownload" class="icon-btn green">
                        <img src="/resources/cms/img/main/excel.svg" alt="">
                        <div>엑셀저장</div>
                    </a>
					<a href="#" id="csvDownload" class="icon-btn green">
                        <img src="/resources/cms/img/main/csv.svg" alt="">
                        <div>CSV저장</div>
                    </a>
				</div>
			</fieldset>
		</div>



	<!-- 이용약관 table -->
	<table class="custom-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>사이트</th>
				<th>작업구분</th>
				<th>작업내용</th>
				<th>작업명령어</th>
				<th>작업결과수</th>
				<th>작업일시</th>
				<th>작업IP</th>
				<th>사용자ID</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${workingLogList}">
				<tr>
					<td><fmt:formatNumber value="${paging.listRowNum - status.index}" pattern="#,###" /></td>
					<td>${empty i.siteName ? 'CMS' : i.siteName}</td>
					<td>${i.work_type eq 'W' ? '일반작업':'개인정보'}</td>
					<td style="text-align: left;"><a href="#" class="dialog-view" data-idx="${i.work_idx}">${i.work_comment}</a></td>
					<td>${i.work_command}</td>
					<td>${i.work_result_count}</td>
					<td><fmt:formatDate value="${i.work_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${i.work_ip}</td>
					<td>${i.member_id}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(workingLogList) eq 0}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#workingLog"/>
	</jsp:include>

</form:form>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="작업 내용 상세"></div>
