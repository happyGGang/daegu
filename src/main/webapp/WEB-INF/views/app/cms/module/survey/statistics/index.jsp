<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>

<script type="text/javascript" src="/resources/cms/js/chart/Chart.bundle.min.js"></script>
<script type="text/javascript" src="/resources/cms/js/html2canvas.js"></script>
<script type="text/javascript" src="/resources/cms/js/FileSaver.min.js"></script>

<script>
var statistics = [];	
var chartGraph = [];
var chartLabels = [];
var label = [];
var bgcolor = [];
var bccolor = []; 
var chartData = [];
var modifyList = {};
modifyList.data = {};
modifyList.data.quest_idx = [];
modifyList.data.chartLabels = [];
modifyList.data.chartData = [];
modifyList.data.label = [];

$(document).ready(function() {	
	
	
	initStatisticsValue();
	
	drawOneGraph(null, 'bar');
	
	drawMatrixGraph(null, 'bar');
	
	
	$('a.close').on('click', function(e) {
		e.preventDefault();
		window.close();
	});
	$('a.print').on('click', function(e) {
		e.preventDefault();
		window.print();
	});
	
	$('a.drawGraph').on('click', function(e){
		e.preventDefault();
		
		var index = $(this).attr("index");
		var type = $(this).attr("data-type");
		var mode = $(this).attr("mode");
		var quest_idx = $(this).attr("quest_idx");
		
		if($(this).attr("modify") != "ture"){
			if(mode == 'ONE' || mode == 'MULTI'){
				drawOneGraph(index,type);			
			} else if (mode == 'MATRIX') {
				drawMatrixGraph(index,type);
			}
		} else {
			var indexOf = modifyList.data.quest_idx.lastIndexOf(Number(quest_idx));
			chartLabels = modifyList.data.chartLabels[indexOf];
			chartData = modifyList.data.chartData[indexOf];
			label = modifyList.data.label[indexOf];
			
			if(mode == 'ONE' || mode == 'MULTI'){
				drawOneGraph2(quest_idx, type,mode,chartLabels,chartData);
			} else if (mode == 'MATRIX'){
				drawMatrixGraph2(quest_idx,type,chartLabels,chartData);
			}
			
		}
	});
	

	$('a.viewDescription').on('click', function(e) {
		e.preventDefault();
		var param = 'survey_idx='+$(this).attr('surveyIdx'); 
		param += '&quest_idx='+$(this).attr('questIdx'); 
		param += '&homepage_id=${param.homepage_id}'; 
		window.open('/cms/survey/surveyStatistics/detailView.do?'+param, 'survey_quest_description', 'width=1200, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
	
	$('a#dialog1').on('click', function(e) {
		e.preventDefault();

		var answer_count = "${answer_count}";
			
		if($('#change_user_count').val() != ''){
			answer_count = $('#change_user_count').val();
		}

		$('div#dialog-1').load('answerEdit.do?answer_count='+answer_count+"&editMode=answerModify", function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a#dialog2').on('click', function(e) {
		e.preventDefault();
		
		var answer_count = "${answer_count}";
		
		if($('#change_user_count').val() != ''){
			answer_count = $('#change_user_count').val();
		}
		var	survey_idx = $(this).attr("survey_idx");
		var	quest_idx = $(this).attr("quest_idx");
		var quest_type = $(this).attr("quest_type");
		var modify = $(this).attr("modify");
		var quest_detail_free_yn = $(this).attr("quest_detail_free_yn");
		
		
		$('div#dialog-1').load('questEdit.do?answer_count='+answer_count+"&editMode=questModify&survey_idx="+survey_idx+"&quest_idx="+quest_idx+"&quest_type="+quest_type+"&quest_detail_free_yn="+quest_detail_free_yn, function( response, status, xhr ) {
			
			$('#dialog-1').dialog('open');
		});
	
	});
	
	$('a#captureBtn').on('click', function(e) {
		e.preventDefault();
		var index = $(this).attr("index");
		
		$("#quest_idx").val($(this).attr("quest_idx"));
		
		$('#quest_content').val($(this).attr("quest_content"));
		
		var background = document.getElementById('chartGraphBox'+index).style.background;
		
	    if(background == "") {
	        document.getElementById('chartGraphBox'+index).style.background = "#fff"; 
	    }
	   
	    var agent = navigator.userAgent.toLowerCase();
	    
	    var scrollY;

	    if (agent.indexOf("chrome") != -1) {
	    	scrollY = window.scrollY; 
	    } else{
	    	scrollY = document.documentElement.scrollTop;
	    }
	    
        html2canvas($('div#chartGraphBox'+index), {
            onrendered: function(canvas) {
            	window.scrollTo(0,scrollY);
            	
                if (typeof FlashCanvas != "undefined") {
                    FlashCanvas.initElement(canvas);
                }
                var image = canvas.toDataURL("image/png"); 
                $("#imgData").val(image);
                $("#imgForm").submit();
            }
        });
		
	});
	
	function initStatisticsValue() {
		
		<c:forEach var="i" varStatus="status" items="${statistics}">
			<c:choose>
				<c:when test="${i.quest_type eq 'ONE'}">
					<c:set var="ratio" value="0"></c:set>
					<c:set var="totalCount" value="0"></c:set>
					<c:set var="total_cnt" value="0"></c:set>
					var statisticsObj = {};
					statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
					statisticsObj.index = '${status.index}';
					statisticsObj.quest_idx = '${i.quest_idx}';
					statisticsObj.type  = "ONE";
					statisticsObj.data 	= {};
					statisticsObj.data.title 	= [];
					statisticsObj.data.series 	= [];
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						statisticsObj.data.title.push('${tag:escapeJS(j.quest_detail_title)}');// title = ${j.quest_detail_title}
						statisticsObj.data.series.push('${j.cnt}');// value = ${j.cnt}
						statisticsObj.index2 = '${status2.count}';
						<c:set var="ratio" value="${ratio + j.ratio}"></c:set>
						<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
						<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						statisticsObj.data.title.push('기타'); 
						statisticsObj.data.series.push('${total_cnt-totalCount}');
						statisticsObj.index2++;
					</c:if>					
					statistics[statisticsObj.index] = statisticsObj;
				</c:when>
				<c:when test="${i.quest_type eq 'MULTI'}">
					<c:set var="ratio" value="0"></c:set>
					<c:set var="totalCount" value="0"></c:set>
					<c:set var="total_cnt" value="0"></c:set>
					var statisticsObj = {};
						statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
						statisticsObj.index = '${status.index}';
						statisticsObj.quest_idx = '${i.quest_idx}';
						statisticsObj.type  = "MULTI";
						statisticsObj.data 	= {};
						statisticsObj.data.title 	= [];
						statisticsObj.data.series 	= [];
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						statisticsObj.data.title.push('${tag:escapeJS(j.quest_detail_title)}');
						statisticsObj.data.series.push('${j.cnt}');
						statisticsObj.index2 = '${status2.count}';
						<c:set var="ratio" value="${ratio + j.ratio}"></c:set>
						<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
						<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
					</c:forEach>
						
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						statisticsObj.data.title.push('기타'); 
						statisticsObj.data.series.push('${total_cnt-totalCount}');
						statisticsObj.index2++;
					</c:if>
					statistics[statisticsObj.index] = statisticsObj; 
				</c:when>
				<c:when test="${i.quest_type eq 'MATRIX'}">
					var statisticsObj = {};
					statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
					statisticsObj.index = '${status.index}';
					statisticsObj.quest_idx = '${i.quest_idx}';
					statisticsObj.type  = "MATRIX";
					statisticsObj.data 	= {};
					statisticsObj.data.title 	= [];
					statisticsObj.data.subTitle 	= [];
					statisticsObj.data.series 	= [];					
					<c:forEach var="j" varStatus="status_j" items="${i.quest_detail_list}">
						statisticsObj.data.title.push('${tag:escapeJS(j.quest_detail_title)}');						
					</c:forEach>
					
					<c:forEach var="j" varStatus="status_j" items="${i.quest_matrix_list}">
						statisticsObj.data.subTitle.push('${tag:escapeJS(j.matrix_title)}');
						statisticsObj.index2 = '${status_j.index}';						
						<c:forEach var="k" varStatus="status_k" items="${j.statisticsList}">
							statisticsObj.data.series.push('${k.cnt}');						
							statisticsObj.index3 = '${status_k.index}';
						</c:forEach>
					</c:forEach>
					statistics[statisticsObj.index] = statisticsObj;
				</c:when>
				<c:when test="${i.quest_type eq 'DESCRIPTION'}">
					var statisticsObj = {};
					statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
					statisticsObj.index = '${status.index}';
					statisticsObj.type  = "DESCRIPTION";
					statisticsObj.data 	= {};
					statisticsObj.data.title 	= [];
					statisticsObj.data.subTitle 	= [];
					statisticsObj.data.series 	= [];				
					statistics[statisticsObj.index] = statisticsObj;
				</c:when>
				<c:when test="${i.quest_type eq 'COMMENT'}">
					var statisticsObj = {};
					statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
					statisticsObj.index = '${status.index}';
					statisticsObj.type  = "COMMENT";
					statisticsObj.data 	= {};
					statisticsObj.data.title 	= [];
					statisticsObj.data.subTitle 	= [];
					statisticsObj.data.series 	= [];				
					statistics[statisticsObj.index] = statisticsObj;
				</c:when>	
				<c:when test="${i.quest_type eq 'IMAGE'}">
					var statisticsObj = {};
					statisticsObj.title = '${tag:escapeJS(i.quest_content)}';
					statisticsObj.index = '${status.index}';
					statisticsObj.type  = "IMAGE";
					statisticsObj.data 	= {};
					statisticsObj.data.title 	= [];
					statisticsObj.data.subTitle 	= [];
					statisticsObj.data.series 	= [];				
					statistics[statisticsObj.index] = statisticsObj;
				</c:when>	
			</c:choose>
		</c:forEach>
	}
	
});



function addComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



function drawOneGraph(index,type,mode) {
	chartLabels = [];
	chartData = [];
	title = [];

	// i는 질문, J 항목
	for(var i = 0; i < statistics.length; i++) {
		
		var a = (index != null) ? index : i;
		
		var quest_idx = statistics[a].quest_idx;
		
		if (Array.isArray(chartLabels) && Array.isArray(chartData)) {
			chartLabels = [];
			chartData = [];
		}
		
		if(statistics[i].type != "MATRIX" && statistics[i].type != "DESCRIPTION") {
			
			for(var j = 0; j < Number(statistics[a].index2); j++) {
				
				if (statistics[a].index2 > 3 && statistics[a].index2 < 6) {
					
					if (statistics[a].data.title[j].length > 7) {
						chartLabels.push(statistics[a].data.title[j].trim().substring(0, 7)+"..."+"("+Number(statistics[a].data.series[j])+"명)");
					} else {
						chartLabels.push(statistics[a].data.title[j].trim()+"("+Number(statistics[a].data.series[j])+"명)");
					}
					
				} else if (statistics[a].index2 > 5 && statistics[a].index2 < 10)  {
					
					if (statistics[a].data.title[j].length > 3) {
						chartLabels.push(statistics[a].data.title[j].trim().substring(0, 2)+"..."+"("+Number(statistics[a].data.series[j])+"명)");
					} else {
						chartLabels.push(statistics[a].data.title[j].trim()+"("+Number(statistics[a].data.series[j])+"명)");
					}
					
				} else if (statistics[a].index2 >= 10) {
					if (statistics[a].data.title[j].length >= 2) {
						chartLabels.push(statistics[a].data.title[j].trim().substring(0, 1)+"..."+"("+Number(statistics[a].data.series[j])+"명)");
					} else {
						chartLabels.push(statistics[a].data.title[j].trim()+"("+Number(statistics[a].data.series[j])+"명)");
					}
					
				} else {
					chartLabels.push(statistics[a].data.title[j].trim()+"("+Number(statistics[a].data.series[j])+"명)");
				}
				chartData.push(Number(statistics[a].data.series[j]));
				
				try {
					chartGraph[quest_idx].destroy();
				} catch (e) {
				}
				
				if (type == 'line') {
					drawLineChart(quest_idx);
				} else if (type == 'bar') {
					drawBarChart(quest_idx);
				} else if (type == 'horizontalBar') {
					drawHbarChart(quest_idx); 
				} else {
					drawPieChart(quest_idx);
				}
			}
		}
	}
}

function drawMatrixGraph(index,type,mode) {
	chartLabels = [];
	chartData = [];
	label = [];
	// 5개씩 50개
	bgcolor = [
		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
		];


	bccolor = [
		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'];
	
	// i는 질문, J 항목
	for(var i = 0; i < statistics.length; i++) {
		
		var a = (index != null) ? index : i;
		
		var quest_idx = statistics[a].quest_idx;
		
		if (Array.isArray(chartLabels) && Array.isArray(chartData) && Array.isArray(label)) {
			chartLabels = [];
			chartData = [];
			label = [];
		}
		
		if(statistics[i].type == "MATRIX"){
			var x = 0;

			for (var j = 0; j < statistics[a].data.title.length; j++){
				chartLabels.push(statistics[a].data.title[j]);
				
			}

			for(var k = 0; k <= Number(statistics[a].index2); k++) {
				var row = [];
											
				label.push(statistics[a].data.subTitle[k]);
				for(var l = 0; l <= Number(statistics[a].index3); l++) {
					row.push(Number(statistics[a].data.series[x]));
					x++;
				}
				chartData.push(row);
				
				try {
					chartGraph[quest_idx].destroy();
				} catch (e) {
				}

				if (type == 'line') {
					drawMatrixLineChart(quest_idx,chartLabels,chartData);
				} else if (type == 'bar') {
					drawMatrixBarChart(quest_idx,chartLabels,chartData);
				} else if (type == 'horizontalBar') {
					drawMatrixHbarChart(quest_idx,chartLabels,chartData);
				} else {
					drawMatrixPieChart(quest_idx,chartLabels,chartData);
				}
				
			}	

		}
	}
}
function drawMatrixGraph2(index,type,chartLabels,chartData,label) {
	
	// 5개씩 50개
	bgcolor = [
		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
		];


	bccolor = [
		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'];
	// i는 질문, J 항목

	for(var i = 0; i < statistics.length; i++) {
		
		var a = (index != null) ? index : i;
		
		if(statistics[i].type == "MATRIX"){
			var x = 0;
			
			for(var k = 0; k <= Number(statistics[i].index2); k++) {
				
				try {
					chartGraph[index].destroy();
				} catch (e) {
				}

				if (type == 'line') {
					drawMatrixLineChart(index,chartLabels,chartData,label);
				} else if (type == 'bar') {
					drawMatrixBarChart(index,chartLabels,chartData,label);
				} else if (type == 'horizontalBar') {
					drawMatrixHbarChart(index,chartLabels,chartData);
				} else {
					drawMatrixPieChart(index,chartLabels,chartData,label);
				}
				
			}	

		}
	}
}
function drawOneGraph2(index,type,mode,chartLabels,chartData) {
	chartLabels = [];
	chartData = [];
	
	// i는 질문, J 항목
	for(var i = 0; i < statistics.length; i++) {
		
		var a = (index != null) ? index : i;
		
		if(statistics[i].type == "ONE" || statistics[i].type == "MULTI") {
			for(var j = 0; j < Number(statistics[i].index2); j++) {
				
				try {
					chartGraph[index].destroy();
				} catch (e) {
				}
				
				if (type == 'line') {
					drawLineChart(index);
				} else if (type == 'bar') {
					drawBarChart(index);
				} else if (type == 'horizontalBar') {
					drawHbarChart(index); 
				} else {
					drawPieChart(index);
				}
			}
		}
	}
}

function drawHbarChart(index) {
	
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'horizontalBar',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '응답자 인원',
	            data: chartData,
	         	// 5개씩 50개
	        	backgroundColor : [
	        		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
	        		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
	        		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
	        		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
	        		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
	        		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
	        		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
	        		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
	        		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
	        		],
	       		borderColor : [
	        		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
	        		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
	        		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
	        		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
	        		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
	        		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
	        		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
	        		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
	        		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'
	        		],
	            borderWidth: 2
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
			            beginAtZero: true
			        }
			    }]
	        },
	        legend: {
	        	display: false
	         },
	        maintainAspectRatio: false,
	        responsive: true,
	        hover: {
				mode: 'dataset',
				intersect: true
			},
			showValue:{
                fontStyle: 'Helvetica', //Default Arial
                fontSize: 10
       		},			
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}


function drawBarChart(index) {
	
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'bar',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '응답자 인원',
	            data: chartData,
	         // 5개씩 50개
	        	backgroundColor : [
	        		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
	        		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
	        		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
	        		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
	        		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
	        		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
	        		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
	        		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
	        		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
	        		],
	       		borderColor : [
	        		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
	        		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
	        		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
	        		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
	        		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
	        		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
	        		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
	        		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
	        		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'
	        		],
	            borderWidth: 2
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
			            beginAtZero: true
			        }
			    }]
	        },
	        legend: {
	        	display: false
	         },
	        maintainAspectRatio: false,
	        responsive: true,
	        hover: {
				mode: 'dataset',
				intersect: true
			},
			showValue:{
                fontStyle: 'Helvetica', //Default Arial
                fontSize: 10
       		},			
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}

