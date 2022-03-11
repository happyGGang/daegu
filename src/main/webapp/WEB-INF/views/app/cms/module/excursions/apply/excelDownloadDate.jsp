<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;	
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${excursions.plan_date}'.split('-');
	var planDateMonth = '${excursions.plan_date}';
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';

		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_year2').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
		$('#plan_year3').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_month2').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
		$('#plan_month3').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-5").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 320
	});
	
	$('a#excelDownload').on('click', function(event) {
		event.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}		
		
		$('#editMode').val("default");
		$('#excelDownloadMonthDate').attr('action','/cms/module/excursions/apply/excelDownloadMonth.do?editMode=default').submit();
	});
	
	$('a#excelDownload2').on('click', function(event) {
		event.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}		
		$('#editMode').val("select");
		$('#excelDownloadMonthDate').attr('action','/cms/module/excursions/apply/excelDownloadMonth.do?editMode=select').submit();
	});
	
	
});
</script>	
<form:form modelAttribute="apply" id="excelDownloadMonthDate" action="/cms/module/excursions/apply/excelDownloadMonth.do">
<form:hidden path="homepage_id"/>
<form:hidden path="plan_date"/>
<form:hidden path="plan_year1" value="${apply.plan_year }"/>
<form:hidden path="plan_month1" value="${apply.plan_month }"/>

<div class="table-wrap">
	<table class="type1 center">
			<tr>
				<td colspan=2 style="background: #e6e6e6; font-weight: bold;">현재 달 엑셀 저장</td>
			</tr>
			<tr style="height: 50px;">			
				<td>
					<div class="monthYear">
						<form:input path="plan_year1" value="${apply.plan_year }" disabled="true" style="text-align:center; width:135px; font-weight: bold;"/> -
						<form:input path="plan_month1" value="${apply.plan_month }" disabled="true" style="text-align:center; width:135px; font-weight: bold;"/>
				    </div>
				</td>
				<td>
					<a href="#" id="excelDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>		
				</td>									
			</tr>
			<tr>
				<td colspan=2 style="background: #e6e6e6; font-weight: bold;">기간선택 엑셀 저장</td>
			</tr>
			<tr style="height: 50px;">
				<td>		
					<div class="monthYear">				
						<form:select path="plan_year2" class="selectmenu" style="width:120px; height:27px; padding: 0px 0px 0px 0px; text-align:center; width:120px; font-weight: bold;"></form:select> -
				        <form:select path="plan_month2" class="selectmenu" style="width:120px; height:27px; padding: 0px 0px 0px 0px; text-align:center; width:120px; font-weight: bold;"></form:select> 부터
				    </div>				    
				    <div class="monthYear" style="margin-top:5px;">				
						<form:select path="plan_year3" class="selectmenu" style="width:120px; height:27px; padding: 0px 0px 0px 0px; text-align:center; width:120px; font-weight: bold;"></form:select> -
				        <form:select path="plan_month3" class="selectmenu" style="width:120px; height:27px; padding: 0px 0px 0px 0px; text-align:center; width:120px; font-weight: bold;"></form:select> 까지
				    </div>			
				</td>
				<td>
					<a href="#" id="excelDownload2" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>			
				</td>
			</tr>
	</table>
</div>
</form:form>