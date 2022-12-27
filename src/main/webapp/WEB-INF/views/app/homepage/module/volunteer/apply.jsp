<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {

	//신청자 수정버튼
	$('a#delete-btn').on('click', function(event) {
		if(confirm("해당 신청내역을 삭제 하시겠습니까?\n삭제된 데이터는 복구가 불가합니다.")) {
			$.ajax({
				url : '/${homepage.context_path}/module/volunteer/save.do?editMode=DELETE&apply_idx=' + $(this).attr("keyValue") + '&homepage_id=' + $('#homepage_id').val(),
				async : false,
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
				}
			});
		}
	});

	<c:if test="${fn:length(subHomepageList) > 0}">
	var a = '${fn:escapeXml(apply.homepage_id)}';
	$('div.tab_menu a[data-hid="'+a+'"]').parent().addClass('active');

	$('div.tab_menu a').on('click', function(e) {
		e.preventDefault();
		var hid = $(this).data('hid');
		$('input#homepage_id').val(hid);
		doGetLoad('apply.do', serializeCustom($('#applyEdit')));
	});
	</c:if>


});
</script>
<style>
	table tbody td{padding:10px 5px;}
</style>
<form:form modelAttribute="apply" id="applyEdit" action="/${homepage.context_path}/module/volunteer/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="apply_idx"/>
<form:hidden path="pageType"/>
<form:hidden path="menu_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<c:if test="${fn:length(subHomepageList) > 0}">
	<div class="tab_menu on">
		<ul class="no${fn:length(subHomepageList)}">
			<c:forEach items="${subHomepageList}" var="i" varStatus="status">
				<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="mg30t"></div>
</c:if>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="*"/>
			<col width="12%"/>
			<col width="15%"/>
			<col width="12%"/>
			<col width="11%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<thead>
			<tr>
				<th>신청자 성명</th>
				<th>신청자 전화번호</th>
				<th>방문 일자</th>
				<th>이용 시간</th>
				<th>방문 인원</th>
				<th>승인 여부</th>
				<th>신청</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${applyList}">
				<tr>
					<td>${i.applicant_name}</td>
					<td>${i.applicant_tel}</td>
					<td>${i.start_date}</td>
					<td>
						<c:choose>
							<c:when test="${hompage_id ne 'h50' }">
								${i.start_time} ~ ${i.end_time }
							</c:when>
							<c:otherwise>
								${i.use_time }							
							</c:otherwise>
						</c:choose>
					</td>
					<td>${i.personnel}</td>
					<td>
						<c:set var="apply_state" value="${i.apply_state}" />
						<c:choose>
						    <c:when test="${apply_state eq '3'}">
						        승인
						    </c:when>
						    <c:when test="${apply_state eq '2'}">
						        불가
						    </c:when>
						    <c:otherwise>
						        대기
						    </c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:if test="${apply_state eq '3'}">
							취소불가
						</c:if>
						<c:if test="${apply_state ne '3'}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.apply_idx}">신청취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(applyList) < 1}">
				<tr>
					<td colspan="8">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
</form:form>