<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script>
var oEditors = [];
$(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "contents",
		sSkinURI: "/resources/common/smart_editor/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
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
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				} else {
					oEditors.getById["contents"].exec("LOAD_CONTENTS_FIELD");
				}
			}
		} catch(e) {

		}
	});

	$('#dialog-1').dialog({ //모달창 기본 스크립트 선언
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
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					var option = {
						url : 'save.do',
						type : 'POST',
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
					$('#terms').ajaxSubmit(option);
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
		width: 850,
		height: 600
	});
	
	
	if($('#terms_type').val() == 6) {
		$('#manage_idx').removeAttr('disabled');
		$('#manage_idx').show();
	}
	$('#terms_type').on('change', function(e) {
		e.preventDefault();
		if($(this).val() == 6) {
			$('#manage_idx').removeAttr('disabled');
			$('#manage_idx').show();
		} else {
			$('#manage_idx').attr('disabled', 'true');
			$('#manage_idx').hide();
		}
	});

});
</script>
<form:form modelAttribute="terms" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="terms_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>약관구분</th>
			<td>
				<form:select path="terms_type" cssStyle="height:24px;">
					<c:forEach var="i" varStatus="status" items="${termsTypeList}">
						<option value="${i.code_id}" <c:if test="${i.code_id eq terms.terms_type}">selected="selected"</c:if>>${i.code_name}</option>
					</c:forEach>
				</form:select>
				
				<form:select path="manage_idx" disabled="true" cssStyle="display: none;">
					<form:option value="0">게시판 선택</form:option>
					<form:options items="${boardManageTermsList}" itemLabel="board_name" itemValue="manage_idx"/>
				</form:select>
			</td>
		</tr>

		<tr>
			<th>필수여부</th>
			<td>
				<form:radiobutton path="required_yn" value="Y" label="필수"/>
				<form:radiobutton path="required_yn" value="N" label="선택"/>
			</td>
		</tr>

		<tr>
			<th>제목</th>
			<td>
				<form:input path="title" cssStyle="width:200px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>

		<tr class="detailContent">
			<th>상세내용</th>
			<td>
				<div class="bbs-textarea">
					<form:textarea path="contents" rows="10" cols="100" cssStyle="width:95%;"/>
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
	</tbody>
</table>
</form:form>