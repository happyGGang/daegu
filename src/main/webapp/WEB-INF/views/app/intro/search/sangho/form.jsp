<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if (!confirm('상호대차신청을 하시겠습니까?')) {
			return false;
		}

		if ($('select#uselibcode').val() == '') {
			alert('제공받을 도서관을 선택하세요.');
			$('select#uselibcode').focus();
			return false;
		}

		if (doAjaxPost($('form#librarySearch'))) {
			location.href='index.do';
		}
	});

	$('select#uselibcode option').each(function() {
		if ($(this).val() != '' && $(this).val() == '${detail.LIB_CODE}') {
			$(this).remove();
		}
	});

});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>상호대차 신청을 위한 선택사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="../sanghoSave.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="isbn" />
<form:hidden path="regNo" />
<form:hidden path="booktype" />
<form:hidden path="manageCode" />

<div class="delibery_info">
	<h3>상호대차 정보 입력</h3>
	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
	<table class="editTbl">
		<colgroup>
	       <col width="28%" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			 <tr>
			 	<th>신청인</th>
			 	<td>
			 		${sessionScope.member.member_name}
			 	</td>
			 </tr>
			 <tr>
			 	<th>제공도서관</th>
			 	<td>
			 		${detail.LIB_NAME}
			 	</td>
			 </tr>
			 <tr>
			 	<th>이용도서관(<span style="color: red;">*</span>)</th>
			 	<td>
<!-- 도서관 선택 분기처리 시작 -->
					<c:choose>
					<c:when test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
			 		<form:select path="uselibcode">
			 			<form:option value="" label="-- 선택 --" />
						<form:option value="127009">구수산도서관</form:option>
						<form:option value="127084">대현도서관</form:option>
						<form:option value="127088">태전도서관</form:option>
						<form:option value="727033">태전1동 작은도서관</form:option>
						<form:option value="727038">산격1동 작은도서관</form:option>
						<form:option value="727040">북구영어작은도서관</form:option>
						<form:option value="727054">침산1동 작은도서관</form:option>
						<form:option value="727055">노원동 작은도서관</form:option>
						<form:option value="727088">서변동작은도서관</form:option>
						<form:option value="727098">노원행복도서관</form:option>
						<form:option value="727102">한강공원부키도서관</form:option>
					</form:select>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
			 	</td>
			 </tr>
			 <tr>
			 	<th>도서명</th>
			 	<td>
			 		${detail.TITLE_INFO}
			 	</td>
			 </tr>
			 <tr>
			 	<th>등록번호</th>
			 	<td>
			 		${detail.REG_NO}
			 	</td>
			 </tr>
			 <c:if test="${not empty detail.APPENDIX_INFO}">
			 <tr>
			 	<th>부록대출</th>
			 	<td>
			 		<form:checkbox path="appendixrctyn" value="y" label="(해당 도서에 부록이 있을 시 부록도 같이 대출하겠습니다.)"/>
			 	</td>
			 </tr>
			 </c:if>
       	</tbody>
	</table>

	<div class="btnArea" style="text-align: center; padding-top: 25px;">
		<a href="/intro/${context_path}/index.do" id="cancel-btn" class="btn btn02">취소</a>
		<a href="#" id="save-btn" class="btn btn1">신청</a>
	</div>
</div>
</form:form>
