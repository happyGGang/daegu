<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "html",
		sSkinURI: "${getContextPath}/resources/cms/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function() {
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			$('input:radio[name="html_use_yn"][value="${popup.html_use_yn}"]').click();
		},
		fCreator: "createSEditor2"
	});
	
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
					oEditors.getById["html"].exec("UPDATE_CONTENTS_FIELD", []);
					$('td input:file').remove();
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#popup').serialize(),
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
					$('#popup').ajaxSubmit(option);
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
		height: 800
	});
	
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
    var url = "/cms/popup/imgUpload.do";

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
				$('div img').attr('src', e.target.result);
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
            $('div#htmlFiles').find('button').text('업로드').prop('disabled', !!data.files.error);
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
    
    $('input:radio[name="html_use_yn"]').on('click', function() {
    	if ( this.value === 'Y' ) {
    		$('tr.detailContent').show();
    		$('tr.htmlPreview').show();
    		$('tr.imgPreview').hide();
    	}
    	else{
    		$('tr.detailContent').hide();
    		$('tr.htmlPreview').hide();
    		$('tr.imgPreview').show();
    	}
    });
});

function getFileData(fileData) {
	fileList = fileData;
	var html = '';
	for (var i = 0; i < fileList.length; i++) {
		alert(fileList[i].name);
	}
}

function pasteHTML(filepath){
    var sHTML = '<img src="'+filepath+'">';
    oEditors.getById["html"].exec("PASTE_HTML", [sHTML]);
}
</script>
<form:form modelAttribute="popup" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="popup_idx"/>
<form:hidden path="popup_type" value="LAYER"/>
<div id="imgFileTemp" hidden="hidden"></div>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>팝업명(<span class="required">*</span>)</th>
			<td>
				<form:input path="popup_name" cssStyle="width:200px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>게시일(<span class="required">*</span>)</th>
			<td>
				<form:input path="start_date" cssClass="text ui-calendar"/> ~ <form:input path="end_date" cssClass="text ui-calendar"/>
			</td>
		</tr>
		<%-- <tr>
			<th>팝업종류</th>
			<td>
				<form:radiobutton path="popup_type" value="LAYER"/> <label for="popup_type1" style="cursor:pointer;">레이어</label>&nbsp;
				<form:radiobutton path="popup_type" value="WINDOW"/> <label for="popup_type2" style="cursor:pointer;">윈도우</label>
			</td>
		</tr> --%>
		<tr>
			<th>창크기</th>
			<td>
				가로 <form:input path="width" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				세로 <form:input path="height" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>px 단위로 설정합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>창위치</th>
			<td>
				상단 <form:input path="y_position" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				왼쪽 <form:input path="x_position" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>px 단위로 설정합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>링크URL(<span class="required">*</span>)</th>
			<td>
				<form:input path="link_url" cssClass="text" cssStyle="width:300px;" maxlength="200"/>
			</td>
		</tr>
		<tr>
			<th>링크타겟</th>
			<td>
				<form:radiobutton path="link_target" value="CURRENT"/> <label for="link_target1" style="cursor:pointer;">현재창</label>&nbsp;
				<form:radiobutton path="link_target" value="BLANK"/> <label for="link_target2" style="cursor:pointer;">새창</label>
			</td>
		</tr>
		<tr>
			<th>HTML 사용여부</th>
			<td>
				<form:radiobutton path="html_use_yn" value="Y"/> <label for="html_use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
				<form:radiobutton path="html_use_yn" value="N"/> <label for="html_use_yn2" style="cursor:pointer;">사용안함</label>
			</td>
		</tr>
		<tr class="detailContent">
			<th>상세내용</th>
			<td> 
				<form:textarea path="html" cssStyle="width:100%;height:60px;"/>
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
			<td colspan="3">
				<div id="htmlFiles" class="item">
					<img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다.">
					<a></a>					 
				</div>
			</td>
		</tr>
		<tr class="imgPreview">
			<th scope="row">이미지 미리보기</th>
			<td colspan="3">
				<div id="fileReaderFiles" class="item">
					<c:if test="${popup.org_file_name eq null}">
						<img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다.">
					</c:if>
					<c:if test="${popup.org_file_name ne null}">
						<img src="${getContextPath}/data/popup/${popup.homepage_id}/${popup.server_file_name}" alt="${popup.server_file_name}">
					</c:if>
					<a></a>					 
				</div>
			</td>
		</tr>
		<tr>
			<th>출력 순서</th>
			<td>
				<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>내림차순 정렬. 높을 수록 앞에 출력됩니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<form:radiobutton path="use_yn" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
				<form:radiobutton path="use_yn" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
			</td>
		</tr>
		<c:if test="${popup.homepage_id eq 'h1'}">
		<tr>
			<th>공통적용여부</th>
			<td>
				<form:radiobutton path="common_yn" value="Y"/> <label for="common_yn1" style="cursor:pointer;">사용함</label>&nbsp;
				<form:radiobutton path="common_yn" value="N"/> <label for="common_yn2" style="cursor:pointer;">사용안함</label>
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
</form:form>