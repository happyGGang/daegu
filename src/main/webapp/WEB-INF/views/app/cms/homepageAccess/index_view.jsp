<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/js/chart/Chart.bundle.min.js"></script>
<script type="text/javascript">
var chartGraph;
var chartLabels = [];
var chartData = [];
$(function(){

	if (new Date($('input#start_date').val()).getTime() < new Date('2019-10-01').getTime()) {
		$('input#start_date').val('2019-10-01');
		$('input#end_date').val('2019-10-01');
	}

	//달력(통계 기간 선택 오류 방지)
	$('input#start_date').datepicker({
		minDate: '2019-10-01',
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
		if (new Date($('input#start_date').val()).getTime() <= 1569801600000) {
			alert('2019-10-01 부터 조회 가능합니다.');
			$('input#start_date').focus();
			return false;
		} else {
			drawGraph('bar', $('#homepageId').val(), $('input#start_date').val(), $('input#end_date').val());
		}
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		$('#homepageName').val($('#homepageId option:selected').text());
		$('#homepageAccessSearch').attr('action', '/cms/homepageAccess/excelViewDownload2019.do');
		$('#homepageAccessSearch').submit();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#homepageName').val($('#homepageId option:selected').text());
		$('#homepageAccessSearch').attr('action', '/cms/homepageAccess/csvViewDownload2019.do');
		$('#homepageAccessSearch').submit();
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

	var data = getJson('getChartViewData.do', {
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

// 	$('div.part2 table tr.percentTable').remove();
// 	$.each(data.reverse(), function(i, v) {
// 		var tr = $('pre table tbody').html();
// 		tr = tr.replace(/{date}/gi, (v.result_date == undefined) ? '합계' : v.result_date);
// 		tr = tr.replace(/{count}/gi, addComma(v.result_count));
// 		var percent;
// 		try {
// 			percent = (v.result_count == totalCount) ? 100 : ((v.result_count / totalCount) * 100).toFixed(2);
// 		} catch (e) {
// 			percent = 100;
// 		}
// 		tr = tr.replace(/{percent}/gi, percent);
// 		if (tr.indexOf('<p></p>') > -1) {
// 			tr = tr.replace('<p></p>', '<p style="width:'+percent+'%"></p>');
// 		}
// 		$('div.part2 table').append($(tr));
// 	});
// 	chart_type = type;
// 	homepage_id = homepage_id;
// 	start_date = '2019-01-01';
// 	end_date = '2019-01-07';

// 	chartLabels = [];
// 	chartData = [];
// 	var totalCount = 100;

// 	chartLabels.push('2019-01-01');
// 	chartLabels.push('2019-01-02');
// 	chartLabels.push('2019-01-03');
// 	chartLabels.push('2019-01-04');
// 	chartLabels.push('2019-01-05');
// 	chartLabels.push('2019-01-06');
// 	chartLabels.push('2019-01-07');

// 	chartData.push(44);
// 	chartData.push(78);
// 	chartData.push(31);
// 	chartData.push(68);
// 	chartData.push(35);
// 	chartData.push(48);
// 	chartData.push(68);
// 	chartData.push(87);

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
	            label: '웹페이지 접속 횟수',
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
						return data.datasets[tooltipItems.datasetIndex].label+": "+addComma(tooltipItems.yLabel)+"회";
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
	            label: '웹페이지 접속 횟수',
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
						return data.datasets[tooltipItems.datasetIndex].label+" : "+addComma(tooltipItems.xLabel)+"회";
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
	            label: '웹페이지 접속 횟수',
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
						return data.datasets[tooltipItems.datasetIndex].label+": "+addComma(tooltipItems.yLabel)+"회";
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
	            label: '웹페이지 접속 횟수',
	            fill:false,
	            data: chartData,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
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
						return data.labels[tooltipItems.index]+" : "+addComma(data.datasets[0].data[tooltipItems.index])+"회";
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
</style>
<div class="search">
	<form:form id="homepageAccessSearch" modelAttribute="homepageAccess" action="/cms/homepageAccess/excelViewDownload.do" method="post" style="display:inline-flex">
		<form:hidden id="homepageName" path="homepage_name"/>
		<form:hidden path="year_count"/>
		<label class="blind">검색</label>
		<c:choose>
			<c:when test="${member.admin}">
				<form:select id="homepageId" path="homepage_id" class="selectmenu-search" style="width:250px">
					<option disabled >홈페이지 선택</option>
					<option value="" selected="selected">전체</option>
					<c:forEach var="i" varStatus="status" items="${homepageList}">
						<option value="${i.homepage_id}">${i.homepage_name}</option>
					</c:forEach>
				</form:select>
			</c:when>
			<c:otherwise>
				<form:hidden id="homepageId" path="homepage_id" value="${asideHomepageId}"/>
			</c:otherwise>
		</c:choose>
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
  		<li>웹페이지 접속 통계</li>
		<li>각 페이지 호출시 카운트(증가) 되는 통계</li>
		<li>2019 기능 개선 사업으로 인해 2019-10-01부터 조회 가능합니다.</li>
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
						<span class="font_navy">{count}회</span>
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

<!-- 자료 테이블 여기까지 -->