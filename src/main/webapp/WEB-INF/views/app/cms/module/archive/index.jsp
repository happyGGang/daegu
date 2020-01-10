<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#archiveBookListForm').submit();
	});
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MOD&homepage_id=' + $('#homepage_id').val() + '&book_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if(confirm('해당 원문을 삭제하시겠습니까?')) {
			$('#hiddenForm_book_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a.dialog-question').on('click', function(e) {
		$('#dialog-2').load('editQuestion.do?homepage_id=' + $('#homepage_id').val() + '&book_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.dialog-reqList').on('click', function(e){
		$('#dialog-3').load('reqList.do?homepage_id=' + $('#homepage_id').val() + '&book_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		e.preventDefault();
	});
	
	$('select#homepage_id').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id').val($(this).val());
			$('#archiveListForm').submit();
		}
		
		e.preventDefault();
	});
	
// 	$('select#jokbo_type, select#rowCount, select#jokbo_year, select#jokbo_month').on('change', function() {
// 		$('#viewPage').val(1);
// 		$('#jokboListForm').submit();
// 	});
	
// 	$('select#rowCount').on('change', function() {
// 		$('#viewPage').val(1);
// 		$('#jokboListForm').submit();
// 	});
	
});
</script>
<form:form id="hiddenForm" modelAttribute="archive" action="delete.do" >
<form:hidden id="hiddenForm_editMode" path="editMode" value="DEL"/>
<form:hidden id="hiddenForm_book_idx" path="book_idx"/>
</form:form>
<form:form id="archiveBookListForm" modelAttribute="archive" action="index.do" >
<form:hidden path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${archiveBookListCount}" pattern="#,###" />건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">20개씩 보기</form:option>
			<form:option value="50">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		<div class="button">
<%-- 			<c:if test="${authC}"> --%>
				<a href="#" id="dialog-add" class="btn btn5" ><i class="fa fa-plus"></i><span>등록</span></a>
<%-- 			</c:if> --%>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="" />
			<col width="100" />
			<col width="100">
			<col width="100" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>편/권차</th>
				<th>사용여부</th>
				<th>수정</th>
				<th>삭제</th>
				<th>페이지</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${archiveBookList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td><a href="page_index.do?homepage_id=${i.homepage_id}&book_idx=${i.book_idx}">${i.subject}</a></td>
					<td>${i.volume}</td>
					<td>${i.delete_yn}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" keyValue="${i.book_idx}">수정</a>
						</c:if>
					</td>
					<td>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue="${i.book_idx}">삭제</a>
						</c:if>
					</td>
					<td>
						<c:if test="${authC or authU}">
							<a href="page_index.do?homepage_id=${i.homepage_id}&book_idx=${i.book_idx}" class="btn">페이지</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${archiveBookListCount eq 0}">
				<tr>
					<td colspan="5">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#archiveBookListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="regnumber">등록번호</form:option>
				<form:option value="callnumber">청구기호</form:option>
				<form:option value="subject">제목</form:option>
				<form:option value="year">발행년도</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="원문 등록"></div>
