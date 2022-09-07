<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookReportClub').serialize());
	});
	
	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#book_club_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#bookReportClub')));
	});
	
	$('select.approval_status').on('change', function(e) {
		e.preventDefault();
		$('form#bookReportClub').attr('action', 'statusChange.do');
		$('#book_club_idx').val($(this).data('key'));
		$('#approval_status').val($(this).val());
		doAjaxPost($('form#bookReportClub'));
	});
	
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 삭제하시겠습니까?\n\n삭제된 신청은 복구가 불가능합니다.')) {
			$('form#bookReportClub').attr('action', 'delete.do');
			$('#book_club_idx').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#bookReportClub'));
			location.reload();
		}
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bookReportClub')));
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#bookReportClub').attr('action', 'excelDownload.do').submit();
		$('#bookReportClub').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#bookReportClub').attr('action', 'csvDownload.do').submit();
	});
	
});
</script>

<form:form modelAttribute="bookReportClub">
<form:hidden path="homepage_id"/>
<form:hidden path="book_club_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="approval_status"/>
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		
		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		
		<div class="button">
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<div>
		<table class="type1 center">
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="5%" />
				<col width="5%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>참가분야</th>
					<th>동아리명</th>
					<th>대표자명</th>
					<th>휴대폰(제1 연락처)</th>
					<th>휴대폰(제2 연락처)</th>
					<th>이메일</th>
					<th>등록일</th>
					<th>상태</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${bookReportClubList}">
					<tr>
						<td>${paging.listRowNum - status.index}</td>
						<td>
							<c:choose>
								<c:when test="${i.participation_field eq '0'}">소년부(초등~중등)</c:when>
								<c:when test="${i.participation_field eq '1'}">장년부(고등~일반)</c:when>
							</c:choose>
						</td>
						<td>
							<a href="#" class="view_btn" data-key="${i.book_club_idx}">${i.club_name}</a>
						</td>
						<td>${i.rep_name}</td>
						<td>${i.user_phone}</td>
						<td>${i.user_phone2}</td>
						<td>${i.user_email}</td>
						<td>
							<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<select class="approval_status" data-key="${i.book_club_idx}">
								<option value="0" ${i.approval_status eq '0' ? 'selected' : ''}>신청</option>
								<option value="1" ${i.approval_status eq '1' ? 'selected' : ''}>승인</option>
								<option value="2" ${i.approval_status eq '2' ? 'selected' : ''}>취소</option>
							</select>
						</td>
						<td>
							<a href="#" class="btn delete_btn" data-key="${i.book_club_idx}">삭제</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(bookReportClubList) < 1}">
					<tr>
						<td colspan="9">등록된 회원정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#bookReportClub"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;">
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu">
					<form:option value="user_name">이름</form:option>
					<form:option value="user_phone">휴대폰(제1 연락처)</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
			</fieldset>
		</div>
		
	</div>
	
</form:form>

<div id="dialog-1" class="dialog-common" title="독서동아리 경연대회 참가신청"></div>
