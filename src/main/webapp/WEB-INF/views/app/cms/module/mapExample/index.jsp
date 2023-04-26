<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${boy.homepage_id}', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${boy.homepage_id}&selection_year=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete').on('click', function(e) {
		e.preventDefault();
		if (confirm('삭제하시겠습니까?')) {
			$('input#selection_year_1').val($(this).attr('keyValue'));
			$('input#editMode_1').val('DELETE');
			doAjaxPost($('form#boy'));
		}
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', serializeCustom($('#boy')));
		}

		e.preventDefault();
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#boy')));
	});

	$('select#rowCount').on('change', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#boy')));
	});
});
</script>

<form:form modelAttribute="boy" method="POST" action="save.do" onsubmit="return false;">
<input type="hidden" id="editMode_1" name="editMode" value="${boy.editMode}"/>
<input type="hidden" id="selection_year_1" name="selection_year" value="${boy.selection_year}"/>
<input type="hidden" id="homepage_id_1" name="homepage_id" value="${boy.homepage_id}"/>
<div id="editDisable" class="disableBox">
	<div class="infodesk">
		검색 결과 : ${paging.totalDataCount}건
		<div class="button btn-group inline">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
			<select id="rowCount" name="rowCount" class="selectmenu" style="width:150px;">
				<option value="10" ${paging.rowCount eq 10 ? 'selected' : ''}>10개씩 보기</option>
				<option value="20" ${paging.rowCount eq 20 ? 'selected' : ''}>20개씩 보기</option>
				<option value="30" ${paging.rowCount eq 30 ? 'selected' : ''}>30개씩 보기</option>
				<option value="50" ${paging.rowCount eq 50 ? 'selected' : ''}>50개씩 보기</option>
				<option value="${paging.totalDataCount}" ${paging.rowCount eq paging.totalDataCount ? 'selected' : ''}> 전체 보기</option>
			</select>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="50">순번</th>
				<th width="100">선정년도</th>
				<th width="200">도서명</th>
				<th width="200">북테스트</th>
				<th width="200">저자</th>
				<th width="150">등록일</th>
				<th width="100">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(boyList) < 1}">
			<tr style="height:100%">
				<td colspan="6" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${boyList}">
			<tr>
				<td width="50">${paging.listRowNum - status.index}</td>
				<td width="100">${i.SELECTION_YEAR}</td>
				<td class="left" width="200">${i.BOOK_NAME}</td>
				<td class="left" width="200">${i.BOOK_TEST}</td>
				<td class="left" width="200">${i.BOOK_AUTHOR}</td>
				<td class="left" width="200">${i.BOOK_TEST10}</td>
				<td width="150"><fmt:formatDate value="${i.ADD_DATE}" pattern="yyyy-MM-dd"/></td>
				<td width="120">
					<c:if test="${authU}">
						<a href="#" class="btn dialog-modify" keyValue="${i.SELECTION_YEAR}">수정</a>
					</c:if>
					<c:if test="${authD}">
						<a href="#" class="btn delete" keyValue="${i.SELECTION_YEAR}">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/pagingFromMap.jsp" flush="false">
		<jsp:param name="formId" value="#boy"/>
	</jsp:include>
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<select id="search_type" name="search_type" class="selectmenu">
				<option value="book_name">도서명</option>
				<option value="book_author">저자</option>
			</select>
			<input id="search_text" name="search_text"  class="text" style="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="도서 정보">
</div>
