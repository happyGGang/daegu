<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<style>
	.view-detail { cursor: pointer; }
</style>
<script type="text/javascript">
$(function() {
	$('.view-detail').on('click', function(e) {
		e.preventDefault();
		var loan_no = $(this).data('loan_no');
		location.href = 'detail.do?vLoanNo=' + loan_no + '&menu_idx=${librarySearch.menu_idx}';
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('LOAN');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/excelDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('LOAN');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/csvDownload.do');
		$('#excelDownForm').submit();
	});
});
</script>
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</c:when>
<c:otherwise>

<c:if test="${fn:length(loanList.dsMyLibraryList) > 0}">
	<div style="text-align: right">
		<a class="btn btn2 excel-btn">엑셀 저장</a>
		<a class="btn btn2 csv-btn">CSV 저장</a>
		<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
			<form:hidden path="excel_type"/>
			
		</form:form>
	</div>
</c:if>

</c:otherwise>
</c:choose>



<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/app/css/sub_layout.css"/>

<div class="subpage_title">
	<h4>대출이력</h4>
</div>
<div class="mylibrary-btn-section">
	<ul>
		<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=5"><img src="/resources/homepage/app/img/mylib01.png" alt=""><br/>대출중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=11" class="on"><img src="/resources/homepage/app/img/mylib02.png" alt=""><br/>대출이력</a></li>
		<li><a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=12"><img src="/resources/homepage/app/img/mylib03.png" alt=""><br/>예약중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=13"><img src="/resources/homepage/app/img/mylib04.png" alt=""><br/>희망도서신청내역</a></li>
		<li><a href="/${homepage.context_path}/html.do?menu_idx=24"><img src="/resources/homepage/app/img/mylib05.png" alt=""><br/>희망도서신청</a></li>
	</ul>
</div>

<div class="book-list">
<c:if test="${fn:length(loanList.dsMyLibraryList) < 1 }"> <h3>조회된 도서가 없습니다.</h3></c:if>
	<c:if test="${fn:length(loanList.dsMyLibraryList) > 0 }">
		<div class="alarm_list">
			<ul>
				<c:forEach items="${loanList.dsMyLibraryList}" var="i" varStatus="status">
				<li class="view-detail" data-loan_no="${i.LOAN_NO}">
					<p class="book_title">${status.index+1}. ${i.TITLE} / ${i.LOAN_LOCA_NAME}</p>
					<p class="book_status">${i.RETURN_TYPE_NAME}</p>
					<p class="date">대출일 : <fmt:parseDate var="curDate" value="${i.LOAN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/></p>
					<p class="date">반납예정일 : <fmt:parseDate var="curDate" value="${i.RETURN_PLAN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/></p>
					<p class="date">반납일 : <fmt:parseDate var="curDate" value="${i.RETURN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/></p>
				</li>
				<%-- [열 번호] 				: ${i.ROW_ID} <br/>
				[대출 일련번호] 			: ${i.LOAN_NO} <br/>
				[등록번호 - 자리수고정] 	: ${i.ACSSON_NO} <br/>
				[딸림자료] 			: ${i.ADD_LOAN} <br/>
				[저자] 				: ${i.AUTHOR} <br/>
				[청구기호] 			: ${i.CALL_NO} <br/>
				[제어번호] 			: ${i.CTRLNO} <br/>
				[대출일] 				: ${i.LOAN_DATE} <br/>
				[대출시간] 			: ${i.LOAN_TIME} <br/>
				[대출된 소장처 코드] 		: ${i.LOAN_LOCA} <br/>
				[대출된 소장처명] 		: ${i.LOAN_LOCA_NAME} <br/>
				[소장처코드] 			: ${i.LOCA} <br/>
				[소장처명] 			: ${i.LOCA_NAME} <br/>
				[등록번호 - 디스플레이용] 	: ${i.PRINT_ACSSON_NO} <br/>
				[출판사] 				: ${i.PUBLER} <br/>
				[연장횟수] 			: ${i.RENEW_CNT} <br/>
				[반납일] 				: ${i.RETURN_DATE} <br/>
				[반납된 소장처 코드] 		: ${i.RETURN_LOCA} <br/>
				[반납된 소장처명] 		: ${i.RETURN_LOCA_NAME} <br/>
				[반납예정일] 			: ${i.RETURN_PLAN_DATE} <br/>
				[반납시간]	 			: ${i.RETURN_TIME} <br/>
				[반납유형코드] 			: ${i.RETURN_TYPE} <br/>
				[반납유형] 			: ${i.RETURN_TYPE_NAME} <br/> 
				[자료실코드] 			: ${i.SUB_LOCA} <br/>
				[자료실명] 			: ${i.SUB_LOCA_NAME} <br/>
				[서명] 				: ${i.TITLE} <br/>
				[별치기호] 			: ${i.PLACE_NO} <br/>
				[대출유형코드] 			: ${i.LOAN_TYPE} <br/>
				[대출유형] 			: ${i.LOAN_TYPE_NAME} <br/> --%>
			
				</c:forEach>
			</ul>
		</div>
	</c:if>
