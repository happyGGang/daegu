<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="/resources/cms/js/load-image.all.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="/resources/cms/js/canvas-to-blob.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-video.js"></script>
<!-- The File Upload validation plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-validate.js"></script>
<script>
var oEditors = [];
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					$('td input:file').remove();
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#editForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
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
					$('#editForm').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 700
	});

	var url = "/cms/specializedServices/imgUpload.do";

	uploadButton = $('<button/>')
		.addClass('btn btn-primary')
		.prop('disabled', true)
		.text('Processing...')
		.on('click', function () {
			var $this = $(this),
					data = $this.data();
			$this
			.off('click')
			.text('취소')
			.on('click', function () {
				$this.remove();
				data.abort();
			});
			data.submit().always(function () {
				$this.remove();
			});
		});

	$('#fileupload').change(function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('img#previewImg').attr('src', e.target.result);
			};
			reader.readAsDataURL(this.files[0]);
		} else {
			$('div img').attr('src', '/resources/img/wsm/noimg_135_42.gif');
		}
	})
	.fileupload({
		url: url,
		dataType: 'json',
		autoUpload: false,
		acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
		maxFileSize: 999000,
		// Enable image resizing, except for Android and Opera,
		// which actually support image resizing, but fail to
		// send Blob objects via XHR requests:
		disableImageResize: /Android(?!.*Chrome)|Opera/
		.test(window.navigator.userAgent),
		previewMaxWidth: 100,
		previewMaxHeight: 100,
		previewCrop: true
	}).on('fileuploadadd', function (e, data) {
		$('div#htmlFiles a').remove();
		$.each(data.files, function (index, file) {
			$('div#htmlFiles').append(uploadButton.clone(true).data(data));
		});
	}).on('fileuploadprocessalways', function (e, data) {
		var index = data.index,
				file = data.files[index];
		if (file.error) {
			$('div#htmlFiles').append('<br>').append($('<span class="text-danger"/>').text(file.error));
		}
		if (index + 1 === data.files.length) {
			$('div#htmlFiles').find('button').hide();
			$('#imgFileTemp').html(data.fileInput);
		}
	}).on('fileuploadprogressall', function (e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function (e, data) {
		$.each(data.result.files, function (index, file) {
			if (file.url) {
				$('#org_file_name').val(file.name);
				$('div#htmlFiles').append('<a href="#" class="paste" data-url="' + file.url + '">에디터에 이미지 삽입</a>');
				$('div#htmlFiles a').on('click', function(e) {
					e.preventDefault();
					pasteHTML($(this).data('url'));
				});
			} else if (file.error) {
				var error = $('<span class="text-danger"/>').text(file.error);
				$('div#htmlFiles').append('<br>').append(error);
			}
		});
	}).on('fileuploadfail', function (e, data) {
		$.each(data.files, function (index) {
			var error = $('<span class="text-danger"/>').text('업로드 실패.');
			$(data.context.children()[index])
			.append('<br>')
			.append(error);
		});
	}).prop('disabled', !$.support.fileInput)
	.parent().addClass($.support.fileInput ? undefined : 'disabled');

});

function getFileData(fileData) {
	fileList = fileData;
	var html = '';
	for (var i = 0; i < fileList.length; i++) {
		alert(fileList[i].name);
	}
}
</script>
<form:form id="editForm" modelAttribute="specializedServices" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="specialized_services_idx"/>
<div id="imgFileTemp" hidden="hidden"></div>
<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>홈페이지(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="service_homepage_id">
					<form:options items="${homepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:options>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>서비스명(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="service_name" cssStyle="width:200px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>링크URL(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="link_url" cssClass="text" cssStyle="width:300px;" maxlength="200"/>
				<%--<div class="ui-state-highlight">
					<em>* 팝업 클릭시 이동 할 URL 입니다.</em>
				</div>--%>
			</td>
		</tr>
		<tr class="detailContent">
			<th>설명(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:textarea path="description" cssStyle="width:100%;height:60px;"/>
			</td>
		</tr>
		<tr>
			<th>이미지 업로드</th>
			<td>
				<form:hidden id="org_file_name" path="org_file_name" />
				<input id="fileupload" type="file" name="imgFile" accept=".gif,.jpeg,.jpg,.png">

			    <div id="progress" class="progress">
			        <div class="progress-bar progress-bar-success"></div>
			    </div>
			</td>
		</tr>
		<tr class="htmlPreview">
			<th scope="row">이미지 미리보기</th>
			<td>
				<div id="htmlFiles" class="item">
					<img src="/resources/cms/img/noimg_135_42.gif" id="previewImg" alt="이미지 미리보기 입니다.">
					<a></a>
				</div>
			</td>
		</tr>
		<tr class="imgPreview">
			<th scope="row">이미지 미리보기</th>
			<td>
				<div id="fileReaderFiles" class="item">
					<c:if test="${specializedServices.org_file_name eq null}">
						<img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다." id="previewImg">
					</c:if>
					<c:if test="${specializedServices.org_file_name ne null}">
						<img src="${getContextPath}/data/specializedServices/${specializedServices.homepage_id}/${specializedServices.server_file_name}" alt="${specializedServices.server_file_name}" id="previewImg">
					</c:if>
					<a></a>
				</div>
			</td>
		</tr>
		</tr>
		<tr>
			<th>노출여부</th>
			<td>
				<form:radiobutton path="view_yn" value="Y"/> <label for="view_yn1" style="cursor:pointer;">노출함</label>&nbsp;
				<form:radiobutton path="view_yn" value="N"/> <label for="view_yn2" style="cursor:pointer;">미노출함</label>
			</td>
		</tr>
	</tbody>
</table>
</form:form>