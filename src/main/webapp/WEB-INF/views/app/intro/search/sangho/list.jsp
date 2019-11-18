<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<!-- contents-title-->
<div id="contents-title">
	<h2>지난 상호대차신청내역조회<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->	

<div class="DepthBtn">
<a href="#" class="bBtn">대출중인도서</a>
<a href="#" class="bBtn">대출내역조회</a>
<a href="#" class="bBtn">상호대차신청내역조회</a>
<a href="#" class="bBtn">상호대차이용내역조회</a>
<a href="#" class="bBtn">대출예약조회</a>
</div>


<div class="book-list">

	<!-- 루프 돌려주세요 -->
	<div class="row">
		<div class="box">
			<div class="item">
				<div class="bif">
					<div class="top">
						<div class="b-title">
							<div class="box"><a href="" class="name">${i.TITLE_INFO}</a></div>
						</div>
						<div class="control">
							<c:if test="${i.TRANSACTION_CODE eq '0'}">
							<a href="" class="btn cancel-btn" keyValue="${i.SELECT_NO}">신청 취소</a>
							</c:if>
						</div>
					</div>
					<p class="info"><em>저자 : ${i.AUTHOR_INFO}</em> <span>/</span> <em>출판사 : ${i.PUB_INFO}</em> </p>
				</div>
				<div class="bci">
					<table summary="신청정보">
						<tbody>
							<tr>
								<th>제공도서관</th>
								<td>${i.HOLD_LIB_NAME}</td>
							</tr>
							<tr>
								<th>대출도서관</th>
								<td>${i.LOAN_LIB_NAME}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>${i.TRANSACTION_CODE_NAME}</td>
							</tr>
							<tr>
								<th>대출만료일</th>
								<td>${i.RETURN_EXPIRE_DATE}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 루프돌려주세요 끝 -->
	
	<!-- 페이징을 넣어주세요 : 시작 - 기존에 사용하던거 그대로 재사용해주시면 될것같아요. -->

	<!-- 페이징을 넣어주세요 : 끝 -->

</div>