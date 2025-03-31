<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
var prevEditorDisplay = '';
$(document).ready(function() {
	<c:if test="${boardManage.editor_use_yn eq 'Y'}">
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "/resources/common/smart_editor/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			//웹취약점 발생시 삭제처리해야함
			bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {

		},
		fCreator: "createSEditor2"
	});

	try {
		prevEditorDisplay = $('.bbs-textarea iframe').css('display');
	} catch(e) { }
	$(window).on('resize', function(e) {
		try {
			var currEditorDisplay = $('.bbs-textarea iframe').css('display');
			if(prevEditorDisplay != currEditorDisplay) {
				prevEditorDisplay = currEditorDisplay;
				if(currEditorDisplay == 'none') {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				} else {
					oEditors.getById["content"].exec("LOAD_CONTENTS_FIELD");
				}
			}
		} catch(e) {

		}
	});
	</c:if>
	$('#board').after('<div id="previewBox" style="display:none;"><div></div></div>');
	$('a#board_preview_btn').on('click', function(e) {
		e.preventDefault();
		<c:if test="${boardManage.editor_use_yn eq 'Y' and !isMobile}">
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		</c:if>
		$('#cloneBoard').remove();
		var cloneBoard = $('form#board').clone();
		$(cloneBoard).attr('id', 'cloneBoard');
		$(cloneBoard).css('display', 'none');
		$(cloneBoard).attr('action', 'preview.do');
		$(cloneBoard).attr('target', 'previewWindow');
		$(cloneBoard).attr('onsubmit', '');
		$('#board').after(cloneBoard);

		var wWidth = $(window).width();
	    var dWidth = wWidth * 0.8;
	    var wHeight = $(window).height();
	    var dHeight = wHeight * 0.8;
		$('div#previewBox > div').load('preview.do', $('form#cloneBoard').serialize());
		var previewBoxDialog = $('div#previewBox > div').dialog({
			modal:true,
			title:'게시물 미리보기',
			width: dWidth,
            height: dHeight,
			position:{
				my:"center",
				at:"center",
				of:window
			},
			close:function() {
				previewBoxDialog.dialog("destroy");
			},
			buttons: [
				{
					text: "닫기",
					"class": 'btn btn1',
					click: function() {
						previewBoxDialog.dialog("destroy");
					}
				}
			]
		});

// 		var previewWindow = window.open('', "previewWindow");
// 		$('form#cloneBoard').submit();


	});

	$('a#board_save_btn').on('click', function(e) {
		e.preventDefault();
        let phoneRegix = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
        if ($('input#user_phone').val() == null || $('input#user_phone').val() === '') {
            alert('연락처를 입력해주세요.');
            return false;
        }
        if (!phoneRegix.test($('input#user_phone').val())) {
            alert('연락처를 형식에 맞춰 입력해주세요.');
            return false;
        }
        if ($('input#imsi_v_1_1_man').val() == null || $('input#imsi_v_1_1_woman').val() == null) {
            alert('성별을 선택해주세요.');
            return false;
        }

		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

		$('#boardFileArray > option').prop('selected', true);

		//$('#content').val($('#content').val().replace(/onE|onM|alert|EMBED|onerror|error/g, ''));

		<c:if test="${boardManage.editor_use_yn eq 'Y'}">
		if(isEditorOn()) {
			//유튜브 업로드시 iframe 사용시 사용가능하게
			var text = oEditors.getById["content"].getIR().replace(/onE|onM|alert|EMBED|onerror|error|onF|onf|onm|onC|Script|script/gi, '');

			oEditors.getById["content"].exec("SET_IR", ['']);
		 	oEditors.getById["content"].exec("PASTE_HTML", [text]);
		 	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		</c:if>
		doAjaxPostBoard($('#board'));
	});

	$('a#board_index_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		//var formData = serializeCustom($('#board').serialize());
		var formData = serializeParameter(['manage_idx', 'board_idx', 'menu_idx', 'category1', 'rowCount', 'viewPage', 'search_type', 'search_text']);
		doGetLoad(url, formData);
	});

	$('input.customCalendar').datepicker({
		onClose: function(selectedDate) {
			$(this).datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#notice_start_date').datepicker({
		maxDate: $('input#notice_end_date').val(),
		onClose: function(selectedDate) {
			$('input#notice_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#notice_end_date').datepicker({
		minDate: $('input#notice_start_date').val(),
		onClose: function(selectedDate) {
			$('input#notice_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#kioskNotice_start_date').datepicker({
		maxDate: $('input#kioskNotice_end_date').val(),
		onClose: function(selectedDate) {
			$('input#kioskNotice_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#kioskNotice_end_date').datepicker({
		minDate: $('input#kioskNotice_start_date').val(),
		onClose: function(selectedDate) {
			$('input#kioskNotice_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input.custom_phone1, input.custom_phone2, input.custom_phone3').on('blur', function(e) {
		var phone1 = $('input#' + $(this).attr('targetFieldId') + '_1').val();
		var phone2 = $('input#' + $(this).attr('targetFieldId') + '_2').val();
		var phone3 = $('input#' + $(this).attr('targetFieldId') + '_3').val();

		$('input#' + $(this).attr('targetFieldId')).val(phone1 + '-' + phone2 + '-' + phone3);
	});

	$('input.custom_email1, input.custom_email2').on('blur', function(e) {
		var email1 = $('input#' + $(this).attr('targetFieldId') + '_1').val();
		var email2 = $('input#' + $(this).attr('targetFieldId') + '_2').val();

		$('input#' + $(this).attr('targetFieldId')).val(email1 + '@' + email2);
	});

	$('a#ebook_btn').on('click', function(e) {
		alert('E_Book 사이트로 이동합니다. \n왼쪽 E-Book생성 메뉴를 선택하셔서 pdf파일 업로드 하신후에 URL을 복사해주시기 바랍니다.');
		window.open('http://ebook.dge.go.kr/program/administrator/administrator_action.jsp?adminId=admin&password=admin&amode=login', '_blank');
	});

});

function isEditorOn() {
	if($('.bbs-textarea iframe').length == 0) {
		return false;
	} else if($('.bbs-textarea iframe').css('display') == 'none') { 
		return false;
	} else {
		return true;
	}
}
function doAjaxPostBoard(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);
	var responseValid = false;

    $.ajax({
        type: "POST",
        url: form.attr('action'),
        async: false,
        data: formData,
        dataType:'json',
        success: function(response) {
        	response = eval(response);
        	responseValid = response.valid;
            if(response.valid) {
                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
                	 alert(response.message);
                 }
                 if(response.reload) {
                	 location.reload();
                 }
                 if(response.targetOpener) {
                	 window.open(response.url, '','width=500,height=510');
                	 return false;
                 }
                 if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
                	 /**
                	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
                	  */
                	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
                		 doAjaxLoad(ajaxBody, response.url, response.data);

                	 } else {
                		 doGetLoad(response.url, response.data);
                	 }
                 }
			} else {
				if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
					alert(response.message);
                } else {
                	for(var i =0 ; i < response.result.length ; i++) {
    					alert(response.result[i].code);
    					$('#'+response.result[i].field).focus();
    					$('#'+response.result[i].field, $(form)).css('border-color', 'red');
                		$('#'+response.result[i].field, $(form)).on('change', function() {
                			$(this).css('border-color', '');
                		});
    					break;
    				}
                }

				if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
					if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
               	 	}
				}
			}
         },
         error: function(jqXHR, textStatus, errorThrown) {
             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
         }
    });

    return responseValid;
}
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>