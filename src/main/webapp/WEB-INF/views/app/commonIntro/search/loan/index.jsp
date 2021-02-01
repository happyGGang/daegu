<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a.delay-btn').on('click', function(e) {
		e.preventDefault();

		$('input#editMode').val('RENEW');
		$('input#loan_key').val($(this).attr('keyValue1'));

		if ( doAjaxPost($('form#renewForm')) ) {
			location.reload();
		}
	});
	
	$('#select_manage').on('change', function() {
		var menu_idx = '${librarySearch.menu_idx}';
		doGetLoad('index.do', 'menu_idx='+menu_idx+'&manageCode='+$(this).val());
	});
	
	$('#excel-btn').on('click', function(e) {
		e.preventDefault();
		var param = 'excel_type=LOAN';
		doGetLoad('/${homepage.context_path}/intro/search/excelDownload.do', param);
	});

});
</script>

<form id="renewForm" action="save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="loan_key" id="loan_key">
	<input type="hidden" name="editMode" value="RENEW">
</form>

<a href="#" id="excel-btn" class="btn btn2">EXCEL</a>

<!-- contents-title-->
<div id="contents-title">
	<h2>대출중인도서<span style="font-weight:300">를 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<fieldset>
	<select name="manageCode" class="selectmenu" id="select_manage">
		<option value="">전체</option>
		<c:forEach items="${homepageList}" var="mc">
		<c:if test="${not empty mc.manage_code}">
		<option value="${mc.manage_code}" ${librarySearch.manageCode eq mc.manage_code ? 'selected' : ''}>${mc.homepage_name}</option>
		</c:if>
		</c:forEach>
	</select>
</fieldset>

<div>
대출중 권수 : ${fn:length(loanList)}<br/>
대출연체 권수 : ${member.overdue_cnt}<br/>
대출정지만기일 : ${member.loan_stop_date eq 'null' ? '해당없음' : member.loan_stop_date}
</div>

<div class="book-list">

<c:if test="${fn:length(loanList) < 1 }"> <h3>현재 대출 중인 도서가 없습니다.</h3></c:if>
<c:forEach items="${loanList}" var="i">
	<div class="row">
		<div class="box">
			<div class="item">
				<div class="bif">
					<div class="top">
						<div class="b-title">
							<div class="box">${i.TITLE_INFO}</div>
						</div>
						<div class="control">
							<c:if test="${i.RETURN_DEALY_CODE eq '100'}">
<%-- 							<a href="#" class="btn delay-btn" keyValue1="${i.PK}">반납연기</a> --%>
							</c:if>
						</div>
					</div>
					<p class="info"><em>저자 : ${i.AUTHOR}</em> <span>/</span> <em>출판사 : ${i.PUBLISHER}</em> </p>
				</div>
				<div class="bci">
					<table summary="신청정보">
						<tbody>
							<tr>
								<th>도서관명</th>
								<td>${i.LIB_NAME}</td>
							</tr>
							<tr>
								<th>대출유형</th>
								<td>
								<c:if test="${i.LOAN_TYPE_CODE eq '0'}">일반대출</c:if>
								<c:if test="${i.LOAN_TYPE_CODE eq '1'}">특별대출</c:if>
								<c:if test="${i.LOAN_TYPE_CODE eq '2'}">관내대출</c:if>
								<c:if test="${i.LOAN_TYPE_CODE eq '3'}">무인대출</c:if>
								<c:if test="${i.LOAN_TYPE_CODE eq '4'}">장기대출</c:if>
								</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<th>대출연장횟수</th> -->
<%-- 								<td>${i.DELAY_CNT}</td> --%>
<!-- 							</tr> -->
							<tr>
								<th>대출일</th>
								<td>${i.LOAN_DATE}</td>
							</tr>
							<tr>
								<th>반납예정일</th>
								<td>${i.RETURN_PLAN_DATE}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
								<c:if test="${i.STATUS eq '0'}">대출</c:if>
								<c:if test="${i.STATUS eq '1'}">반납</c:if>
								<c:if test="${i.STATUS eq '2'}">반납연기</c:if>
								<c:if test="${i.STATUS eq '3'}">예약</c:if>
								<c:if test="${i.STATUS eq '4'}">예약취소</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

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
</div>