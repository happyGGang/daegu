<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
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

	$('a#board_save_btn').on('click', function(e) {
		e.preventDefault();
		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}
		
		$('#boardFileArray > option').prop('selected', true);

		<c:if test="${boardManage.editor_use_yn eq 'Y'}">
		if(isEditorOn()) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		</c:if>
		doAjaxPost($('#board'));
	});

	$('a#board_index_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		//var formData = serializeCustom($('#board').serialize());
		var formData = serializeParameter(['manage_idx', 'board_idx', 'menu_idx', 'category1', 'rowCount', 'viewPage', 'search_type', 'search_text']);
		doGetLoad(url, formData);
	});

	$('#board').after('<div id="previewBox" style="display:none;"><div></div></div>');
	$('a#board_preview_btn').on('click', function(e) {
		e.preventDefault();

		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
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

// 		doAjaxPostBoard($('#board'));

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

$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<jsp:include page="/WEB-INF/views/app/board/common/edit/terms.jsp" flush="false" />
<form:form modelAttribute="board" action="save.do" method="post" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="group_idx"/>
<form:hidden path="parent_idx"/>
<form:hidden path="preview_img"/>
<form:hidden path="imsi_v_8"/>
<div class="wrapper-bbs">
	<table class="bbs-edit">
		<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>제목(서명)</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" />
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<jsp:include page="/WEB-INF/views/app/board/common/edit/userName.jsp" flush="false" />
				</td>
				<th>작성일</th>
				<td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<th>전시기간</th>
				<td>
					<form:input path="imsi_v_1" cssClass="text"/>
				</td>
				<th>전시장소</th>
				<td>
					<form:input path="imsi_v_2" cssClass="text"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="editor">
					<div class="bbs-textarea">
						<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}"/>
					</div>
				</td>
			</tr>
			<c:if test="${boardManage.file_use_yn eq 'Y'}">
			<tr>
				<td colspan="4" class="file_attach mmm1">
					<jsp:include page="/WEB-INF/views/app/board/common/edit/jqueryFileUpload.jsp" flush="false">
						<jsp:param name="formId"  value="#board"/>
					</jsp:include>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/board/common/edit/button.jsp" flush="false" />
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>