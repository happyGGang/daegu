<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a.loan-renew').on('click', function(e) {
		$('#renewLoanForm #editMode').val('RENEW');
		$('#renewLoanForm #vLoanNo').val($(this).attr('vLoanNo'));
		$('#renewLoanForm #vLoca').val($(this).attr('vLoca'));
		$('#renewLoanForm #vSubLoca').val($(this).attr('vSubLoca'));

		if ( doAjaxPost($('#renewLoanForm')) ) {
			location.reload();
		}
		e.preventDefault();
	});

	$('a#view-list').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
});
</script>
<form:form id="renewLoanForm" modelAttribute="librarySearch" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="vLoanNo"/>
	<form:hidden path="vLoca" htmlEscape="true"/>
	<form:hidden path="vSubLoca" htmlEscape="true"/>
</form:form>

<div class="book-list">
<c:if test="${empty loanDetail}"> <h3>현재 대출 중인 도서가 없습니다.</h3></c:if>
<c:if test="${not empty loanDetail}">
<c:forEach items="${loanDetail.dsMyLibraryListD}" var="i">
	<div class="row">
		<div class="box">
			<div class="item">
				<div class="bif">
					<div class="top">
						<div class="b-title">
							<div class="box"><a href="" class="name">${i.TITLE}</a></div>
						</div>
						<div class="control">
							<%-- 00147009 성주, 00147004 군위 --%>
							<c:if test="${(i.LOCA eq '00147009' or i.LOCA eq '00147004') and i.RETURN_TYPE_NAME ne '정상반납'}">
								<a href="" class="btn loan-renew" vLoanNo="${i.LOAN_NO}" vLoca="${fn:escapeXml(i.LOCA)}" vSubLoca="${fn:escapeXml(i.SUB_LOCA)}">대출 연장</a>
							</c:if>
						</div>
					</div>
					<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLER}</em> </p>
				</div>
				<div class="bci">
					<table summary="신청정보">
						<tbody>
							<tr>
								<th>대출된 소장처명</th>
								<td>${i.LOCA_NAME}</td>
							</tr>
							<tr>
								<th>대출된 자료실명</th>
								<td>${i.SUB_LOCA_NAME}</td>
							</tr>
							<tr>
								<th>대출연장횟수</th>
								<td>${i.RENEW_CNT}</td>
							</tr>
							<tr>
								<th>대출일</th>
								<td>
									<fmt:parseDate var="curDate" value="${i.LOAN_DATE}" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
							<tr>
								<th>반납예정일</th>
								<td>
									<fmt:parseDate var="curDate" value="${i.RETURN_PLAN_DATE}" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${curDate}" type="both" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>${i.RETURN_TYPE_NAME}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
	<%-- [열 번호] 				: ${loanDetail.ROW_ID} <br/>
	[대출 일련번호] 			: ${loanDetail.LOAN_NO} <br/>
	[등록번호 - 자리수고정] 	: ${loanDetail.ACSSON_NO} <br/>
	[딸림자료] 			: ${loanDetail.ADD_LOAN} <br/>
	[저자] 				: ${loanDetail.AUTHOR} <br/>
	[청구기호] 			: ${loanDetail.CALL_NO} <br/>
	[제어번호] 			: ${loanDetail.CTRLNO} <br/>
	[대출일] 				: ${loanDetail.LOAN_DATE} <br/>
	[대출시간] 			: ${loanDetail.LOAN_TIME} <br/>
	[대출된 소장처 코드] 		: ${loanDetail.LOAN_LOCA} <br/>
	[대출된 소장처명] 		: ${loanDetail.LOAN_LOCA_NAME} <br/>
	[소장처코드] 			: ${loanDetail.LOCA} <br/>
	[소장처명] 			: ${loanDetail.LOCA_NAME} <br/>
	[등록번호 - 디스플레이용] 	: ${loanDetail.PRINT_ACSSON_NO} <br/>
	[출판사] 				: ${loanDetail.PUBLER} <br/>
	[연장횟수] 			: ${loanDetail.RENEW_CNT} <br/>
	[반납일] 				: ${loanDetail.RETURN_DATE} <br/>
	[반납된 소장처 코드] 		: ${loanDetail.RETURN_LOCA} <br/>
	[반납된 소장처명] 		: ${loanDetail.RETURN_LOCA_NAME} <br/>
	[반납예정일] 			: ${loanDetail.RETURN_PLAN_DATE} <br/>
	[반납시간]	 			: ${loanDetail.RETURN_TIME} <br/>
	[반납유형코드] 			: ${loanDetail.RETURN_TYPE} <br/>
	[반납유형] 			: ${loanDetail.RETURN_TYPE_NAME} <br/>
	[자료실코드] 			: ${loanDetail.SUB_LOCA} <br/>
	[자료실명] 			: ${loanDetail.SUB_LOCA_NAME} <br/>
	[서명] 				: ${loanDetail.TITLE} <br/> 	[별치기호] 			: ${loanDetail.PLACE_NO} <br/>   	[대출유형코드] 			: ${loanDetail.LOAN_TYPE} <br/> 	[대출유형] 			: ${loanDetail.LOAN_TYPE_NAME} <br/> --%>
</c:if>
</div>
<br/>
<div class="button center" style="padding-bottom:20px;">
	<a href="#" class="btn" id="view-list"><i class="fa fa-list"></i><span>목록 보기</span></a>
</div>