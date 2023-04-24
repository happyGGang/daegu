<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	var $form = $('form#pictureBook');
	
	$('a.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'menu_idx='+$('#menu_idx').val() + '&picture_book_loan_idx='+$(this).attr('keyValue') + '&viewPage='+$('#viewPage').val();
		doGetLoad('loanView.do', formData);
	});
	
	$('a.cancle-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 대출 신청을 취소하시겠습니까?')) {
			$('#editMode').val('DELETE');
			$('#picture_book_loan_idx').val($(this).attr('keyValue'));
			$form.attr('action', 'loanSave.do');
			$form.attr('method', 'POST');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	var currDate = new Date();
	var year = currDate.getFullYear();
	var currYear = '${pictureBook.loan_year}';
	var currMonth = '${pictureBook.loan_month}';
	for(var i = 2018; i <= year + 1; i++) {
		var selected = '';
		if(currYear == i) {
			selected = 'selected="selected"';
		}
		$('select#loan_year').append('<option value="'+i+'" '+selected+'>'+i+'</option>');
	}
	
	for(var j = 1; j <= 12; j++) {
		var selected = '';
		if(currMonth == j) {
			selected = 'selected="selected"';
		}
		
		var valueMonth = j < 10 ? '0'+j : j;
		$('select#loan_month').append('<option value="'+valueMonth+'" '+selected+'>'+valueMonth+'</option>');
	}
	
	$('.listChange').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		$('#pay_yn').val($(this).attr('keyValue'));
		doGetLoad('loanList.do', $('form#pictureBook').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#pictureBook').serialize());
	});
	
	$('select#loan_year, select#loan_month, select#request_status').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#pictureBook').serialize());
	});
	
	$('#allChk').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.loan_chk').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.loan_chk').prop('checked', false);
		}
	});
	
	$('#status-change').on('click', function(e) {
		e.preventDefault();
		
		if($('input[name="picture_book_loan_arr"]:checked').length < 1) {
			alert('변경할 신청 리스트를 선택하세요.');
			return false;
		}
		
		if($('select#statusAll option:selected').val() == '') {
			alert('변경할 상태를 선택하세요.');
			return false;
		}
		
		$('select#request_status').val($('select#statusAll').val()).prop('selected', true);
		$('#editMode').val('STATUS');
		$('#pictureBook').attr('action', 'loanSave.do');
		$('#pictureBook').attr('method', 'POST');
		doAjaxPost($('#pictureBook'));
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(pictureBookLoanList)}' > 0) {
			$('#pictureBook').attr('method', 'POST');
			$('#pictureBook').attr('action', 'excelDownload.do');
			$('form#pictureBook').submit();
			
			$('#pictureBook').attr('method', 'GET');
			$('#pictureBook').attr('action', 'loanList.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
	});
	
});
</script>
<style type="text/css">

