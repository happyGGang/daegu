<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){

	$('input#plan_date').datepicker({
		minDate: 0
	});

	$('a#studyBtn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&plan_date='+$('input#plan_date').val();
	});

	$('button#apply-btn').on('click', function() {
		location.href = 'apply.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
	});
});
</script>
<style>
table.cal-tbl th { text-align: center; padding: 10px; font-size:15px;}
table.cal-tbl td { text-align: center; padding: 8px 0 !important;}
</style>
<form:form modelAttribute="facilityStudy">
<form:hidden id="menu_idx" path="menu_idx"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<div class="ym_btns" style="float:right;">
		<form:input path="plan_date" class="text ui-calendar new_text01"/>
		<a href="#" class="btn btn1" id="studyBtn">이동</a>
	</div>

	<div id="calendar">
		<table class="cal-tbl">
			<thead>
				<tr>
					<th>구분</th>
					<th>좌석수</th>
					<th>오전</th>
					<th>오후</th>
					<th>야간</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>스터디룸 1팀</td>
					<td>8석</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num11}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=1&study_time=1&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num11 and applicableList.num11 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num11 and applicableList.num11 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num12}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=1&study_time=2&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num12 and applicableList.num12 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num12 and applicableList.num12 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num13}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=1&study_time=3&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num13 and applicableList.num13 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num13 and applicableList.num13 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>스터디룸 2팀</td>
					<td>8석</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num21}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=2&study_time=1&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num21 and applicableList.num21 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num21 and applicableList.num21 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num22}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=2&study_time=2&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num22 and applicableList.num22 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num22 and applicableList.num22 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num23}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=2&study_time=3&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num23 and applicableList.num23 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num23 and applicableList.num23 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>스터디룸 3팀</td>
					<td>8석</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num31}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=3&study_time=1&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num31 and applicableList.num31 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num31 and applicableList.num31 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num32}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=3&study_time=2&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num32 and applicableList.num32 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num32 and applicableList.num32 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
						<c:when test="${not empty closedDay}">
						휴관
						</c:when>
						<c:when test="${empty applicableList.num33}">
						<a class="btn" href="edit.do?study_date=${facilityStudy.plan_date}&study_num=3&study_time=3&menu_idx=${facilityStudy.menu_idx}">신청</a>
						</c:when>
						<c:when test="${not empty applicableList.num33 and applicableList.num33 eq '0'}">
						대기
						</c:when>
						<c:when test="${not empty applicableList.num33 and applicableList.num33 eq '1'}">
						신청완료
						</c:when>
						</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form:form>
<div style="text-align: center; margin-top: 20px;">
	<button id="apply-btn" class="btn btn2">그룹스터디룸 신청 확인</button>
</div>