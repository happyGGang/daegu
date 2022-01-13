<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a.delay-btn').on('click', function(e) {
		e.preventDefault();

		$('input#editMode').val('RENEW');
		$('input#loan_key').val($(this).attr('keyValue1'));

		if ( doAjaxPost($('form#renewForm')) ) {
			location.reload();
		}
	});
	
	$('#select_manage').on('change', function() {
		var menu_idx = '${librarySearch.menu_idx}';
		doGetLoad('index.do', 'menu_idx='+menu_idx+'&manageCode='+$(this).val());
	});
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = 'excel_type=LOAN';
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});

});
</script>
<jsp:useBean id="now" class="java.util.Date"/>

<form id="renewForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="loan_key" id="loan_key">
	<input type="hidden" name="editMode" value="RENEW">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="manageCode"/>
	<form:hidden path="excel_type" value="LOAN"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<!-- contents-title
<div id="contents-title">
	<h2>대출중인도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
/contents-title-->
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="loan_box">
	<ul>
		<li>
			<img src="/resources/common/img/loan_icon01.png">
			<h5>대출 중 권수</h5>
			<span>${fn:length(loanList)}</span>
		</li>
		<li>
			<img src="/resources/common/img/loan_icon02.png">
			<h5>대출 연체 권수</h5>
			<span>${member.overdue_cnt}</span>
		</li>
		<li>
			<img src="/resources/common/img/loan_icon03.png">
			<h5>대출 정지 만기일</h5>
			<span>${member.loan_stop_date eq 'null' ? '해당없음' : member.loan_stop_date}</span>
		</li>
	</ul>
</div>

<div class="new_select_box_wrap">
	<fieldset>
	<select name="manageCode" class="selectmenu new_select_box" id="select_manage">
		<option value="">전체</option>
		<c:forEach items="${homepageList}" var="mc">
		<c:if test="${not empty mc.manage_code}">
		<option value="${mc.manage_code}" ${librarySearch.manageCode eq mc.manage_code ? 'selected' : ''}>${mc.homepage_name}</option>
		</c:if>
		</c:forEach>
	</select>
	</fieldset>
</div>

<div class="excel_btn_box_wrap">
	<a href="#" id="excel-btn" class="btn excel-btn">리스트 다운로드</a>
</div>

<div class="book-list" style="padding-top:10px;">

	<c:if test="${fn:length(loanList) < 1 }">
		<h3>현재 대출 중인 도서가 없습니다.</h3>
	</c:if>

	<table summary="신청정보">
		<thead>
			<th>순번</th>
			<th>제목</th>
			<th>저자 / 발행자</th>
			<th>도서관명</th>
			<th>대출일</th>
			<th>반납예정일</th>
			<th>상태</th>
		</thead>
		<tbody>
			<c:forEach items="${loanList}" var="i">
			<tr>
				<td>${i.RNUM}</td>
				<td>${i.TITLE_INFO}</td>
				<td>${i.AUTHOR} / ${i.PUBLISHER}</td>
				<td>${i.LIB_NAME}</td>
				<td>${i.LOAN_DATE}</td>
				<td>${i.RETURN_PLAN_DATE}</td>
				<td>
				<fmt:parseDate value="${i.RETURN_PLAN_DATE}" pattern="yyyy/MM/dd" var="rpd"/>
				<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowDate"/>
				<fmt:formatDate value="${rpd}" pattern="yyyyMMdd" var="endDate"/>
				<c:choose>
					<c:when test="${(nowDate - endDate) > 0}">연체</c:when>
					<c:when test="${i.STATUS eq '0'}">대출</c:when>
					<c:when test="${i.STATUS eq '1'}">반납</c:when>
					<c:when test="${i.STATUS eq '2'}">반납연기</c:when>
					<c:when test="${i.STATUS eq '3'}">예약</c:when>
					<c:when test="${i.STATUS eq '4'}">예약취소</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>