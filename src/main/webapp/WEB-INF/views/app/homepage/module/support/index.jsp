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
	var planDate = '${support.plan_date}'.split('-');
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
		
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('module/support/index.do?plan_date=' + $('#plan_date').val()+'&pageType=ajax');
		} else {
			doGetLoad('index.do', serializeCustom($('#support')));
		}
		
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
		
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('module/support/index.do?plan_date=' + $('#plan_date').val()+'&pageType=ajax');
		} else {
			doGetLoad('index.do', serializeCustom($('#support')));
		}
		
	});	
	
	$('a#next-btn').on('click', function(event) {			
		event.preventDefault($('#pageType').val());
		
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
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('module/support/index.do?plan_date=' + $('#plan_date').val()+'&pageType=ajax');
		} else {
			doGetLoad('index.do', serializeCustom($('#support')));
		}
		
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
	
	$('a#modify').on('click', function(event) {		
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('/${homepage.context_path}/module/support/edit.do', 'editMode=MODIFY&seq=' + $(this).attr('keyValue') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val());	
		} else {
			doGetLoad('/${homepage.context_path}/module/support/edit.do', 'editMode=MODIFY&seq=' + $(this).attr('keyValue') + '&menu_idx=' + $('#menu_idx').val());	
		}
		event.preventDefault();
	});
	
	$('a#add').on('click', function(event) {
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('/${homepage.context_path}/module/support/edit.do', 'editMode=ADD&menu_idx=' + $('#menu_idx').val() + '&plan_date=' + $(this).attr('keyValue') + '&pageType=' + $('#pageType').val());	
		} else {
			doGetLoad('/${homepage.context_path}/module/support/edit.do', 'editMode=ADD&menu_idx=' + $('#menu_idx').val() + '&plan_date=' + $(this).attr('keyValue'));	
		}
		event.preventDefault();
	});
	
	$('a#result').on('click', function(event) {	
		if($('#pageType').val() == 'ajax') {
			$('#tabCon2').load('/${homepage.context_path}/module/support/apply.do', 'seq=' + $(this).attr('keyValue') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val());	
		} else {
			doGetLoad('/${homepage.context_path}/module/support/apply.do', 'seq=' + $(this).attr('keyValue') + '&menu_idx=' + $('#menu_idx').val());	
		}		
		event.preventDefault();
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
	
});
</script>
<form:form modelAttribute="support" id="support">
	<form:hidden path="plan_date"/>
	<form:hidden path="menu_idx"/>	
	<form:hidden path="pageType"/>	

	<div class="ym_btns">
		<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<form:select path="plan_year" class="" style="width:80px;height:28px;"></form:select>
		<form:select path="plan_month" class="" style="width:65px;height:28px;"></form:select>
		<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	</div>

	<div id="calendar">
		<div class="cal-func">
			<div class="date-type">
				<span class="type-r"><i></i><em>신청가능</em></span>
				<span class="type-e"><i></i><em>신청불가</em></span>
				<span class="type-m"><i></i><em>신청완료</em></span>
			</div>
		</div>
		
		<table class="cal-tbl">
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>								
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<ul>
								<tag:supportUser plan_date="${plan_date}" supportList="${supportList}" calendarManageList="${calendarManageList}" memberid="${memberId}" supportManageRep="${supportManageRepo}" mode="admin"/>
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
