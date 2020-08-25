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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "개인정보 삭제",
				"class": 'btn btn5',
				click: function() {
					if(confirm('개인정보(등록ID, 신청자명, 반, 전화번호)를 삭제합니다.\n삭제된 데이터는 복구가 불가능합니다.\n\n계속 하시겠습니까?')) {
						if(doAjaxPost($('#deletePersonalDataForm'))) {
							$('#dialog-3').load('reqList.do?homepage_id=${quiz.homepage_id}&quiz_idx=${quiz.quiz_idx}', function( response, status, xhr ) {
								$('#dialog-3').dialog('open');
							});
						}
					}
				}
			},{
				text: "당첨자 추첨",
				"class": 'btn btn3',
				click: function() {
					<c:choose>
					<c:when test="${quiz.select_cnt eq 0}">
					if(confirm('당첨자 추첨을 시작합니다.\n\n무작위 순서로 정답자 중에서 당첨자가 선정되고 한번 선정되면 되돌릴 수 없습니다. 또한 해당 퀴즈의 문항 정보(보기 및 정답)를 수정할 수 없게 됩니다.\n\n계속 하시겠습니까?')) {
						var winnerCount = parseInt('${winnerCount}');
						
						if(winnerCount == 0) {
							alert('정답자가 없습니다. 추첨을 중단합니다.');
							return;
						}
						
						var max = parseInt(prompt('추첨할 당첨자 인원을 입력해주세요. (정답자 인원: ${winnerCount}명)')) || -1;
						
						if(max == -1) {
							alert('숫자(양의 정수)를 입력해주세요.');
							return;
						} else if(max == 0 || max > winnerCount) {
							alert('1 ~ ' + winnerCount + ' 내 숫자를 입력해주세요.');
							return;
						}
						
						$('#shuffleForm_max').val(max);
						
						if(doAjaxPost($('#shuffleForm'))) {
							$('#dialog-3').load('reqList.do?homepage_id=${quiz.homepage_id}&quiz_idx=${quiz.quiz_idx}', function( response, status, xhr ) {
								$('#dialog-3').dialog('open');
							});
						}
					}
					</c:when>
					<c:otherwise>
					alert('이미 당첨자 추첨이 완료됐습니다. 당첨자를 변경할 수 없습니다.');
					</c:otherwise>
					</c:choose>
				}
			},{
				text: "엑셀저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(quizReqList)}' > 0) {
						$('#winnerForm input#rowCount').val('1000');
						$('#winnerForm').attr('action', '/cms/module/quizReq/excelDownload.do').submit();
						$('#winnerForm').attr('action', 'saveWinner.do');	
					} else {
						alert('해당 내역이 없습니다.');	
					}
				}
			},{
				text: "CSV저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(quizReqList)}' > 0) {
						$('#winnerForm input#rowCount').val('1000');
						$('#winnerForm').attr('action', '/cms/module/quizReq/csvDownload.do').submit();
						$('#winnerForm').attr('action', 'saveWinner.do');	
					} else {
						alert('해당 내역이 없습니다.');
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
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1300,
		height: 700
	});
	
	$('select[name="winner_yn"]').change(function() {
		$('#winnerForm input#quiz_req_idx').val($(this).attr('keyValue'));
		$('#winnerForm input#winner_yn').val($(this).val());
		doAjaxPost($('#winnerForm'));
	});
	
	$('div#cms_paging_ajax a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('form#quizForm').serialize();
		$('div#dialog-3').load('reqList.do?' + param);
		e.preventDefault();
	});
	
});

</script>
<form:form id="winnerForm" modelAttribute="quizReq" action="saveWinner.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="quiz_idx"/>
	<form:hidden path="quiz_req_idx"/>
	<form:hidden path="winner_yn"/>
	<form:hidden path="rowCount"/>
</form:form>

<form:form id="shuffleForm" modelAttribute="quizReq" action="shuffle.do">
	<form:hidden path="homepage_id" id="shuffleForm_homepage_id"/>
	<form:hidden path="quiz_idx" id="shuffleForm_quiz_idx"/>
	<form:hidden path="quiz_req_idx" id="shuffleForm_quiz_req_idx"/>
	<input type="hidden" name="max" id="shuffleForm_max" value="0">
</form:form>

<form:form id="deletePersonalDataForm" modelAttribute="quizReq" action="deletePersonalData.do">
	<form:hidden path="homepage_id" id="deletePersonalDataForm_homepage_id"/>
	<form:hidden path="quiz_idx" id="deletePersonalDataForm_quiz_idx"/>
</form:form>

