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
	
	<c:if test="${fn:length(board.imsi_v_1) > 0}">
	var imsi_v_1 = '${board.imsi_v_1}'.split('-');
	$('input#imsi_v_1_1').val(imsi_v_1[0]);
	$('input#imsi_v_1_2').val(imsi_v_1[1]);
	</c:if>
	
	<c:if test="${board.editMode eq 'MODIFY'}">
	var yyyymmdd = '${board.imsi_v_1}' +'-'+'${board.imsi_v_2}';
	$('input#tmp').val(yyyymmdd);
	$('input#tmp').datepicker({});
	$('input#tmp').on('change', function() {
		var val = $(this).val();
		var yyyymm = val.substr(0,7);
		var dd = val.substr(8);
		$('input#imsi_v_1').val(yyyymm);
		$('input#imsi_v_2').val(dd);
	});
	if ('${board.imsi_v_13}' != '' && '${board.imsi_v_13}'.indexOf('분') > -1) {
		var imsi_v_13 = '${board.imsi_v_13}'.replace('분', ''); 
		$('input#imsi_v_13').val(imsi_v_13);
	}
	</c:if>
	<c:if test="${board.editMode eq 'ADD'}">
	var currDate = new Date();
	var currDateStr = currDate.yyyymmdd();
	$('input#tmp').val(currDate.yyyymmdd());
	$('input#imsi_v_1').val(currDateStr.substr(0,7));
	$('input#imsi_v_2').val(currDateStr.substr(8));
	$('input#tmp').datepicker({});
	$('input#tmp').on('change', function() {
		var val = $(this).val();
		var yyyymm = val.substr(0,7);
		var dd = val.substr(8);
		$('input#imsi_v_1').val(yyyymm);
		$('input#imsi_v_2').val(dd);
	});
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
Date.prototype.yyyymmdd = function()
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + '-' +(mm[1] ? mm : '0'+mm[0]) + '-' + (dd[1] ? dd : '0'+dd[0]);
}

</script>
<jsp:include page="/WEB-INF/views/app/board/common/edit/terms.jsp" flush="false" />
<form:form modelAttribute="board" action="save.do" method="post" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="group_idx"/>
<form:hidden path="parent_idx"/>
<form:hidden path="plan_date"/>
<div class="wrapper-bbs">
	<table class="bbs-edit">
		<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>영화제목</th>
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
				<c:choose>
          <c:when test="${homepage.context_path eq 'gw'}">
            <td><form:input path="add_date_sample" cssClass="text" cssStyle="width:30%" maxlength="100" /></td>
          </c:when>
          <c:otherwise>
            <td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
          </c:otherwise>
        </c:choose>
			</tr>
			<tr> 
				<th>일시</th>
				<td colspan="3">
					<input id="tmp" type="text" class="text ui-calendar">
					<form:hidden path="imsi_v_1"/>
					<form:hidden path="imsi_v_2"/>
					<form:input path="imsi_v_3" cssClass="text" cssStyle="width:6%" maxlength="2" numberOnly="true"/>시 
					<form:input path="imsi_v_4" cssClass="text" cssStyle="width:6%" maxlength="2" numberOnly="true"/>분 ex) 14:30
				</td>
			</tr>
			<tr> 
				<th>상영장소</th>
				<td>
					<form:input path="imsi_v_6" cssClass="text" maxlength="100"/>
				</td>
				<th>상영시간(러닝타임)</th>
				<td>
					<form:input path="imsi_v_13" cssClass="text" cssStyle="width:20%"  maxlength="3" numberOnly="true"/>분
				</td>
			</tr>
			<tr> 
				<th>감독</th>
				<td>
					<form:input path="imsi_v_7" cssClass="text" maxlength="100"/>
				</td>
				<th>출연</th>
				<td>
					<form:input path="imsi_v_8" cssClass="text" maxlength="100"/>
				</td>
			</tr>
			<tr> 
				<th>장르</th>
				<td>
					<form:input path="imsi_v_9" cssClass="text" maxlength="100"/>
				</td>
				<th>등급</th>
				<td>
					<form:input path="imsi_v_12" cssClass="text" maxlength="100"/>
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
				<td colspan="4" class="file_attach">
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