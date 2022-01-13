<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#facilityStudy'));
		doGetLoad('applyList.do', param);
		e.preventDefault();
	});

	$('a.view').on('click', function(e) {
		e.preventDefault();
		location.href="edit.do?editMode=VIEW&menu_idx=${fn:escapeXml(param.menu_idx)}&study_idx="+$(this).data('idx');
	});

	$('a.cancel').on('click', function(e) {
		e.preventDefault();
		if (confirm('취소하시겠습니까?')) {
			$('input#cancel_idx').val($(this).data('idx'));
			doAjaxPost($('form#cancelForm'));
		}
	});
});

</script>

<form id="cancelForm" action="save.do" method="post" onsubmit="return false;">
<input type="hidden" name="editMode" value="CANCEL">
<input type="hidden" name="study_idx" id="cancel_idx">
<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>


<form:form modelAttribute="facilityStudy" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>
<form:hidden path="study_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="wrapper-bbs">
	<div class="table-wrap">
		<table class="bbs center" summary=">그룹스터디 신청기록">
			<caption>그룹스터디 신청기록</caption>
			<colgroup>
				<col width="10%">
				<col width="20%">
				<col width="12%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="mmm2">신청일자</th>
					<th class="mmm2">이용자리</th>
					<th class="mmm1">이용시간</th>
					<th class="mmm2">접수상태</th>
					<th class="mmm2">확인/취소</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${facilityStudyList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important num"><fmt:formatDate value="${i.apply_date}" pattern="yyyy.MM.dd" /></td>
					<td class="important num">스터디룸 ${i.study_num}팀</td>
					<td class="important num">${i.study_date} /
						<c:if test="${i.study_time eq '1'}">오전</c:if>
						<c:if test="${i.study_time eq '2'}">오후</c:if>
						<c:if test="${i.study_time eq '3'}">야간</c:if>
					</td>
					<td class="important num">
						<c:choose>
						<c:when test="${i.apply_status eq '0'}">대기</c:when>
						<c:when test="${i.apply_status eq '1'}">승인</c:when>
						<c:otherwise>${i.cancel_reason}</c:otherwise>
						</c:choose>
					</td>
					<td class="important num">
						<a href="#" class="btn view" data-idx="${i.study_idx}">확인하기</a>
						<c:if test="${i.apply_status eq '2'}">취소불가</c:if>
						<c:if test="${i.apply_status ne '2'}"><a href="#" class="btn cancel" data-idx="${i.study_idx}">취소하기</a></c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(facilityStudyList) < 1 }">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">등록된 신청 내역이 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>

	<form:hidden path="viewPage"/>
	<div id="board_paging" class="dataTables_paginate">
	<c:if test="${paging.firstPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
	</c:if>
	<c:if test="${paging.prevPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
	</c:if>
		<span>
	<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
	<c:choose>
	<c:when test="${i eq paging.viewPage}">
		<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
	</c:when>
	<c:otherwise>
		<a href="" class="paginate_button" keyValue="${i}">${i}</a>
	</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${paging.nextPageNum > 0}">
		<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
	</c:if>
	<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
		<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
	</c:if>
		</span>
	</div>

</div>
</form:form>
