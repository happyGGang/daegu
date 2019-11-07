<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a.resve-cancel').on('click', function(e) {
		$('#resveCancelForm #editMode').val('CANCEL');
		$('#resveCancelForm #vResveNo').val($(this).attr('vResveNo'));
		
		if ( doAjaxPost($('#resveCancelForm')) ) {
			location.reload();
		}
		e.preventDefault();
	});
});

</script>
<form:form id="resveCancelForm" modelAttribute="librarySearch" action="save.do">
	<form:hidden path="editMode" value="CANCEL"/>
	<form:hidden path="vResveNo"/>
</form:form>

<div class="book-list">
	<c:if test="${fn:length(hopeList.dsMyLibraryList) < 1 }"> <h3>예약중인 도서 내역이 없습니다.</h3></c:if>
	<c:forEach items="${resveList.dsMyLibraryList}" var="i"> 
		<div class="row">
			<div class="box">
				<div class="item">
					<div class="bif">
						<div class="top">
							<div class="b-title">
								<div class="box"><a href="" class="name">${i.TITLE}</a></div>
							</div>
							<div class="control">
								<c:if test="${i.STATUS_NAME != '예약취소'}">
								<a href="" class="btn resve-cancel" vResveNo="${i.RESVE_NO}">예약 취소</a>
								</c:if>
							</div>
						</div>
						<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLER}</em> </p>
					</div>
					<div class="bci">
						<table summary="신청정보">
							<tbody>
								<tr>
									<th>소장처명</th>
									<td>${i.LOCA_NAME}</td>
								</tr>
								<tr>
									<th>예약일</th>
									<td>${i.RESVE_DATE}</td>
								</tr>
								<tr>
									<th>예약순위</th>
									<td>${i.RESVE_RANK}</td>
								</tr>
								<tr>
									<th>예약상태</th>
									<td>${i.STATUS_NAME}</td>
								</tr>
								<tr>
									<th>예약유효일</th>
									<td>${i.RESVE_VALID_DATE}</td>
								</tr>
								<tr>
									<th>도착통보일</th>
									<td>${i.RPT_DATE}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	
	<%-- [저자] 						: ${i.AUTHOR} <br/> 
	[청구기호] 					: ${i.CALL_NO} <br/>
	[제어번호] 					: ${i.CTRLNO} <br/>
	[대출가능일] 					: ${i.LOAN_POSBL_DATE} <br/> 
	[소장처코드] 					: ${i.LOCA} <br/>
	[소장처명] 					: ${i.LOCA_NAME} <br/>
	[출판사] 						: ${i.PUBLER} <br/>
	[통보받은 등록번호 - 자리수고정] 	: ${i.RECPT_ACSSON_NO} <br/> 
	[통보받은 등록번호 - 디스플레이용] 	: ${i.RECPT_PRINT_ACSSON_NO} <br/>
	[예약일] 						: ${i.RESVE_DATE} <br/>
	[예약 일련번호]	 				: ${i.RESVE_NO} <br/>
	[예약순위] 					: ${i.RESVE_RANK} <br/>
	[예약상태코드] 					: ${i.RESVE_STATUS} <br/>
	[예약시간] 					: ${i.RESVE_TIME} <br/>
	[예약유효일] 					: ${i.RESVE_VALID_DATE} <br/>
	[열 번호] 						: ${i.ROW_ID} <br/> 
	[도착통보일] 					: ${i.RPT_DATE} <br/>
	[예약상태] 					: ${i.STATUS_NAME} <br/>
	[자료실코드] 					: ${i.SUB_LOCA} <br/>
	[자료실명] 					: ${i.SUB_LOCA_NAME} <br/> 
	[서명] 						: ${i.TITLE} <br/> 
	[권호기호] 					: ${i.VOLUME_NO} <br/> --%> 
	</c:forEach>
</div>


