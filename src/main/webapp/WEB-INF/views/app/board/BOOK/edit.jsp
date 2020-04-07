<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {

	if ('${board.editMode}' == 'ADD') {
		$('input[name=secret_yn][value=Y]').prop('checked', true);
	}
});
</script>
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

		var imsi1 = $('input#imsi_v_1_1').val();
		var imsi2 = $('input#imsi_v_1_2').val();
		if (imsi2.length == 1) {
			imsi2 = '0' + imsi2;
		}
		$('input#imsi_v_1').val(imsi1 + '-' + imsi2);

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

	<c:if test="${fn:length(board.imsi_v_1) > 0}">
	var imsi_v_1 = '${board.imsi_v_1}'.split('-');
	$('input#imsi_v_1_1').val(imsi_v_1[0]);
	$('input#imsi_v_1_2').val(imsi_v_1[1]);
	</c:if>

	<c:if test="${board.editMode eq 'ADD'}">
	var currDate = new Date();
	var currYear = currDate.getFullYear();
	var currMonth = currDate.getMonth()+1;
	if (currMonth < 10) {
		currMonth = '0'+currMonth;
	}
	$('input#imsi_v_1_1').val(currYear);
	$('input#imsi_v_1_2').val(currMonth);
	</c:if>
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

	$('a#getIlus').on('click', function(e) {
		e.preventDefault();
		if ('${homepage.context_path}' == '') {
			alert('홈페이지에서만 가능합니다');
		} else {
			var ilusList = window.open('/${homepage.context_path}/intro/search/indexForBoard.do', 'ilusLnkBook', 'width=800 height=600,scrollbars=yes');
		}
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

function getLasData(arg) {
	arg = arg.split('///');
	//${i.TITLE}//${i.PUBLER_YEAR}//${i.AUTHOR}//${i.PUBLER}//${i.ISBN}//${i.CALL_NO}//${i.i.COVER_SMALLURL}//${i.CTRLNO}//${i.PLACE_NAME}
	$('input#title').val(arg[0]);
	$('input#imsi_v_2').val(arg[1]);
	$('input#imsi_v_3').val(arg[2]);
	$('input#imsi_v_4').val(arg[3]);
	$('input#imsi_v_5').val(arg[4]);
	$('input#imsi_v_7').val(arg[5]);
	$('input#preview_img').val(arg[6]);
	$('input#imsi_v_6').val(arg[7]);
	return false;
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
				<th>추천년월(*)</th>
				<td>
					<form:hidden path="imsi_v_1" cssClass="text" />
					<input id="imsi_v_1_1" class="text" maxlength="4" numberOnly="true" style="width: 50px;"/>년
					<input id="imsi_v_1_2" class="text" maxlength="2" numberOnly="true" style="width: 30px;" />월 ex) 2016-01
				</td>
				<th>출판년도</th>
				<td>
					<form:input path="imsi_v_2" cssClass="text" maxlength="4" numberOnly="true" /> ex) 2016
				</td>
			</tr>
			<tr>
				<th>저자</th>
				<td>
					<form:input path="imsi_v_3" cssClass="text" maxlength="100"/>
				</td>
				<th>출판사</th>
				<td>
					<form:input path="imsi_v_4" cssClass="text" maxlength="100"/>
				</td>
			</tr>
			<tr>
				<th>소장자료실</th>
				<td>
					<form:input path="imsi_v_6" cssClass="text" maxlength="100"/>
				</td>
				<th>ISBN</th>
				<td>
					<form:input path="imsi_v_5" cssClass="text" maxlength="100"/>
				</td>
			</tr>
			<tr>
				<th>청구기호</th>
				<td>
					<form:input path="imsi_v_7" cssClass="text" maxlength="100"/>
				</td>
				<th>도서검색</th>
				<td>
					<a href="#" class="btn btn2" id="getIlus"><i class="fa fa-plus"></i><span>도서검색</span></a>
					<br/>
					*도서검색을 통해 등록할 경우 <br/>책 이미지 등록하지 않으셔도 됩니다.
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