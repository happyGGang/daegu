<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function () {
	
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 650
	});
	
	
	$('div.brdBtn > edit').on('click', function(e) {
		e.preventDefault();
		window.open('/cms/survey/quest/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}');
	});
		
	<%-- 설문기본 목록 --%>
	$('div.brdBtn > a.list').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		var formData = serializeParameter(['survey_idx', 'viewPage', 'homepage_id']);
		doGetLoad(url, formData);
		
	});
		
	<%-- 설문지 수정 팝업 --%>
	$('#btn_edit').on('click', function(e) {
		$('#dialog-3').load('/cms/survey/quest/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
			if (response.indexOf('응답자가 있는 경우 수정하실 수 없습니다.') >= 0 ) {
			}
			else {
				$('#dialog-3').dialog('open');	
			}
			
			
		});
		e.preventDefault();
	});
	
	<%-- 설문지 보기 팝업 --%>
	$('#btn_view').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'Y') {
			window.open("/${homepage.context_path}/module/survey/view.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue'), "설문지보기", "toolbar=no, menubar=no, scrollbars=yes");  
		} else {
			//window.open('/${homepage.context_path}/module/survey/view.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn='+$(this).attr('keyValue'), 'survey_quest');
			window.open("/${homepage.context_path}/module/survey/view.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue'), "설문지보기", "toolbar=no, menubar=no, scrollbars=yes");
		}
	});
	
	<%-- 설문지통계 팝업 --%>
	$('#btn_analysis').on('click', function(e) {
		
// 		$('#dialog-6').load('/cms/survey/surveyStatistics/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
// 			$('#dialog-6').dialog('open');
// 		});
		e.preventDefault();
		window.open('/cms/survey/surveyStatistics/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', 'survey_quest', 'width=820, height=800, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
	
	$('#excelDownLoad').on('click', function(e) {
		e.preventDefault();
		$('#surveyView').attr('action','/cms/survey/surveyStatistics/excelDownload.do').submit();
		$('#surveyView').attr('action','save.do');
	});
	
	$('#csvDownLoad').on('click', function(e) {
		e.preventDefault();
		$('#surveyView').attr('action','/cms/survey/surveyStatistics/csvDownload.do').submit();
		$('#surveyView').attr('action','save.do');
	});
	
	<%-- 응답자 현황 --%>
	$('#btn_check').on('click', function(e) {
		$('#dialog-5').load('/cms/survey/surveyStatistics/answerUser.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
			$('#dialog-5').dialog('open');
		});
		e.preventDefault();
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
			$('form#surveyView').attr('action', 'changeOpen.do');
			doAjaxPost($('form#surveyView'));
		}
	});
	
	<%--공개여부 변경--%>
	$('#btn_private').on('click', function(e) {
		e.preventDefault();
		if (confirm('공개여부를 변경하시겠습니까?')) {
			$('form#surveyView').attr('action', 'changePrivateOpen.do');				
			doAjaxPost($('form#surveyView'));
		}
	});
	
	$('a#offline').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'Y') {
// 			window.open("/${homepage.context_path}/module/survey/view2.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue'), "설문지보기", "width=820, height=800, toolbar=no, menubar=no, scrollbars=yes");
			location.href = "/${homepage.context_path}/module/survey/view2.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue');
		} else {
			//window.open('/${homepage.context_path}/module/survey/view.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn='+$(this).attr('keyValue'), 'survey_quest');
// 			window.open("/${homepage.context_path}/module/survey/view2.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue'), "설문지보기", "width=820, height=800, toolbar=no, menubar=no, scrollbars=yes");
			location.href = "/${homepage.context_path}/module/survey/view2.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&popup_yn="+$(this).attr('keyValue');
		}
// 		$('#surveyView').attr('action','/cms/module/survey/offLineExcelDownload.do').submit();
// 		$('#surveyView').attr('action','save.do');
	});
	
	$('a#offline-upload').on('click', function(e) {
		e.preventDefault();
		if ( $('#homepage_id').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
			return false;
		}
		
		$('#dialog-upload').load('uploadForm.do?homepage_id=' + $('#surveyView #homepage_id').val() + '&survey_idx=' + $('#surveyView #survey_idx').val(), function( response, status, xhr ) {
			$('#dialog-upload').dialog('open');
		});
	});
	
	<%-- 당첨자 추첨 --%>
	$('#btn_pick').on('click', function(e) {
		e.preventDefault();
		
		if('${selectedUsersCnt > 0}' == 'true') {
			alert('이미 당첨자 등록이 된 상태입니다. 당첨자를 변경할 수 없습니다.');
		} else {
			if ('${param.homepage_id}' == 'h30') {
				if(confirm('당첨자 추첨을 시작합니다.\n 추첨 횟수가 증가하며 무작위 순서로 응답자 목록이 나옵니다.\n계속 하시겠습니까?')) {
					var number = $('.number').val();
					
					if ('#randomCount' < 'number') {
					$('#dialog-7').load('/cms/survey/surveyStatistics/shuffleAnswers.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&randomCount=' + $('#randomCount').val(), function( response, status, xhr ) {
						$('#dialog-7').dialog('open');
						});
					}
					else {
						alert('응답자가 당첨인원보다 적습니다.');	
						return false;
					}
				}
			}else {
				if(confirm('당첨자 추첨을 시작합니다.\n 추첨 횟수가 증가하며 무작위 순서로 응답자 목록이 나옵니다.\n계속 하시겠습니까?')) {
						$('#dialog-7').load('/cms/survey/surveyStatistics/shuffleAnswers.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
							$('#dialog-7').dialog('open');
					});
				}
			}
		}
		
	});
});
</script>
<style>
	.type1 tbody tr th {width:15% !important;}
