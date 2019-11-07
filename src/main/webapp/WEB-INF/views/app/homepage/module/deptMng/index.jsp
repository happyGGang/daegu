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
		var div_idx = $(this).attr('div_idx').replace('c', 'p');
		if($(this).text() == '-' && $('th.'+div_idx).attr('colspan') < 2) {
			$('th.'+div_idx).attr('rowspan', 2);
			$(this).remove();
		}
	});


	var datasource = {};
	var items = [];
	<c:forEach items="${deptList}" var="i" varStatus="status">
		var above_idx = parseInt('${i.above_idx}');
		var id = parseInt('${i.dept_idx}');

		<c:if test="${status.first}">
	        items[id] = {
	        	id: id,
	            name: '${i.dept_name}'
	        };

        datasource = items[id];
		</c:if>

		<c:if test="${!status.first}">
		if (items[above_idx]) {
	        var item = {
	        	id : id,
	            name: '${i.dept_name}'
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
<style type="text/css">
	.mid-bar {margin:60px 0px;}
	.doc-body-title h3 {font-size: 25px;padding: 20px 0;color: #333;background: none;}
.deptMng_list {width:90%; margin: auto;}
.deptMng_list .node .title{font-weight: bold;border-radius: 0px;font-size: 16px;height: 20px;padding: 5px 0px;margin: 0px;position: relative;background-color: #a8a8a8;top:2px;}
.deptMng_list .node .title.level1 {background-color: #2e629c; color: #fff;}
.deptMng_list .node .title.level2 {background-color: #ff7439; color: #fff;}
.deptMng_list .node .title.level3 {background-color: #41b903; color: #fff;}
.deptMng_list .node .title.level4 {background-color: #d9b502; color: #fff;}
.deptMng_list .node .title.level5 {background-color: #61b4db; color: #fff;}
.deptMng_list .node .title.level6 {background-color: #4b6e39; color: #fff;}
.deptMng_list .node .title.level7 {background-color: #9c5ba4; color: #fff;}
.deptMng_list .node .title.level8 {background-color: #829fd3; color: #fff;}
.deptMng_list .node .title.level9 {background-color: #fc8a8a; color: #fff;}
.deptMng_list .node .title.level10 {background-color: #00c6cf; color: #fff;}
.deptMng_list .lines .leftLine {    border-left: 1px solid #dbdbdb;}
.deptMng_list .lines .rightLine {    border-right: 1px solid #dbdbdb;}
.deptMng_list .lines .topLine {    border-top: 2px solid #dbdbdb;}
.deptMng_list .lines .downLine{background-color:#dbdbdb}
/* .deptMng_list .lines .downLine {    height: 15px;    background-color: #aeaeae;    width: 1px;} */
/* .deptMng_list .lines .topLine{border-top:1px solid #aeaeae;}
.deptMng_list .lines .leftLine{border-left:1px solid #fff;}
.deptMng_list .lines .rightLine{border-right:1px solid #fff;}
.deptMng_list .lines .leftLine.topLine {    border-left: 1px solid #aeaeae;    border-top: 1px solid #aeaeae;}
.deptMng_list .lines .rightLine.topLine {   border-right: 1px solid #aeaeae;  border-top: 1px solid #aeaeae;} */
.deptMng_list .node {    padding: 0px;   margin: 0px;}

</style>
<div class="doc-body con106" id="contentArea">
	<div class="body">
		<c:if test="${fn:contains(deptMng.chart_yn, 'Y')}">
		<div id="orgChart" class="deptMng_list">

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
					<c:forEach items="${divList}" var="i">
					<th class="div-p-${i.div_idx}" colspan="${i.col_cnt}">${i.div_name}</th>
					</c:forEach>
					<th rowspan="2">계</th>
				</tr>
				<tr class="">
					<c:forEach items="${statusList}" var="i">
					<th scope="col" class="btw" div_idx="div-c-${i.div_idx}">${i.rating}</th>
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
					<td>${i.cur_cnt}</td>
					</c:forEach>
					<td>${totalCnt.cur_cnt}</td>
				</tr>
			</tbody>
		</table>
		</c:if>
		<br><br>
		<div class="doc-body-title">
			<h3>담당 업무</h3>
		</div>
		<c:forEach items="${deptList}" var="i">
		<h3>${i.dept_name}</h3>
		<table class="center tspan" summary="${i.dept_name}의 직원현황입니다.">
			<colgroup>
				<col class="col14">
				<col class="col15" width="15%">
				<col class="col16">
				<col class="col17">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="th1">직  위(급)</th>
					<th scope="col" class="th2">성 명</th>
					<th scope="col" class="th3">담   당   업   무</th>
					<th scope="col" class="th4">전 화</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${workList}" var="j">
					<c:if test="${i.dept_idx eq j.dept_idx}">
					<tr>
						<td>${j.position}</td>
						<td>${j.worker}</td>
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
