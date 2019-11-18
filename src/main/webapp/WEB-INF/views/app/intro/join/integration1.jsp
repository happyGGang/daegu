<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
	<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<script>
$(function() {
	$('a#join-btn').on('click', function() {
		$('form#procForm').submit();
	})
})


</script>

	<!-- contents-title-->
	<div id="contents-title">
		<h2><span style="font-weight:300">회원님은</span> <span style="font-weight:300; color:#fab000">통합회원 대상자</span> <span style="font-weight:300">입니다.</span></h2>
	</div>
	<!-- /contents-title-->

	<form id="procForm" name="procForm" method="post" action="integration2.do">
	<input type="hidden" id="user_no" name="user_no" value=""/>
	<input type="hidden" id="name" name="name" value=""/>
	<input type="hidden" id="rec_key" name="rec_key" value=""/>
	<input type="hidden" id="manage_code" name="manage_code" value=""/>


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
				<tr>
				<td>
					<input type="radio" id="tmp_rec_key" name="tmp_rec_key" value="9102616011#BL" checked/>
				</td>
				<td>
					12200712009502</td>
				<td>
					권기현</td>
				<td>
					1979-06-30 00:00:00</td>
				<td>
					010-6476-6584</td>
				<td>[ 책이음회원 - 통합우선순위 ] | 책이음 회원 등록일 : 2019-04-08 16:49:14</td>
				</tr>

				<tr>
				<td>
					<input type="radio" id="tmp_rec_key" name="tmp_rec_key" value="9102616011#BL" checked/>
				</td>
				<td>
					12200712009502</td>
				<td>
					권기현</td>
				<td>
					1979-06-30 00:00:00</td>
				<td>
					010-6476-6584</td>
				<td></td>
				</tr>

				<tr>
				<td>
					<input type="radio" id="tmp_rec_key" name="tmp_rec_key" value="9102616011#BL" checked/>
				</td>
				<td>
					12200712009502</td>
				<td>
					권기현</td>
				<td>
					1979-06-30 00:00:00</td>
				<td>
					010-6476-6584</td>
				<td></td>
				</tr>
			</tbody>
		</table>


	</div>

	<div style="text-align:center;padding:20px 0">
	<a href="#" id="join-btn"  class="btn">확인</a>
	</div>
	</form>