<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/circleroom.css"/>
<script type="text/javascript">
$(document).ready(function() {
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	
	//년도 초기화 (내년 일정 까지 볼수 있게 + 1함)
	var planDate = '${circlesRoom.plan_date}'.split('-');
	$('#plan_year').append(planDate[0]);
	$('#plan_month').append(planDate[1]);

	$('a#before-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').text();
		var month = $('#plan_month').text();

		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}
		month = month < 10 ? "0"+month : month;
		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#circlesRoom')));

	});

	$('a#next-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').text();
		var month = $('#plan_month').text();

		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}

		month = month < 10 ? "0"+month : month;

		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#circlesRoom')));

	});
	
	$('a.req-circle').on('click', function(e) {
		e.preventDefault();
		$('input#visit_date').val($(this).attr('req_date'));
		doGetLoad('edit.do', serializeCustom($('#circlesRoom')));
	});
	
	$('a.req-view').on('click', function(e) {
		e.preventDefault();
		$('input#visit_date').val($(this).attr('req_date'));
		doGetLoad('view.do', serializeCustom($('#circlesRoom')));
	});
});
</script>
<c:set var="plan_date" value="${fn:split(circlesRoom.plan_date, '-')}" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="circlesRoom">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="plan_date"/>
	<form:hidden path="visit_date" value="2018-12-27"/>
	<div class="infodesk">
		<div class="monthYear" style="text-align: center;">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
				<span id="plan_year"></span>년
				<span id="plan_month"></span>월
			<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
		</div>
	</div>
</form:form>
<div class="table-wrap" id="calTable">
	<table class="type1 center">
		<colgroup>
			<col width="100px" span="7">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" style="color: red;">일요일</th>
				<th scope="col">월요일</th>
				<th scope="col">화요일</th>
				<th scope="col">수요일</th>
				<th scope="col">목요일</th>
				<th scope="col">금요일</th>
				<th scope="col" style="color: blue;">토요일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${calendarList}" var="i" varStatus="status">
			<tr>
				<c:choose>
				<c:when test="${i.sun eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top" style="color: red;">
						<p class="date">${i.sun}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.sun) < 2 ? '0' : ''}${i.sun}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.mon eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.mon}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.mon) < 2 ? '0' : ''}${i.mon}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.tue eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.tue}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.tue) < 2 ? '0' : ''}${i.tue}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.wed eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.wed}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.wed) < 2 ? '0' : ''}${i.wed}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.thu eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.thu}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.thu) < 2 ? '0' : ''}${i.thu}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.fri eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.fri}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.fri) < 2 ? '0' : ''}${i.fri}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${i.sat eq null}">
					<td class="top none"></td>
				</c:when>
				<c:otherwise>
					<td class="top">
						<p class="date">${i.sat}</p>
						<c:set var="plan_date" value="${circlesRoom.plan_date}-${fn:length(i.sat) < 2 ? '0' : ''}${i.sat}" />
						<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="circlesRoom" dayCode="2"/>
					</td>
				</c:otherwise>
				</c:choose>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>