function drawLineChart(index) {
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'line',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '응답자 인원',
	            data: chartData,
	            backgroundColor: 'rgba(255, 99, 132, 0.2)',
	            borderColor: 'rgba(255,99,132,1)',
	            lineTension: 0,
	            fill:false,
	            borderWidth: 2,
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
	        legend: {
	        	display: false
	         },
	        maintainAspectRatio: false,
	        responsive: true,
	        hover: {
				mode: 'dataset',
				intersect: true
			},
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}

function drawMatrixHbarChart(index,chartLabels,chartData) {
	var data = [];
	for(var n = 0; n < chartData.length; n++){
		data.push(
				{
				   label: label[n],
		           data: chartData[n],
		           backgroundColor: bgcolor[n],
		           borderColor: bccolor[n],
		           lineTension: 0,
		           fill:false,
		           borderWidth: 1,
		           pointStyle: 'circles',
		           pointRadius: 1
		         }
				);
	}
	
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'horizontalBar',
		data: {
	        labels: chartLabels,
	        datasets: data
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
			            beginAtZero: true
			        }
			    }]
	        },
	        legend: {
	            position: 'bottom'
	         },
	        maintainAspectRatio: false,
	        responsive: true,
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
	}

function drawMatrixBarChart(index,chartLabels,chartData) {
	var data = [];
	for(var n = 0; n < chartData.length; n++){
		data.push(
				{
				   label: label[n],
		           data: chartData[n],
		           backgroundColor: bgcolor[n],
		           borderColor: bccolor[n],
		           lineTension: 0,
		           fill:false,
		           borderWidth: 1,
		           pointStyle: 'circles',
		           pointRadius: 1
		         }
				);
	}
	
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'bar',
		data: {
	        labels: chartLabels,
	        datasets: data
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
			            beginAtZero: true
			        }
			    }]
	        },
	        legend: {
	            position: 'bottom'
	         },
	        maintainAspectRatio: false,
	        responsive: true,
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
	}