</style>

<form:form modelAttribute="survey" id="surveyView" action="save.do" method="POST" target="sbm">
<form:hidden path="homepage_id"/>
<form:hidden path="survey_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="viewPage"/>
<form:hidden path="survey_open_yn"/>
<form:hidden path="survey_private_yn"/>
</form:form>

<iframe name="sbm" style="display: none;"></iframe>

<div class="guide">
	<ul class="list">
		<li><em>도서관 활동</em>에 필요한 설문조사를 도와주는 온라인 설문조사 시스템입니다.</li>
		<li>편리하게 설문조사를 할 수 있도록 <em>설문항 작성, 실시간 모니터링</em> 기능 등을 제공합니다.</li>
	</ul>
	<table class="type1" style="width:100%;">
		<colgroup>
			<col width="120" />
			<col width="285" />
			<col width="120" />
			<col width="285" />
		</colgroup>
		<tbody>
			<tr>
				<th>조사자</th>
				<td colspan="3">${survey.add_user_name}</td>
			</tr>
			<tr>
				<th>조사명</th>   
				<td colspan="3">${survey.survey_title}</td>
			</tr>
			<tr>
				<th>조사소개</th>
				<td colspan="3" style="white-space: normal;">${survey.survey_content}</td>
			</tr>		
			<tr>
				<th>설문기간</th>
				<td colspan="3">${survey.survey_start_date} ~ ${survey.survey_end_date}</td>
			</tr>
			<tr>
				<th>설문조사</br> 공개여부</th>
				<td>
					${survey.survey_private_yn }
				</td>
				<th>추첨 횟수</th>
				<td>
					${survey.select_cnt}
				</td>
			</tr>
			<tr>
				<th>설문조사개방</th>
				<td>
					${survey.survey_open_yn}
				</td>
				<th>익명여부</th>
				<td>
					${survey.name_yn}
				</td>
			</tr>
			<tr>
				<th>공개여부</th>
				<td>
					${survey.open_yn}
				</td>
				<th>팝업유무</th>
				<td>
					${survey.popup_yn}
				</td>
			</tr>
			<tr>
				<th>인사말</th>
				<td colspan="3" style="white-space: normal;">${survey.greetings}</td>
			</tr>
		</tbody>
	</table>
	<div class="infodesk">
		<strong>설문조사 관리</strong>		
	</div>
	<table class="type2" summary="설문조사 관리메뉴입니다.">
		<colgroup>
			<col width="120px" />
			<col width="275px" />
			<col width="120px" />
			<col width="275px" />
		</colgroup>
		<tbody>
			<tr>
				<th>공개여부</th>
				<td>					
					<c:if test="${survey.survey_private_yn eq 'N' }">
						<a href="" class="btn btn7" id="btn_private"><span>비공개</span></a>
					</c:if>								
					<c:if test="${survey.survey_private_yn eq 'Y' }">
						<a href="" class="btn btn7" id="btn_private"><span>공개</span></a>
					</c:if>
				</td>
				<th>오프라인</th>
				<td>					
					<a href="#" id="offline" class="btn btn6" >오프라인 설문지 다운로드</a>
					<a href="#" id="offline-upload" class="btn btn6" >엑셀 업로드</a>
				</td>
			</tr>
			<tr>
				<th>설문지</th>
				<td>
					<a href="" class="btn btn1" id="btn_view" keyValue="${survey.popup_yn }"><span>설문지 보기</span></a>
					<a href="" class="btn btn2" id="btn_edit"><span>설문지 수정</span></a>
				</td>
				<th>결과분석</th>
				<td>									
					<a href="" class="btn btn3" id="btn_analysis"><span>통계분석하기</span></a><br>
					<a href="" class="btn btn6" id="excelDownLoad">엑셀저장</a>
					<a href="" class="btn btn6" id="csvDownLoad">CSV저장</a>
				</td>
			</tr>
			<tr>
				<th>조사여부</th>
				<td>
					<c:if test="${survey.survey_open_yn eq 'N' }">
						<a href="" class="btn btn4" id="btn_change"><span>조사완료</span></a>
					</c:if>								
					<c:if test="${survey.survey_open_yn eq 'Y' }">
						<a href="" class="btn btn4" id="btn_change"><span>미완료</span></a>
					</c:if>
				</td>
				<th>응답자 현황</th>
				<td colspan="4">
					<span class="number" style="width: 30px">${survey.answer_count}명</span>				
					<a href="" class="btn btn5" id="btn_check"><span>응답자 확인</span></a><br>
					<c:if test="${survey.homepage_id eq 'h30' }">
						<input id="randomCount" style="width:30px;" numberonly="true"/>
					</c:if>
					<a href="" class="btn btn4" id="btn_pick"><span>당첨자 추첨</span></a>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div id="dialog-3" class="dialog-common" title="설문항 작성"></div>
<div id="dialog-5" class="dialog-common" title="응답자 확인"></div>
<div id="dialog-7" class="dialog-common" title="당첨자 추천"></div>
<div id="dialog-upload" class="dialog-common" title="엑셀파일 업로드"></div>