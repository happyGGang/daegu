<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(function(){

	$('a.cancel-btn').on('click', function(e) {
		e.preventDefault();
		$('input#human_book_idx').val($(this).data('book_idx'));
		$('input#human_apply_idx').val($(this).data('apply_idx'));

		if(confirm('선택하신 휴먼책 신청 취소하시겠습니까?')) {
			if(doAjaxPost($('form#humanApplyCancel'))) {
				location.reload();
			}
		}
	});

});
</script>
<form:form modelAttribute="humanApply" id="humanApplyCancel" action="save.do" method="POST">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode" value="APPLY_CANCEL"/>
<form:hidden path="human_book_idx"/>
<form:hidden path="human_apply_idx"/>
</form:form>

<form:form modelAttribute="humanApply" action="index.do" method="POST">
<form:hidden path="menu_idx"/>
<h4 class="h4">대출 현황 및 이력</h4>
	<table class="tbl">
		<caption class="hidden">대출이력 목록</caption>
		<thead>
			<th scope="col">분류</th>
			<th scope="col" class="title">사람책 제목</th>
			<th scope="col">장소</th>
			<th scope="col">반납/취소일</th>
			<th scope="col">신청상태</th>
			<th scope="col">비고</th>
			<th scope="col">기능</th>
		</thead>
		<tbody>
			<c:forEach items="${humanApplyList}" var="i">
			<tr>
				<td style="padding:10px;">
					<c:forEach items="${activityCateList}" var="ac">
						<c:if test="${ac.code_id eq i.activity_category}">
						${ac.code_name}
						</c:if>
					</c:forEach>
				</td>
				<td style="padding:10px;">${i.human_book_title}</td>
				<td style="padding:10px;">${i.human_apply_place}</td>
				<td style="padding:10px;">${i.human_return_date}</td>
				<td style="padding:10px;">
					<c:choose>
						<c:when test="${i.human_apply_status eq '0'}">신청</c:when>
						<c:when test="${i.human_apply_status eq '1'}">승인</c:when>
						<c:when test="${i.human_apply_status eq '2'}">취소</c:when>
						<c:when test="${i.human_apply_status eq '3'}">미승인</c:when>
					</c:choose>
				</td>
				<td style="padding:10px;">${i.unapproved_reasons}</td>
				<td style="padding:10px;">
					<c:if test="${i.human_apply_status eq '0'}">
					<a href="#" class="btn cancel-btn" data-book_idx="${i.human_book_idx}" data-apply_idx="${i.human_apply_idx}">신청취소</a>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(humanApplyList) < 1}">
				<tr>
					<td colspan="7" id="no_data" class="no_data_pc" style="padding: 15px 10px;text-align:center;">정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#humanApply"/>
	</jsp:include>
</form:form>