<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	<%-- 희망도서 신청 취소 --%>
	$('a.cancel-btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('취소하시겠습니까?')) {
			$('#select_no').val($(this).attr('keyValue1'));
			if ( doAjaxPost($('#cancelForm')) ) {
				location.reload();
			}
		}
	});

	<%-- 페이징 --%>
	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('index.do', param);
	});

});

</script>
<form id="cancelForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="editMode" value="CANCEL"/>
	<input type="hidden" id="select_no" name="select_no"/>
</form>


<!-- contents-title-->
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 하고 싶으세요?</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
<c:set var="prefix" value="/intro/${context_path}/search/"></c:set>
<a href="${prefix}loan/index.do" class="bBtn">대출중인도서</a>
<a href="${prefix}loan/history.do" class="bBtn">대출내역조회</a>
<c:if test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks' || context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol' || context_path eq 'junggu' || context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib' || context_path eq 'donggu' || context_path eq 'sincheon' || context_path eq 'donggusm'}">
<a href="${prefix}sangho/index.do" class="bBtn">상호대차신청내역조회</a>
<a href="${prefix}sangho/history.do" class="bBtn">상호대차이용내역조회</a>
</c:if>
<a href="${prefix}resve/index.do" class="bBtn">대출예약조회</a>
<a href="${prefix}hope/index.do" class="bBtn">희망도서신청조회</a>
</div>

<form:form modelAttribute="librarySearch" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="viewPage"/>
<div class="book-list">
	<c:if test="${fn:length(hopeList) < 1 }"> <h3>희망도서신청 내역이 없습니다.</h3></c:if>
	<c:forEach items="${hopeList}" var="i">

			<div class="row">
				<div class="box">
					<div class="item">
						<div class="bif">
							<div class="top" >
								<div class="b-title">
								서명 : <b>${i.TITLE}</b>
								</div>
								<div class="b-title">
								저자 : <b>${i.AUTHOR}</b><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><br class="mobileBr"/>
								출판사 : <b>${i.PUBLISHER}</b><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><br class="mobileBr"/>
								출판년도 : <b>${i.PUBLISH_YEAR}</b>
								</div>
							</div>
						</div>
						<div class="bci">
							<table summary="신청정보">
								<tbody>
									<tr>
										<th>비치도서관</th>
										<td>${i.LIB_NAME}</td>
									</tr>
									<tr>
										<th>신청일</th>
										<td>${i.APPLICANT_DATE}</td>
									</tr>
									<tr>
										<th>처리일</th>
										<td>${i.FURNISH_DATE}</td>
									</tr>
									<tr>
										<th>비치상태</th>
										<td>
										<c:if test="${i.FURNISH_STATUS eq '1'}">신청</c:if>
										<c:if test="${i.FURNISH_STATUS eq '2'}">처리중</c:if>
										<c:if test="${i.FURNISH_STATUS eq '3'}">비치완료</c:if>
										<c:if test="${i.FURNISH_STATUS eq '4'}">취소</c:if>
										</td>
									</tr>
									<tr>
										<th>취소사유</th>
										<td>${i.CANCEL_REASON}</td>
									</tr>
									<c:if test="${i.FURNISH_STATUS eq '1'}">
									<tr>
										<th>신청취소</th>
										<td>
											<a href="#" class="btn cancel-btn" title="취소" keyValue1="${i.REC_KEY}" >취소</a>
										</td>
									</tr>
									</c:if>
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

