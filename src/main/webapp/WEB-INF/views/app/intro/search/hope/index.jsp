<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
});

</script>
<%-- <div style="padding:0 0 10px">
	<c:if test="${view_yn}">
		<a id="req-btn" class="btn btn5"><i class="fa fa-plus"></i><span>희망도서신청</span></a>
	</c:if>
</div> --%>
<div class="book-list">
	<c:if test="${fn:length(hopeList.dsMyLibraryList) < 1 }"> <h3>희망도서신청 내역이 없습니다.</h3></c:if>
	<c:forEach items="${hopeList.dsMyLibraryList}" var="i">
		
			<div class="row">
				<div class="box">
					<div class="item">
						<div class="bif">
							<div class="top" >
								<div class="b-title">
									<div class="box"><a href="" class="name">${i.TITLE}</a></div>
								</div>
								<div class="control">
									<c:if test="${i.CANCELABLE_YN eq 'Y'}">
										<a href="" class="btn cancel-btn" keyValue="${i.SELECT_NO}">신청 취소</a>
									</c:if>
								</div>
							</div>
							<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLER}</em> <span>/</span> <em>출판년도 : ${i.PUBLER_YEAR}</em></p>
						</div>
						<div class="bci">
							<table summary="신청정보">
								<tbody>
									<tr>
										<th>비치처</th>
										<td>${i.LOCA_NAME}</td>
									</tr>
									<tr>
										<th>신청일</th>
										<td>${i.INSERT_DATE}</td>
									</tr>
									<tr>
										<th>처리일</th>
										<td>${i.PROCESS_DATE}</td>
									</tr>
									<tr>
										<th>처리결과</th>
										<td>${i.STATUS_FLAG_DISPLAY}</td>
									</tr>
									<tr>
										<th>비고사항</th>
										<td>${i.USER_REMARK}</td>
									</tr>
									<c:if test="${i.CANCEL_REASON ne null and i.CANCEL_REASON ne ''}">
									<tr>
										<th>취소사유</th>
										<td>${i.CANCEL_REASON}</td>
									</tr> 
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	</c:forEach>		
</div>

<form:form id="modHope" modelAttribute="librarySearch" method="POST" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="select_no"/>
</form:form>