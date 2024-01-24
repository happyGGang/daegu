<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cols" value="8"/>
<c:if test="${lending.isReserve == 'Y'}">
<c:set var="cols" value="7"/>
</c:if>

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

$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#lendingListForm').submit();
	});

	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(lendingList)}' > 0) {
			$('#hiddenForm_sortField').val($('#sortField').val());
			$('#hiddenForm_type').val($('#type').val());
			$('#hiddenForm_com_code').val($('#com_code').val());
			$('#hiddenForm_parent_id').val(nvl($('#parent_id').val(), 0));
			$('#hiddenForm_cate_id').val(nvl($('#cate_id').val(), 0));
			$('#hiddenForm_library_code').val($('#library_code').val());
			$('#hiddenForm_search_sdt').val($('#search_sdt').val());
			$('#hiddenForm_search_edt').val($('#search_edt').val());
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(lendingList)}' > 0) {
			$('#hiddenForm_sortField').val($('#sortField').val());
			$('#hiddenForm_type').val($('#type').val());
			$('#hiddenForm_com_code').val($('#com_code').val());
			$('#hiddenForm_parent_id').val(nvl($('#parent_id').val(), 0));
			$('#hiddenForm_cate_id').val(nvl($('#cate_id').val(), 0));
			$('#hiddenForm_library_code').val($('#library_code').val());
			$('#hiddenForm_search_sdt').val($('#search_sdt').val());
			$('#hiddenForm_search_edt').val($('#search_edt').val());
			$('#hiddenForm').attr('action', 'csvDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	$('select#type').on('change', function(e) {
		updateCategory($(this).val());
	});
	updateCategory($('select#cate1').val());
	
	$('select#sortField').on('change', submit);
	$('select#rowCount').on('change', submit);
	$('a#search').on('click', submit);
	
});

function nvl(val, alt) {
	if(val == '' || val == null) {
		return alt;
	} else {
		return val;
	}
}

function updateCategory(cate_id) {
	if(cate_id != null && cate_id != '' && cate_id != '0') {
		$.get('/cms/module/elib/category/' + $('select#type').val() + '/getCategories.do?depth=1&type=' + $('select#type').val(), function(data) {
			var cate1 = $('select#cate1').empty();
			var selected = null;
			
			cate1.append($('<option>', { value: '0', text: '1차 카테고리 선택'}));
			$(data.data).each(function(i) {
				var attrs = { value: this.cate_id, text: this.cate_name };
				
				if('${obj.parent_id}' == this.cate_id) {
					attrs.selected = 'selected';
				}
				
				cate1.append($('<option>', attrs));
			});
			
			cate1.select2('destroy');
			cate1.select2('');
		});
	}
}

function submit(e) {
	e.preventDefault();
	$('#lendingListForm').submit();
}
</script>

<form:form id="hiddenForm" modelAttribute="lending" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="sortField" id="hiddenForm_sortField"/>
<form:hidden path="homepage_id"/>
<form:hidden path="lend_idx" id="hiddenForm_book_idx"/>
<form:hidden path="isReserve" id="hiddenForm_isReserve"/>
<form:hidden path="type" id="hiddenForm_type"/>
<form:hidden path="com_code" id="hiddenForm_com_code"/>
<form:hidden path="parent_id" id="hiddenForm_parent_id"/>
<form:hidden path="cate_id" id="hiddenForm_cate_id"/>
<form:hidden path="library_code" id="hiddenForm_library_code"/>
<form:hidden path="search_sdt" id="hiddenForm_search_sdt"/>
<form:hidden path="search_edt" id="hiddenForm_search_edt"/>
</form:form>
<form:form id="lendingListForm"  modelAttribute="lending" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden path="isReserve"/>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/category_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			<form:select class="selectmenu-search" style="width:200px" path="status">
				<form:option value="">대출, 예약 가능 여부</form:option>
				<form:option value="대출 가능">대출 가능</form:option>
				<form:option value="예약 가능">예약 가능</form:option>
			</form:select>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${lendingListCnt}" pattern="#,###" />건
		<form:select path="sortField" class="selectmenu">
			<form:option value="">정렬 순서 선택</form:option>
			<form:option value="book_name">서명순</form:option>
			<form:option value="author_name">저자순</form:option>
			<form:option value="member_id">ID순</form:option>
			<c:if test="${lending.isReserve != 'Y'}">
			<form:option value="lend_dt">대출일자순</form:option>
			<form:option value="return_due_dt">만료일자순</form:option>
			<form:option value="return_dt">반납일자순</form:option>
			</c:if>
			<c:if test="${lending.isReserve == 'Y'}">
			<form:option value="reserve_dt">예약일자순</form:option>
			<form:option value="lend_dt">대출일자순</form:option>
			</c:if>
			<form:option value="reserves_cnt">예약자많은순</form:option>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
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
			<col width="50"/>
			<col width="80"/>
			<col width="150"/>
			<col width="100"/>
			<c:if test="${lending.isReserve != 'Y'}">
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
			</c:if>
			<c:if test="${lending.isReserve == 'Y'}">
			<col width="80"/>
			<col width="80"/>
			</c:if>
		</colgroup>
		<thead>
			<tr>
				<th>기기</th>
				<th>회원ID</th>
				<th>카테고리</th>
				<th>도서명</th>
				<th>저자</th>
				<c:if test="${lending.isReserve != 'Y'}">
				<th>대출일자</th>
				<th>만료일자</th>
				<th>반납일자</th>
				</c:if>
				<c:if test="${lending.isReserve == 'Y'}">
				<th>예약일자</th>
				<th>대출일자</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(lendingList) < 1}">
				<tr style="height:100%">
					<td colspan="${cols}" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${lendingList}">
				<tr>
					<td>${i.device}</td>
					<td>${i.member_id}</td>
					<td>${i.cate_name}</td>
					<td>${i.book_name}</td>
					<td>${i.author_name}</td>
					<c:if test="${lending.isReserve != 'Y'}">
					<td>${i.lend_dt}</td>
					<td>${i.return_due_dt}</td>
					<td>${i.return_dt}</td>
					</c:if>
					<c:if test="${lending.isReserve == 'Y'}">
					<td>${i.reserve_dt}</td>
					<td>${i.lend_dt}</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#lendingListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="member_id">회원ID</form:option>
				<form:option value="book_name">책제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
