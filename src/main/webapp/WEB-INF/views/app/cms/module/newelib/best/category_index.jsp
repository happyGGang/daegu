<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookListForm').submit();
	});
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&type=${book.type}', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
			$('select#cate1_dialog').select2();
			$('select#com_code_dialog').select2();
			$('select#library_code_dialog').select2();
			$('select#device_dialog').select2();
			<c:if test="${book.type != 'ADO'}">
			$('select#cate2_dialog').select2();
			$('select#cate1_dialog').on('change', function(e) {
				updateSubcategory_dialog($(this).val());
			});
			updateSubcategory_dialog($('select#cate1_dialog').val());
			</c:if>
		});
		
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&type=${book.type}&book_idx=' + $(this).data('book_idx'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
			$('select#cate1_dialog').select2();
			$('select#com_code_dialog').select2();
			$('select#library_code_dialog').select2();
			$('select#device_dialog').select2();
			<c:if test="${book.type != 'ADO'}">
			$('select#cate2_dialog').select2();
			$('select#cate1_dialog').on('change', function(e) {
				updateSubcategory_dialog($(this).val());
			});
			updateSubcategory_dialog($('select#cate1_dialog').val());
			</c:if>
		});
		
		e.preventDefault();
	});
	
	$('a.addbestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('ADDCATBESTBOOK');
		$('#bestbook_book_code').val($(this).data('book_code'));
		$('#bestbook_parent_id').val($(this).data('parent_id'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.deletebestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('DELETECATBESTBOOK');
		$('#bestbook_book_code').val($(this).data('book_code'));
		$('#bestbook_parent_id').val($(this).data('parent_id'));
		if(confirm('제외하시겠습니까?') && doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.raisebestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('RAISECATBESTBOOK');
		$('#bestbook_book_code').val($(this).data('book_code'));
		$('#bestbook_print_seq').val($(this).data('print_seq'));
		$('#bestbook_parent_id').val($(this).data('parent_id'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.lowerbestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('LOWERCATBESTBOOK');
		$('#bestbook_book_code').val($(this).data('book_code'));
		$('#bestbook_print_seq').val($(this).data('print_seq'));
		$('#bestbook_parent_id').val($(this).data('parent_id'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	<c:if test="${book.type == 'ADO'}">
	$('select#cate1').on('change', submit);
	</c:if>
	<c:if test="${book.type != 'ADO'}">
	$('select#cate2').on('change', submit);
	</c:if>
	$('select#library_code').on('change', submit);
	$('select#device').on('change', submit);
	$('select#com_code').on('change', submit);
	$('select#sortField').on('change', submit);
	$('select#rowCount').on('change', submit);
	$('select#type').on('change', submit);
	$('select#cate1').on('change', submit);
	
});

function submit(e) {
	e.preventDefault();
	$('#bookListForm').submit();
}
</script>
<form:form id="hiddenForm" modelAttribute="book" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="book_idx" id="hiddenForm_book_idx"/>
<form:hidden path="type" id="hiddenForm_type"/>
</form:form>
<form:form modelAttribute="book" id="bestbook_form" action="save.do" method="post">
<form:hidden path="editMode" id="bestbook_editMode"/>
<form:hidden path="book_code" id="bestbook_book_code"/>
<form:hidden path="parent_id" id="bestbook_parent_id"/>
<form:hidden path="cate_id" id="bestbook_cate_id"/>
<form:hidden path="print_seq" id="bestbook_print_seq"/>
</form:form>
<form:form id="bookListForm"  modelAttribute="book" action="category_index.do" >
<c:if test="${!member.admin}">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</c:if>

<c:set var="countName" value="대출횟수"/>
<c:set var="cols" value="11"/>
<c:if test="${book.type != 'WEB'}">
<c:set var="cols" value="11"/>
</c:if>

<c:if test="${member.admin}">
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/primary_category_select.jsp"/>
		</fieldset>
	</div>
</c:if>

<table class="type1 center">
<colgroup>
	<col width="20px"/>
	<col width="50px"/>
	<col width="20px"/>
	<col width="150px"/>
	<col width="100px"/>
	<col width="50px"/>
	<col width="80px"/>
</colgroup>
<thead>
	<tr>
		<th>순위</th>
		<th>카테고리</th>
		<th>대출횟수</th>
		<th>제목</th>
		<th>저자</th>
		<th>출판사</th>
		<th>기능</th>
	</tr>
</thead>
<tbody>
	<c:if test="${fn:length(bestBookList) < 1}">
		<tr style="height:100%">
			<td colspan="7" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${bestBookList}">
	<tr<c:if test="${status.index >= 5}"> style="background-color: #AAAAAA"</c:if>>
		<td>${status.index+1}</td>
		<td>${i.parent_name}</td>
		<td>${i.lend_total}</td>
		<td>${i.book_name}</td>
		<td>${i.author_name}</td>
		<td>${i.book_pubname}</td>
		<td>
			<a href="#" class="btn deletebestbook" data-book_code="${i.book_code}" data-parent_id="${i.parent_id}">제외</a>
			<c:if test="${!status.first}">
			<a href="#" class="btn raisebestbook" data-book_code="${i.book_code}" data-print_seq="${i.print_seq}" data-parent_id="${i.parent_id}">위로</a>
			</c:if>
			<c:if test="${!status.last}">
			<a href="#" class="btn lowerbestbook" data-book_code="${i.book_code}" data-print_seq="${i.print_seq}" data-parent_id="${i.parent_id}">아래로</a>
			</c:if>
		</td>
	</tr>
	</c:forEach>
</tbody>
</table>
<br/>

<c:if test="${member.admin}">
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/device_select.jsp"/>
		</fieldset>
	</div>
</c:if>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${bookListCnt}" pattern="#,###" />건
		<form:select path="sortField" class="selectmenu">
			<option value="">정렬 순서 선택</option>
			<option value="book_idx" <c:if test="${book.sortField eq 'book_idx'}">selected="selected"</c:if>>내부등록번호</option>
			<option value="book_name" <c:if test="${book.sortField eq 'book_name'}">selected="selected"</c:if>>책제목순</option>
			<option value="author_name" <c:if test="${book.sortField eq 'author_name'}">selected="selected"</c:if>>저자순</option>
			<option value="lend_total" <c:if test="${book.sortField eq 'lend_total'}">selected="selected"</c:if>>${countName}순</option>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="50"/>
			<col width="200"/>
			<col width="150"/>
			<col width="100"/>
			<c:if test="${book.type != 'WEB'}">
			<col width="100"/>
			</c:if>
			<col width="50"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>${countName}</th>	
				<th>책제목</th>
				<th>저자</th>	
				<th>출판사</th>
				<c:if test="${book.type != 'WEB'}">
				<th>ISBN</th>	
				</c:if>
				<th>포맷</th>
				<th>도서관명</th>
				<th>공급사</th>
				<th>지원기기</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(bookList) < 1}">
				<tr style="height:100%">
					<td colspan="${cols}" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${bookList}">
				<tr>
					<td>${i.parent_name}</td>
					<td>${i.lend_total}</td>
					<td>${i.book_name}</td>
					<td>${i.author_name}</td>
					<td>${i.book_pubname}</td>
					<c:if test="${book.type != 'WEB'}">
					<td>${i.isbn13}</td>
					</c:if>
					<td>${i.format}</td>
					<td>${i.library_name}</td>
					<td>${i.comp_name}</td>
					<td>${i.label}</td>
					<td>
						<c:if test="${authC}">
							<a href="#" class="btn addbestbook" data-book_code="${i.book_code}" data-parent_id="${i.parent_id}">베스트</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookListForm"/>
		<jsp:param name="pagingUrl" value="category_index.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="book_code">책코드</form:option>
				<form:option value="book_name">책제목</form:option>
				<form:option value="author_name">저자</form:option>
				<form:option value="book_pubname">출판사</form:option>
				<form:option value="isbn13">ISBN</form:option>
				<form:option value="format">포맷</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="콘텐츠 관리"></div>