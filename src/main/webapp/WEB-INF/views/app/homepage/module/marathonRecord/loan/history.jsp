<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2><span style="font-weight:300">대출내역을 통해 </span>도서를 선택<span style="font-weight:300">하실 수 있습니다.</span></h2>
</div>

<form:form modelAttribute="librarySearch" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
</form:form>

<div class="wrapper-bbs">
<div class="table-wrap">
	<table class="marathon_bbs center">
		<colgroup>
			<col width="17%"/>
			<col width="32%"/>
			<col width="17%"/>
			<col width="17%"/>
			<col width="17%"/>
		</colgroup>
		<thead>
			<tr>
				<th>소장도서관</th>
				<th>도서명</th>
				<th>청구기호</th>
				<th>등록번호</th>
				<th>대출내역선택</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(loanList) < 1}"><td colspan="5">대출한 도서가 없습니다.</td></c:if>
		<c:forEach items="${loanList}" var="i" varStatus="status">
			<tr>
				<td>${i.LIB_NAME}</td>
				<td><span style="color: #034DA0;">${i.TITLE}</span><br/>${i.AUTHOR} / ${i.PUBLISHER}</td>
				<td>${i.CALL_NO}</td>
				<td>${i.REG_NO}</td>
				<td><a href="#" id="selectOne" class="btn btn1" style="width:30%;height:10%;">선택</a>
				<span data="${fn:replace(fn:replace(i.TITLE, '</b>', ''), '<b>', '')}//${i.AUTHOR}//${i.PUBLISHER}//${i.CALL_NO}//${i.REG_NO}//${i.MANAGE_CODE}//${i.LIB_NAME}"></span>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</div>

<div id="board_paging" class="dataTables_paginate" style="margin-bottom: 5%">
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

<script>
	$(function() {

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', $(this).attr('keyValue'));
			doAjaxLoad('div#historyBox', 'loan/history.do', $('form#librarySearch').serialize());
		});

		$('a#selectOne').on('click', function(e) {
			e.preventDefault();
			var data = $(this).next('span').attr('data').split('//');
			$('input#book_name').val(data[0].replace(/(<([^>]+)>)/ig,""));
			$('input#book_author').val(data[1].replace(/(<([^>]+)>)/ig,""));
			$('input#publisher').val(data[2].replace(/(<([^>]+)>)/ig,""));
			$('input#call_no').val(data[3].replace(/(<([^>]+)>)/ig,""));
			$('input#reg_no').val(data[4].replace(/(<([^>]+)>)/ig,""));
			
			$('input#book_name').attr('readonly', true);
			$('input#book_author').attr('readonly', true);
			$('input#publisher').attr('readonly', true);
			$('input#call_no').attr('readonly', true);
			$('input#reg_no').attr('readonly', true);
			$('input#book_name').focus();
			
			var manage_code = data[5].replace(/(<([^>]+)>)/ig,"");
			
			$('span#writing').hide();
			$('span#selectButton').show();
			if (manage_code == 'BY') {
				$('select#book_resources').val('100').prop('selected', true);
			} else if (manage_code == 'BW') {
				$('select#book_resources').val('200').prop('selected', true);
			} else if (manage_code == 'BV') {
				$('select#book_resources').val('300').prop('selected', true);
			} else if (manage_code == 'BZ') {
				$('select#book_resources').val('400').prop('selected', true);
			} else if (manage_code == 'BX') {
				$('select#book_resources').val('600').prop('selected', true);
			} else if (manage_code == 'BU') {
				$('select#book_resources').val('700').prop('selected', true);
			} else {
				$('select#book_resources').val('write').prop('selected', true);
				$('input#book_resources_1').css('display', '');
				$('input#book_resources_1').val(data[6].replace(/(<([^>]+)>)/ig,""));
			}
			
			$('select#book_resources').attr('onfocus', 'this.initialSelect = this.selectedIndex');
			$('select#book_resources').attr('onchange', 'this.selectedIndex = this.initialSelect');
			$('input#book_resources_1').attr('readonly', true);
		});
	});
</script>