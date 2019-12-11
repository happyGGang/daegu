<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${getContexPath}/resources/common/jqueryFileUpload/js/vendor/jquery.ui.widget.js"></script>
<script src="${getContexPath}/resources/common/jqueryFileUpload/js/jquery.iframe-transport.js"></script>
<script src="${getContexPath}/resources/common/jqueryFileUpload/js/jquery.fileupload.js"></script>
<script src="${getContexPath}/resources/common/jqueryFileUpload/js/handlers.js"></script>
<style>
.fileinput-button {position: relative; overflow: hidden;}
.fileinput-button input {position: absolute; top: 0; right: 0; margin: 0; opacity: 0; -ms-filter: 'alpha(opacity=0)'; font-size: 200px; direction: ltr; cursor: pointer;}

/* Fixes for IE < 8 */
@media screen\9 {
  .fileinput-button input {filter: alpha(opacity=0); font-size: 100%; height: 100%;}
}
</style>

<script>
	var uploading = false;
	var file_ban_ext = '${boardManage.file_ban_ext}';
	$(document).ready(function() {
		/* $.ajax('${getContextPath}/board/boardFile/initBoardFile.ws?mode=${board.editMode}&board_idx=${board.board_idx}');	 */

		<c:if test="${board.editMode eq 'modify'}">
	    <c:forEach var="i" varStatus="status" items="${boardFileList}">
	    var file = new Object();
	    file.filestatus = -4;
		file.name = '${i.org_file_name}';
		file.saveFileName = '${i.server_file_name}';
		file.status = -4;
		file.id = 'file_${status.index}';
		file.index = fileNum++;
		file.size = ${i.file_size};
		file.ext = '${i.file_ext_name}';
		file.path = '${i.file_path}/${i.board_idx}/';
		file.makeValue = file.name+'//'+file.saveFileName+'//'+file.size+'//'+file.ext+'//'+file.index;
		fileList.push( file );
		updateNum++;
	    </c:forEach>
	    </c:if>

		$('#fileupload').fileupload({
	        dataType: 'json',
	        url : '/board/boardFile/upload.do',
	        limitMultiFileUploadSize : 10*1024*1024, // 10Mb
	        add : function(e, data) {
	        	$('select#boardFileArray').addClass('on');
	        	var file_count = $('#boardFileArray > option').length;
	        	data.formData = { "mode" : "${board.editMode}" , "board_idx" : "${board.board_idx}", "file_count" : file_count};
	        	data.process().done(function () {
	                data.submit();
	            });
	        },
	        submit : function(e, data) {
	        	uploading = true;
	        	$.each(data.files, function(index, file) {
	        		uploadStart(file);
	        	});
	        },
	        done : function(e, data) {
	        	uploading = false;
	        	$.each(data.files, function(index, file) {
	        		uploadSuccess(file, data.result);
	        	});
	        	previewUpload();
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

		fileListAreaID = $('#boardFileArray')[0];		//select 박스 id
	    previewAreaID = $('#previewFile')[0];			//미리보기 ID
	    fileSizeViewID = $('#fileSizeView')[0];			//파일사이즈 ID
	    defaultPath = "${board.editMode eq 'MODIFY'?'/data/board/':'/data/boardTemp/'}";	// 파일 미리보기 폴더
	    //defaultPath = "/data/board/";
	    /* totalFileSize = '10';  	// 파일 총용량 사이즈(MB)
	    singleFileSize = '5';		// 파일당 사이즈(MB)
	    fileCount = '10';		// 허용 파일 갯수 */

	    $('#delete_btn').on('click', function(e) {
	    	e.preventDefault();
	    	deleteFiles($('input#board_idx').val(), $('input#editMode').val());
	    });

	    $('#boardFileArray').on('change', function(e) {
	    	e.preventDefault();
	    	preview();
	    });

	    $('#inEditorButton').on('click', function(e) {
	    	e.preventDefault();
	    	pasteHTML('content');
	    });

	    showFileList();
	});
</script>

<input type="hidden" id="preview_img" />
<form:hidden path="deleteBoardFileArray" />
<div id="attach_area">
	<h4>파일첨부</h4>
	<div class="fileUploader">
		<div class="file_attach_info">
			<p><strong>파일 용량 :</strong> <span id="fileSizeView">0Byte</span> / 최대 200MB</p>
			<p><strong>파일 갯수 :</strong> 최대 5 개</p>
		</div>
		<div class="preview">
			<span id="previewFile">미리보기</span>
		</div>
		<div class="fileBox">
			<div class="fileListArea">
				<form:select path="boardFileArray" multiple="multiple" size="6" />
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
					<input id="fileupload" type="file" name="multiFile" multiple>
				</span>
					<a class="btn btn1" id="delete_btn"><i class="fa fa-minus-circle"></i><span>선택삭제</span></a>
					<a class="btn btn1" id="inEditorButton"><i class="fa fa-arrow-circle-up"></i><span>에디터에 넣기</span></a>
				</div>
			</div>
		</div>
	</div>
</div>