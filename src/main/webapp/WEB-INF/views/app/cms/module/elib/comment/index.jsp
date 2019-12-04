<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
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
	
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#commentListForm').submit();
	});
	
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&comment_idx=' + $(this).data('comment_idx'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if(confirm('삭제하시겠습니까?')) {
			$('#hiddenForm_comment_idx').val($(this).data('comment_idx'));
			$('#editMode').val('DELETE');
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		if(${fn:length(commentList)} > 0) {
			$('#hiddenForm_type').val($('#type').val());
			$('#hiddenForm_cate_id').val($('#cate_id').val());
			$('#hiddenForm_parent_id').val($('#parent_id').val());
			$('#hiddenForm_search_sdt').val($('#search_sdt').val());
			$('#hiddenForm_search_edt').val($('#search_edt').val());
			$('#hiddenForm_member_id').val($('#member_id').val());
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if(${fn:length(commentList)} > 0) {
			$('#hiddenForm_type').val($('#type').val());
			$('#hiddenForm_cate_id').val($('#cate_id').val());
			$('#hiddenForm_parent_id').val($('#parent_id').val());
			$('#hiddenForm_search_sdt').val($('#search_sdt').val());
			$('#hiddenForm_search_edt').val($('#search_edt').val());
			$('#hiddenForm_member_id').val($('#member_id').val());
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
	
	$('a#search').on('click', function(e) {
		e.preventDefault();
		$('#commentListForm').submit();
	});
	
});

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

</script>
<form:form id="hiddenForm" modelAttribute="comment" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="comment_idx" id="hiddenForm_comment_idx"/>
<form:hidden path="type" id="hiddenForm_type"/>
<form:hidden path="cate_id" id="hiddenForm_cate_id"/>
<form:hidden path="parent_id" id="hiddenForm_parent_id"/>
<form:hidden path="search_sdt" id="hiddenForm_search_sdt"/>
<form:hidden path="search_edt" id="hiddenForm_search_edt"/>
<form:hidden path="member_id" id="hiddenForm_member_id"/>
</form:form>
<form:form id="commentListForm"  modelAttribute="comment" action="index.do" >
<c:if test="${!member.admin}">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</c:if>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/category_select.jsp"/>
			<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회일 선택"/>
			<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
			<form:input path="member_id" cssClass="text" placeholder="회원ID"/>
			<a href="#" id="search" class="btn"><span>조회</span></a>
		</fieldset>
	</div>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${commentListCnt}" pattern="#,###" />건
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="200"/>
			<col width="250"/>
			<col width="150"/>
			<col width="100"/>
			<col width=""/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>회원ID</th>
				<th>일시</th>
				<th>서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>서평</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(commentList) < 1}">
				<tr style="height:100%">
					<td colspan="7" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${commentList}">
				<tr>
					<td>${i.member_id}</td>
					<td>${i.add_date}</td>
					<td>${i.book_name}</td>
					<td>${i.author_name}</td>
					<td>${i.book_pubname}</td>
					<td>${i.user_comment}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" data-comment_idx="${i.comment_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" data-comment_idx="${i.comment_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#commentListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>
	
</form:form>
	
<div id="dialog-1" class="dialog-common" title="서평 수정" style="display:none;"></div>