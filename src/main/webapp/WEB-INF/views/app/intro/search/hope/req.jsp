<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {

		if ($('input#price').val() != '') {
			var price = $('input#price').val();
			if (!parseInt(price)) {
				alert('가격은 숫자만 입력가능합니다.');
				$('input#price').focus();
				return false;
			}
			var isbn = $('input#isbn').val();
			if (isbn != '' && !parseInt(isbn)) {
				alert('ISBN은 숫자만 입력가능합니다.');
				$('input#isbn').focus();
				return false;
			}
		}

		if ( doAjaxPost($('#reqHopeForm')) ) {
			doGetLoad('index.do');
		}
		e.preventDefault();
	});

	doAjaxLoad('div#searchBox', 'search.do?manageCode=${context_path}');
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 하고 싶으세요?</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
	<a href="/intro/${context_path}/search/hope/req.do" class="bBtn">희망도서신청</a>
	<a href="/intro/${context_path}/search/hope/index.do" class="bBtn">신청내역보기</a>
</div>

<div id="searchBox">

</div>
<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">

<form:form id="reqHopeForm" modelAttribute="librarySearch" action="save.do" method="post">
	<form:hidden path="editMode" value="ADD"/>
	<table class="edit">
		<tbody>
		<!-- 신청도서관 부분 추가 : 한개의 검색대에서 두개 이상의 도서관이 존재하여 신청 도서관을 선택해야하는 경우를 생각하여 CMS관리자에서 신청도서관 설정할수 있도록 하는게 맞을것 같음.  -->
		<tr>
			<th>신청도서관 <em><font color="red">(*)</font></em></th>
			<td>
				<c:choose>
				<c:when test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
				<form:select path="manageCode">
					<form:option value="BA">구수산도서관</form:option>
					<form:option value="BB">대현도서관</form:option>
					<form:option value="BC">태전도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${context_path eq 'jungang'}">
				<form:select path="manageCode">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dongdu'}">
				<form:select path="manageCode">
					<form:option value="AH">동부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'seobu'}">
				<form:select path="manageCode">
					<form:option value="AF">서부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'nambu'}">
				<form:select path="manageCode">
					<form:option value="AG">남부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'bukbu'}">
				<form:select path="manageCode">
					<form:option value="AC">북부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'duryu'}">
				<form:select path="manageCode">
					<form:option value="AB">두류도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq '228'}">
				<form:select path="manageCode">
					<form:option value="AA">228기념학생도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq '228lib'}">
				<form:select path="manageCode">
					<form:option value="AL">228민주운동</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'suseong'}">
				<form:select path="manageCode">
					<form:option value="AE">수성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dalseong'}">
				<form:select path="manageCode">
					<form:option value="AJ">달성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'std'}">
				<form:select path="manageCode">
					<form:option value="AK">대구학생문화센터</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dmsl'}">
				<form:select path="manageCode">
					<form:option value="FV">대구시청작은도서관</form:option>
				</form:select>
				</c:when>
				<c:otherwise>
				<form:select path="manageCode">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<!-- 신청도서관 부분 추가 -->
		<tr>
			<th>제목 <em><font color="red">(*)</font></em></th>
			<td><form:input path="title" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>저자 <em><font color="red">(*)</font></em></th>
			<td><form:input path="author" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>출판사 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>연도 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer_year" style="width:40%" class="text" type="text" numberOnly="true" maxlength="4"/></td>
		</tr>
		<tr>
			<th>ISBN</th>
			<td><form:input path="isbn" style="width:40%" class="text" type="text" maxlength="13"/></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><form:input path="user_remark" style="width:90%" class="text" type="text" maxlength="50"/></td>
		</tr>
		<tr>
			<th>가격 <em><font color="red">(*)</font></em></th>
			<td><form:input path="price" style="width:40%" class="text" type="text" maxlength="10" numberOnly="true" /></td>
		</tr>
		<c:if test="${context_path ne 'nambu' and context_path ne 'std'}">
		<tr>
			<th>우선대출예약여부</th>
			<td><form:checkbox path="reservation_yn" class="text" value="Y" checked="checked"/> <label for="reservation_yn1">우선대출을 원하실 경우 체크를 해주세요</label></td>
		</tr>
		</c:if>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
	<a id="save-btn" href="" class="btn btn5"><span>신청하기</span></a>
</div>

