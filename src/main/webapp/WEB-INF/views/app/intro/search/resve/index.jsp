<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	$('a.reserveCancel').on('click', function(e) {
		e.preventDefault();
		if ( confirm("예약 취소 하시겠습니까?") ) {
			$('input#bookkey').val($(this).data('pk'));
			if (doAjaxPost($('form#cancelForm'))) {
				location.reload();
			}
		}

	});
});

</script>
<form id="cancelForm" action="save.do" method="post">
	<input type="hidden" name="bookkey" id="bookkey">
	<input type="hidden" name="editMode" value="CANCEL">
</form>


<!-- contents-title-->
<div id="contents-title">
	<h2>현재 예약중인 자료<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
<c:set var="prefix" value="/intro/${homepage.context_path}/search/"></c:set>
<a href="${prefix}loan/index.do" class="bBtn">대출중인도서</a>
<a href="${prefix}loan/history.do" class="bBtn">대출내역조회</a>
<a href="${prefix}sangho/index.do" class="bBtn">상호대차신청내역조회</a>
<a href="${prefix}sangho/history.do" class="bBtn">상호대차이용내역조회</a>
<a href="${prefix}resve/index.do" class="bBtn">대출예약조회</a>
</div>

<div class="book-list">
	<c:if test="${fn:length(resveList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:forEach items="${resveList}" var="i">
		<div class="row">
			<div class="box">
				<div class="item">
					<div class="bif">
						<div class="top">
							<div class="b-title">
								<div class="box"><a href="" class="name">${i.TITLE_INFO}</a></div>
							</div>
							<div class="control">
								<c:if test="${i.STATUS eq '3'}">
								<a href="" class="btn reserveCancel" keyValue="${i.PK}">예약취소</a>
								</c:if>
							</div>
						</div>
						<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLISHER}</em> </p>
					</div>
					<div class="bci">
						<table summary="신청정보">
							<tbody>
							<tr>
								<th>도서관명</th>
								<td>${i.LIB_NAME}</td>
							</tr>
							<tr>
								<th>예약일</th>
								<td>${i.RESERVATION_DATE}</td>
							</tr>
							<tr>
								<th>예약순위</th>
								<td>${i.RESERVE_RANK}</td>
							</tr>
							<tr>
								<th>예약만기일</th>
								<td>${i.RESERVATION_EXPIRE_DATE }</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

	<!-- 페이징을 넣어주세요 : 시작 - 기존에 사용하던거 그대로 재사용해주시면 될것같아요. -->

	<!-- 페이징을 넣어주세요 : 끝 -->
</div>


