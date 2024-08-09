<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/orgChart/css/jquery.orgchart.css"/>
<script type="text/javascript" src="/resources/common/orgChart/js/jquery.orgchart.js"></script>
<script type="text/javascript">

$(function() {
	$('table.tspan').rowspan(0);

	$('th.btw').each(function() {
		var div_idx = $(this).attr('division_idx').replace('c', 'p');
		if($(this).text() == '-' && $('th.'+div_idx).attr('colspan') < 2) {
			$('th.'+div_idx).attr('rowspan', 2);
			$(this).remove();
		}
	});


	<c:if test="${fn:contains(organization.chart_yn, 'Y')}">
	var datasource = {};
	var items = [];
	<c:forEach items="${organizationList}" var="i" varStatus="status">
		var above_idx = parseInt('${i.above_idx}');
		var id = parseInt('${i.organization_idx}');

		<c:if test="${status.first}">
	        items[id] = {
	        	id: id,
	            name: '${i.organization_name}'
	        };

        datasource = items[id];
		</c:if>

		<c:if test="${!status.first}">
		if (items[above_idx]) {
	        var item = {
	        	id : id,
	            name: '${i.organization_name}'
	        };

	        if (!items[above_idx].children) {
	            items[above_idx].children = [];
	        }

	        items[above_idx].children[items[above_idx].children.length] = item;
	        items[id] = item;
	    }
		</c:if>
	</c:forEach>

	$('div#orgChart').orgchart({
		data : datasource
	});
	</c:if>
});

$.fn.rowspan = function(colIdx, isStats) {
	return this.each(function() {
		var that;
		$('tr', this).each(function(row) {
			$('td', this).eq(colIdx).each(function(col) {
				if($(this).html() == $(that).html()) {
					rowspan = $(that).attr('rowspan') || 1;
					rowspan = Number(rowspan)+1;

					$(that).attr('rowspan', rowspan);

					$(this).hide();
				} else {
					that = this;
				}

				that = (that == null) ? this : that;
			});
		});
	});
}
</script>
<link rel="stylesheet" href="/resources/common/css/organization.css" />

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="doc-body con106" id="contentArea">
	<div class="body">
		<c:if test="${fn:contains(organization.chart_yn, 'Y')}">
		<div id="orgChart" class="organization_list">

		</div>
		</c:if>

		<c:if test="${fn:length(statusList) > 0}">
		<div class="doc-body-title">
			<h3>직원 현황</h3>
		</div>
		<table class="center status-tbl">
			<thead>
				<tr>
					<th rowspan="2">구분</th>
					<c:forEach items="${divisionList}" var="i">
					<th class="div-p-${i.division_idx}" colspan="${i.column_cnt}">${i.division_name}</th>
					</c:forEach>
					<th rowspan="2">계</th>
				</tr>
				<tr class="">
					<c:forEach items="${statusList}" var="i">
					<th scope="col" class="btw" division_idx="div-c-${i.division_idx}">${i.rating}</th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>정원</th>
					<c:forEach items="${statusList}" var="i">
					<td>${i.max_cnt}</td>
					</c:forEach>
					<td>${totalCnt.max_cnt}</td>
				</tr>
				<tr>
					<th>현원</th>
					<c:forEach items="${statusList}" var="i">
					<td>${i.current_cnt}</td>
					</c:forEach>
					<td>${totalCnt.current_cnt}</td>
				</tr>
			</tbody>
		</table>
		</c:if>

		<div class="doc-body-title">
			<h3>담당 업무</h3>
		</div>
		<c:forEach items="${organizationList}" var="i">
		<h3>${i.organization_name}</h3>
		<table class="center tspan" summary="${i.organization_name}의 직원현황입니다.">
			<colgroup>
				<col class="col14" width="20%">
				<c:choose>
					<c:when test="${(i.homepage_id == 'h10' || i.homepage_id == 'h4') && i.organization_name == '관장'}">
					</c:when>
					<c:otherwise>
						<col class="col15" width="15%">
					</c:otherwise>
				</c:choose>
				<col class="col16">
				<col class="col17" width="15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="th1">직  위(급)</th>
					<c:choose>
						<c:when test="${(i.homepage_id == 'h10' || i.homepage_id == 'h4') && i.organization_name == '관장'}">
						</c:when>
						<c:otherwise>
							<th scope="col" class="th2">성 명</th>
						</c:otherwise>
					</c:choose>
					<th scope="col" class="th3">담   당   업   무</th>
					<th scope="col" class="th4">전 화</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${workList}" var="j">
					<c:if test="${i.organization_idx eq j.organization_idx}">
					<tr>
						<td>${j.position}</td>
						<c:choose>
							<c:when test="${(i.homepage_id == 'h10' || i.homepage_id == 'h4') && i.organization_name == '관장'}">
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${i.homepage_id == 'h4' || i.homepage_id == 'h7'}">
										<td>${j.worker}</td>
									</c:when>
									<c:otherwise>
										<td>
											<c:if test="${fn:length(j.worker) > 1}">
												${fn:substring(j.worker,0,1)}**
											</c:if>
										</td>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<td class="left">${j.work_info}</td>
						<td>${j.phone}</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<br><br>
		</c:forEach>

	</div>
</div>
