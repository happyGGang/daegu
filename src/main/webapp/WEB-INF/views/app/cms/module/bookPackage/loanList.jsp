<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	// 책 꾸러미 대출 수정
	$('a.dialog-edit').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('loanEdit.do?editMode=MODIFY&book_package_loan_idx='+$(this).attr('keyValue'), function(response, status, xhr) {
			$('#dialog-2').dialog('open');
		});		
	});
	
	$('a.return-req').on('click', function(e) {
		e.preventDefault();
		var return_yn = $(this).attr('keyValue2')
		var msg = '';
		
		$('#editMode').val('returnReq');
		$('form#bookPackage').attr('action', 'loanSave.do');
		$('#book_package_loan_idx').val($(this).attr('keyValue'));
		$('input[name="return_yn"]').val(return_yn);
		$('input[name="return_yn"]').prop('checked', true);
		
		if(return_yn == 'Y') {
			msg = '반납요청을 하시겠습니까?';
		} else {
			msg = '반납요청을 취소 하시겠습니까?';
		}
		
		if(confirm(msg)) {
			if(doAjaxPost($('form#bookPackage'))) {
				location.reload();
			}
		}
		
	});
	
	$('a.cancle-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 대출 신청을 취소하시겠습니까?')) {
			$('#editMode').val('DELETE');
			$('form#bookPackage').attr('action', 'loanSave.do');
			$('form#bookPackage').attr('method', 'POST');
			$('#book_package_loan_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#bookPackage'))) {
				location.reload();
			}
		}
	});
	
	var currDate = new Date();
	var year = currDate.getFullYear();
	var currYear = '${bookPackage.loan_start_date}';
	for(var i=2016; i<=year; i++) {
		var selected = '';
		if(currYear == i) {
			selected = 'selected="selected"';
		}
		$('select#loan_start_date').append('<option value="'+i+'" '+selected+'>'+i+'</option>');
	}
	
	$('input[name="return_yn"]').on('click', function() {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#bookPackage').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#bookPackage').serialize());
	});
	
	$('select#request_status, select#loan_start_date, select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#bookPackage').serialize());
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
		
		if($('input[name="book_package_loan_arr"]:checked').length < 1) {
			alert('변경할 신청 리스트를 선택하세요.');
			return false;
		}
		
		if($('select#statusAll option:selected').val() == '') {
			alert('변경할 상태를 선택하세요.');
			return false;
		}
		
		$('select#request_status').val($('select#statusAll').val()).prop('selected', true);
		$('#editMode').val('STATUS');
		$('#bookPackage').attr('action', 'loanSave.do');
		$('#bookPackage').attr('method', 'POST');
		if(doAjaxPost($('#bookPackage'))) {
			location.reload();
		}
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(loanList)}' > 0) {
			$('#editMode').val('bookPackageLoan');
			$('#bookPackage').attr('method', 'POST');
			$('#bookPackage').attr('action', 'excelDownload.do').submit();
			$('form#bookPackage').submit();
			
			$('#bookPackage').attr('method', 'GET');
			$('#bookPackage').attr('action', 'loanList.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
	});
	
});
</script>
<style type="text/css">
input[name="return_yn"] {display: none;}
input[name="return_yn"] + label, input[name="return_yn"].customCheck:checked + label {display: inline-block;cursor: pointer;padding-left: 30px;padding-right: 15px;}
input[name="return_yn"] + label {color: #222;background: url("/resources/common/img/icon_cate_chk.png") no-repeat;}
input[name="return_yn"]:checked + label {color: #1ba8ed;background: url("/resources/common/img/icon_cate_chk_on.png") no-repeat;}

p.point-txt {display: inline-block;padding-left: 22px;background: url(/resources/common/img/icon_point.gif) no-repeat 0 1px;font-size: 13px;line-height: 17px;color: #222;word-break: keep-all;}
span.status {display: block;padding: 0 5px;border-radius: 3px;font-size: 12px;letter-spacing: -0.05em;color: #fff;}
span.status.status1 {background-color: #36bc74;}
span.status.status2 {background-color: #7d57de;}
span.status.status3 {background-color: #1ba8ed;}
span.status.status4 {background-color: #E5BA0F;}
span.status.status5 {background-color: #CE3419;}
span.status.status6 {background-color: #787b80;}
a.sub-btn {display: inline-block;padding: 0 5px;border-radius: 3px;font-size: 12px;}
a.return {border: 1px solid #e94949;color: #e94949;}
a.return2 {background: #e94949;color: #fff;}
a.cancle-btn {border: 1px solid #787b80;color: #787b80;}
</style>
<form:form modelAttribute="bookPackage" action="loanList.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="book_package_loan_idx"/>
<%-- <form:hidden path="return_yn"/> --%>
	<div>
		<form:checkbox path="return_yn" value="Y" label="반납요청"/>
	</div>
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<form:select path="loan_start_date" cssClass="selectmenu">
			<form:option value="">연도별전체</form:option>
		</form:select>
		<form:select path="request_status" cssClass="selectmenu">
			<form:option value="">상태전체</form:option>
			<form:option value="0">신청중</form:option>
			<form:option value="1">예약상담중</form:option>
			<form:option value="2">대출중</form:option>
			<form:option value="3">반납완료</form:option>
			<form:option value="4">관리자취소</form:option>
			<form:option value="5">반납요청완료</form:option>
		</form:select>
		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
	</div>
	<div class="search txt-center">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="book_package_subject">책꾸러미명</form:option>
				<form:option value="school_name">학교명</form:option>
				<form:option value="request_name">신청자</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	<div style="text-align: right;margin-bottom: 5px;">
		<p class="point-txt"><strong>반납요청중</strong>을 클릭하면 반납요청을 취소할 수 있습니다.</p>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col />
			<col />
			<col width="10%" />
			<col width="12%" />
			<col width="12%"/>
			<col width="9%" />
			<col width="5%" />
			<col width="8%" />
			<col width="5%" />
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>책꾸러미명</th>
				<th>주제명</th>
				<th>대출기간</th>
				<th>학교명/신청자</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>권수</th>
				<th>반납요청</th>
				<th>취소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${loanList}">
				<tr>
					<td>
						<input type="checkbox" name="book_package_loan_arr" class="loan_chk" value="${i.book_package_loan_idx}"/>
					</td>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="left">
						<a href="#" class="dialog-edit" keyValue="${i.book_package_loan_idx}">
							${i.book_package_subject}
							<br/>
							<c:if test="${i.request_status eq '1'}">
							<span>(예약일: ${i.loan_start_date}~${fn:substring(i.loan_end_date, 5, 10)})</span>
							</c:if>
						</a>
					</td>
					<td class="left">${i.keyword}</td>
					<td class="center">
						<c:if test="${i.request_status ne '1'}">
						${i.loan_start_date}<br/>
						<span>~</span>${i.loan_end_date}
						</c:if>
					</td>
					<td>
						${i.school_name}<br/>
						/${i.request_name}
					</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:choose>
							<c:when test="${i.request_status eq '0'}"><span class="status status1">신청중</span></c:when>
							<c:when test="${i.request_status eq '1'}"><span class="status status2">예약상담중</span></c:when>
							<c:when test="${i.request_status eq '2'}"><span class="status status3">대출중</span></c:when>
							<c:when test="${i.request_status eq '3'}"><span class="status status4">반납완료</span></c:when>
							<c:when test="${i.request_status eq '4'}"><span class="status status5">관리자취소</span></c:when>
							<c:when test="${i.request_status eq '5'}"><span class="status status6">반납요청완료</span></c:when>
						</c:choose>
					</td>
					<td>${i.loan_count}권</td>
					<td>
						<c:if test="${i.request_status eq '2'}">
						<c:choose>
							<c:when test="${i.return_yn eq 'N'}">
							<a href="#" class="return-req sub-btn return" keyValue="${i.book_package_loan_idx}" keyValue2="Y">반납요청</a>
							</c:when>
							<c:otherwise>
							<a href="#" class="return-req sub-btn return2" keyValue="${i.book_package_loan_idx}" keyValue2="N">반납요청중</a>
							</c:otherwise>
						</c:choose>
						</c:if>
					</td>
					<td>
						<c:if test="${i.request_status eq '0' or i.request_status eq '1'}">
						<a href="#" class="cancle-btn sub-btn" keyValue="${i.book_package_loan_idx}">취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(loanList) < 1}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<a href="#" id="allChk" keyValue="N">전체 선택/해제</a>
	<select id="statusAll" class="selectmenu">
		<option value="">상태전체</option>
		<option value="0">신청중</option>
		<option value="1">예약상담중</option>
		<option value="2">대출중</option>
		<option value="3">반납완료</option>
		<option value="4">관리자취소</option>
		<option value="5">반납요청완료</option>
	</select>
	<a href="#" id="status-change" class="btn btn3">선택상태변경</a>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookPackage"/>
		<jsp:param name="pagingUrl" value="loanList.do"/>
	</jsp:include>
</form:form>

<div id="dialog-2" class="dialog-common" title="대출리스트"></div>