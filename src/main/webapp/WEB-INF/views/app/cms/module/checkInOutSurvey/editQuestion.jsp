<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "문항 추가",
				"class": 'btn btn5 add-question',
				click: function() {
					$('#comment').remove();
					var control_key		= "question_" + $('div.questionLayer').length;
					var homepage_id 	= '${checkInOutSurveyQuestion.homepage_id}';
					var checkinout_survey_idx 		= '${checkInOutSurveyQuestion.checkinout_survey_idx}';
					var question_form 	= [];
					question_form.push('<div class="questionLayer" style="margin-bottom:10px;">');
					question_form.push('<form id="' + control_key + '" name="checkInOutSurveyQuestion" class="questionForm" method="post" action="saveQuestion.do" enctype="multipart/form-data">');
					question_form.push('	<input type="hidden" name="_csrf" value="${_csrf.token}">');
					question_form.push('	<input type="hidden" id="editMode" name="editMode" value="ADD"/>');
					question_form.push('	<input type="hidden" id="homepage_id" name="homepage_id" value="' + homepage_id + '"/>');
					question_form.push('	<input type="hidden" id="checkinout_survey_idx" name="checkinout_survey_idx" value="' + checkinout_survey_idx + '"/>');
					question_form.push('	<input type="hidden" id="checkinout_survey_question_idx" name="checkinout_survey_question_idx" value="0"/>');
					question_form.push('    <input type="hidden" id="checkinout_survey_question_item" name="checkinout_survey_question_item"/>');
					question_form.push('	<table class="type2">');
					question_form.push('		<colgroup>');
					question_form.push('	       <col width="130"/>');
					question_form.push('	       <col width="*"/>');
					question_form.push('       	</colgroup>');
					question_form.push('       	<tbody>');
					question_form.push('	        <tr>');
					question_form.push('	         	<th>문항 제목</th>');
					question_form.push('	         	<td><input name="checkinout_survey_question_title" type="text" class="text" value="${i.checkinout_survey_question_title}" style="width:100%"/></td>');
					question_form.push('	        </tr>');
					question_form.push('	        <tr>');
					question_form.push('	         	<th>문항 이미지</th>');
					question_form.push('	        	<td>');
					question_form.push('	        		<div style="margin-top:5px;">');
					question_form.push('	        			<c:if test="${not empty i.image_org_file_name}">');
					question_form.push('	        				<img src="/data/checkInOutSurvey/${i.homepage_id}/${i.server_file_name}" style="max-width: 400px;" alt="문항 이미지 입니다.">');
					question_form.push('	        				<a class="btn btn1 delete-image-btn">삭제</a><br/>');
					question_form.push('	        			</c:if>');
					question_form.push('	        			<input type="file" id="checkinout_survey_file" name="checkinout_survey_file" class="text" accept=".gif,.jpeg,.jpg,.png">');
					question_form.push('	        			<button id="cancelImage">등록취소</button>');
					question_form.push('	        			<div class="ui-state-highlight">');
					question_form.push('	        			<em>* 파일 확장자가  gif, jpeg, jpg, png 인 경우에만 업로드 가능합니다. <br/> * 기타 파일(pdf, hwp 등)을 등록하실 경우 정상적으로 나타나지 않습니다. </em>');
					question_form.push('	        			</div>');
					question_form.push('	        			<input type="hidden" name="origin_file_name"/>');
					question_form.push('	        		</div>');
					question_form.push('	        	</td>');
					question_form.push('	        </tr>');
					question_form.push('			<tr>');
					question_form.push('		     	<th>기능</th>');
					question_form.push('		     	<td cssStyle="width:100%">');
					question_form.push('					<a href="" class="btn question-delete" keyValue="' + control_key + '">삭제</a>');
					question_form.push('				</td>');
					question_form.push('		    </tr>');
					question_form.push('		</tbody>');
					question_form.push('	</table>');
					question_form.push('</form>');
					question_form.push('</div>');
					$('div#questionArea').append(question_form.join(''));
					initEvent();
				}
			},
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					var formCount = $('form.questionForm').length;
					var sendCount = 0;

					if ( doValidation() ) {
						$('form.questionForm').each(function(i, v) {
							var form = $(this);
							var formData = new FormData(form[0]);

							$.ajax({
								url: 'saveQuestion.do',
								type: 'POST',
								data: formData,
								async: false,
								cache: false,
								contentType: false,
								processData: false,
								dataType: 'json',
								success: function (data) {
									if (data.valid) {
										if (data.message != null && data.message.replace(/\s/g, '').length != 0) {
											sendCount += 1;
										}
									} else {
									}
								}
							});

						});	
					}

					if ( formCount == sendCount ) {
						reload();
					}
					else {
					}
					
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({
		width: 800,
		height: 700
	});

	$('div.questionLayer select').change(function() {
		var value = $(this).val();
		if ( value == 'TEXT' ) {
			$(this).parent().parent().parent().find('a.add-item').hide();
			$(this).parent().parent().parent().find('.question_items').children().hide();
		} else {
			$(this).parent().parent().parent().find('a.add-item').show();
			$(this).parent().parent().parent().find('.question_items').children().show();
		}
	}).trigger('change');

	function doValidation() {
		var isValid = true;
		
		if ( !isValid ) {
			return isValid;
		}
		
		$('input[name="checkinout_survey_question_title"]').each(function() {
			if ( $(this).val() == '' ) {
				isValid = false;
				$(this).focus();
				alert('문항 제목을 입력하세요.');
				return;
			} 
		});

		return isValid;
	}

	function initEvent() {
		$('a.question-delete').unbind('click').on('click', function(e) {
			e.preventDefault();

			var form = $('#'+$(this).attr('keyValue'));

			if ( form.find('input#editMode').val() == 'MODIFY' ) {
				form.find('input#editMode').val('DELETE');
				if ( doAjaxPost(form) ) {
					reload();
				}
			}
			else {
				form.parent().remove();
			}

		});

		$('a.add-item').unbind('click').on('click', function(e) {
			e.preventDefault();

			var form 		= $('#'+$(this).attr('keyValue'));
			var value 		= $(this).val();
			var htmlStr 	= [];
			var divTag = $('<div style="margin-top:5px;"></div>');
			divTag.append($(' <a href="" class="btn item-delete">보기삭제</a>').on('click', function(e) { $(this).parent().remove(); e.preventDefault();}));
			form.find('td.question_items').append(divTag);

		});

		$('a.item-delete').unbind('click').on('click', function(e) {
			e.preventDefault();

			$(this).parent().remove();
		});
	}

	function reload() {
		$('#dialog-2').load('editQuestion.do?homepage_id=${checkInOutSurveyQuestion.homepage_id}&checkinout_survey_idx=${checkInOutSurveyQuestion.checkinout_survey_idx}');
	}

	initEvent();
});

