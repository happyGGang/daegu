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
<a href="excelDownloadSample.do" class="btn btn2" id="excel_down"><i class="fa fa-arrow-down" aria-hidden="true"></i><span>엑셀양식</span></a>
<h2>작업 순서</h2>
<h3>메타 추가</h3>
<ul>
	<li>1. '테스트 모드'를 선택하고 'Insert / Update' 작업으로 추가할 메타를 업로드한다</li>
	<li>2. 오류 메시지가 나오면 엑셀 파일을 수정한다</li>
	<li>3. 오류 메시지 없이 완료되면 '실제 반영'을 선택하고 메타를 업로드한다</li>
	<li>*** 새로운 카테고리는 아카이브 카테고리 관리에서 추가를 하고 업로드 해야 한다<br/>
</ul>
<br/>
<h3>메타 수정</h3>
<ul>
	<li>1. '테스트 모드'를 선택하고 'Insert / Update' 작업으로 수정된 전자책 메타를 업로드한다</li>
	<li>2. 오류 메시지가 나오면 엑셀 파일을 수정한다</li>
	<li>3. 오류 메시지 없이 완료되면 '실제 반영'을 선택하고 메타를 업로드한다</li>
	<li>*** 새로운 카테고리는 아카이브 카테고리 관리에서 추가를 하고 업로드 해야 한다.</li>
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