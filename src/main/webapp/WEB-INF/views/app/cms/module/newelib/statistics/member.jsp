<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cols" value="5"/>
<c:set var="lendName" value="PC 대출 수"/>

<script type="text/javascript">
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    showAnim: "",
	    onChangeMonthYear: writeSelectedDate,
	    closeText: "선택",
// 	    beforeShow: pickupDate
	  }, options);
	  function writeSelectedDate(year, month, inst ){
	   var thisFormat = jQuery(this).datepicker("option", "dateFormat");
	   var d = jQuery.datepicker.formatDate(thisFormat, new Date(year, month-1, 1));
	   inst.input.val(d);
	  }
	  function hideDaysFromCalendar() {
	    var thisCalendar = $(this);
	    jQuery('.ui-datepicker-calendar').detach();
	    jQuery('.ui-datepicker-close').click(function() {
	      var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	      var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	      thisCalendar.datepicker('setDate', new Date(year, month, 1));
	      thisCalendar.datepicker("hide");
	    });
	  }
// 	  function pickupDate() {
// 		  var thisCalendar = $(this);
// 		  if(thisCalendar.val() != '') {
// 			  var date = thisCalendar.val().split('-');
// 			  thisCalendar.datepicker('setDate', new Date(date[0], date[1]-1, 1));
// 		  }
// 	  }
	  jQuery(this).datepicker(options);
	}
	
function formatDate(date, withoutDay) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    
    if(withoutDay)
    	return [year, month].join('-');
    else
    	return [year, month, day].join('-');
}

$(function() {
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(elibStatisticsList)}' > 0) {
			$('input#hiddenForm_library_code').val($('#library_code').val());
			$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
			$('input#hiddenForm_type').val($('select#type').val());
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(elibStatisticsList)}' > 0) {
			$('input#hiddenForm_library_code').val($('#library_code').val());
			$('input#hiddenForm_search_sdt').val($('input#search_sdt').val());
			$('input#hiddenForm_type').val($('select#type').val());
			$('#hiddenForm').attr('action', 'csvDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	var search_sdt = $('input#search_sdt');
// 	if(search_sdt.val() == '') {
// 		var d = new Date();
// 		d.setMonth(d.getMonth()-1);
// 		search_sdt.val(formatDate(d, true));
// 	}
	
	var search_edt = $('input#search_edt');
// 	if(search_edt.val() == '') search_edt.val(formatDate(new Date(), true));
	
	$('a#search').on('click', submit);
	$('select#rowCount').on('change', submit);
	$('select#sortField').on('change', submit);
});

function submit(e) {
	e.preventDefault();
	if($('select#type').val() == '') {
		alert('콘텐츠 타입을 선택해주세요.');
		return;
	}
	$('#elibStatisticsListForm').submit();
}
</script>

<form:form id="hiddenForm" modelAttribute="elibStatistics" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="library_code" id="hiddenForm_library_code"/>
<form:hidden path="com_code" id="hiddenForm_com_code"/>
<form:hidden path="search_sdt" id="hiddenForm_search_sdt"/>
<form:hidden path="search_edt" id="hiddenForm_search_edt"/>
<form:hidden path="type" id="hiddenForm_type"/>
<form:hidden path="menu" id="hiddenForm_menu"/>
</form:form>
<form:form id="elibStatisticsListForm"  modelAttribute="elibStatistics" action="index.do" >
<form:hidden path="menu"/>
<c:if test="${!member.admin}">
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden path="library_code" value="${library_code}"/>
</c:if>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
			<c:if test="${member.admin}">
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			</c:if>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			회원 ID : 
			<form:input path="member_id" cssClass="text"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${elibStatisticsCnt}" pattern="#,###" />건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		<form:select path="sortField" class="selectmenu">
			<option value="">정렬 순서 선택</option>
			<option value="member_id" <c:if test="${elibStatistics.sortField eq 'member_id'}">selected="selected"</c:if>>ID순</option>
			<option value="pcnt" <c:if test="${elibStatistics.sortField eq 'pcnt'}">selected="selected"</c:if>>PC대출수 순</option>
			<option value="scnt" <c:if test="${elibStatistics.sortField eq 'scnt'}">selected="selected"</c:if>>(구) 스마트폰 대출수 순</option>
			<option value="scnt" <c:if test="${elibStatistics.sortField eq 'acnt'}">selected="selected"</c:if>>스마트폰 대출수 순</option>
			<option value="scnt" <c:if test="${elibStatistics.sortField eq 'icnt'}">selected="selected"</c:if>>스마트폰 대출수 순</option>
			<option value="scnt" <c:if test="${elibStatistics.sortField eq 'ecnt'}">selected="selected"</c:if>>스마트폰 대출수 순</option>
			<option value="cnt" <c:if test="${elibStatistics.sortField eq 'cnt'}">selected="selected"</c:if>>전체 대출수 순</option>
			<option value="comments_cnt" <c:if test="${elibStatistics.sortField eq 'comments_cnt'}">selected="selected"</c:if>>서평수 순</option>
		</form:select>

		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50"/>
<%-- 			<col width="50"/> --%>
			<col width="150"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="80"/>
			<col width="50"/>
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" colspan="1">회원ID</th>
<!-- 				<th rowspan="2" colspan="1">회원명</th> -->
				<th rowspan="2" colspan="1">소속도서관</th>
				<th rowspan="2" colspan="1">${lendName}</th>
				<th rowspan="1" colspan="4">스마트폰 대출 수</th>
				<th rowspan="2" colspan="1">기타(불명) 대출 수</th>
				<th rowspan="2" colspan="1">전체 대출 수</th>
				<th rowspan="2" colspan="1">서평 수</th>
			</tr>
			<tr>
				<th>Android</th>
				<th>iOS</th>
				<th>(구 스마트폰 대출 수)</th>
				<th>스마트폰 합계</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(elibStatisticsList) < 1}">
				<tr style="height:100%">
					<td colspan="${cols}" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${elibStatisticsList}">
				<tr>
					<td>${i.member_id}</td>
<%-- 					<td>${i.user_name}</td> --%>
					<td>${i.library_name}</td>
					<td><fmt:formatNumber value="${i.p_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.a_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.i_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.s_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.a_cnt + i.i_cnt + i.s_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.e_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.p_cnt + i.a_cnt + i.i_cnt + i.s_cnt + i.e_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${i.comments_cnt}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
				<tr>
					<th>합계(검색 조건 전체)</th>
<%-- 					<th>${i.user_name}</th> --%>
					<th></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.p_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.a_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.i_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.s_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.a_cnt + getStatisticsByMemberTotal.i_cnt + getStatisticsByMemberTotal.s_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.e_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.p_cnt + getStatisticsByMemberTotal.a_cnt + getStatisticsByMemberTotal.i_cnt + getStatisticsByMemberTotal.s_cnt + getStatisticsByMemberTotal.e_cnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${getStatisticsByMemberTotal.comments_cnt}" pattern="#,###" /></th>
				</tr>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#elibStatisticsListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>

</form:form>
