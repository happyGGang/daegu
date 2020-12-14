<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
	<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<script>
$(function() {
	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ($('input.tmp_user_no:checked').length < 1) {
			alert('통합회원을 선택해주세요.');
			return false;
		}
		$('input#user_no').val($('input.tmp_user_no:checked').val());
		$('form#procForm').removeAttr('onsubmit');
		$('form#procForm').submit();
	});

	<%-- 1순위 책이음 회원--%>
	if ($('input.tmp_user_no[data-kl=Y]').length > 0) {
		$('input.tmp_user_no[data-kl=N]').remove();
		$("input.tmp_user_no[data-kl='']").remove();
	} else if ($('input.tmp_user_no[data-ci=Y]').length > 0) {
		<%-- 2순위 자관 && CI가 있는 회원--%>
		$('input.tmp_user_no[data-ci=N]').remove();
	}

/*
	if ($('input.tmp_user_no[data-kl=Y]').length > 0) {
		$('input.tmp_user_no[data-kl=N]').remove();
	} else if ($('input.tmp_user_no[data-ci=Y]').length > 0) {
		<%-- 2순위 자관 && CI가 있는 회원--%>
		$('input.tmp_user_no[data-ci=N]').remove();
	}
*/

	$('#manageCode').val( $('input.tmp_user_no:first').data('mg') );

	 $("input.tmp_user_no").click(function(){
		var mgc = $(this).data('mg');
		//alert(mgc);
		$('#manageCode').val(mgc);
	 });

	<%-- 첫번째 강제 선택 --%>
	$('input.tmp_user_no:first').prop('checked', true);

});


</script>

	<!-- contents-title-->
	<div id="contents-title">
		<h2><span style="font-weight:300">회원님은</span> <span style="font-weight:300; color:#fab000">통합회원 대상자</span> <span style="font-weight:300">입니다.</span></h2>
	</div>
	<!-- /contents-title-->

	<form id="procForm" name="procForm" method="post" action="integration2.do" onsubmit="return false;">
	<input type="hidden" id="user_no" name="user_no" value=""/>
	<input type="hidden" id="manageCode" name="manageCode" value=""/>

	<div class="search-wrap">

		<table class="table_gray">
			<thead>
			<tr>
				<th>선택</th>
				<th>대출번호</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>핸드폰번호</th>
				<th>비고</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${integrationMemberList}" var="i" varStatus="status">
				<tr>
					<td>
						<input type="radio" class="tmp_user_no" value="${i.USER_NO}" data-kl="${i.KL_MEMBER_YN}" data-ci="${i.ORDER2}" data-mg="${i.MANAGE_CODE}"/>
					</td>
					<td>${i.USER_NO}</td>
					<td>${i.NAME}</td>
					<td>${i.BIRTHDAY}</td>
					<td>${i.HANDPHONE}</td>
					<td>
						<c:if test="${i.KL_MEMBER_YN eq 'Y'}">
						[ 책이음회원 - 통합우선순위 ]
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>


	</div>

	<div style="text-align:center;padding:20px 0">
	<a href="#" id="join-btn"  class="btn">확인</a>
	</div>
	</form>