function drawMatrixLineChart(index,chartLabels,chartData) {
	var data = [];
	for(var n = 0; n < chartData.length; n++){
		data.push(
				{
				   label: label[n],
		           data: chartData[n],
		           backgroundColor: bgcolor[n],
		           borderColor: bccolor[n],
		           lineTension: 0,
		           fill:false,
		           borderWidth: 1,
		           pointStyle: 'circles',
		           pointRadius: 1
		         }
				);
	}
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'line',
		data: {
	        labels: chartLabels,
	        datasets: data
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        },
	        legend: {
	            position: 'bottom'
	         },
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+":"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}
function drawMatrixPieChart(index,chartLabels,chartData) {
	var data = [];

	for(var n = 0; n < chartData.length; n++){
		data.push(
				{
				    label: label[n],
		            data: chartData[n],
		        	// 5개씩 50개
					backgroundColor : [
		        		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
		        		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
		        		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
		        		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
		        		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
		        		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
		        		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
		        		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
		        		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
		        		],
		       		borderColor : [
		        		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
		        		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
		        		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
		        		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
		        		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
		        		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
		        		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
		        		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
		        		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'
		        		]
		         }
				);
	}
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'pie',
		data: {
	        labels: chartLabels,
	        datasets: data
	    },
	    options: {
	    	legend: {
	            position: 'bottom'
	         },
	        maintainAspectRatio: false,
	        responsive: true,
	        tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+": ("+data.labels[tooltipItems.index] + ")"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}

function drawPieChart(index) {
	chartGraph[index] = new Chart($('canvas#chartGraph'+index), {
		type: 'pie',
		data: {
	        labels: chartLabels,
	        datasets: [{
	            label: '응답자 인원',
	            data: chartData,
	         // 5개씩 50개
	        	backgroundColor : [
	        		'rgba(255, 99, 132, 0.2)',	'rgba(54, 162, 235, 0.2)', 	'rgba(255, 206, 86, 0.2)', 	'rgba(75, 192, 192, 0.2)', 	'rgba(153, 102, 255, 0.2)',
	        		'rgba(255, 159, 64, 0.2)',	'rgba(173, 116, 69, 0.2)',	'rgba(168, 74, 92, 0.2)', 	'rgba(136, 56, 45, 0.2)' ,	'rgba(66, 66, 104, 0.2)',
	        		'rgba(20, 49, 61, 0.2)',	'rgba(150, 100, 143, 0.2)',	'rgba(051, 000, 255, 0.2)',	'rgba(051, 000, 000, 0.2)',	'rgba(051, 255, 255, 0.2)',
	        		'rgba(153, 000, 000, 0.2)',	'rgba(051, 102, 102, 0.2)',	'rgba(102, 153, 204, 0.2)',	'rgba(204, 255, 000, 0.2)',	'rgba(255, 000, 153, 0.2)',
	        		'rgba(153, 204, 051, 0.2)',	'rgba(153, 000, 102, 0.2)',	'rgba(000, 102, 255, 0.2)',	'rgba(153, 051, 000, 0.2)',	'rgba(255, 255, 204, 0.2)',
	        		'rgba(255, 255, 000, 0.2)',	'rgba(85, 0, 0, 0.2)',		'rgba(199, 233, 155, 0.2)',	'rgba(128, 88, 210, 0.2)',	'rgba(255, 223, 170, 0.2)',
	        		'rgba(190, 127, 173, 0.2)',	'rgba(128, 24, 21, 0.2)',	'rgba(47, 63, 115, 0.2)',	'rgba(56, 84, 2, 0.2)',		'rgba(217, 211, 231, 0.2)',
	        		'rgba(40, 4, 60, 0.2)',		'rgba(203, 122, 155, 0.2)',	'rgba(165, 211, 127, 0.2)',	'rgba(190, 114, 157, 0.2)',	'rgba(237, 210, 143, 0.2)',
	        		'rgba(90, 29, 2, 0.2)',		'rgba(163, 112, 51, 0.2)',	'rgba(111, 109, 165, 0.2)',	'rgba(255, 171, 0, 0.2)',	'rgba(255, 146, 146, 0.2)'
	        		],
	       		borderColor : [
	        		'rgba(255, 99, 132, 1)',	'rgba(54, 162, 235, 1)', 	'rgba(255, 206, 86, 1)',	'rgba(75, 192, 192, 1)',	'rgba(153, 102, 255, 1)',
	        		'rgba(255, 159, 64, 1)',	'rgba(173, 116, 69, 1)',	'rgba(168, 74, 92, 1)', 	'rgba(136, 56, 45, 1)', 	'rgba(66, 66, 104, 1)',
	        		'rgba(20, 49, 61, 1)',		'rgba(150, 100, 143, 1)',	'rgba(051, 000, 255, 1)',	'rgba(051, 000, 000, 1)',	'rgba(051, 255, 255, 1)',
	        		'rgba(153, 000, 000, 1)',	'rgba(051, 102, 102, 1)',	'rgba(102, 153, 204, 1)',	'rgba(204, 255, 000, 1)',	'rgba(255, 000, 153, 1)',
	        		'rgba(153, 204, 051, 1)',	'rgba(153, 000, 102, 1)',	'rgba(000, 102, 255, 1)',	'rgba(153, 051, 000, 1)',	'rgba(255, 255, 204, 1)',
	        		'rgba(255, 255, 000, 1)',	'rgba(85, 0, 0, 1)',		'rgba(199, 233, 155, 1)',	'rgba(128, 88, 210, 1)',	'rgba(255, 223, 170, 1)',
	        		'rgba(190, 127, 173, 1)',	'rgba(128, 24, 21, 1)',		'rgba(47, 63, 115, 1)',		'rgba(56, 84, 2, 1)',		'rgba(217, 211, 231, 1)',
	        		'rgba(40, 4, 60, 1)',		'rgba(203, 122, 155, 1)',	'rgba(165, 211, 127, 1)',	'rgba(190, 114, 157, 1)',	'rgba(237, 210, 143, 1)',
	        		'rgba(90, 29, 2, 1)',		'rgba(163, 112, 51, 1)',	'rgba(111, 109, 165, 1)',	'rgba(255, 171, 0, 1)',		'rgba(255, 146, 146, 1)'
	        		],
	            lineTension: 0,

	            borderWidth: 2,
	            pointStyle: 'circles',
	            pointRadius: 5
	        }       
	        ]
	    },
	    
	    options: {
	    	legend: {
	            position: 'right'
	         },
	        maintainAspectRatio: false,
	        responsive: true,
			tooltips: {
				mode: 'point',
				intersect: true,
				callbacks: {
					label: function(tooltipItems, data) {
					
						return data.datasets[tooltipItems.datasetIndex].label+": ("+data.labels[tooltipItems.index] + ")"+addComma(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index])+"명";
					}
				}
			}
	    }
	});
}

