<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('a.dialog-view').on('click', function(e) {

		$('div#dialog-1').load('view.do?work_idx='+$(this).data('idx'), function( response, status, xhr ) {
			$('div#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('select#work_type, select#rowCount').on('change', function() {
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#workingLog').serialize());
	})

	$('a#excelDownload').on('click', function(e) {
		$('#workingLog').attr('action', 'excelDownload.do').submit();
		//$('#workingLog').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#workingLog').attr('action', 'csvDownload.do').submit();
	});

});
</script>
<form:form modelAttribute="workingLog">
<c:if test="${asideHomepageId ne 'CMS'}">
<form:hidden path="site_id"/>
</c:if>

	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="150">150개씩 보기</form:option>
			<form:option value="300">300개씩 보기</form:option>
			<form:option value="500">500개씩 보기</form:option>
		</form:select>
		작업구분 : <form:select path="work_type" cssClass="selectmenu">
			<form:option value="">전체</form:option>
			<form:option value="W">일반작업</form:option>
			<form:option value="P">개인정보</form:option>
		</form:select>
		<c:if test="${asideHomepageId eq 'CMS'}">
		사이트 : <form:select path="site_id" cssClass="selectmenu">
			<form:option value="">전체</form:option>
			<c:forEach items="${homepageList}" var="i" varStatus="status">
			<form:option value="${i.homepage_id}">${empty i.homepage_alias ? i.homepage_name : i.homepage_name}</form:option>
			</c:forEach>
		</form:select>
		</c:if>


		<div class="search">
			<fieldset>
				검색 : <form:select path="search_type" cssClass="selectmenu">
					<form:option value="work_comment">작업내용</form:option>
					<form:option value="member_id">사용자ID</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
				<div class="right" style="float: right;">
					<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
					<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
				</div>
			</fieldset>
		</div>
	</div>

	<!-- 이용약관 table -->
	<table class="type1 center">
		<colgroup>
			<col width="100" />
			<col width="150" />
			<col width="100" />
			<col width="" />
			<col width="150" />
			<col width="120" />
			<col width="200" />
			<col width="150" />
			<col width="150" />
		</colgroup>
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
					<td><fmt:formatNumber value="${i.work_idx}" pattern="#,###" /></td>
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

<div id="dialog-1" class="dialog-common" title="작업 내용 상세"></div>
