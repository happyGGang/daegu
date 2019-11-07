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
	
	//모달창 링크 버튼
	$('a.dialog-add').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val()+'&hope_req_dt='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#dialog-add-manage').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-4').load('editManage.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val() + '&plan_date=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#dialog-apply').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-3').load('indexApply.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val() + '&plan_date='+$('#plan_date').val(), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		
		event.preventDefault();
	});				
		
	<%--수정--%>
	$('a.modify').on('click', function(event) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&seq=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		event.preventDefault();
	});
	
	<%--결과등록--%>
	$('a.result').on('click', function(event) {
		$('#dialog-2').load('result.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&seq=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(event) {
		event.preventDefault();
		
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		
		$('#support').attr('action','/cms/module/support/apply/excelDownloadMonth.do').submit();
	});
	
	$('a#totalExcelDownload').on('click', function(event) {
		event.preventDefault();
		
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		
		$('#plan_date').val("");
		$('#support').attr('action','/cms/module/support/apply/excelDownload.do').submit();
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
		
		var planDate = year + '-' + (month < 10 ? '0' + month : month) ;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#support')));
		
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
		
		var planDate = year + '-' + (month < 10 ? '0' + month : month) ;
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#support')));
		
	});
		
	$('#plan_year,#plan_month').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#support')));
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', 'plan_date=' + $('#plan_date').val()+'&homepage_id='+$('#homepage_id_1').val());
		}
		
		e.preventDefault();
	});
	
	$('td.top').height(150);
});
</script>
<form:form modelAttribute="support" action="" id="support">
<form:hidden path="plan_date"/>
	<form:hidden id="homepage_id_1" path="homepage_id"/>

<div class="infodesk">
	<div class="monthYear" style="display:inline-block;zoom:1;*display:inline">
		<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<form:select path="plan_year" class="selectmenu" style="width:100px;"></form:select>
        <form:select path="plan_month" class="selectmenu" style="width:100px;"></form:select>
        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
    </div>
	<div class="button">
<!-- 		<a href="#" id="totalExcelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체 엑셀저장</span></a>&nbsp;&nbsp; -->
<!-- 		<a href="#" id="excelDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp; -->
		<c:if test="${authC}">
		<a href="" class="btn btn1 left" id="dialog-add-manage" keyValue="${support.plan_date}"><i class="fa fa-plus"></i><span>신청가능일 관리</span></a>
		</c:if>
		<a href="" class="btn btn4 left" id="dialog-apply"><span>현장지원 신청현황</span></a>
	</div>
</div>
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col width="100px" span="7"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일요일</th>
					<th scope="col">월요일</th>
					<th scope="col">화요일</th>
					<th scope="col">수요일</th>
					<th scope="col">목요일</th>
					<th scope="col">금요일</th>
					<th scope="col">토요일</th>
				</tr>
			</thead>
			<tbody>			
			<c:forEach var="i" varStatus="status" items="${calendarList}">
				<tr>
					<c:choose>
					<c:when test="${i.sun eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #ff4e4e; color: white; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sun}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.mon eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.mon}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.tue eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.tue}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.wed eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.wed}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.thu eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.thu}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.fri eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.fri}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.sat eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #dee7f9; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sat}</div>
							<c:set var="plan_date" value="${support.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<tag:support plan_date="${plan_date}" supportList="${supportList}" mode="admin" />
							<c:if test="${supportManageRepo[plan_date] ne null}">
								<a href="" class="btn btn5 left dialog-add" keyValue="${plan_date}"><i class="fa fa-plus"></i><span>현장지원 등록</span></a>
							</c:if>
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="현장지원 신청"></div>
<div id="dialog-2" class="dialog-common" title="결과등록"></div>
<div id="dialog-3" class="dialog-common" title="현장지원 신청현황"></div>
<div id="dialog-4" class="dialog-common" title="현장지원 신청일 관리"></div>