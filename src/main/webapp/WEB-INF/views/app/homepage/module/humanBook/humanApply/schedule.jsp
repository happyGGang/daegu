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

	$('a.status_chage').on('click', function(e) {
		e.preventDefault();
		var param = 'editMode=STATUS&homepage_id='+$('#homepage_id').val() + '&human_book_idx='+$(this).data('book_idx') + '&human_apply_idx='+$(this).data('apply_idx');
		$('#dialog-1').load('status.do?'+param, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

});
</script>
<h4 class="h4">휴먼북대출스케쥴</h4>
<form:form modelAttribute="humanApply" action="schedule.do" method="POST">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
	<table class="tbl">
		<caption class="hidden">휴먼북대출스케쥴</caption>
		<thead>
			<th scope="col">열람일</th>
			<th scope="col">열람장소</th>
			<th scope="col" class="title_th">사람책</th>
			<th scope="col">신청자</th>
			<th scope="col" class="cnt_th">열람인원</th>
			<th scope="col" class="questions_th">질문사항</th>
			<th scope="col" >상태</th>
		</thead>
		<tbody>
			<c:forEach items="${humanScheduleList}" var="i">
			<tr>
				<td style="padding:10px;">${i.human_apply_hope_date}</td>
				<td style="padding:10px;">${i.human_apply_place}</td>
				<td style="padding:10px;">${i.human_book_title}</td>
				<td style="padding:10px;">${i.human_apply_name}</td>
				<td style="padding:10px;">${i.human_apply_people}</td>
				<td style="padding:10px;">${i.human_apply_content}</td>
				<td style="padding:10px;">
					<a href="#" class="status_chage" data-book_idx="${i.human_book_idx}" data-apply_idx="${i.human_apply_idx}">
					<c:choose>
						<c:when test="${i.human_apply_status eq '0'}">신청</c:when>
						<c:when test="${i.human_apply_status eq '1'}">승인</c:when>
						<c:when test="${i.human_apply_status eq '3'}">미승인</c:when>
					</c:choose>
					</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(humanScheduleList) < 1}">
			<tr>
				<td colspan="7" id="no_data" class="no_data_pc" style="padding: 15px 10px;text-align:center;">정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#humanApply"/>
		<jsp:param name="pagingUrl" value="schedule.do"/>
	</jsp:include>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="신청상태"></div>