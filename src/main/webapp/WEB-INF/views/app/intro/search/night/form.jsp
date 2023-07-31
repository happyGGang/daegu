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
<input type="hidden" name="booktype" id="booktype" value="${fn:substring(detail.WORKING_STATUS,0,2) }"/>
<input type="hidden" name="exprire_date_cnt" id="exprire_date_cnt" value="7"/>
<c:choose>
<c:when test="${detail.MANAGE_CODE eq 'AA'}">
<input type="hidden" name="worker" id="worker" value="DGL0001"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AL'}">
<input type="hidden" name="worker" id="worker" value="DGL0002"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AG'}">
<input type="hidden" name="worker" id="worker" value="DGL0003"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AJ'}">
<input type="hidden" name="worker" id="worker" value="DGL0004"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AH'}">
<input type="hidden" name="worker" id="worker" value="DGL0005"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AB'}">
<input type="hidden" name="worker" id="worker" value="DGL0006"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AC'}">
<input type="hidden" name="worker" id="worker" value="DGL0007"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AF'}">
<input type="hidden" name="worker" id="worker" value="DGL0008"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AE'}">
<input type="hidden" name="worker" id="worker" value="DGL0009"/>
</c:when>
<c:when test="${detail.MANAGE_CODE eq 'AD'}">
<input type="hidden" name="worker" id="worker" value="DGL0010"/>
</c:when>

<c:when test="${detail.MANAGE_CODE eq 'BR'}">
<input type="hidden" name="worker" id="worker" value="DGL0011"/>
</c:when>

<c:otherwise>
<input type="hidden" name="worker" id="worker" value="DGL0010"/>
</c:otherwise>
</c:choose>

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