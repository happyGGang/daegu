<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${calendarManage.plan_date}'.split('-');
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';
		
		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화 
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);
		
		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	
	$('#plan_year,#plan_month').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
	});
	
	$('a#changeView').on('click', function(e) {
		e.preventDefault();
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
	});
		
	$('select#homepage_id_1').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
		}
		
		e.preventDefault();
	});
		
	$('a.modify').on('click', function(event) {
		if($(this).attr('type') == 'calendar') {
			if ($(this).attr('linkurl') == null || $(this).attr('linkurl') == 'null') {
				doGetLoad('/${homepage.context_path}/module/calendarManage/detail.do', '&menu_idx=' + $('#menu_idx').val()+'&cm_idx='+$(this).attr('keyValue2')+'&date_type='+$(this).attr('keyValue3'));
			} else {
				doGetLoad($(this).attr('linkurl'));
			}
		} else if ($(this).attr('type') == 'teach') {
			doGetLoad('/${homepage.context_path}/module/teach/detail.do', 'category_idx=' + $(this).attr('keyValue') + '&teach_idx=' + $(this).attr('keyValue2')+ '&menu_idx=' + $('#menu_idx').val()+ '&group_idx=' + $(this).attr('keyValue3')+ '&homepage_id=' + $('input#homepage_id_1').val());
		} else if ($(this).attr('type') == 'move') {
			doGetLoad('/${homepage.context_path}/board/view.do', 'menu_idx='+$(this).attr('keyValue3')+'&manage_idx=' + $(this).attr('keyValue') + '&board_idx=' + $(this).attr('keyValue2'));
		}
		event.preventDefault();
	});
	
	$('a#before-btn').on('click', function(event) {			
		event.preventDefault();
		
		var year = $('#plan_year').val();
		var month = $('#plan_month').val();
		
		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}
		
		var planDate = year + '-' + month;
		if( month < 10 ) {
			var planDate = year + '-0' + month;
		} else {
			var planDate = year + '-' + month;
		}
		$('#plan_date').val(planDate);
		doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
		
	});	
	
	$('a#next-btn').on('click', function(event) {			
		event.preventDefault();
		
		var year = $('#plan_year').val();
		var month = $('#plan_month').val();
		
		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}
		
		var planDate = year + '-' + month;
		if( month < 10 ) {
			var planDate = year + '-0' + month;
		} else {
			var planDate = year + '-' + month;
		}
		$('#plan_date').val(planDate);
		doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
		
	});
	
	/* 달력 제어 시작 */
	$('tr.week').each(function(i, e) {
		var $this = $(this);
		var liCountByTr = $this.find('li').length;
		
		var date = new Date();
		var day = date.getDate();		
		
		if ( liCountByTr > 0) {
			$this.find('td').each(function(i, e) {						
				var liCountByTd = $(this).find('li').length;
				if ( liCountByTd > 0 ) {  
					$(this).addClass('data'+liCountByTd); 
				}				
			});
		} else {
			$this.addClass('noData');
		}
		
		$this.find('td').each(function(i, e) {
			if($('#plan_year').val() + $('#plan_month').val() == year+""+month) {
				if($(this).find("div").text() == day) {
					$(this).addClass('today');
				}	
			}
							
		});
	});
	
	function cwFunc(){
		var cw = ($('#calendar td').width())-8;
		$('#calendar td ul').css({'width':cw+'px'}).show();
	}
	cwFunc();
	
	$(window).resize(function(){
		cwFunc();
	});
	/* 달력 제어 종료 */

	<c:if test="${fn:length(subHomepageList) > 0}">
	var a = '${fn:escapeXml(calendarManage.homepage_id)}';
	$('div.tab_menu a[data-hid="'+a+'"]').parent().addClass('active');

	$('div.tab_menu a').on('click', function(e) {
		e.preventDefault();
		var hid = $(this).data('hid');
		$('input#homepage_id_1').val(hid);
		doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
	});
	</c:if>
});
</script>
<style>
#calendarListTable a{font-size: 15px;}
#calendarListTable li{padding-top: 3px;}
#calendarListTable th{border: 1px solid #e5e8eb !important;}
#calendarListTable td{border: 1px solid #e5e8eb !important;}
</style>
	<c:set var="plan_date" value="${fn:split(calendarManage.plan_date, '-')}" />
	<form:form modelAttribute="calendarManage" method="GET">
		<form:hidden path="plan_date"/>
		<form:hidden id="homepage_id_1" path="homepage_id"/>
		<form:hidden id="menu_idx" path="menu_idx"/>

		<c:if test="${fn:length(subHomepageList) > 0}">
			<div class="tab_menu on">
				<ul class="no${fn:length(subHomepageList)}">
					<c:forEach items="${subHomepageList}" var="i" varStatus="status">
						<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
					</c:forEach>
				</ul>
			</div>
		</c:if>

		<div class="ym_btns">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<label for="plan_year"/>
			<form:select path="plan_year" class="" style="width:80px;height:28px;"></form:select>
			<label for="plan_month"/>
			<form:select path="plan_month" class="" style="width:65px;height:28px;"></form:select>
			<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
			<a href="#" style="float: right;" class="btn btn2 left" id="changeView"><i style="font-size: 100%;" class="fa fa-calendar" aria-hidden="true"></i><span style="margin-left: 5px;">달력형 보기</span></a>
		</div>
		<div id="calendar" class="event-cal">
			<div class="cal-func">
				<div class="date-type">
					<span class="type-r"><i></i><em>휴관일</em></span>
					<span class="type-e"><i></i><em>행사일정</em></span>
					<span class="type-m"><i></i><em>영화상영</em></span>
				</div>
			</div>

			<table class="cal-tbl" summary="이달의행사">
				<colgroup>
					<col width="5%"/>
					<col />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" style="text-align: center !important;">일자</th>
						<th scope="col" style="text-align: center !important;">내용</th>
					</tr>
				</thead>
				<tbody id="calendarListTable">
				<c:forEach var="i" varStatus="status" items="${calendarListType}">
					<tr>
						<fmt:formatDate value="${i.days}" pattern="yyyy-MM-dd" var="dateStr"/>
						<c:choose>
							<c:when test="${i.weekday eq 1}">
						<th class="center" style="color: red; text-align: center !important;" >${dateStr}</th>
							</c:when>
							<c:when test="${i.weekday eq 7}">
						<th class="center" style="color: blue; text-align: center !important;">${dateStr}</th>
							</c:when>
							<c:otherwise>
						<th class="center" style="text-align: center !important;">${dateStr}</th>
							</c:otherwise>
						</c:choose>
						<td class="top" style="text-align: left;">
							<tag:calendarManageUser plan_date="${dateStr}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="${i.weekday}"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>				
		</div>
	</form:form>
