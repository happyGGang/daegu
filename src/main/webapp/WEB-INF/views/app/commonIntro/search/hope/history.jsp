<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#req-btn').on('click', function(e) {
		doGetLoad('req.do');
		e.preventDefault();
	});
	
	$('.cancel-btn').on('click', function(e) {
		$('#editMode').val("CANCEL");
		$('#select_no').val($(this).attr('keyValue'));
		if ( doAjaxPost($('#modHope')) ) {
			location.reload();
		}
		e.preventDefault();
	});
	
	$('.del-btn').on('click', function(e) {
		$('#editMode').val("DELETE");
		$('#select_no').val($(this).attr('keyValue'));
		if ( doAjaxPost($('#modHope')) ) {
			
		}
		e.preventDefault();
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excelStart').val($('input#search_start_date').val());
		$('#excelDownForm #excelEnd').val($('input#search_end_date').val());
		$('#excelDownForm #excel_type').val('HOPE');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/excelDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excelStart').val($('input#search_start_date').val());
		$('#excelDownForm #excelEnd').val($('input#search_end_date').val());
		$('#excelDownForm #excel_type').val('HOPE');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/csvDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('history.do', $('form#searchForm').serialize());		
	});
	
	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(), 
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(), 
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
});

</script>

<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/app/css/sub_layout.css"/>

<div class="subpage_title">
	<h4>희망도서 신청내역</h4>
</div>

<div class="mylibrary-btn-section">
	<ul>
		<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=5"><img src="/resources/homepage/app/img/mylib01.png" alt=""><br/>대출중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=11"><img src="/resources/homepage/app/img/mylib02.png" alt=""><br/>대출이력</a></li>
		<li><a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=12"><img src="/resources/homepage/app/img/mylib03.png" alt=""><br/>예약중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=13" class="on"><img src="/resources/homepage/app/img/mylib04.png" alt=""><br/>희망도서신청내역</a></li>
		<li><a href="/${homepage.context_path}/html.do?menu_idx=24"><img src="/resources/homepage/app/img/mylib05.png" alt=""><br/>희망도서신청</a></li>
	</ul>
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>


<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
	<form:hidden path="excel_type"/>
	<form:hidden path="search_start_date" id="excelStart"/>
	<form:hidden path="search_end_date" id="excelEnd"/>
</form:form>

<c:choose>
<c:when test="${homepage.context_path eq 'app'}">


<div style="padding:10px;box-sizing:border-box">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>

<form:form modelAttribute="librarySearch" id="searchForm" method="post">
<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:10px;padding:10px 5px" >
	<span class="" style="letter-spacing:-1px">조회기간 :</span> 
		<form:input path="search_start_date" cssClass="text ui-calendar" title="시작일, 입력예시 2017-01-01"/><label for="search_start_date" class="blind">시작일</label>~<form:input path="search_end_date" cssClass="text ui-calendar" title="종료일, 입력예시 2017-01-01" /><label for="search_end_date" class="blind">종료일</label>
		<form:hidden path="menu_idx"/>
		<a href="#" id="search-btn" class="btn btn1" title="조회" >조회</a>

		<c:choose>
		<c:when test="${homepage.context_path eq 'app'}">
		</c:when>
		<c:otherwise>

			<c:if test="${fn:length(hopeList.dsMyLibraryList) > 0 }">
			<a class="btn btn2 excel-btn" title="엑셀 저장" ><i class="fa fa-file-excel-o"></i>엑셀 저장</a>
			<a class="btn btn2 csv-btn" title="CSV저장" ><i class="fa fa-file-excel-o"></i>CSV 저장</a>
			</c:if>

		</c:otherwise>
		</c:choose>
</div>
</form:form>
<div class="book-list">
	<c:if test="${fn:length(hopeList.dsMyLibraryList) < 1 }"> <h3>희망도서신청 내역이 없습니다.</h3></c:if>
	<c:forEach items="${hopeList.dsMyLibraryList}" var="i">
		
			<div class="row">
				<div class="box">
					<div class="item">
						<div class="bif">
							<div class="top" >
								<div class="b-title">
									<div class="box"><a href="#" class="name" title="제목">${i.TITLE}</a></div>
								</div>
								<div class="control">
									<c:if test="${i.CANCELABLE_YN eq 'Y'}">
										<a href="" class="btn cancel-btn" keyValue="${i.SELECT_NO}" title="신청 취소">신청 취소</a>
									</c:if>
								</div>
							</div>
							<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLER}</em> <span>/</span> <em>출판년도 : ${i.PUBLER_YEAR}</em></p>
						</div>
						<div class="bci">
							<table>
								<caption class="blind">신청정보</caption>
								<colgroup>
									<col width="15%"/>
									<col width="35%"/>
									<col width="15%"/>
									<col width="35%"/>
								</colgroup>
								<tbody>
									<tr>
										<th>신청도서관</th>
										<td>${i.LOCA_NAME}</td>
										<th>신청일</th>
										<td>
											<c:catch var="e1">
											<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMddHHmmss" var="insertDate"/>
											<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd HH:mm"/>	
											</c:catch>
											<c:if test="${e1 != null}">
											<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMdd" var="insertDate"/>
											<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd"/>	
											</c:if>
										</td>
									</tr>
									<tr>
										<th>처리결과</th>
										<td>${i.STATUS_FLAG_DISPLAY}</td>
										<th>처리일</th>
										<td>
											<c:if test="${i.INSERT_DATE ne i.PROCESS_DATE}">
											<c:catch var="e2">
											<fmt:parseDate value="${i.PROCESS_DATE}" pattern="yyyyMMddHHmmss" var="processDate"/>
											<fmt:formatDate value="${processDate}" pattern="yyyy-MM-dd HH:mm"/>	
											</c:catch>
											<c:if test="${e2 != null}">
											<fmt:parseDate value="${i.PROCESS_DATE}" pattern="yyyyMMdd" var="processDate"/>
											<fmt:formatDate value="${processDate}" pattern="yyyy-MM-dd"/>	
											</c:if>
											</c:if>
										</td>
									</tr>
									<c:if test="${i.CANCEL_REASON ne null and i.CANCEL_REASON ne ''}">
									<tr>
										<th>취소사유</th>
										<td colspan="3">
											<c:choose>
												<c:when test="${not empty i.REMARK}">
											${i.REMARK}
												</c:when>
												<c:otherwise>
											${i.CANCEL_REASON}
												</c:otherwise>
											</c:choose>
										</td>
									</tr> 
									</c:if>
									<tr>
										<th>이용자 비고</th>
										<td colspan="3">${i.USER_REMARK}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	</c:forEach>		
</div>

<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>



<form:form id="modHope" modelAttribute="librarySearch" method="POST" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="select_no"/>
</form:form>