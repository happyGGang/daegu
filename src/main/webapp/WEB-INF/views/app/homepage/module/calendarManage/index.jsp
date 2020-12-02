<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	
	$('a#monthSelect').on('click', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
	});
	
	
	$('a#changeView').on('click', function(e) {
		e.preventDefault();
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index_list.do', serializeCustom($('#calendarManage')));
	});
		
	$('select#homepage_id_1').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', serializeCustom($('#calendarManage')));
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
			doGetLoad('/${homepage.context_path}/module/teach/detail.do', 'category_idx=' + $(this).attr('keyValue') + '&teach_idx=' + $(this).attr('keyValue2')+ '&menu_idx=' + $('#menu_idx').val()+ '&group_idx=' + $(this).attr('keyValue3'));
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
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
		
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
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
		
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
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
	});
	</c:if>
});
</script>
	<c:set var="plan_date" value="${fn:split(calendarManage.plan_date, '-')}" />
	<form:form modelAttribute="calendarManage" method="GET">
		<form:hidden path="plan_date"/>
		<form:hidden id="homepage_id_1" path="homepage_id"/>
		<form:hidden id="menu_idx" path="menu_idx"/>

		<c:if test="${fn:length(subHomepageList) > 0}">
		<div class="tab_menu on">
			<ul class="no6">
				<c:forEach items="${subHomepageList}" var="i" varStatus="status">
					<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="mg30t"></div>
		</c:if>
		<div class="ym_btns">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
<!-- 			<label for="plan_year"/> -->
			<form:select path="plan_year" class="" style="width:80px;height:28px;" title="년도"></form:select>
<!-- 			<label for="plan_month"/> -->
			<form:select path="plan_month" class="" style="width:65px;height:28px;" title="월"></form:select>
			<a href="#" id="monthSelect" class="btn btn1">이동</a>
			<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
			<a href="#" style="float: right;" class="btn btn2 left" id="changeView"><i style="font-size: 100%;" class="fa fa-list" aria-hidden="true"></i><span style="margin-left: 5px;">목록형 보기</span></a>
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
				<caption>이달의 행사 일정 안내</caption>
				<thead>
					<tr>
						<th class="sun">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th class="sat">토</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="i" varStatus="status" items="${calendarList}">
					<tr class="week">	
						<c:choose>
						<c:when test="${i.sun eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td class="sun">
								<div>${i.sun}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}"  teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="1"/>
								</ul>												
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.mon eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td>
								<div>${i.mon}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}"  teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="2"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.tue eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td>
								<div>${i.tue}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="3"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.wed eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td>
								<div>${i.wed}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="4"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.thu eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td>
								<div>${i.thu}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="5"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.fri eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td>
								<div>${i.fri}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="6"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${i.sat eq null}">
							<td><div>&nbsp;</div></td>
						</c:when>
						<c:otherwise>
							<td class="sat">
								<div>${i.sat}</div>
								<c:set var="plan_date" value="${calendarManage.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
								<ul>
									<tag:calendarManageUser plan_date="${plan_date}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}" teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="7"/>
								</ul>
							</td>
						</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
				</tbody>
			</table>				
		</div>
	</form:form>