</script>

<form:form id="deleteFileForm" modelAttribute="checkInOutSurveyQuestion" action="deleteFile.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="checkinout_survey_question_idx"/>
</form:form>

<div id="questionArea">
	<c:choose>
		<c:when test="${fn:length(checkInOutSurveyQuestionList) > 0}">
			<c:forEach items="${checkInOutSurveyQuestionList}" var="i" varStatus="status">
				<div class="questionLayer" style="margin-bottom:10px;">
					<form:form id="question_${status.index}" class="questionForm" modelAttribute="checkInOutSurveyQuestion" method="post" action="saveQuestion.do" enctype="multipart/form-data">
						<form:hidden path="editMode" value="MODIFY"/>
						<form:hidden path="homepage_id" value="${i.homepage_id}"/>
						<form:hidden path="checkinout_survey_idx" value="${i.checkinout_survey_idx}"/>
						<form:hidden path="checkinout_survey_question_idx" value="${i.checkinout_survey_question_idx}"/>
						<form:hidden path="checkinout_survey_question_item"/>
						<table class="type2">
							<colgroup>
								<col width="130" />
								<col width="*"/>
							</colgroup>
							<tbody>
							<tr>
								<th>문항 제목</th>
								<td>
									<input name="checkinout_survey_question_title" type="text" class="text" value="${i.checkinout_survey_question_title}" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th>문항 이미지</th>
								<td class="imagePlanFile">
									<div style="margin-top:5px;">
										<c:if test="${not empty i.origin_file_name}">
											<img src="/data/checkInOutSurvey/${i.homepage_id}/${i.server_file_name}" style="max-width: 400px;" alt="문항 이미지 입니다.">
											<a class="btn btn1 delete-image-btn">삭제</a>
											<br/>
										</c:if>
										<input type="file" id="checkinout_survey_file" name="checkinout_survey_file" class="text" accept=".gif,.jpeg,.jpg,.png">
										<button id="cancelImage">등록취소</button>
										<div class="ui-state-highlight">
											<em>* 파일 확장자가  gif, jpeg, jpg, png 인 경우에만 업로드 가능합니다. <br/> * 기타 파일(pdf, hwp 등)을 등록하실 경우 정상적으로 나타나지 않습니다. </em>
										</div>
										<form:hidden path="origin_file_name"/>
									</div>
								</td>
							</tr>
							<tr>
								<th>기능</th>
								<td>
									<a href="" class="btn question-delete" keyValue="question_${status.index}">삭제</a>
								</td>
							</tr>
							</tbody>
						</table>
					</form:form>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<h3 style="color:#666;" id="comment"><b>등록된 설문조사가 없습니다.</b></h3>
		</c:otherwise>
	</c:choose>
</div>