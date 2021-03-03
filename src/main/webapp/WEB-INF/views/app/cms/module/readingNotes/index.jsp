<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	
	<c:forEach items="${readingNotesList}" var="i" varStatus="status">
		$('#approveStatus${status.count}').val('${i.approve_status}').attr('selected', true);
		$('input#cancelReason${status.count}').val('${i.cancel_reason}');
	</c:forEach>

	$('select#book_type').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#readingNotes')));
	});

	$('select#approve_status_search').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#readingNotes')));
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#readingNotes')));
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
		$('#editMode').val('DELETE');
		if(confirm('선택한 게시물을 삭제하시겠습니까?')){
			var checkboxarr = $('input:checkbox[name = reading_notes_idx_arr]:checked');
			var member_id_arr = new Array();
			checkboxarr.each(function(i) {
				member_id_arr.push($(this).siblings('input[name = member_id_1]').val());
			});
			$('input#member_id_arr').val(member_id_arr);

			$('form#readingNotes').attr('action', 'save.do');
			if(doAjaxPost($('form#readingNotes'))){
				location.reload();
			}
		}
	});
	
	$('a.updateStatusOne').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFYSTATUSONE');
		if(confirm('선택한 게시글의 정보를 변경하시겠습니까?')) {
			var member_id = $(this).closest('tr').find('#selectedMember').val();
			var reading_notes_idx = $(this).attr('keyValue');
			var approve_status_replace = $(this).closest('tr').find('.selectmenu').val();
			var cancel_reason_replace = $(this).closest('tr').find('.text').val();

			$('input#member_id').val(member_id);
			$('input#reading_notes_idx').val(reading_notes_idx);
			$('input#approve_status_replace').val(approve_status_replace);
			$('input#cancel_reason_replace').val(cancel_reason_replace);
			
			$('form#readingNotes').attr('action', 'save.do');
			if(doAjaxPost($('form#readingNotes'))) {
				location.reload();
			}
		}
	});

	$('a#updateStatus').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFYSTATUS');
		if(confirm('선택한 게시글의 정보를 변경하시겠습니까?')){
			var checkboxarr = $('input:checkbox[name = reading_notes_idx_arr]:checked');
			var member_id_arr = new Array();
			var approve_status_arr = new Array();
			var cancel_reason_arr = new Array();
			
			checkboxarr.each(function(i) {

				member_id_arr.push($(this).siblings('input[name = member_id_1]').val());
				approve_status_arr.push($(this).closest('tr').find('.selectmenu').val());
				cancel_reason_arr.push($(this).closest('tr').find('.text').val());
			});

			$('input#member_id_arr').val(member_id_arr);
			$('input#approve_status_arr').val(approve_status_arr);
			$('input#cancel_reason_arr').val(cancel_reason_arr);

			$('form#readingNotes').attr('action', 'save.do');
			if(doAjaxPost($('form#readingNotes'))) {
				location.reload();
			}
		}
	});

	$('a#viewReadingNotesExcelDown').on('click', function(e) { //참가자 엑셀 다운 ( 참가자 정보 )
		e.preventDefault();
		doGetLoad('viewReadingNotesExcelDown.do', serializeCustom($('form#readingNotes')));
	});
});
</script>
<form:form modelAttribute="readingNotes" action="index.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="member_id_arr"/>
	<form:hidden path="approve_status_arr"/>
	<form:hidden path="cancel_reason_arr"/>
	<form:hidden path="member_id"/>
	<form:hidden path="reading_notes_idx"/>
	<form:hidden path="approve_status_replace"/>
	<form:hidden path="cancel_reason_replace"/>

	<div class="infodesk">
		검색 결과 : 총  ${paging.totalDataCount}건
		<span style="padding-left: 1%;">자료구분 :</span>
		<form:select path="book_type" cssClass="selectmenu">
			<form:option value="" label="전체"/>
			<form:option value="LOAN" label="대출도서"/>
			<form:option value="API" label="개별(API)"/>
		</form:select>
		<span style="padding-left: 1%;">승인상태 :</span>
		<form:select path="approve_status_search" cssClass="selectmenu">
			<form:option value="" label="전체"/>
			<form:option value="C" label="확인중"/>
			<form:option value="Y" label="승인"/>
			<form:option value="N" label="반려"/>
		</form:select>
		<div class="button">
			<a href="#" id="viewReadingNotesExcelDown" class="btn btn2"><i class="fa fa-file-excel-o"></i>
				<span>엑셀 다운로드</span>
			</a>
		</div>
	</div>

	<table class="type1 center">
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>작성자 / 대출번호</th>
				<th>도서명</th>
				<th>자료구분</th>
				<th>승인상태</th>
				<th>완독일</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${readingNotesList}" varStatus="status" var="i">
				<tr>
					<td>
						<input type="hidden" name="member_id_1" value="${i.member_id}" id="selectedMember"/>
						<form:checkbox path="reading_notes_idx_arr" value="${i.reading_notes_idx}" class="reading_notes_idx_arr"/>
					</td>
					<td>${paging.listRowNum - status.index}</td>
					<td>${i.member_name} / ${i.user_no}</a></td>
					<td>${i.book_name}</td>
					<td>
						<c:choose>
							<c:when test="${i.book_type eq 'LOAN'}">
								대출도서
							</c:when>
							<c:otherwise>
								개별(API)
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<form:select path="approve_status" cssClass="selectmenu" id="approveStatus${status.count}">
							<form:option value="C" label="확인중"/>
							<form:option value="Y" label="승인"/>
							<form:option value="N" label="반려"/>
						</form:select>
						<br/>
						사유 : <form:input path="cancel_reason" cssClass="text" id="cancelReason${status.count}"/><br/>
						<a class="btn updateStatusOne" keyValue="${i.reading_notes_idx}">수정</a>
					</td>
					<td>${i.read_success_date}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(readingNotesList) < 1}">
				<tr>
					<td colspan="8">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
		<a href="#" id="checkAll" class="btn btn3">전체 선택/해제</a>
		<a href="#" id="deleteSelected" class="btn btn3">선택 게시글 삭제</a>
		선택한 일지를
		<form:select path="approve_status_modify" cssClass="selectmenu">
			<form:option value="C">확인중</form:option>
			<form:option value="Y">승인</form:option>
			<form:option value="N">반려</form:option>
		</form:select>
		로 <a href="#" id="updateStatus" class="btn btn3">변경</a>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#readingNotes"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="member_id">아이디</form:option>
				<form:option value="member_name">이름</form:option>
				<form:option value="user_no">대출번호</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>