</div>


</c:when>
<c:otherwise>

<div class="book-list">
<c:if test="${fn:length(loanList.dsMyLibraryList) < 1 }"> <h3>조회된 도서가 없습니다.</h3></c:if>
	<c:if test="${fn:length(loanList.dsMyLibraryList) > 0 }">
		<table summary="신청정보">
			<colgroup>
				<col width="50px"/>
				<col/>
				<col width="20%"/>
				<col width="12%"/>
				<col width="12%"/>
				<col width="12%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>서명</th>
					<th>소장처명</th>
					<th>대출일</th>
					<th>반납예정일</th>
					<th>반납일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${loanList.dsMyLibraryList}" var="i" varStatus="status">
				<tr class="view-detail" data-loan_no="${i.LOAN_NO}">
					<td class="center">${status.index+1}</td>
					<td class="left"><a>${i.TITLE}</a></td>
					<td>${i.LOAN_LOCA_NAME}</td>
					<td>
						<fmt:parseDate var="curDate" value="${i.LOAN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						<fmt:parseDate var="curDate" value="${i.RETURN_PLAN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						<fmt:parseDate var="curDate" value="${i.RETURN_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
					</td>
					<td>${i.RETURN_TYPE_NAME}</td>
				</tr>
				
			<%-- [열 번호] 				: ${i.ROW_ID} <br/>
			[대출 일련번호] 			: ${i.LOAN_NO} <br/>
			[등록번호 - 자리수고정] 	: ${i.ACSSON_NO} <br/>
			[딸림자료] 			: ${i.ADD_LOAN} <br/>
			[저자] 				: ${i.AUTHOR} <br/>
			[청구기호] 			: ${i.CALL_NO} <br/>
			[제어번호] 			: ${i.CTRLNO} <br/>
			[대출일] 				: ${i.LOAN_DATE} <br/>
			[대출시간] 			: ${i.LOAN_TIME} <br/>
			[대출된 소장처 코드] 		: ${i.LOAN_LOCA} <br/>
			[대출된 소장처명] 		: ${i.LOAN_LOCA_NAME} <br/>
			[소장처코드] 			: ${i.LOCA} <br/>
			[소장처명] 			: ${i.LOCA_NAME} <br/>
			[등록번호 - 디스플레이용] 	: ${i.PRINT_ACSSON_NO} <br/>
			[출판사] 				: ${i.PUBLER} <br/>
			[연장횟수] 			: ${i.RENEW_CNT} <br/>
			[반납일] 				: ${i.RETURN_DATE} <br/>
			[반납된 소장처 코드] 		: ${i.RETURN_LOCA} <br/>
			[반납된 소장처명] 		: ${i.RETURN_LOCA_NAME} <br/>
			[반납예정일] 			: ${i.RETURN_PLAN_DATE} <br/>
			[반납시간]	 			: ${i.RETURN_TIME} <br/>
			[반납유형코드] 			: ${i.RETURN_TYPE} <br/>
			[반납유형] 			: ${i.RETURN_TYPE_NAME} <br/> 
			[자료실코드] 			: ${i.SUB_LOCA} <br/>
			[자료실명] 			: ${i.SUB_LOCA_NAME} <br/>
			[서명] 				: ${i.TITLE} <br/>
		 	[별치기호] 			: ${i.PLACE_NO} <br/>
		   	[대출유형코드] 			: ${i.LOAN_TYPE} <br/>
		 	[대출유형] 			: ${i.LOAN_TYPE_NAME} <br/> --%>
		 	
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>

</c:otherwise>
</c:choose>
