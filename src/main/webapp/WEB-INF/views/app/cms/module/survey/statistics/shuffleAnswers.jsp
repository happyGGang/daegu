<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(document).ready(function() {
	$('#dialog-7').dialog({ //모달창 기본 스크립트 선언
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
				text: "재추첨",
				"class": 'btn',
				click: function() {
					if(confirm('새로 추첨합니다. 추첨 횟수가 증가합니다. (현재: ${survey.select_cnt+1}회)\n계속 하시겠습니까?')) {
						$('#dialog-7').load('/cms/survey/surveyStatistics/shuffleAnswers.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}',
							function( response, status, xhr ) {
								$('#dialog-7').dialog('open');
						});
					}
				}
			},{
				text: "저장",
				"class": 'btn',
				click: function() {
					var count = $('tbody#shuffle_answers input[type=checkbox]:checked').length;

					if(Number(count) == 0) {
						alert('당첨자를 선택해주세요.');
						return;
					}
					
					if(confirm('선택한 ' + count + '명을 당첨자로 선정합니다. 한번 선정하면 취소할 수 없습니다.\n계속 하시겠습니까?')) {
						if ( doAjaxPost($('#select_form')) ) {
							$(this).dialog('destroy');
						}
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

	$("#dialog-7").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 820,
		height: 800
	});
	
	$('#checkAll').on('click', function() {
		$('tbody#shuffle_answers input:checkbox').prop('checked', $(this).prop('checked'));
		$('#check_cnt').text($('tbody#shuffle_answers input[type=checkbox]:checked').length);
	});
	
	$('tbody#shuffle_answers input[type=checkbox]').on('click', function(e) {
		$('#check_cnt').text($('tbody#shuffle_answers input[type=checkbox]:checked').length);
	});

});

</script>

<form:form id="select_form" modelAttribute="survey" action="/cms/survey/surveyStatistics/surveySave.do" method="POST">
<form:hidden path="homepage_id" id="homepage_id"/>
<form:hidden path="survey_idx"/>
<form:hidden path="editMode" value="SELECT"/>
<div class="guide">
	<div class="inBox">
		<div class="list QType">
			<h1>${survey.survey_title} <small>(${survey.select_cnt+1}회 추첨)</small></h1>
		</div>
		
	</div>
	<div class="infodesk">
		검색 결과 : 총 ${fn:length(answerUser)}건
	</div>
	<table class="type1 center">
		<tbody>
		<caption></caption>
		<colgroup>
			<col width="50" />
			<col />
			<col />
			<col />
			<col />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th><input id="checkAll" type="checkbox"><br/><span id="check_cnt">0</span>건</th>
				<th>순번</th>
				<th>성명</th>
				<th>회원구분</th>
				<th>아이피</th>
				<th>설문일시</th>
				<th>마지막 문항 응답</th>
			</tr>
		</thead>
		<tbody id="shuffle_answers">
			<c:forEach var="i" varStatus="status" items="${answerUser}">
			<tr>
				<td><input type="checkbox" id="check${status.index}" name="chosenAnswerList" value="${i.add_id}"/></td>
				<td>${status.count}</td>
				<td>${i.add_user_name}</td>
				<td>${i.add_user_div}</td>
				<td>${i.add_user_ip}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm"/> </td>
				<td>${i.last_short_answer}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table> 
</div>
</form:form>
