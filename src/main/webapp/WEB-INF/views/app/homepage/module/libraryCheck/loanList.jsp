<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	// 책 꾸러미 대출 수정
	$('a.edit-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'menu_idx='+$('#menu_idx').val()+'&editMode=MODIFY&library_check_loan_idx='+$(this).attr('keyValue')+'&viewPage='+$('#viewPage').val();
		doGetLoad('loanEdit.do', formData);
	});
	
	$('a.cancle-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 대출 신청을 취소하시겠습니까?')) {
			$('#editMode').val('DELETE');
			$('#library_check_loan_idx').val($(this).attr('keyValue'));
			$('#libraryCheck').attr('action', 'loanSave.do');
			$('#libraryCheck').attr('method', 'POST');
			if(doAjaxPost($('form#libraryCheck'))) {
				location.reload();
			}
		}
	});
	
	$('.listChage').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#libraryCheck').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#libraryCheck').serialize());
	});
	
	$('select#library_check_number, select#request_status').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#libraryCheck').serialize());
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
		
		if($('input[name="library_check_loan_arr"]:checked').length < 1) {
			alert('변경할 신청 리스트를 선택하세요.');
			return false;
		}
		
		if($('select#statusAll option:selected').val() == '') {
			alert('변경할 상태를 선택하세요.');
			return false;
		}
		
		$('select#request_status').val($('select#statusAll').val()).prop('selected', true);
		$('#editMode').val('STATUS');
		$('#libraryCheck').attr('action', 'loanSave.do');
		$('#libraryCheck').attr('method', 'POST');
		if(doAjaxPost($('#libraryCheck'))) {
			location.reload();
		}
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(libraryCheckLoanList)}' > 0) {
			$('#libraryCheck').attr('method', 'POST');
			$('#libraryCheck').attr('action', 'excelDownload.do').submit();
			$('form#libraryCheck').submit();
			
			$('#libraryCheck').attr('method', 'GET');
			$('#libraryCheck').attr('action', 'loanList.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
	});
	
});
</script>
<style type="text/css">
.listChage {background-color: #ccc;}
.listChage.on {background: none;}
</style>
<form:form modelAttribute="libraryCheck" action="loanList.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="viewPage"/>
<form:hidden path="library_check_loan_idx"/>
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<form:select path="library_check_number" cssClass="selectmenu">
			<form:option value="-1">상태점검기전체</form:option>
			<c:forEach items="${libraryCheckList}" var="i">
			<form:option value="${i.library_check_number}">장서점검기${i.library_check_number}</form:option>
			</c:forEach>
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
		
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<c:if test="${sessionScope.authGroup eq '1'}">
			<col width="4%" />
			</c:if>
			<col width="7%" />
			<col />
			<col width="12%" />
			<col width="12%"/>
			<col width="15%" />
			<col width="12%" />
			<col width="10%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<c:if test="${sessionScope.authGroup eq '1'}">
				<th>선택</th>
				</c:if>
				<th>번호</th>
				<th>장서점검기</th>
				<th>대출기간</th>
				<th>방문예정일자</th>
				<th>학교명/신청자</th>
				<th>신청일자</th>
				<th>상태</th>
				<th>취소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${libraryCheckLoanList}">
				<tr>
					<c:if test="${sessionScope.authGroup eq '1'}">
					<td>
						<input type="checkbox" name="library_check_loan_arr" class="loan_chk" value="${i.library_check_loan_idx}"/>
					</td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>
						<a href="#" class="edit-btn" keyValue="${i.library_check_loan_idx}">장서점검기${i.library_check_number}</a>
					</td>
					<td class="center">${i.loan_start_date}<br/>~${i.loan_end_date}</td>
					<td>${i.hope_date}</td>
					<td>${i.school_name}<br/>/${i.request_name}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:choose>
							<c:when test="${i.request_status eq '0'}">신청중</c:when>
							<c:when test="${i.request_status eq '1'}">예약상담중</c:when>
							<c:when test="${i.request_status eq '2'}">대출중</c:when>
							<c:when test="${i.request_status eq '3'}">반납완료</c:when>
							<c:when test="${i.request_status eq '4'}">관리자취소</c:when>
							<c:when test="${i.request_status eq '5'}">반납요청완료</c:when>
						</c:choose>
					</td>
					<td>
						<c:if test="${i.request_status eq '0' or i.request_status eq '1'}">
						<a href="#" class="cancle-btn" keyValue="${i.library_check_loan_idx}">취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(libraryCheckLoanList) < 1}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<c:if test="${sessionScope.authGroup eq '1'}">
	<a href="#" id="allChk" keyValue="N">전체 선택/해제</a>
	
	<select id="statusAll" class="selectmenu">
		<option value="">상태변경</option>
		<option value="0">신청중</option>
		<option value="1">예약상담중</option>
		<option value="2">대출중</option>
		<option value="3">반납완료</option>
		<option value="4">관리자취소</option>
		<option value="5">반납요청완료</option>
	</select>
	<a href="#" id="status-change" class="btn btn3">선택상태변경</a>
	</c:if>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#libraryCheck"/>
		<jsp:param value="pagingUrl" name="loanList.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="school_name">학교명</form:option>
				<form:option value="request_name">신청자</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-2" class="dialog-common" title="장서점검기 "></div>