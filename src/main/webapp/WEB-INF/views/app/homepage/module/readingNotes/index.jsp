<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	var $form = $('form#readingNotes');

	$('a#write').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		var url = 'addNotLoanBook.do';
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a#record').on('click', function(e) {
		e.preventDefault();
		var url = 'edit.do';
		$('input#editMode').val('MODIFY');
		$('input#reading_notes_idx').val($(this).attr('keyValue'));
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a#rowCountSelect').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		var url = 'index.do';
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a#checkAll').on('click', function(e) {
		e.preventDefault();
		if($('input:checkbox[name = reading_notes_idx_arr]').eq(0).is(':checked')){
			for(var i = 0; i < $('input:checkbox[name = reading_notes_idx_arr]').length; i++){
				$('input:checkbox[name = reading_notes_idx_arr]').eq(i).prop('checked', false);
			}
		}else{
			for(var i = 0; i < $('input:checkbox[name = reading_notes_idx_arr]').length; i++){
				$('input:checkbox[name = reading_notes_idx_arr]').eq(i).prop('checked', true);
			}
		}
	});
	
	$('a#deleteSelected').on('click', function(e) {
		e.preventDefault();

		if($('input:checkbox[name = reading_notes_idx_arr]:checked').length == 0) {
			alert('삭제할 게시글을 선택해 주세요.');
			return false;
		}

		if(confirm('선택한 독서노트를 삭제하시겠습니까?')){
			$('#editMode').val('DELETE');
			$('form#readingNotes').attr('action', 'save.do');
			if(doAjaxPost($('form#readingNotes'))){
				location.reload();
			}
		}
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#readingNotes')));
	});
	
	$('a#excelDown').on('click', function(e) {
		e.preventDefault();
		
		doGetLoad('viewMemberNotesOneExcelDown.do', serializeCustom($('form#readingNotes')));
	});
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="readingNotes" action="index.do" method="GET" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="reading_notes_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>	

	<div class="wrapper-bbs">
		<div class="infodesk">
			<div class="button btn-group inline">
				<span class="bbs-result">
					전체 <b>${paging.totalDataCount}</b>개
				</span>
				<form:select path="rowCount" class="selectmenu" style="width:110px;" title="보기 개수 선택">
					<form:option value="10">10개씩 보기</form:option>
					<form:option value="20">20개씩 보기</form:option>
					<form:option value="30">30개씩 보기</form:option>
					<form:option value="40">40개씩 보기</form:option>
					<form:option value="50">50개씩 보기</form:option>
				</form:select>
				<a href="#" id="rowCountSelect" class="btn btn1">이동</a>
			</div>
		</div>
		<div class="rsv-info"></div>
		<div class="auto-scroll table-wrap">
			<table class="bbs center">
				<thead>
					<tr>
						<th>선택</th>
						<th>번호</th>
						<th>도서명</th>
						<th>완독일</th>
						<th>등록일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${readingNotesList}" var="i" varStatus="status">
						<tr>
							<td><form:checkbox path="reading_notes_idx_arr" value="${i.reading_notes_idx}"/></td>
							<td>${status.count}</td>
							<td style="width:30%;"><a href="#" keyValue="${i.reading_notes_idx}" id="record">${i.book_name}</a></td>
							<td>${i.read_success_date}</td>
							<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
							<td>
								<c:choose>
									<c:when test="${i.approve_status eq 'C'}">
										확인중
									</c:when>
									<c:when test="${i.approve_status eq 'Y'}">
										승인
									</c:when>
									<c:otherwise>
										반려
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(readingNotesList) < 1}">
						<tr>
							<td colspan="6" class="dataEmpty first last td1">등록된 일지가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="button bbs-btn right">
			<a href="#" class="btn" id="excelDown"><span>엑셀 다운로드</span></a>
			<a href="#" class="btn checkAll" id="checkAll"><span>전체 선택/해제</span></a>
			<a href="#" class="btn deleteSelected" id="deleteSelected"><i class="fa fa-trash-o"></i><span>선택 게시글 삭제</span></a>
			<!-- <a href="#" class="btn btn1 write" id="write"><i class="fa fa-pencil"></i><span>대출도서 외 등록</span></a> -->
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonRecord"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="book_name">도서명</form:option>
				<form:option value="contents">감상문내용</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	
</form:form>