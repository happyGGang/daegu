<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

});
</script>

<form id="renewForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="loan_key" id="loan_key">
	<input type="hidden" name="editMode" value="RENEW">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>

<!-- contents-title-->
<div id="contents-title">
	<h2>대출중인도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="DepthBtn">
<c:set var="prefix" value="/intro/${context_path}/search/"></c:set>
<a href="${prefix}loan/index.do" class="bBtn">대출중인도서</a>
<a href="${prefix}loan/history.do" class="bBtn">대출내역조회</a>
<c:if test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks' || context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol' || context_path eq 'junggu' || context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib' || context_path eq 'donggu' || context_path eq 'sincheon' || context_path eq 'donggusm' || context_path eq 'suseongLake'}">
<a href="${prefix}sangho/index.do" class="bBtn">상호대차신청내역조회</a>
<a href="${prefix}sangho/history.do" class="bBtn">상호대차이용내역조회</a>
</c:if>
<a href="${prefix}resve/index.do" class="bBtn">대출예약조회</a>
<a href="${prefix}hope/index.do" class="bBtn">희망도서신청조회</a>
</div>

<div>
대출연체 권수 : ${member.overdue_cnt}<br/>
대출정지만기일 : ${member.loan_stop_date eq 'null' ? '해당없음' : member.loan_stop_date}
</div>

<div class="book-list">
<c:if test="${fn:length(loanList) < 1 }"> <h3>현재 대출 중인 도서가 없습니다.</h3></c:if>
<c:forEach items="${loanList}" var="i">
	<div class="row">
		<div class="box">
			<div class="item">
				<div class="bif">
					<div class="top">
						<div class="b-title">서명 : <b>${i.TITLE_INFO}</b></div>
						<div class="b-title">저자 : <b>${i.AUTHOR}</b><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><br class="mobileBr"/>출판사 :<b> ${i.PUBLISHER}</b></div>
					</div>
				</div>
				<div class="bci">
					<table summary="신청정보">
						<tbody>
							<tr>
								<th>도서관명</th>
								<td>${i.LIB_NAME}</td>
							</tr>
							<tr>
								<th>대출유형</th>
								<td>
								${i.LOAN_TYPE_CODE}
								</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<th>대출일</th> -->
<%-- 								<td>${i.LOAN_DATE}</td> --%>
<!-- 							</tr> -->
							<tr>
								<th>반납예정일</th>
								<td>${i.RETURN_PLAN_DATE}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
								<c:if test="${i.STATUS eq '0'}">대출</c:if>
								<c:if test="${i.STATUS eq '1'}">반납</c:if>
								<c:if test="${i.STATUS eq '2'}">반납연기</c:if>
								<c:if test="${i.STATUS eq '3'}">예약</c:if>
								<c:if test="${i.STATUS eq '4'}">예약취소</c:if>
								</td>
							</tr>
							<c:if test="${i.RETURN_DEALY_CODE eq '100'}">
							<tr>
								<th>반납연기</th>
								<td>
<%-- 									<a href="#" class="btn delay-btn" keyValue1="${i.PK}">신청</a> --%>
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
</div>