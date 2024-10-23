<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:choose>
	<c:when test="${homepage.context_path eq 'dmsl'}">
	<script type="text/javascript">
	$(function() {

		$('#save-btn').on('click', function(e) {
			e.preventDefault();
			if (!confirm('별관 이동도서관 신청을 하시겠습니까?')) {
				return false;
			}

			if (doAjaxPost($('form#librarySearch'))) {
				history.back();
			}
		});

	});
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
	$(function() {

		$('#save-btn').on('click', function(e) {
			e.preventDefault();
			if (!confirm('무인예약 신청을 하시겠습니까?')) {
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
	</c:otherwise>
</c:choose>



<!-- contents-title-->
<div id="contents-title">
<c:choose>
	<c:when test="${homepage.context_path eq 'dmsl'}">
	<h2>별관 이동도서관 신청을 위한 신청사항<span style="font-weight:300">을 확인하세요.</span></h2>
	</c:when>
	<c:otherwise>
	<h2>무인예약 신청을 위한 신청사항<span style="font-weight:300">을 확인하세요.</span></h2>
	</c:otherwise>
</c:choose>
	
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="bookkey"/>
<input type="hidden" name="booktype" id="booktype" value="${fn:substring(detail.WORKING_STATUS,0,2) }"/>
<!-- <input type="hidden" name="title" value="${detail.TITLE_INFO}"/> -->
<c:if test="${context_path eq 'dmsl'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
<c:if test="${context_path eq 'jungang'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
<c:if test="${context_path eq '228'}">
<input type="hidden" name="exprire_date_cnt" value="3"/>
</c:if>
<c:if test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
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
			<c:choose>
			<c:when test="${context_path eq 'dmsl'}">
			<input type="hidden" name="worker" id="worker" value="DMSL0011"/>
			</c:when>
			<c:otherwise>
			<tr>
				<th>수령장소</th>
				<td class="left">
					<form:select path="worker" style="border:1px solid #c9c9c9;border-radius:4px;height:30px">
						<c:if test="${context_path eq 'jungang'}">
						<form:option value="SUB01">반월당역 예약대출기</form:option>
						</c:if>
						<c:if test="${context_path eq '228'}">
						<form:option value="228ECOCHECK01">예약대출기</form:option> <!--DBECOBOXLIB01-->
						</c:if>
						<c:if test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english'}">
						<form:option value="DSSUB02">용산역</form:option>
						<!-- <form:option value="DSSUB01">상인역</form:option> -->
						</c:if>
					</form:select>
				</td>
			</tr>
			</c:otherwise>
			</c:choose>

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