<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: false,
	    showAnim: "",
	    closeText: "선택",
	    onChangeMonthYear: writeSelectedDate
//	    beforeShow: pickupDate
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
//	  function pickupDate() {
//		  var thisCalendar = $(this);
//		  if(thisCalendar.val() != '') {
//			  var date = thisCalendar.val().split('-');
//			  thisCalendar.datepicker('setDate', new Date(date[0], date[1]-1, 1));
//		  }
//	  }
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

$(document).ready(function() {
	<%--검색--%>
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#loginLog').serialize());
	});
	
	<%--10개씩보기--%>
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#loginLog').serialize());
	});
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	$('a#search').on('click', function(e) {
		$('form#loginLog').submit();
	});
});

</script>

<form:form modelAttribute="loginLog" action="index.do" method="POST">
<div class="search">
	<fieldset>
		<label class="blind">검색</label>
		<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
		<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
		<a href="#" id="search" class="btn"><span>조회</span></a>
	</fieldset>
</div>

<div class="infodesk">
	검색 결과 : <fmt:formatNumber value="${loginLogCnt}" pattern="#,###" />건
	<form:select path="rowCount" class="selectmenu" style="width:100px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${loginLogCnt}">전체 보기</form:option>
	</form:select>
</div>

<form:hidden id="member_id_index" path="member_id"/>
<form:hidden id="editMode_index" path="editMode"/>
<form:hidden path="menu_idx"/>
		<table class="type1 center">
			<colgroup>
				<col width="50px">
				<col width="10%">
				<col>
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="mmm2">ID</th>
					<th class="mmm2">접속 위치</th>
					<th class="mmm2">기기</th>
					<th class="mmm2">운영체제</th>
					<th class="mmm2">브라우저</th>
					<th class="mmm1">IP</th>
					<th class="mmm2">일시</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${loginLogList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important">${i.member_id}</td>
					<td class="important">
						<c:choose>
						<c:when test="${i.login_type eq 'CMS'}">
						CMS
						</c:when>
						<c:otherwise>
						${i.homepage_name}
						</c:otherwise>
						</c:choose>
					</td>
					<td class="important">${i.category}</td>
					<td class="important">${i.os}</td>
					<td class="important">${i.browser}</td>
					<td class="important">${i.ip}</td>
					<td class="important">${i.login_date}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(loginLogList) < 1 }">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">접속 이력이 없습니다.</td>
			</tr>
		</table>
		</c:if>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#loginLog"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="MEMBER_ID">사용자ID</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
