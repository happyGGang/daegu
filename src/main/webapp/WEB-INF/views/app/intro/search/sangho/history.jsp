<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	//페이징
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('history.do', param);
		e.preventDefault();
	});

});
</script>
<!-- contents-title-->
<div id="contents-title">
	<h2>지난 상호대차신청내역조회<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
<c:set var="prefix" value="/intro/${context_path}/search/"></c:set>
<a href="${prefix}loan/index.do" class="bBtn">대출중인도서</a>
<a href="${prefix}loan/history.do" class="bBtn">대출내역조회</a>
<a href="${prefix}sangho/index.do" class="bBtn">상호대차신청내역조회</a>
<a href="${prefix}sangho/history.do" class="bBtn">상호대차이용내역조회</a>
<a href="${prefix}resve/index.do" class="bBtn">대출예약조회</a>
</div>

<form:form modelAttribute="librarySearch" action="index.do" method="get">
<form:hidden path="viewPage"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="book-list">

	<c:if test="${fn:length(sanghoHistory) < 1 }"> <h3>상호대차신청 내역이 없습니다.</h3></c:if>

	<c:forEach items="${sanghoHistory}" var="i" varStatus="status" begin="1">

	<div class="row">
		<div class="box">
			<div class="item">
				<div class="bif">
					<div class="top">
						<div class="b-title">
							<div class="box"><a href="" class="name">${i.TITLE_INFO}</a></div><!-- 도서명 -->
						</div>
						<div class="control">

						</div>
					</div>
					<p class="info"><em>저자 : ${i.AUTHOR_INFO}</em> <span>/</span> <em>출판사 : ${i.PUB_INFO}</em> </p><!-- 저자 -->
				</div>
				<div class="bci">
					<table summary="신청정보">
						<tbody>
							<tr>
								<th>대출일</th>
								<td>${i.LOAN_DATE}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
									<c:choose>
										<c:when test="${i.TRANSACTION_CODE eq '0'}">
										신청
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '1'}">
										발송중
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '2'}">
										발송거절
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '3'}">
										입수
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '4'}">
										대출중
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '5'}">
										완료
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '6'}">
										신청취소
										</c:when>
										<c:when test="${i.TRANSACTION_CODE eq '7'}">
										대출만기자료
										</c:when>
										<c:otherwise>
										오류! 도서관에 문의 요망!
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</c:forEach>

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