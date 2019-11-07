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
					if('${quiz.select_cnt > 0}' == 'true') {
						alert('당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.');
						return;
					}
					
					$('#comment').remove();
					var control_key		= "question_" + $('div.questionLayer').length;
					var homepage_id 	= '${quizQuestion.homepage_id}';
					var quiz_idx 		= '${quizQuestion.quiz_idx}';
					var question_form 	= [];
					question_form.push('<div class="questionLayer" style="margin-bottom:10px;">');
					question_form.push('<form id="' + control_key + '" name="quizQuestion" class="questionForm" method="post" action="saveQuestion.do" >');
					question_form.push('	<input type="hidden" name="_csrf" value="${_csrf.token}">');
					question_form.push('	<input type="hidden" id="editMode" name="editMode" value="ADD"/>');
					question_form.push('	<input type="hidden" id="homepage_id" name="homepage_id" value="' + homepage_id + '"/>');
					question_form.push('	<input type="hidden" id="quiz_idx" name="quiz_idx" value="' + quiz_idx + '"/>');
					question_form.push('	<input type="hidden" id="quiz_question_idx" name="quiz_question_idx" value="0"/>');
					question_form.push('    <input type="hidden" id="quiz_question_item" name="quiz_question_item"/>');
					question_form.push('	<table class="type2">');
					question_form.push('		<colgroup>');
					question_form.push('	       <col width="130"/>');
					question_form.push('	       <col width="*"/>');
					question_form.push('       	</colgroup>');
					question_form.push('       	<tbody>');
					question_form.push('	        <tr>');
					question_form.push('	         	<th>문항구분</th>');
					question_form.push('	         	<td>');
					question_form.push('	         		<select name="quiz_question_type" class="selectmenu" keyValue="' + control_key + '">');
					question_form.push('	         			<option value="">선택</option>');
					question_form.push('	         			<option value="RADIO">한개선택</option>');
					question_form.push('	         			<option value="CHECK">다중선택</option>');
					question_form.push('	         			<option value="TEXT">주관식</option>');
					question_form.push('	         		</select>');
					question_form.push('	         	</td>');
					question_form.push('	        </tr>');
					question_form.push('	        <tr>');
					question_form.push('	         	<th>문항제목</th>');
					question_form.push('	         	<td><textarea name="quiz_question_title" class="text" style="width:100%" value="${i.quiz_question_title}"></textarea></td>');
					question_form.push('	        </tr>');
					question_form.push('	        <tr>');
					question_form.push('	         	<th>문항보기 <a class="btn btn1 add-item" keyValue="' + control_key + '">추가</a></th>');
					question_form.push('	         	<td class="question_items"></td>');
					question_form.push('	        </tr>');
					question_form.push('	        <tr>');
					question_form.push('	        	<th>정답</th>');
					question_form.push('	        	<td><input name="quiz_question_answer" class="text" />');
					question_form.push('	        		<div class="ui-state-highlight">');
					question_form.push('	        			<em>* 1개선택 : 보기의 답을 그대로 적어주세요<br/>* 다중선택 : 보기의답을 ','(콤마,쉼표)로 구분하여 적어주세요. ex) 수박,사과,오렌지<br/>* 주관식 : 주관식 답란을 공백을 포함하여 정확히 입력해주세요.</em>');
					question_form.push('	        		</div>');
					question_form.push('	        														  </td>');
					question_form.push('	      	</tr>');
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
				text: "일괄저장",
				"class": 'btn btn1',
				click: function() {
					if('${quiz.select_cnt > 0}' == 'true') {
						alert('당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.');
						return;
					}
					
					var formCount = $('form.questionForm').length;
					var sendCount = 0;
					
					if ( doValidation() ) {
						$('form.questionForm').each(function(i, v) {
							var form = $(this);
							var items = [];
							//보기 한줄로 합치기
							form.find('input[name="tmp_question_item"]').each(function(i, v) { items.push($(this).val());});
							form.find('input[name="quiz_question_item"]').val(items.join('<whale>'));
							
							if ( doAjaxPost(form) ) {
								sendCount += 1;
							}
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 700
	});
	
	$('div.questionLayer select').change(function() {
		var value = $(this).val();
		if ( value == 'TEXT' ) {
			$(this).parent().parent().parent().find('a.add-item').hide();
			$(this).parent().parent().parent().find('.question_items').children().hide();
		}
		else {
			$(this).parent().parent().parent().find('a.add-item').show();
			$(this).parent().parent().parent().find('.question_items').children().show();
		}
	}).trigger('change');
	
	function doValidation() {
		var isValid = true;
		$('select[name="quiz_question_type"]').each(function() {
			if ( $(this).val() == '' ) {
				isValid = false;
				$(this).focus();
				alert('문항 구분을 지정하세요.');
				return;
			} 
		});
		
		if ( !isValid ) {
			return isValid;
		}
		
		$('input[name="quiz_question_title"]').each(function() {
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
			if('${quiz.select_cnt > 0}' == 'true') {
				alert('당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.');
				return;
			}
			
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
			if('${quiz.select_cnt > 0}' == 'true') {
				alert('당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.');
				return;
			}
			
			var form 		= $('#'+$(this).attr('keyValue'));
			var value 		= $(this).val();
			var htmlStr 	= [];
			var divTag = $('<div style="margin-top:5px;"></div>');
			divTag.append('<input name="tmp_question_item" type="text" class="text"  style="width:70%"/> ');
			divTag.append($(' <a href="" class="btn item-delete">보기삭제</a>').on('click', function(e) { $(this).parent().remove(); e.preventDefault();}));
			form.find('td.question_items').append(divTag);
			
		});
		
		$('a.item-delete').unbind('click').on('click', function(e) {
			e.preventDefault();
			if('${quiz.select_cnt > 0}' == 'true') {
				alert('당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.');
				return;
			}
			
			$(this).parent().remove(); 
		});
	}
	
	function reload() {
		$('#dialog-2').load('editQuestion.do?homepage_id=${quizQuestion.homepage_id}&quiz_idx=${quizQuestion.quiz_idx}');
	}
	
	initEvent();
	
});