</script>

<style>
	body{background:#fff;}
	
	.list th, .list td {border : 0;}
	
	ul.icon_list{position: absolute; right: 0px; top:30px;}
	
	ul.icon_list li {display:inline-block; margin-rigth:5px; width: 35px; height: 35px;}
	ul.icon_list li a.btn_graph_hbar {background: url(/resources/cms/img/btn_graph_hbar.png) no-repeat; width: 32px; height: 32px; float:left;}
	ul.icon_list li a.btn_graph_bar {background: url(/resources/cms/img/btn_graph_bar.png) no-repeat; width: 32px; height: 32px; float:left;}
	ul.icon_list li a.btn_graph_line {background: url(/resources/cms/img/btn_graph_line.png) no-repeat; width: 32px; height: 32px;   float:left;}   
	ul.icon_list li a.btn_graph_pie {background: url(/resources/cms/img/btn_graph_pie.png) no-repeat; width: 32px; height: 32px;  float:left; }
	
	
	.buttonbox{max-width: 800px; height:65px; position:relative;}
</style>

<style media="print">
	.btn{display:none;}
	ul.icon_list li{display:none;}
	.buttonbox{height:0px;}
</style>

<form:form modelAttribute="quest" id="imgForm" action="imgDownload.do" onclick="return false;">
	<form:hidden path="imgData"/>
	<form:hidden path="quest_idx"/>
	<form:hidden path="quest_content"/>
</form:form>

<div class="brdTop_02">
	<div class="survey_info_wrap">
		<div class="survey_info">
			<h1>${survey.survey_title}</h1>
			<div class="description">
			${survey.survey_content}
			</div>
		</div>
<%-- 		<p class="contact"><span><strong>조사문의:</strong>  담당자 ( ${survey.add_user_tel} )  </span></p> --%>
	</div>

</div>
<div class="surveyList" style="width:800px; margin:0 auto;">

	<input type="hidden" id="user_count" value="${answer_count}" />
	<input type="hidden" id="change_user_count"/>
	
	<table class="list" summary="설문조사 문항에 대한 답변을 작성할 수 있습니다." style="position:relative; width:800px">
		<caption>설문조사 목록</caption>
		<colgroup>
			<col width="46" />
			<col width="" />
		</colgroup>
		<tbody>
		
		<!-- @@@@@ statistics.length: ${fn:length(statistics)} -->
		
		<c:forEach var="i" varStatus="status" items="${statistics}">
		
		<c:choose>
		
		<c:when test="${i.quest_type eq 'ONE'}">
			<tr>
				<td class="qustionNum"><span>${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content} (응답자: <span class="total_cnt${i.quest_idx}">${i.quest_detail_list[0].total_cnt} </span>명)</td>
				<td></td>
			</tr>
			
	
			<tr>
				<td>
					
				</td>
				<td class="aL">
					
					<div class="chart_wrap">
						<ul class="mysurvey_list">
							<c:set var="ratio" value="0"></c:set>
							<c:set var="totalCount" value="0"></c:set>
							<c:set var="total_cnt" value="0"></c:set>
							<c:forEach var="j"  items="${i.quest_detail_list}" varStatus="status2">
								<li>
									<span class="title${i.quest_idx}${status2.index} detailTitle${i.quest_idx}">${j.quest_detail_title}</span> (<span class="cntOne${i.quest_idx}${status2.index}">${j.cnt}</span>명:<span class="ratioOne${i.quest_idx}${status2.index}">${j.ratio}</span>%)
									<c:set var="ratio" value="${ratio + j.ratio}"></c:set>
									<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
									<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
								</li>
								<c:set var="statusIdx" value="${status2.index}"></c:set>
							</c:forEach>
							<c:if test="${i.quest_detail_free_yn eq 'Y'}">
								<li>
									<span class="title${i.quest_idx}${statusIdx+1} detailTitle${i.quest_idx}">기타</span> (<span class="cntOne${i.quest_idx}${statusIdx+1}">${total_cnt-totalCount}</span>명:<span class="ratioOne${i.quest_idx}${statusIdx+1}"><fmt:formatNumber value="${(i.quest_detail_list[0].total_cnt > 0) ? (total_cnt-totalCount == 0 ? 0 : 100-ratio) : 0}" pattern="##.##"  />
									%</span>) <a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription">&lt;응답보기&gt;</a>
								</li>
							</c:if>
						</ul> 

						<%-- <div class="chart_one" id="chart_one${status.index}"></div> --%>
						<div class="buttonbox">
							<a href="#" id="captureBtn" class="btn" index="${status.index}" quest_idx="${i.quest_idx}" quest_content="${i.quest_content}"style="position:absolute; right:110px;"><i class="fa fa-image"></i><span>이미지 저장</span></a>
							<a href="#" class="btn modifyBtn${i.quest_idx}" id="dialog2" style="position:absolute; right:0;" survey_idx="${i.survey_idx}" quest_idx="${i.quest_idx}" modify="false" quest_type="${ i.quest_type}" quest_detail_free_yn="${i.quest_detail_free_yn }" index="${status.index}"><i class="fa fa-plus"></i><span>문항 보기 수정</span></a>
							<ul class="icon_list" >
								<li><a class="btn_graph_hbar drawGraph btn${i.quest_idx}" data-type="horizontalBar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_bar drawGraph btn${i.quest_idx}" data-type="bar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_line drawGraph btn${i.quest_idx}" data-type="line" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_pie drawGraph btn${i.quest_idx}" data-type="pie" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
						    </ul>
						</div>
						<div class="chartGraphBox" id="chartGraphBox${status.index}" style="float:left; width:100%; height:150px;" index="${status.index}">
							<canvas id="chartGraph${i.quest_idx}"></canvas>						
						</div>
					</div>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MULTI'}">
			<tr>
				<td class="qustionNum"><span>${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content} (응답자: <span class="total_cnt${i.quest_idx}">${i.quest_detail_list[0].total_cnt} </span>명)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL">
					<div class="chart_wrap">
						<ul class="mysurvey_list">
						<c:set var="ratio" value="0"></c:set>
						<c:set var="totalCount" value="0"></c:set>
						<c:set var="total_cnt" value="0"></c:set>
						<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
							<li>
								<span class="title${i.quest_idx}${status2.index} detailTitle${i.quest_idx}">${j.quest_detail_title}</span> (<span class="cntOne${i.quest_idx}${status2.index}">${j.cnt}</span>명:<span class="ratioOne${i.quest_idx}${status2.index}">${j.ratio}</span>%)
								<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
								<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
							</li>
							<c:set var="statusIdx" value="${status2.index}"></c:set>
						</c:forEach>
						<c:if test="${i.quest_detail_free_yn eq 'Y'}">
								<li>
									<span class="title${i.quest_idx}${statusIdx+1} detailTitle${i.quest_idx}">기타</span> (<span class="cntOne${i.quest_idx}${statusIdx+1}">${total_cnt-totalCount}</span>명:<span class="ratioOne${i.quest_idx}${statusIdx+1}"><fmt:formatNumber value="${(i.quest_detail_list[0].total_cnt > 0) ? (total_cnt-totalCount == 0 ? 0 : 100-ratio) : 0}" pattern="##.##"  />
									%</span>) <a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription">&lt;응답보기&gt;</a>
								</li>
						</c:if>
						</ul>
						<%-- <div class="chart_one" id="chart_one${status.index}"></div> --%>
						
						<div class="buttonbox">
							<a href="#" id="captureBtn" class="btn" index="${status.index}" quest_idx="${i.quest_idx}" quest_content="${i.quest_content}" style="position:absolute; right:110px;"><i class="fa fa-image"></i><span>이미지 저장</span></a>
							<a href="#" class="btn modifyBtn${i.quest_idx}" id="dialog2" style="position:absolute; right:0;" survey_idx="${i.survey_idx}" quest_idx="${i.quest_idx}" modify="false" quest_type="${ i.quest_type}" quest_detail_free_yn="${i.quest_detail_free_yn }" index="${status.index}"><i class="fa fa-plus"></i><span>문항 보기 수정</span></a>
							<ul class="icon_list" >
								<li><a class="btn_graph_hbar drawGraph btn${i.quest_idx}" data-type="horizontalBar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_bar drawGraph btn${i.quest_idx}" data-type="bar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_line drawGraph btn${i.quest_idx}" data-type="line" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
								<li><a class="btn_graph_pie drawGraph btn${i.quest_idx}" data-type="pie" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
							</ul>
						</div>
						
						<div class="chartGraphBox" id="chartGraphBox${status.index}" style="float:left; width:100%; height:150px;" index="${status.index}">
							<canvas id="chartGraph${i.quest_idx}"></canvas>						
						</div>
					</div>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MATRIX'}">
			<tr>
				<td class="qustionNum"><span>${questIdx+1}</span></td>
				
				<td class="qustion">${i.quest_content} (응답자: <span class="total_cnt${i.quest_idx}"><fmt:formatNumber value="${i.quest_detail_list[0].total_cnt/fn:length(i.quest_matrix_list)}"/></span>명)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL">
					<table class="in_tbl" summary="매트릭스형의 세부질문과 보기 내용을 확인할 수 있습니다.">
						<caption>매트릭스형 세부질문 및 보기</caption>
						<colgroup>
							<col width="30" />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">세부질문</th>
								<c:forEach var="j" varStatus="status_j" items="${i.quest_detail_list}">
								<th><span class="detailTitle${i.quest_idx} title${i.quest_idx}${status_j.index}">${j.quest_detail_title}</span></th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="j" varStatus="status_j" items="${i.quest_matrix_list}">
							<tr>
								<td>${status_j.count})</td>
								<td style="width:300px; white-space:pre-line;"><span class="matrixTitle${i.quest_idx}${status_j.index}">${j.matrix_title}</span></td>
								
								<c:forEach var="k" varStatus="status_k" items="${j.statisticsList}">
								<td>
									<div class="count${i.quest_idx}${status_j.index}">							
								 	<span class="cntOne${i.quest_idx}${status_j.index}${status_k.index}">${k.cnt}</span>명:<span class="ratioOne${i.quest_idx}${status_j.index}${status_k.index}">${k.ratio}</span>%
									</div>
								</td>
								</c:forEach>
							</tr>							
							</c:forEach>
						</tbody>
					</table>
					<%-- <div class="chart_one" id="chart_one${status.index}"></div>  --%>
					<div class="buttonbox">
						<a href="#" id="captureBtn" class="btn" index="${status.index}" quest_content="${i.quest_content}" quest_idx="${i.quest_idx}" style="position:absolute; right:110px;"><i class="fa fa-image"></i><span>이미지 저장</span></a>
						<a href="#" class="btn modifyBtn${i.quest_idx}" id="dialog2" style="position:absolute; right:0;" survey_idx="${i.survey_idx}" quest_idx="${i.quest_idx}" modify="false" quest_type="${ i.quest_type}" index="${status.index}"><i class="fa fa-plus"></i><span>문항 보기 수정</span></a>
						<ul class="icon_list" >
							<li><a class="btn_graph_hbar drawGraph btn${i.quest_idx}" data-type="horizontalBar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
							<li><a class="btn_graph_bar drawGraph btn${i.quest_idx}" data-type="bar" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
							<li><a class="btn_graph_line drawGraph btn${i.quest_idx}" data-type="line" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
							<li><a class="btn_graph_pie drawGraph btn${i.quest_idx}" data-type="pie" index="${status.index}" modify="false" mode="${i.quest_type}" quest_idx="${i.quest_idx}"></a></li>
						</ul>
					</div>
						
						<div class="chartGraphBox" id="chartGraphBox${status.index}" style="float:left; width:100%; height:190px;" index="${status.index}">
							<canvas id="chartGraph${i.quest_idx}"></canvas>						
						</div>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}"/>
		</c:when>
		
		<c:when test="${i.quest_type eq 'DESCRIPTION'}">
		<c:set value="필수" var="required"></c:set>
		<c:if test="${i.required_yn eq 'N'}"><c:set value="선택" var="required"></c:set></c:if>
		<tr>
			<td class="qustionNum"><span>${questIdx+1}</span></td>
			<td class="qustion">${i.quest_content} (응답자: <span class="total_cnt">${i.quest_detail_list[0].total_cnt} </span>명)</td>
		</tr>
		<tr>
			<td></td>
			<td class="aL">
				<a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription">&lt;응답보기&gt;</a>
			</td>
		</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		<%-- <div class="chart_one" id="chart_one${status.index}" style="display:none;"/> --%>
		</c:when>
		</c:choose>
		</c:forEach>

		</tbody>
	</table>
</div>

<!-- 버튼 -->
<div class="brdBtn">	
	<a href="#" class="button close">닫기</a>
	<a href="#" class="button print">인쇄</a>
</div>
<!--// 버튼 -->

<div id="dialog-1" class="dialog-common" title="문항 보기 수정" style="display:none"></div>
