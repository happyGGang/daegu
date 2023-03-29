<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function(e) {
		e.preventDefault();

		<c:forEach var="i" items="${termsList}" varStatus="status" step="1">
		<c:if test="${fn:contains(untactBookSetting.terms, i.terms_idx)}">
		if ($("input:checkbox[id='terms_${i.terms_idx}']").is(":checked") == false) {
			alert("${i.title}을(를) 동의하셔야 대출하실 수 있습니다.");
			return;
		}
		</c:if>
		</c:forEach>

		if (!confirm('비대면 도서대출 예약 신청을 하시겠습니까?\n도서연체시 대출불가')) {
			return false;
		}

		if (doAjaxPost($('form#librarySearch'))) {
			history.back();
		}
	});

});
</script>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="now_date" value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>

<div id="contents-title">
	<h2>비대면 도서대출 예약 신청을 위한 신청사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<br>
<form:form modelAttribute="librarySearch" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="bookkey"/>
<form:hidden path="homepage_id"/>
<form:hidden path="book_isbn" value="${detail.ISBN}"/>
<form:hidden path="reg_no" value="${detail.REG_NO}"/>
<form:hidden path="shelf_loc_name" value="${detail.SHELF_LOC_NAME}"/>
<form:hidden path="call_no" value="${detail.CALL_NO}"/>
<input type="hidden" name="booktype" id="booktype" value="${fn:substring(detail.WORKING_STATUS,0,2) }"/>

<div>
	<c:forEach var="i" items="${termsList}" varStatus="status" step="1">
		<c:if test="${fn:contains(untactBookSetting.terms, i.terms_idx)}">
			<h4>${i.title}</h4>
			<div class="ui-state-default" style="padding: 20px;">
				${i.contents}
			</div>
			<div style="text-align: right; margin: 16px;">
				<input type="checkbox" name="terms_${i.terms_idx}" id="terms_${i.terms_idx}" >
				<label for="terms_${i.terms_idx}">${i.title} 동의[필수]</label>
			</div>
		</c:if>
	</c:forEach>
</div>
<br>
<div class="delibery_info">

<!-- 	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div> -->
	<table class="table_01">
		<colgroup>
			<col width="10%" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>신청인</th>
				<td class="left">${sessionScope.member.member_name}</td>
			</tr>
			<tr>
				<th>신청일</th>
				<td class="left"><form:hidden path="request_date" value="${now_date}"/>${now_date}</td>
			</tr>
			 <tr>
				<th>도서명</th>
				<td class="left"><form:hidden path="book_name" value="${detail.TITLE_INFO}"/>${detail.TITLE_INFO}</td>
			 </tr>
			 <tr>
				<th>등록번호</th>
				<td class="left">${detail.REG_NO}</td>
			 </tr>
			 <tr>
				<th>이용안내</th>
				<td class="left">
					<c:choose>
						<c:when test="${homepage.context_path eq 'suseong'}">
							<a href="/suseong/html.do?menu_idx=187" class="btn btn2" target="_blank"><span>무인예약대출서비스 이용방법</span></a>
						</c:when>
						<c:otherwise>
							<a href="/bukgs/html.do?menu_idx=136" class="btn btn2" target="_blank"><span>무인예약대출서비스 이용방법</span></a>
						</c:otherwise>
					</c:choose>
				</td>
			 </tr>
		</tbody>
	</table>

	<div id="" class="" style="text-align: center; padding-top: 15px;">
		<p style="color: red;font-weight: bold;">* 도서연체중에는 비대면 도서대출 예약 불가 (본인 대출상태 확인필요)</p>
	</div>

	<div class="btnArea" style="text-align: center; padding-top:5px;">
		<a href="#" id="save-btn" class="btn btn03">확인</a>
		<a href="javascript:history.back();" class="btn btn02">취소</a>
	</div>
</div>
</form:form>