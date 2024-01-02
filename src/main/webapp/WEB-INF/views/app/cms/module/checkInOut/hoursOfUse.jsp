<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('input#start_date').datepicker({
		minDate: '2023-09-11',
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('#searchBtn').on('click', function (e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('hoursOfUse.do', $('form#checkInOut').serialize());
	});

	$('a#excelDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'hourOfUseExcelDownload.do').submit();
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'hourOfUseCsvDownload.do').submit();
		e.preventDefault();
	});
});

</script>
<style>
	ul.icon_list{float: right;}

	ul.icon_list li {display:inline-block; margin-rigth:5px; width: 35px; height: 35px;}
	ul.icon_list li a.btn_graph_hbar {background: url(/resources/cms/img/btn_graph_hbar.png) no-repeat; width: 32px; height: 32px; float:left;}
	ul.icon_list li a.btn_graph_bar {background: url(/resources/cms/img/btn_graph_bar.png) no-repeat; width: 32px; height: 32px; float:left;}
	ul.icon_list li a.btn_graph_line {background: url(/resources/cms/img/btn_graph_line.png) no-repeat; width: 32px; height: 32px;   float:left;}
	ul.icon_list li a.btn_graph_pie {background: url(/resources/cms/img/btn_graph_pie.png) no-repeat; width: 32px; height: 32px;  float:left; }
	
	.tab{float:left; width:100%;}
	.tabnav{font-size:0; width:100%; margin-bottom: 10px; border:1px solid #ddd; border-top:0; border-right:0;}
	.tabnav li{display: inline-block; height:46px; text-align:center; border-right:1px solid #ddd;}
	.tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:3px; }
	.tabnav li a.active:before{background:#7ea21e;}
	.tabnav li a.active{border-bottom:1px solid #fff;}
	.tabnav li a{ 
		position:relative; 
		display:block; 
		background: #f8f8f8; 
		color: #000; 
		padding:0 30px; 
		line-height:46px; 
		text-decoration:none; 
		font-size:16px;
		border-top:1px solid #ddd;
	}
	.tabnav li a:hover,
	.tabnav li a.active{background:#fff; color:#7ea21e; }
	.tabcontent{padding: 20px; height:244px; border:1px solid #ddd; border-top:none;}
</style>

<div class="tab">
	<ul class="tabnav">
		<li><a href="/cms/module/checkInOut/chartIndex.do" style="font-size: 13px;">방문자수 통계</a></li>
		<li><a href="/cms/module/checkInOut/usageRanking.do" style="font-size: 13px;">이용순위 통계</a></li>
		<li><a href="/cms/module/checkInOut/hoursOfUse.do" class="active" style="font-size: 13px;">이용시간 통계</a></li>
	</ul>
</div>
		
<div class="search">
	<form:form id="checkInOut" modelAttribute="checkInOut" action="/excelDownload.do" method="post" style="display:inline-flex">
	<form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
		<label class="blind">검색</label>
		<b>
			<form:input type="text" path="start_date" class="text ui-calendar"/>
			<span id="tilde" style="font-size:12px">~</span>
			<form:input type="text" path="end_date" class="text ui-calendar"/>
		</b>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</form:form>
</div>

<table id="accessTableData" class="chartData">
<thead>
	<tr>
		<th width="200">시간</th>
		<th>방문수</th>
		<th>비율(%)</th>
		<th>비고</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="i" varStatus="status" items="${hoursOfUseList}">
		<tr>
			<td class="left">
				${i.result_date}시
			</td>
			<td>${i.result_count}</td>
			<td>
			<c:choose>
				<c:when test="${total_count == 0}"><em>(0%)</em></c:when>
				<c:otherwise>
				<em>(<fmt:formatNumber value="${i.result_count / total_count * 100}" pattern="0.00"/>%)</em>
				</c:otherwise>
			</c:choose>
			</td>
			<td></td>
		</tr>
	</c:forEach>
</tbody>
<tfoot>
	<tr>
		<th>합계</th>
		<td colspan="3">${total_count}<em>(100%)</em></td>
	</tr>
</tfoot>
</table>