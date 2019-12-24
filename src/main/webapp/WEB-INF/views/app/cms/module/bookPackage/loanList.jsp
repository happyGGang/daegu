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
	
	$('select#request_status, select#loan_start_date').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('loanList.do', $('form#bookPackage').serialize());
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
		
		<div class="button">
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col />
			<col width="12%" />
			<col width="12%" />
			<col width="12%"/>
			<col width="12%" />
			<col width="10%" />
			<col width="12%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>책꾸러미명</th>
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
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>
						<a href="#" class="dialog-edit" keyValue="${i.book_package_loan_idx}">
							${i.book_package_subject}
							<br/>
							<c:if test="${i.request_status eq '1'}">
							<span>(예약일: )</span>
							</c:if>
						</a>
					</td>
					<td class="center">
						${i.loan_start_date}
						<br/><span>~</span><br/>
						${i.loan_end_date}
					</td>
					<td>
						${i.school_name}<br/>
						/${i.request_name}
					</td>
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
					<td>${i.quantity}</td>
					<td>
						<c:choose>
							<c:when test="${i.return_yn eq 'N'}">
							<a href="#" class="return-req" keyValue="${i.book_package_loan_idx}" keyValue2="Y">반납요청</a>
							</c:when>
							<c:otherwise>
							<a href="#" class="return-req" keyValue="${i.book_package_loan_idx}" keyValue2="N">반납요청중</a>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:if test="${i.request_status eq '0' or i.request_status eq '1'}">
						<a href="#" class="cancle-btn" keyValue="${i.book_package_loan_idx}">취소</a>
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
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookPackage"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
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
</form:form>

<div id="dialog-2" class="dialog-common" title="대출리스트"></div>