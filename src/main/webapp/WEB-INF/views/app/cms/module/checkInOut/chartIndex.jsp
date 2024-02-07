<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/js/chart/Chart.bundle.min.js"></script>
<script type="text/javascript">
var chartGraph;
var chartLabels = [];
var chartData = [];
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
		drawGraph('bar', $('#homepageId').val(), $('input#start_date').val(), $('input#end_date').val());
	});

	$('a#excelDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'csvDownload.do').submit();
		e.preventDefault();
	});

	drawGraph('bar', $('#homepageId').val(), $('input#start_date').val(), $('input#end_date').val());

	$('a.drawGraph').on('click', function(e) {
		e.preventDefault();
		drawGraph($(this).data('type'), $('#homepageId').val(), $('input#start_date').val(), $('input#end_date').val());
	});

	$('a#statisticsSearch').on('click', function(e) {
		e.preventDefault();
		drawGraph('bar', $('#homepageId').val(), $('input#start_date').val(), $('input#end_date').val());
	});
});

function getJson(url, formData) {
	var returnData;
	$.ajax({
		type: 'POST',
		url: url,
		async: false,
		data: formData,
		success: function(response) {
			returnData = eval(response);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			returnData = null;
		}
	});

	return returnData;
}

function addComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function drawGraph(type, homepage_id, start_date, end_date, options) {

	var data = getJson('getChartData.do', {
		chart_type : type,
		homepage_id : homepage_id,
		start_date : start_date,
		end_date : end_date
	});

	chartLabels = [];
	chartData = [];
	var totalCount = 0;

	$.each(data, function(i, v) {
		if (v.result_date != undefined) {
			chartLabels.push(v.result_date);
			chartData.push(v.result_count);
			if (data.length == 1) {
				totalCount = v.result_count;
			}
		} else {
			totalCount = v.result_count;
		}
	});

	try {
		chartGraph.destroy();
	} catch (e) {
	}
	if (type == 'line') {
		drawLineChart();
	} else if (type == 'bar') {
		drawBarChart();
	} else if (type == 'horizontalBar') {
		drawHBarChart();
	} else {
		drawPieChart();
	}
}

function drawLineChart() {
	chartGraph = new Chart($('canvas#chartGraph'), {
		type: 'line',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '방문자수 통계',
	            data: chartData,
	            backgroundColor: 'rgba(255, 99, 132, 0.2)',
	            borderColor: 'rgba(255,99,132,1)',
	            lineTension: 0,
	            fill:false,
	            borderWidth: 2,
	            pointStyle: 'circles',
	            pointRadius: 2
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        },
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
				mode: 'index',
				intersect: false,
				callbacks: {
					label: function(tooltipItems, data) {
						return data.datasets[tooltipItems.datasetIndex].label+": "+addComma(tooltipItems.yLabel)+"명";
					}
				}
			}
	    }
	});
}

function drawHBarChart() {
	chartGraph = new Chart($('canvas#chartGraph'), {
		type: 'horizontalBar',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '방문자수 통계',
	            data: chartData,
	            backgroundColor: 'rgba(255, 99, 132, 0.2)',
	            borderColor: 'rgb(255,99,132)',
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }],
	            xAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        },
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
				mode: 'index',
				intersect: false,
			},
	        hover: {
				mode: 'nearest',
				intersect: true
			},
			tooltips: {
	        	bodyFontSize: 15,
	        	titleFontSize: 15,
	        	mode: 'index',
				intersect: false,
				callbacks: {
					label: function(tooltipItems, data) {
						return data.datasets[tooltipItems.datasetIndex].label+" : "+addComma(tooltipItems.xLabel)+"명";
					}
				}
			}
	    }
	});
}

function drawBarChart() {
	chartGraph = new Chart($('canvas#chartGraph'), {
		type: 'bar',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '방문자수 통계',
	            data: chartData,
	            backgroundColor: 'rgba(255, 99, 132, 0.2)',
	            borderColor: 'rgb(255,99,132)',
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        },
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
				mode: 'index',
				intersect: false,
			},
	        hover: {
				mode: 'nearest',
				intersect: true
			},
			tooltips: {
	        	bodyFontSize: 15,
	        	titleFontSize: 15,
	        	mode: 'index',
				intersect: false,
				callbacks: {
					label: function(tooltipItems, data) {
						return data.datasets[tooltipItems.datasetIndex].label+": "+addComma(tooltipItems.yLabel)+"명";
					}
				}
			}
	    }
	});
}

function drawPieChart() {
	chartGraph = new Chart($('canvas#chartGraph'), {
		type: 'pie',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '방문자수 통계',
	            fill:false,
	            data: chartData,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	            	'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ]
	        }]
	    },
	    options: {
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
	        	bodyFontSize: 15,
	        	titleFontSize: 15,
	        	callbacks: {
					label: function(tooltipItems, data) {
						return data.labels[tooltipItems.index]+" : "+addComma(data.datasets[0].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}
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
		<li><a href="/cms/module/checkInOut/indexAll.do" style="font-size: 13px;">전체 통계</a></li>
		<li><a href="/cms/module/checkInOut/chartIndex.do" class="active" style="font-size: 13px;">방문자수 통계</a></li>
		<li><a href="/cms/module/checkInOut/usageRanking.do" style="font-size: 13px;">이용순위 통계</a></li>
		<li><a href="/cms/module/checkInOut/hoursOfUse.do" style="font-size: 13px;">이용시간 통계</a></li>
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
		<ul class="float_right icon_list" >
			<li><a href="#" class="btn_graph_bar drawGraph" data-type="bar" title="막대형"></a></li>
			<li><a href="#" class="btn_graph_hbar drawGraph" data-type="horizontalBar" title="가로막대형"></a></li>
			<li><a href="#" class="btn_graph_line drawGraph" data-type="line" title="선형"></a></li>
			<li><a href="#" class="btn_graph_pie drawGraph" data-type="pie" title="파이형"></a></li>
	    </ul>
	</form:form>
</div>
<div class="alert">
	<ul>
		<li>방문자수 통계</li>
	</ul>
</div>

<div class="graphWrap">
	<div class="part1" style="width: 100%; text-align: center; height: 400px;">
		<canvas id="chartGraph"></canvas>
	</div>
</div>

<div style="clear:both">&nbsp;</div>
<br/>

<pre style="display: none;">
	<code>
		<table>
			<tbody>
				<tr class="percentTable">
					<td>{date}</td>
					<td>
						<span class="font_navy">{count}명</span>
						<span class="font_blue">({percent}%)</span>
					</td>
					<td>
						<p style="width:{percent}%"></p>
					</td>
				</tr>
			</tbody>
		</table>
	</code>
</pre>