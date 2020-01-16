<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
var started = false;
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookListForm').submit();
	});

	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();

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
	});
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();

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
	});

	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();

		if(confirm('삭제하시겠습니까?')) {
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});

	$('a.approve-btn').on('click', function(e) {
		if(confirm('승인하시겠습니까?')) {
			$('#hiddenForm #editMode').val('approve');
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			$('#hiddenForm').attr('action', 'approve.do');
			$('#hiddenForm').val($(this).data('book_idx'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();

		if('${fn:length(bookList)}' > 0) {
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');
		} else {
			alert('해당 내역이 없습니다.');
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


	$('a#fileUpload').on('click', function(e) {
		e.preventDefault();

		if($('input#mfile').val() == '') {
			alert('엑셀 파일을 선택해주세요.');
			return;
		}
		if($('select#upload_com_code').val() == '') {
			alert('공급사를 선택해주세요.');
			return;
		}
		if($('select#upload_library_code').val() == '') {
			alert('도서관을 선택해주세요.');
			return;
		}

		if(started) {
			alert('작업을 진행 중입니다. 잠시 기다려주세요.');
			return;
		}

		if($('input[name=operation]:checked').val() != 'M') {
			started = true;
		}

		$('form#file-upload-form').submit();
	});
});

function submit(e) {
	e.preventDefault();
	$('#bookListForm').submit();
}
</script>

<h2>작업 순서</h2>
<h3>메타 추가</h3>
<ul>
	<li>1. '테스트 모드'를 선택하고 'Insert / Update' 작업으로 추가할 메타를 업로드한다</li>
	<li>2. 오류 메시지가 나오면 엑셀 파일을 수정한다</li>
	<li>3. 오류 메시지 없이 완료되면 '실제 반영'을 선택하고 메타를 업로드한다</li>
	<li>4. 업로드된 전자책은 '미승인' 상태가 되며 <br/>
	&nbsp;&nbsp;&nbsp;&nbsp;<a href="//library.daegu.go.kr/elib/module/elib/set.do?debug=true">https://library.daegu.go.kr/elib/module/elib/set.do?debug=true</a> 를 열면<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;현 세션이 일시적으로 미승인 자료만 열람 가능한 상태가 된다.<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;(취소는 <a href="//library.daegu.go.kr/elib/module/elib/set.do?debug=false">https://library.daegu.go.kr/elib/module/elib/set.do?debug=false</a>)
	</li>
	<li>5. 미승인 자료로 대출, 반납, 연장, 예약, 책 열기를 테스트한다</li>
	<li>6. 전자책이 정상 작동하면 작업 종류를 '승인'으로 선택하고 메타를 다시 업로드 한다</li>
</ul>
<br/>
<h3>메타 수정</h3>
<ul>
	<li>1. '테스트 모드'를 선택하고 'Insert / Update' 작업으로 수정된 전자책 메타를 업로드한다</li>
	<li>2. 오류 메시지가 나오면 엑셀 파일을 수정한다</li>
	<li>3. 오류 메시지 없이 완료되면 '실제 반영'을 선택하고 메타를 업로드한다</li>
</ul>
<br/>
<h3>메타 삭제</h3>
<ul>
	<li>1. '테스트 모드'를 선택하고 'Delete' 작업으로 삭제할 메타를 업로드한다</li>
	<li>2. 오류 메시지가 나오면 엑셀 파일을 수정한다</li>
	<li>3. 오류 메시지 없이 완료되면 '실제 반영'을 선택하고 메타를 업로드한다</li>
</ul>
</p>
<br/>
<form id="file-upload-form" name="file-upload-form" action="result.do" method="POST" enctype="multipart/form-data">
<table class="type2" style="width: 600px;">
	<colgroup>
		<col width="100px;">
		<col width="500px;">
	</colgroup>
<!-- 		<thead> -->
<!-- 		</thead> -->
	<tbody>
		<tr><th>엑셀 파일</th><td><input type="file" id="mfile" name="mfile"></td></tr>
		<tr>
			<th>작업 종류</th>
			<td>
				<input type="radio" name="operation" id="operation1" value="I" checked="checked" style="width: 20px;"> <label for="operation1">Insert / Update</label>
				&nbsp;<input type="radio" name="operation" id="operation2" value="D" style="width: 20px;"> <label for="operation2">Delete</label>
				&nbsp;<input type="radio" name="operation" id="operation3" value="A" style="width: 20px;"> <label for="operation3">승인</label>
				&nbsp;<input type="radio" name="operation" id="operation4" value="DA" style="width: 20px;"> <label for="operation4">승인 취소</label>
				&nbsp;<input type="radio" name="operation" id="operation5" value="M" style="width: 20px;"> <label for="operation5">마크URL 추출</label><br/>
<!-- 				&nbsp;<input type="radio" name="operation" value="FD" style="width: 20px;"> 강제 삭제<br/> -->
			</td>
		</tr>
<%--
		<tr>
			<th>1차 카테고리<br/>접두사</th>
			<td>
				<input type="text" name="category_prefix" value="" style="width: 200px;"><br/>
				* 마지막 빈칸은 직접 넣어야 함
			</td>
		</tr>
		<tr>
			<th>타입</th>
			<td>
				<input type="radio" name="type" value="EBK" checked="checked" style="width: 20px;"> 전자책(EBK)
				&nbsp;<input type="radio" name="type" value="ADO" style="width: 20px;"> 오디오북(ADO)
				&nbsp;<input type="radio" name="type" value="WEB" style="width: 20px;"> 이러닝(WEB)
			</td>
		</tr>
		<tr>
			<th>공급사</th>
			<td>
				<select id="upload_com_code" name="com_code" style="width:200px">
					<option value="">공급사 선택</option>
					<c:forEach var="i" varStatus="status" items="${compList}">
						<option value="${i.com_code}">${i.com_code} (${i.comp_name})</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th>도서관</th>
			<td>
				<select id="upload_library_code" name="library_code" style="width:200px">
					<option value="">도서관 선택</option>
					<c:forEach var="i" varStatus="status" items="${homepageList}">
						<option value="${fn:substring(i.homepage_code, 0, 8)}" <c:if test="${fn:substring(i.homepage_code, 0, 8) eq obj.library_code }">selected="selected"</c:if>>${fn:substring(i.homepage_code, 0, 8)}(${i.homepage_name})</option>
					</c:forEach>
				</select>
				<br/>
			</td>
		</tr>
--%>
		<tr>
			<th>새 카테고리</th>
			<td>
				<input type="radio" name="new_category" id="new_category1"  value="1" checked="checked" style="width: 20px;"> <label for="new_category1">추가하지 않음</label>
				&nbsp;<input type="radio" name="new_category" id="new_category2" value="2" style="width: 20px;"> <label for="new_category2">새로 추가</label><br/>
				* '추가하지 않음'을 선택할 경우 미등록 카테고리 발견 시 작업 중단<br/>
				* '새로 추가'는 반드시 도서관으로부터 새 카테고리 등록 승인을 받은 후 진행해야 함
			</td>
		</tr>
		<tr>
			<th>테스트 or 실제 반영</th>
			<td>
				<input type="radio" name="run_mode" id="run_mode1" value="DRY_RUN" checked="checked" style="width: 20px;"> <label for="run_mode1">테스트 모드</label>
				&nbsp;<input type="radio" name="run_mode" id="run_mode2" value="DEPLOY" style="width: 20px;"> <label for="run_mode2">실제 반영</label><br/>
				* 테스트 모드로 테스트 후 이상이 없을 시 실제 반영
			</td>
		</tr>
		<tr>
			<th colspan="2" style="text-align: center;">
				<a href="#" class="btn" id="fileUpload">작업 시작!</a><br/>
				* 엑셀 파일 용량에 따라 수십 초 ~ 수 분이 걸릴 수 있습니다
			</th>
		</tr>
	</tbody>
</table>
</form>
<%--
<br/>
<form:form id="hiddenForm" modelAttribute="book" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="book_idx" id="hiddenForm_book_idx"/>
<form:hidden path="type" id="hiddenForm_type"/>
</form:form>
<form:form id="bookListForm"  modelAttribute="book" action="index.do" >
<c:if test="${!member.admin}">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</c:if>
<form:hidden path="type"/>

<c:set var="countName" value="대출횟수"/>
<c:if test="${book.type != 'EBK'}">
<c:set var="countName" value="이용횟수"/>
</c:if>
<c:set var="cols" value="11"/>
<c:if test="${book.type != 'WEB'}">
<c:set var="cols" value="11"/>
</c:if>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/category_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/device_select.jsp"/>
		</fieldset>
	</div>

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
		<div class="button">
<!-- 			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a> -->
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50"/>
			<col width="80"/>
			<col width="80"/>
			<col width="100"/>
			<col width="100"/>
			<col width="200"/>
			<col width="150"/>
			<col width="100"/>
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th>타입</th>
				<th>공급사</th>
				<th>도서관명</th>
				<th>1차 카테고리</th>
				<th>2차 카테고리</th>
				<th>책제목</th>
				<th>저자</th>
				<th>출판사</th>
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
					<td>${i.type}</td>
					<td>${i.com_code}<br/>${i.comp_name}</td>
					<td>${i.library_code}<br/>${i.library_name}</td>
					<td>${i.parent_id}<br/>${i.parent_name}</td>
					<td>${i.cate_id}<br/>${i.cate_name}</td>
					<td>${i.book_name}</td>
					<td>${i.author_name}</td>
					<td>${i.book_pubname}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn approve-btn" data-book_idx="${i.book_idx}">승인</a>
						</c:if>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" data-book_idx="${i.book_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" data-book_idx="${i.book_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
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
--%>