.listChange {display: table-cell;width: 200px;line-height: 45px;text-align: center;color: #555;font-size: 15px;border: 1px solid #ccc;background-color: #e5e5e5;}
.listChange.on {position: relative;border: 1px solid #554246;background: #fff;font-weight: bold;color: #554246;}
span.status {display: block;padding: 0 5px;border-radius: 3px;font-size: 12px;letter-spacing: -0.05em;color: #fff;}
span.status.status1 {background-color: #36bc74;}
span.status.status2 {background-color: #7d57de;}
span.status.status3 {background-color: #1ba8ed;}
span.status.status4 {background-color: #E5BA0F;}
span.status.status5 {background-color: #CE3419;}
span.status.status6 {background-color: #787b80;}
a.sub-btn {display: inline-block;padding: 0 5px;border-radius: 3px;font-size: 12px;}
a.cancle-btn {border: 1px solid #787b80;color: #787b80;}
</style>
<div style="padding-bottom: 20px;">
	<a href="#" class="listChange ${pictureBook.pay_yn eq 'N' ? 'on' : ''}" keyValue="N">소형액자</a>
	<a href="#" class="listChange ${pictureBook.pay_yn eq 'Y' ? 'on' : ''}" keyValue="Y">대형액자</a>
</div>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="pictureBook" action="loanList.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pay_yn"/>
<form:hidden path="picture_book_loan_idx"/>
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<form:select path="loan_year" cssClass="selectmenu">
			<form:option value="">전체년도</form:option>
		</form:select>
		<form:select path="loan_month" cssClass="selectmenu">
			<form:option value="">전체월</form:option>
		</form:select>
		<form:select path="request_status" cssClass="selectmenu">
			<form:option value="">상태전체</form:option>
			<form:option value="7">예약완료</form:option>
			<form:option value="1">신청완료</form:option>
			<form:option value="2">대출중</form:option>
			<form:option value="3">반납신청</form:option>
			<form:option value="4">반납요청완료</form:option>
			<form:option value="5">반납완료</form:option>
			<form:option value="6">대출불가</form:option>
		</form:select>
		
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
	</div>
	<div class="search txt-center">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="picture_book_subject">원화명</form:option>
				<form:option value="school_name">학교명</form:option>
				<form:option value="request_name">신청자</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	<table class="type1 center">
		<colgroup>
			<c:if test="${member.admin or loginSupport.auth_group eq '1'}">
			<col width="6%" />
			</c:if>
			<col width="6%" />
			<col />
			<col width="12%" />
			<col width="15%"/>
			<col width="12%" />
			<col width="8%" />
			<col width="10%" />
			<col width="6%" />
		</colgroup>
		<thead>
			<tr>
				<c:if test="${member.admin or loginSupport.auth_group eq '1'}">
				<th>선택</th>
				</c:if>
				<th>번호</th>
				<th>원화명</th>
				<th>대출기간</th>
				<th>학교명/신청자</th>
				<th>신청일자</th>
				<th>비고</th>
				<th>상태</th>
				<th>취소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${pictureBookLoanList}">
				<tr>
					<c:if test="${member.admin or loginSupport.auth_group eq '1'}">
					<td>
						<input type="checkbox" name="picture_book_loan_arr" class="loan_chk" value="${i.picture_book_loan_idx}"/>
					</td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>
						<a href="#" class="view-btn" keyValue="${i.picture_book_loan_idx}">${i.picture_book_subject}</a>
					</td>
					<td class="center">
						${fn:substring(i.loan_start_date, 0, 10)}<br/>
						<span>~</span>${fn:substring(i.loan_end_date, 0, 10)}
					</td>
					<td>${i.school_name}<br/>/${i.request_name}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>${i.pay_yn eq 'Y' ? '무료' : '무료'}</td>
					<td>
						<c:choose>
							<c:when test="${i.request_status eq '7'}"><span class="status status6" style="background:#007e52;">예약완료</span></c:when>
							<c:when test="${i.request_status eq '1'}"><span class="status status2">신청완료</span></c:when>
							<c:when test="${i.request_status eq '2'}"><span class="status status2" style="background:#0061ac;">대출중</span></c:when>
							<c:when test="${i.request_status eq '3'}"><span class="status status3">반납신청</span></c:when>
							<c:when test="${i.request_status eq '4'}"><span class="status status1">반납요청완료</span></c:when>
							<c:when test="${i.request_status eq '5'}"><span class="status status4">반납완료</span></c:when>
							<c:when test="${i.request_status eq '6'}"><span class="status status5">대출불가</span></c:when>
						</c:choose>
					</td>
					<td>
						<c:if test="${i.request_status eq '1' or i.request_status eq '7'}">
						<a href="#" class="cancle-btn sub-btn" keyValue="${i.picture_book_loan_idx}">취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(pictureBookLoanList) < 1}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<c:if test="${member.admin or loginSupport.auth_group eq '1'}">
	<a href="#" id="allChk" keyValue="N">전체 선택/해제</a>
	
	<select id="statusAll" class="selectmenu">
		<option value="">상태변경</option>
		<option value="7">예약완료</option>
		<option value="1">신청완료</option>
		<option value="2">대출중</option>
		<option value="3">반납신청</option>
		<option value="4">반납요청완료</option>
		<option value="5">반납완료</option>
		<option value="6">대출불가</option>
	</select>
	<a href="#" id="status-change" class="btn btn3">선택상태변경</a>
	</c:if>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#pictureBook"/>
		<jsp:param name="pagingUrl" value="loanList.do"/>
	</jsp:include>
</form:form>