</script>

<div id="questionArea">
	<c:choose>
		<c:when test="${fn:length(quizQuestionList) > 0}">
			<c:forEach items="${quizQuestionList}" var="i" varStatus="status">
				<div class="questionLayer" style="margin-bottom:10px;">
					<form:form id="question_${status.index}" class="questionForm" modelAttribute="quizQuestion" method="post" action="saveQuestion.do" >
						<form:hidden path="editMode" value="MODIFY"/>
						<form:hidden path="homepage_id" value="${i.homepage_id}"/>
						<form:hidden path="quiz_idx" value="${i.quiz_idx}"/>
						<form:hidden path="quiz_question_idx" value="${i.quiz_question_idx}"/>
						<form:hidden path="quiz_question_item"/>
						<table class="type2">
							<colgroup>
						       <col width="130" />
						       <col width="*"/>
					       	</colgroup>
					       	<tbody>
					       		<tr>
						         	<th>문항 구분</th>
						         	<td>
						         		<select name="quiz_question_type" class="selectmenu" keyValue="question_${status.index}">
						         			<option value="RADIO" <c:if test="${i.quiz_question_type eq 'RADIO'}">selected="selected"</c:if>>한개선택</option>
						         			<option value="CHECK" <c:if test="${i.quiz_question_type eq 'CHECK'}">selected="selected"</c:if>>다중선택</option>
						         			<option value="TEXT" <c:if test="${i.quiz_question_type eq 'TEXT'}">selected="selected"</c:if>>주관식</option>
						         		</select>
						         	</td>
						        </tr>
						        <tr>
						         	<th>문항 제목</th>
						         	<td><textarea name="quiz_question_title" style="width:100%;" >${i.quiz_question_title}</textarea></td>
						        </tr>
						        <tr>
						         	<th>문항 보기 <a class="btn btn1 add-item" keyValue="question_${status.index}">추가</a></th>
						         	<td class="question_items">
						         		<c:forEach items="${fn:split(i.quiz_question_item,'<whale>')}" var="j" >
						         			<div style="margin-top:5px;">
						         				<input name="tmp_question_item" type="text" class="text" value="${j}" style="width:70%"/> <a href="" class="btn item-delete">보기삭제</a>
						         			</div>
						         		</c:forEach>
						         	</td>
						        </tr>
						        <tr>
						         	<th>정답</th>
						         	<td><input name="quiz_question_answer" class="text" value="${i.quiz_question_answer}"/>
						         		<div class="ui-state-highlight">
											<em>* 1개선택 : 보기의 답을 그대로 적어주세요<br/>* 다중선택 : 보기의답을 ','(콤마,쉼표)로 구분하여 적어주세요. 구분시 공백을 입력하시면 안됩니다. ex) 수박,사과,오렌지<br/>* 주관식 : 주관식 답란을 공백을 포함하여 정확히 입력해주세요.</em>
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
			<h3 style="color:#666;" id="comment"><b>등록된 퀴즈가 없습니다.</b></h3>
		</c:otherwise>
	</c:choose>
	
</div>