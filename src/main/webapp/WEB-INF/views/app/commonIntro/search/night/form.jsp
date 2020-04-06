<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if (!confirm('워킹스루 신청을 하시겠습니까?')) {
			return false;
		}

		if ($('select#worker').val() == '') {
			alert('수령장소를 선택하세요.');
			$('select#worker').focus();
			return false;
		}

		if (doAjaxPost($('form#librarySearch'))) {
			history.back();
		}
	});

});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>워킹스루 신청을 위한 신청사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="bookkey"/>
<form:hidden path="booktype"/>
<form:hidden path="title" value="${detail.TITLE_INFO}"/>
<form:hidden path="exprire_date_cnt" value="7"/>

<div class="delibery_info">
	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
	<table class="table_01">
		<colgroup>
			<col width="28%" />
			<col width="*"/>
		</colgroup>
		<tbody>
			 <tr>
				<th>신청인</th>
				<td class="left">${sessionScope.member.member_name}</td>
			 </tr>
			 <tr>
				<th>소장도서관</th>
				<td class="left">${detail.LIB_NAME}</td>
			 </tr>
			 <!-- <tr>
				<th>수령장소</th>
				<td class="left">
					<form:select path="worker" style="border:1px solid #c9c9c9;border-radius:4px;height:30px">
						<form:option value="">--- 장소를 선택하세요 ---</form:option>
						<option value="SYSUB02">수영역</option>
						<option value="SYSUB01">남천동메가마트</option>
					</form:select>
				</td>
			 </tr> -->
			 <tr>
				<th>도서명</th>
				<td class="left">${detail.TITLE_INFO}</td>
			 </tr>
			 <tr>
				<th>등록번호</th>
				<td class="left">${detail.REG_NO}</td>
			 </tr>
		</tbody>
	</table>
	<div class="btnArea" style="text-align: center; padding-top: 25px;">
		<a href="#" id="save-btn" class="btn btn03">확인</a>
		<a href="javascript:history.back();" class="btn btn02">취소</a>
	</div>
</div>
</form:form>