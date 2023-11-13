<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	//상호대차 취소
	$('a.cancel-btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('상호대차 신청취소하시겠습니까?')) {
			$('input#loan_key').val($(this).attr('keyValue1'));
			$('input#hold_lib_code').val($(this).attr('keyValue2'));
			$('input#local_book_key').val($(this).attr('keyValue3'));
			if (doAjaxPost($('#cancelForm'))) {
				location.reload();
			}
		}
	});

	//페이징
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});

});
</script>

<form id="cancelForm" action="../sanghoSave.do" method="post" onsubmit="return false;">
	<input type="hidden" name="editMode" value="CANCEL"/>
	<input type="hidden" id="loan_key" name="loan_key"/>
	<input type="hidden" id="hold_lib_code" name="hold_lib_code"/>
	<input type="hidden" id="local_book_key" name="local_book_key"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>


<!-- contents-title-->
<div id="contents-title">
	<h2>지난 상호대차신청내역조회<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="index.do" method="get">
<form:hidden path="viewPage"/>
<form:hidden path="menu_idx"/>

<div class="book-list">
	<c:if test="${fn:length(sanghoHistory) < 1 }"> <h3>상호대차신청 내역이 없습니다.</h3></c:if>
	<table summary="신청정보">
		<thead>
			<th style="width:6%">순번</th>
			<th style="width:18%">제목</th>
			<th style="width:15%">저자 / 발행자</th>
			<th style="width:17%">제공도서관</th>
			<th style="width:12%">대출도서관</th>
			<th style="width:8%">상태</th>
			<th style="width:8%">대출만료일</th>
			<th style="width:8%">취소</th>
		</thead>
		<tbody>
				<c:forEach items="${sanghoHistory}" var="i" varStatus="status">
					<tr>
						<td>${i.RNUM}</td>
						<td>${i.TITLE_INFO}</td>
						<td>${i.AUTHOR_INFO} / ${i.PUB_INFO}</td>
						<td>${i.HOLD_LIB_NAME}</td>
						<td>${i.LOAN_LIB_NAME}</td>
						<td>${i.TRANSACTION_CODE_NAME}</td>
						<td>${i.RETURN_EXPIRE_DATE}</td>
						<td>
							<c:if test="${i.TRANSACTION_CODE eq '0'}">
							<a href="#" class="btn cancel-btn" style="background-color:skyblue;color:black;font-weight:bold;" keyValue1="${i.LOAN_KEY}" keyValue2="${i.HOLD_LIB_CODE}" keyValue3="${i.LOCAL_BOOK_KEY}">신청<br/>취소</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			<c:if test='${fn:length(sanghoHistory) < 1 }'>
				<tr>
					<td colspan="8">상호대차신청 내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
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