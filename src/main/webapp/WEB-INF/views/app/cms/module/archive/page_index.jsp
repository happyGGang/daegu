<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.fileinput-button {position: relative; overflow: hidden;}
.fileinput-button input {position: absolute; top: 0; right: 0; margin: 0; opacity: 0; -ms-filter: 'alpha(opacity=0)'; font-size: 200px; direction: ltr; cursor: pointer;}

/* Fixes for IE < 8 */
@media screen\9 {
  .fileinput-button input {filter: alpha(opacity=0); font-size: 100%; height: 100%;}
}
</style>
<script src="/resources/common/jqueryFileUpload/js/vendor/jquery.ui.widget.js"></script>
<script src="/resources/common/jqueryFileUpload/js/jquery.iframe-transport.js"></script>
<script src="/resources/common/jqueryFileUpload/js/jquery.fileupload.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		
		$('#viewPage').val(1);
		$('#archivePageListForm').submit();
	});
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();

		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		
		if($('#file_' + $(this).data('page_idx')).val() == '') {
			$('#file_' + $(this).data('page_idx')).remove();
		}
		var option = {
			url : 'page_save.do',
			type : 'POST',
			success: function(response) {
				 if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					if ( response.message != null ) {
						alert(response.message);
					}
					else {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}	
					}
				}
	         },
	         error: function(jqXHR, textStatus, errorThrown) {
	             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
	         }
		};
		$('#mod_form_' + $(this).data('page_idx')).ajaxSubmit(option);
	});
	
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		
		if(confirm('해당 페이지를 삭제하시겠습니까?')) {
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			$('#hiddenForm_page_idx').val($(this).data('page_idx'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});
	
	$('a.delete-file-btn').on('click', function(e) {
		e.preventDefault();
		
		if(confirm('이미지를 삭제하시겠습니까?')) {
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			$('#hiddenForm_page_idx').val($(this).data('page_idx'));
			$('#hiddenForm').attr('action', 'page_delete_image.do');
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});
	
	$('a#batch-delete-btn').on('click', function(e) {
		e.preventDefault();
		
		var cnt = $('input.page_idx_list:checked').length;
		if(cnt == 0) {
			alert('페이지를 선택해주세요.');
			return;
		}
		if(confirm('선택 페이지(' + cnt + '개)를 삭제하시겠습니까?')) {
			$('#hiddenForm_editMode').val('BATCH');
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			$('#hiddenForm_page_idx_list').val($('input.page_idx_list:checked').map(function() { return $(this).val(); }).get().join(','));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});
	
	$('a#reorder-btn').on('click', function(e) {
		e.preventDefault();
		
		if(confirm('순서일괄수정을 하시겠습니까?')) {
			$('#hiddenForm').attr('action', 'save.do');
			$('#hiddenForm_editMode').val('REORDER');
			$('#hiddenForm_book_idx').val($(this).data('book_idx'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});
	
	$('a.move-up-btn').on('click', function(e) {
		e.preventDefault();
		
		$('#hiddenForm').attr('action', 'page_move_up.do');
		$('#hiddenForm_book_idx').val($(this).data('book_idx'));
		$('#hiddenForm_page_idx').val($(this).data('page_idx'));
		$('#hiddenForm_code').val($(this).data('code'));
		if(doAjaxPost($('#hiddenForm'))) {
			location.reload();
		}
	});
	
	$('a.move-down-btn').on('click', function(e) {
		e.preventDefault();
		
		$('#hiddenForm').attr('action', 'page_move_down.do');
		$('#hiddenForm_book_idx').val($(this).data('book_idx'));
		$('#hiddenForm_page_idx').val($(this).data('page_idx'));
		$('#hiddenForm_code').val($(this).data('code'));
		if(doAjaxPost($('#hiddenForm'))) {
			location.reload();
		}
	});
});

var fileNum = 0;
var updateNum = 0;
var fileListAreaID;		//select 박스 id
var previewAreaID;		//미리보기 ID
var fileSizeViewID;		//파일사이즈 ID
var fileCountViewID;		//파일개수 ID
var defaultPath;			//기본 경로
var fileList = new Array(); // 파일 목록 저장 배열 추가

var uploading = false;
var uploadResult = false;
var done_cnt = 0;
$(document).ready(function() {
	$('#archivePageForm').on('submit', function(e) {
		e.preventDefault();
		done_cnt = 0;
		fileList.sort(function (a, b) {
			var nameA = a.files[0].name;
			var nameB = b.files[0].name;
			
			if(nameA < nameB) return -1;
			else if(nameA > nameB) return 1;
			else return 0;
		});
		for(var i=0; i<fileList.length; i++) {
			fileList[i].formData = {book_idx: ${archive.book_idx}, file_idx: i+1};
			$('#fileupload').fileupload('send', fileList[i])
				.complete(function (result, textStatus, jqXHR) {
					if(++done_cnt == fileList.length) {
						alert('업로드 완료됐습니다.');
						location.reload();
					}
				});
			showFileList();
		}
	});
	
	$('#fileupload').fileupload({
        url : 'page_save.do',
        dataType: 'json',
        autoUpload: false,
        sequentialUploads: true,
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        add : function(e, data) {
        	data.files[0].status = -1;
        	if(data.files[0].name.match(/(\.|\/)(gif|jpe?g|png)$/i)) {
	        	fileList.push(data);
	        	showFileList();
        	} else {
        		alert('이미지 파일만 업로드 가능합니다. (.gif, .jpg, .jpeg, .png)');
        	}
        },
        submit : function(e, data) {
        	uploading = true;
        	data.files[0].status = -2;
        	showFileList();
        },
        send : function(e, data) {
        	uploading = true;
        	data.files[0].status = -2;
        	showFileList();
        },
        done : function(e, data) {
        	uploading = false;
        	data.files[0].status = -4;
        	showFileList();
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('.progress_bar #progressBarStatus').css(
                'width',
                progress + '%'
            );
            $('#progressStatus').text(progress+"%");
        },

        dropZone: $('#attach_area')
    });

	fileListAreaID = $('#filelist_select')[0];		//select 박스 id
    previewAreaID = $('#preview')[0];			//미리보기 ID
    fileSizeViewID = $('#fileSizeView')[0];			//파일사이즈 ID
    fileCountViewID = $('#fileCountView')[0];			//파일사이즈 ID

    $('#delete_btn').on('click', function(e) {
    	e.preventDefault();
    	deleteFiles();
    });

    $('#filelist_select').on('change', function(e) {
    	e.preventDefault();
    	preview();
    });
    
	$('input#checkAll').on('click', function() {
		$('input.page_idx_list:checkbox').prop('checked', $(this).is(':checked'));
	});
});

/**
 * 셀렉트 박스에 파일 정보를 업데이트 한다.
 */
function showFileList() {
	var selectObj = fileListAreaID;
	var length = selectObj.childNodes.length - 1;

	while(selectObj.childNodes.length > 0) {
		selectObj.removeChild(selectObj.childNodes[length--]);
	}

	var text;
	var totalSize = 0;

	for( var i = 0; i < fileList.length; i++ ) {
		text = "";

		if( fileList[i] != null ) {
			var file = fileList[i].files[0];

			// 파일 상태에 따른 데이터 변경
			/*
				QUEUED		 : -1,
				IN_PROGRESS	 : -2,
				ERROR		 : -3,
				COMPLETE	 : -4,
				CANCELLED	 : -5
			*/
			if( file.status == -1 ) {
				text = file.name + "(" + calculateFileSize( file.size ) + ") 대기 중...";
			} else if( file.status == -2 ) {
				text = file.name + "(" + calculateFileSize( file.size ) + ") 업로드 중...";
			} else if( file.status == -4 ) {
				text = file.name + "(" + calculateFileSize( file.size ) + ") 완료";
			}
			totalSize += file.size;

			if( text ) {
				var optionElement = document.createElement("OPTION");

				var textNode = document.createTextNode( text );

				optionElement.appendChild( textNode );
				optionElement.setAttribute( "value", i );		// fileSize , 실제파일명 , 확장자명 으로 후에 변경 ( 확장자명 통일 jpeg -> jpg )
				optionElement.setAttribute( "label", text );

				selectObj.appendChild( optionElement );
			}
		}
	}
	// 총 업로드 사이즈 출력
	fileSizeViewID.innerHTML = calculateFileSize( totalSize );
	fileCountViewID.innerHTML = fileList.length;
}

/**
 * 파일 삭제 처리(select 리스트에서만)
 * ( ajax 를 통하여 실제 파일을 삭제)
 */
function deleteFiles() {
	var selectObj = fileListAreaID;
	if( selectObj.selectedIndex < 0 ) {
		alert("삭제할 파일을 선택하여 주십시오.");
		return false;
	}
	if( selectObj.selectedIndex != -1 ) {
		for(var i=0;i<selectObj.length;i++) {
			if(selectObj.options[i].selected == true) {
				selectObj.options[i].remove();
				fileList.splice(i, 1);
				i--;
			}
		}
	}
	showFileList();
}

/**
 * 가독성을 위해 byte 단위의 사이즈를 KB 나 MB 로 출력
 */
function calculateFileSize( fileSize ) {
	// 사이즈가 1메가 초과일 경우
	if( fileSize > 1048576 )
		fileSize = Math.floor( ( ( fileSize / 1024 ) / 1024  ) * 100 ) / 100 + "MB";
	else if( fileSize > 1024 )
		fileSize = Math.floor( ( fileSize / 1024 ) * 100 ) / 100 + "KB";
	else
		fileSize += "Byte";
	return fileSize;
}

function preview() {
	var selectObj = fileListAreaID;

	if( selectObj.selectedIndex != -1 ) {
		var fileId = selectObj.options[selectObj.selectedIndex].value;
		var file = fileList[fileId];
		if(file.files[0].name.match(/(\.|\/)(gif|jpe?g|png)$/i)) {
			try {
				var reader = new FileReader();
				reader.onload = function(){
					previewAreaID.innerHTML = '<img src="' + reader.result + '" style="width: 120px; height: 120px;">';
				};
				reader.readAsDataURL(file.files[0]);
			} catch(e) {
			}
		}
	}
}
</script>
<form:form id="hiddenForm" modelAttribute="archive" action="page_delete.do" >
<form:hidden id="hiddenForm_editMode" path="editMode" value="DEL"/>
<form:hidden id="hiddenForm_book_idx" path="book_idx"/>
<form:hidden id="hiddenForm_page_idx" path="page_idx"/>
<form:hidden id="hiddenForm_page_idx_list" path="page_idx_list"/>
<form:hidden id="hiddenForm_code" path="code"/>
</form:form>
<form:form id="archivePageForm" name="archivePageForm" modelAttribute="archive" method="POST" enctype="multipart/form-data" action="page_save.do" onsubmit="return false;">
	<form:hidden path="book_idx"/>
	<form:hidden path="page_idx"/>
	<form:hidden path="editMode" value="ADD"/>
	
	<div id="attach_area">
		<div class="fileUploader" style="width: 640px;">
			<div class="file_attach_info">
				<p>※ 파일명 순서대로 페이지가 생성됩니다. (가나다, ABC 순)</p>
				<p><strong>파일 용량 :</strong> <span id="fileSizeView">0Byte</span></p>
				<p><strong>파일 개수 :</strong> <span id="fileCountView">0</span>개</p>
			</div>
			<div class="preview" style="width: 120px; height: 120px; display: inline-block;">
				<span id="preview">미리보기</span>
			</div>
			<div class="fileBox" style="width: 90%;">
				<div class="fileListArea">
					<form:select id="filelist_select" path="file" multiple="multiple" size="6" title="파일을 여기에 드래그 할 수 있습니다."/>
					<div id="fsUploadProgress" class="fileResult">
						<div class="rate" id="progressText">업로드 진행률</div>
						<div class="loading">
							<div class="progress_bar">
								<span id="progressBarStatus" style="width:0%;"></span>
							</div>
						</div>
						<div class="dsc_loading_no">
							<span id="progressStatus" class="progress">0%</span>
						</div>
					</div>
				</div>
				<div class="file_info">
					<div class="fileUploadControl">
					<span class="fileinput-button">
						<a class="btn btn1"><i class="fa fa-plus-circle"></i><span>파일추가</span></a>
						<input id="fileupload" type="file" name="file" title="파일추가 하기" multiple>
					</span>
						<a class="btn btn1" id="delete_btn"><i class="fa fa-minus-circle"></i><span>선택삭제</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="button right">
		<input type="submit" class="btn btn2" value="등록">
	</div>
</form:form>

	<br>
	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${count}" pattern="#,###" />건
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="150" />
			<col width="150" />
			<col width="" />
			<col width="300" />
			<col width="100">
			<col width="100">
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>순서</th>
				<th>등록 이미지</th>
				<th>페이지명</th>
				<th>이미지 수정</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${archivePageList}">
				<form:form id="mod_form_${i.page_idx}" name="mod_form_${i.page_idx}" modelAttribute="archive" method="POST" enctype="multipart/form-data" action="page_save.do" onsubmit="return false;">
				<form:hidden path="book_idx" id="book_idx_${i.page_idx}" value="${i.book_idx}"/>
				<form:hidden path="page_idx" id="page_idx_${i.page_idx}" value="${i.page_idx}"/>
				<input type="hidden" name="editMode" value="MOD">
				<tr>
					<td><input type="checkbox" class="page_idx_list" value="${i.page_idx}"/></td>
					<td>
						<a href="#" class="btn move-up-btn" data-book_idx="${i.book_idx}" data-page_idx="${i.page_idx}" data-code="${i.code}"><i class="fa fa-angle-double-up"></i></a>
						<form:input path="code" id="code_${i.page_idx}" value="${i.code}" style="width: 50px; text-align: center;" readonly="true"/>
						<a href="#" class="btn move-down-btn" data-book_idx="${i.book_idx}" data-page_idx="${i.page_idx}" data-code="${i.code}"><i class="fa fa-angle-double-down"></i></a>
					</td>
					<td>
						<c:if test="${not empty i.server_file_name}">
						<img src="/data/archive/${archive.homepage_id}/${i.book_idx}/${i.server_file_name}">
						<a href="" class="btn delete-file-btn" data-book_idx="${i.book_idx}" data-page_idx="${i.page_idx}">이미지 삭제</a>
						</c:if>
					</td>
					<td><input type="text" name="subject" id="subject_${i.page_idx}" class="text" style="width: 100%;" value="${i.subject}"></td>
					<td><input type="file" name="file" id="file_${i.page_idx}"></td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" data-book_idx="${i.book_idx}" data-page_idx="${i.page_idx}">수정</a>
						</c:if>
					</td>
					<td>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" data-book_idx="${i.book_idx}" data-page_idx="${i.page_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
				</form:form>
			</c:forEach>
			<c:if test="${count eq 0}">
				<tr>
					<td colspan="5">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="button">
		<a href="#" id="batch-delete-btn" class="btn btn5" data-book_idx="${archive.book_idx}">선택 페이지 삭제</a>
		<a href="#" id="reorder-btn" class="btn" data-book_idx="${archive.book_idx}">순서일괄수정</a>
	</div>
