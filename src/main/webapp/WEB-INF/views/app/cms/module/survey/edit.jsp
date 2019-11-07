<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(document).ready(function() {
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "survey_content",
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
					oEditors.getById["survey_content"].exec("UPDATE_CONTENTS_FIELD", []);
				} else {
					oEditors.getById["survey_content"].exec("LOAD_CONTENTS_FIELD");
				}
			}
		} catch(e) {
			
		}
	});
	
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		oEditors.getById["survey_content"].exec("UPDATE_CONTENTS_FIELD", []);
		if ( doAjaxPost($('#survey')) ) {
			var url = 'index.do';
			var formData = serializeParameter(['viewPage', 'homepage_id']);
			
			doGetLoad(url, formData);
		}
	});
	
	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		
		var url = 'index.do';
		var formData = serializeParameter(['viewPage', 'homepage_id']);
		
		doGetLoad(url, formData);
	});
	
	$('input#survey_start_date').datepicker({
		maxDate: $('input#survey_end_date').val(), 
		onClose: function(selectedDate){
			$('input#survey_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#survey_end_date').datepicker({
		minDate: $('input#survey_start_date').val(), 
		onClose: function(selectedDate){
			$('input#survey_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
		
	<%-- 설문지 수정 팝업 --%>
	$('#btn_edit').on('click', function(e) {
		e.preventDefault();
		var quest_popup = window.open('/cms/survey/quest/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', 'survey_quest', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
		quest_popup.focus();
	});
	
	<%-- 설문지 보기 팝업 --%>
	$('#btn_view').on('click', function(e) {
		e.preventDefault();
		window.open('/${homepage.context_path}/module/survey/view.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', 'survey_quest');
	});
	<%-- 설문지통계 팝업 --%>
	$('#btn_analysis').on('click', function(e) {
		e.preventDefault();
		window.open('/cms/survey/surveyStatistics/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', 'survey_quest', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
	
	<%-- 응답자 현황 --%>
	$('#btn_check').on('click', function(e) {
		e.preventDefault();
		window.open('/cms/survey/surveyStatistics/answerUser.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', 'survey_answer_user', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
	
	<%--주소복사--%>
	$('#btn_copyUrl').on('click', function(e) {
		e.preventDefault();
		alert('준비중');
	});
	
	<%--조사여부 변경--%>
	$('#btn_change').on('click', function(e) {
		e.preventDefault();
		if (confirm('조사여부를 변경하시겠습니까?')) {
			$('form#survey').attr('action', 'changeOpen.do');
			
			doAjaxPost($('form#survey'));
		}
	});
	
	
	$('a#preview-button1').on('click', function(e) {
		e.preventDefault();
		
		window.open('skinSample.do?skin_cd=1', 'survey_answer_user', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
		
	});
	
	$('a#preview-button2').on('click', function(e) {
		e.preventDefault();
		window.open('skinSample.do?skin_cd=2', 'survey_answer_user', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
});
</script>
<style>
table tbody th{text-align: center; font-weight: bold !important;}
</style>
<form:form modelAttribute="survey" method="POST" action="save.do">
<form:hidden path="homepage_id" />
<form:hidden path="survey_idx" />
<form:hidden path="editMode"/>
	<fieldset>			
		<table class="type2" summary="새로운 설문을 등록할 수 있습니다.">
			<h5>설문조사 기본설정</h5>
			<colgroup>
				<col width="20%" />
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th>조사자</th>
					<c:if test="${survey.editMode eq 'ADD' }">
					<td>${member.member_id}</td>
					</c:if>
					<c:if test="${survey.editMode eq 'MODIFY' }">
					<td>${survey.add_user_id}</td>
					</c:if>
				</tr>
				<tr>
					<th>조사명</th>
					<td>
						<form:input path="survey_title" cssStyle="width:500px;" cssClass="text" maxlength="25"/>
					</td>
				</tr>
				<tr style="display: none;">
					<th>연락처</th>
					<td>
						<form:hidden path="add_user_tel"/>							
						<form:input path="add_user_tel1" cssStyle="width:40px;" class="text" maxlength="3" numberonly="true"/>-
						<form:input path="add_user_tel2" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/> -
						<form:input path="add_user_tel3" cssStyle="width:40px;" class="text" maxlength="4" numberonly="true"/>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="item">
							<form:textarea path="survey_content" cssClass="i_text" cssStyle="width:90%; display:none;" rows="5" wrap="hard"/>
						</div>	
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="">스킨</label></th>
					<td class="aL" colspan="3">
						<form:radiobutton path="skin_cd" value="1" label="스킨1"/>
						<form:radiobutton path="skin_cd" value="2" label="스킨2"/>
						&nbsp;&nbsp;&nbsp;
						<a href="#" id="preview-button1" class="btn">스킨1 샘플 보기</a>
						&nbsp;&nbsp;&nbsp;
						<a href="#" id="preview-button2" class="btn">스킨2 샘플 보기</a>
					</td>
				</tr>		 			
				<tr>
					<th>설문기간</th>
					<td>
						<form:input type="text" id="survey_start_date" path="survey_start_date" class="text ui-calendar"/>
						<span id="tilde" style="font-size:12px">~</span>
						<form:input type="text" id="survey_end_date" path="survey_end_date" class="text ui-calendar"/>
					</td>
				</tr>
				<tr>
					<th>설문조사 공개여부</th>
					<td>
						<form:radiobutton path="survey_private_yn" value="N" label="아니오"/>
						<form:radiobutton path="survey_private_yn" value="Y" label="예"/>
						("예" 선택시 도서관홈페이지에 해당 설문조사가 공개됩니다.)
					</td>
				</tr>
				<tr>
					<th>설문조사개방</th>
					<td>
						<form:radiobutton path="survey_open_yn" value="N" label="아니오"/>
						<form:radiobutton path="survey_open_yn" value="Y" label="예"/>
						("예" 선택시 기간내 참여가 가능합니다. "아니오" 선택시 기간과 별개로 마감됩니다. )
					</td>
				</tr>
				<tr>
					<th>익명여부</th>
					<td>
						<form:radiobutton path="name_yn" value="N" label="아니오"/>
						<form:radiobutton path="name_yn" value="Y" label="예"/>
						("예" 선택시 익명으로 참여하게 됩니다. )
					</td>
				</tr>
				<tr>
					<th>결과공개여부</th>
					<td>
						<form:radiobutton path="open_yn" value="N" label="아니오"/>
						<form:radiobutton path="open_yn" value="Y" label="예"/>
						("예" 선택시 일반이용자도 설문결과 조회가 가능합니다.)
					</td>
				</tr>
				<tr>
					<th>팝업유무</th>
					<td>
						<form:radiobutton path="popup_yn" value="N" label="아니오"/>
						<form:radiobutton path="popup_yn" value="Y" label="예"/>
						("예" 선택시 설문조사 페이지가 새창으로 열립니다.)
					</td>
				</tr>
				<tr>
					<th>비로그인 사용자 참여여부</th>
					<td>
						<form:radiobutton path="annyms_yn" value="N" label="아니오"/>
						<form:radiobutton path="annyms_yn" value="Y" label="예"/>
						("예" 선택시 비로그인 사용자도 설문조사에 참여가능합니다.(중복응답가능))
					</td>
				</tr>
				<tr>
					<th>인사말</br>(설문종료 후 인사말)</th>
					<td>
						<div class="item">
							<form:textarea path="greetings" cssClass="i_text" cssStyle="width:90%; resize:none;" rows="5" wrap="hard"/>
						</div>	
					</td>
				</tr>									
			</tbody>
		</table>
		<strong style="color:#0054FF;">※본 조사는 응답자가 생길 경우 모든 수정이 불가합니다.</strong>
	</fieldset>
</form:form>
<div class="button" style="text-align: center; padding-top: 20px;">
	<a href="" id="save_btn" class="btn btn1"><span>저장</span></a>
	<a href="" id="list_btn" class="btn"><span>목록</span></a>
</div>

<div id="dialog-1" class="dialog-common" title="설문등록"></div>
<!-- <div id="dialog-8" class="dialog-common" title="스킨 미리보기"></div> -->
<!-- <div id="skin1-preview" title="스킨1 샘플" style="display: none;"> -->
<!-- <img src="/resources/cms/survey/img/skin1_preview.jpg" alt="스킨1 샘플"> -->
<!-- </div> -->

<!-- <div id="skin2-preview" title="스킨2 샘플" style="display: none;"> -->
<!-- <img src="/resources/cms/survey/img/skin2_preview.jpg" alt="스킨2 샘플"> -->
<!-- </div> -->