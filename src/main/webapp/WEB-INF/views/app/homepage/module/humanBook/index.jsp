<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap.min.css?3.3.6"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap-multiselect.css"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/mir_home_sub_community.css" />
<script type="text/javascript">
$(function(){

	$('a#board_edit_btn').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		doGetLoad('edit.do', serializeCustom($('form#humanBook')));
	});

});
</script>
<form:form modelAttribute="humanBook" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<h4 class="h4">휴먼북 등록현황</h4>
	<table class="tbl">
		<caption class="hidden">휴먼북 등록현황</caption>
		<thead>
			<th scope="col">분류</th>
			<th scope="col">사람책 제목</th>
			<th scope="col">요일 및 시간대</th>
			<th scope="col">등록일</th>
			<th scope="col">상태</th>
			<th scope="col">비고</th>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${humanBookAll}">
				<tr>
					<td style="padding:10px;">
<%-- 						<c:forEach items="${activityCateList}" var="code"> --%>
<%-- 							<c:if test="${code.code_id eq i.activity_category}"> --%>
<%-- 							${code.code_name} --%>
<%-- 							</c:if> --%>
<%-- 						</c:forEach> --%>
						
						<c:forTokens items="${i.activity_category}" delims="," var="ac">
							<c:if test="${ac eq '1'}">기본형</c:if>
							<c:if test="${ac eq '2'}">클래식</c:if>
							<c:if test="${ac eq '3'}">뜨거운감자</c:if>
							<c:if test="${ac eq '4'}">TED</c:if>
							<c:if test="${ac eq '5'}">실속파</c:if>
							<c:if test="${ac eq '6'}">행동파</c:if>
							<c:if test="${ac eq '7'}">챌린지</c:if>
						</c:forTokens>
					</td>
					<td style="padding:10px;">${i.human_book_title}</td>
					<td style="padding:10px;">
						<c:forTokens items="${i.activity_day}" delims="," var="day">
							<c:if test="${day eq '1'}">일</c:if>
							<c:if test="${day eq '2'}">월</c:if>
							<c:if test="${day eq '3'}">화</c:if>
							<c:if test="${day eq '4'}">수</c:if>
							<c:if test="${day eq '5'}">목</c:if>
							<c:if test="${day eq '6'}">금</c:if>
							<c:if test="${day eq '7'}">토</c:if>
						</c:forTokens>
						<br>
						<c:forTokens items="${i.activity_time}" delims="," var="time">
							<c:if test="${time eq '1'}">오전(10:00~12:00)</c:if>
							<c:if test="${time eq '2'}">오후(13:00~17:00)</c:if>
							<c:if test="${time eq '3'}">저녁(19:00~22:00)</c:if>
							<br>
						</c:forTokens>
					</td>
					<td style="padding:10px;">
						<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
					</td>
					<td style="padding:10px;">
						<c:choose>
							<c:when test="${i.apply_status eq '0'}">신청</c:when>
							<c:when test="${i.apply_status eq '1'}">미승인</c:when>
							<c:when test="${i.apply_status eq '2'}">승인</c:when>
						</c:choose>
					</td>
					<td style="padding:10px;">${i.unapproved_reasons}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(humanBookAll) < 1}">
				<tr>
					<td colspan="7" id="no_data" class="no_data_pc" style="padding: 15px 10px;text-align:center;">정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

</form:form>