<div>
<h3>
	${quiz.quiz_name}
	<c:choose>
	<c:when test="${quiz.select_cnt eq 0}">
	<small>(당첨자 추첨 미시행)</small>
	</c:when>
	<c:otherwise>
	<small>(당첨자 추첨 완료)</small>
	</c:otherwise>
	</c:choose>
</h3>
[ 정답 : 
	<c:forEach items="${quizQuestionList}" var="oneQuestion" varStatus="questionStatus">
		${questionStatus.count} - ${oneQuestion.quiz_question_answer} <c:if test="${!questionStatus.last}">/</c:if>
	</c:forEach>
	]
</div>
<br/>
<form:form id="quizForm" modelAttribute="quizReq" action="reqList.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="quiz_idx"/>	
	<form:hidden id="viewPage_ajax" path="viewPage"/>		
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="135" />
			<col width="80" />
			<col width="" />
			<col width="100" />
			<col width="50" />
			<col width="50" />
			<col width="50" />
			<col width="50" />
			<col width="100" />
			<col width="200" />
			<col width="130" />
			<col width="100" />
			<col width="100" />
			<c:if test="${quiz.select_cnt > 0}">
			<col width="100" />
			</c:if>
		</colgroup>
       	<thead>
       		<tr>
       			<th>번호</th>
       			<th>등록ID</th>
       			<th>신청자명</th>
       			<th>제출답안</th>
       			<th>학교</th>
       			<th>학년</th>
       			<th>반</th>
       			<th>성별</th>
       			<th>연령대</th>
       			<th>전화번호</th>
       			<th>응모일시</th>
       			<th>정답자여부</th>
       			<c:if test="${quiz.select_cnt > 0}">
       			<th>당첨자 여부</th>
       			</c:if>
       		</tr>
       	</thead>
       	<tbody>
       		<c:choose>
       			<c:when test="${fn:length(quizReqList) > 0}">
       				<c:forEach items="${quizReqList}" var="i">
			       		<tr>
				         	<td>${i.quiz_req_idx}</td>
				         	<td>${i.add_id}</td>
				         	<td>${i.name}</td>
				         	<td class="left">
								<c:forTokens items="${i.quiz_answer}" delims="|" var="oneAnswer" varStatus="status">
				         			<span <c:if test="${fn:replace(fn:trim(quizQuestionList[status.index].quiz_question_answer), ' ', '') eq fn:replace(fn:trim(oneAnswer), ' ', '')}">style="background:#0f0"</c:if>>${status.count}번 답: ${oneAnswer}</span><br/>
				         		</c:forTokens>
			         		</td>
			         		<td>${i.school}</td>
				         	<td>${i.hak}</td>
				         	<td>${i.ban}</td>
				         	<td>
			         		<c:choose>
				         		<c:when test="${i.gender eq '0'}">남</c:when>
				         		<c:when test="${i.gender eq '1'}">여</c:when>
			         		</c:choose>
				         	</td>
				         	<td>
			         		<c:choose>
				         		<c:when test="${i.age eq '20'}">성인</c:when>
				         		<c:when test="${i.age eq '14'}">청소년</c:when>
			         		</c:choose>
				         	</td>
				         	<td>${i.phone}</td>
				         	<td>${i.add_date}</td>
				         	<td>
				         		${i.winner_yn}
<%--
				         		<select class="selectmenu" name="winner_yn" keyValue="${i.quiz_req_idx}">
				         			<option <c:if test="${winnerYn eq 'N'}">selected="selected"</c:if> value="N">N</option>
				         			<option <c:if test="${winnerYn eq 'Y'}">selected="selected"</c:if> value="Y">Y</option>
				         		</select>
--%>
							</td>
							<c:if test="${quiz.select_cnt > 0}">
				         	<td>${i.chosen_yn}</td>
				         	</c:if>
				        </tr>
		       		</c:forEach>
       			</c:when>
       			<c:otherwise>
       				<tr>
       					<td colspan="10">조회된 데이터가 없습니다.</td>
       				</tr>
       			</c:otherwise>
       		</c:choose>
		</tbody>
	</table>
	
	<div id="cms_paging_ajax" class="dataTables_paginate">
	<c:if test="${paging.firstPageNum > 0}">
		<a href="#" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
	</c:if>
	<c:if test="${paging.prevPageNum > 0}">
		<a href="#" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
	</c:if>	
		<span>
	<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
	<c:choose>
	<c:when test="${i eq paging.viewPage}">	
		<a href="#" class="paginate_button current" keyValue="${i}">${i}</a>
	</c:when>
	<c:otherwise>
		<a href="#" class="paginate_button" keyValue="${i}">${i}</a>
	</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${paging.nextPageNum > 0}">
		<a href="#" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
	</c:if>
	<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
		<a href="#" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
	</c:if>
		</span>
	</div>
</form:form>
