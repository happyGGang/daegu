<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="questIdx" value="0" />
<script>
$(function() {
	$('#dialog-3').dialog({ //모달창 기본 스크립트 선언
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
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 820,
		height: 800
	});
	
	$('div.QType > a, div.AType > a').on('click', function(e) {
		e.preventDefault();
		var quest_type = $(this).attr('keyValue');
		
		$('#dialog-4').load('/cms/survey/quest/edit.do?quest_type=' + quest_type + '&survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
	});
	
	$('a.questModify').on('click', function(e) {
		e.preventDefault();
		
		var quest_idx = $(this).attr('keyValue');
		$('#dialog-4').load('/cms/survey/quest/edit.do?editMode=modify&survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&quest_idx=' + quest_idx, function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
	});
	
	$('a.questDelete').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제 하시겠습니까?')) {
			var quest_idx = $(this).attr('keyValue');
			
			$('#dialog-3').load('/cms/survey/quest/delete.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&quest_idx='+quest_idx, function(e) {
				alert('삭제 되었습니다.');
			});
		}
	});
	
	$('td.move > span > a').on('click', function(e) {
		e.preventDefault();
		
		var quest_idx = $(this).attr('keyValue');
		var quest_idx_fr = $(this).attr('quest_idx_fr');
		
		$('#dialog-3').load('/cms/survey/quest/modifyOrder.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}&quest_idx='+quest_idx+'&quest_idx_fr='+quest_idx_fr, function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		
		
	});
});
</script>
<div class="guide">
	<ul class="list">
		<li><em>[문항작성]</em>에서 문항유형을 선택하면, 해당 설문항을 작성할 수 있습니다.</li>
		<li>문항의 순서를 조정하려면, 순서의 <em>[화살표]</em>를 이용하십시오.</li>
	</ul>
	<div class="inBox">
		<span class="tit"><img src="/resources/cms/survey/img/tit_01.gif" alt="문항작성"></span>
		<div class="list QType">
			<a href="#" class="btn btn1" keyValue="ONE">단일선택형</a>
			<a href="#" class="btn btn1" keyValue="MULTI">복수선택형</a>
			<a href="#" class="btn btn1" keyValue="MATRIX">매트릭스형</a>
			<a href="#" class="btn btn1" keyValue="DESCRIPTION">서술형</a>
		</div>
		<span class="tit under clrB"><img src="/resources/cms/survey/img/tit_02.gif" alt="부가기능"></span>
		<div class="list AType">
			<a href="#" class="btn btn2" keyValue="COMMENT">주석문</a>
			<a href="#" class="btn btn2" keyValue="IMAGE">이미지</a>
		</div>
	</div>
</div>
<p class="hspace10"></p>

<form:form modelAttribute="quest" action="save.do" method="POST" onsubmit="return false;">
<div class="boardList mysurvey">
	<table class="list" summary="설문항 내용 기입 및 순서 조절과 수정, 삭제를 할 수 있습니다.">
		<caption>설문항 작성 목록</caption>
		<colgroup>
			<col width="50" />
			<col width="*" />
			<col width="50" />
			<col width="60" />
			<col width="60" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>문항내용</th>
				<th>순서</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${questList}">
		<c:choose>
		<c:when test="${i.quest_type eq 'ONE'}">
			<tr>
				<th>${questIdx + 1}</th>
				<td class="aL">
					<p class="current_type">${fn:replace(i.quest_content, crlf, '<br/>')}</p>
					<ul class="answer_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<form:radiobutton id="questIdx_${questIdx}_${status2.count}" path="answer_list[${questIdx}].quest_idx_list" value="${status2.count}" />
							<label for="questIdx_${questIdx}_${status2.count}">${j.quest_detail_title}
								<c:if test="${j.quest_content ne null}"> (<tag:cutStr cutNum="40" inStr="${j.quest_order - j.cnt}" />번 문항으로 이동)</c:if>
							</label>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>
							<form:radiobutton id="questIdx_${questIdx}_99" path="answer_list[${questIdx}].quest_idx_list" value="99" />
							<label for="questIdx_${questIdx}_99">기타</label>
							<form:input path="answer_list[${questIdx}].short_answer" size="25" maxlength="20"/>
						</li>
					</c:if>
					</ul>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		<c:set var="questIdx" value="${questIdx + 1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'MULTI'}">
			<tr>
				<th>${questIdx + 1}</th>
				<td class="aL">
					<p class="current_type">${i.quest_content}</p>
					<ul class="answer_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<form:checkbox id="questIdx_${questIdx}_${status2.count}" path="answer_list[${questIdx}].quest_idx_list" value="${status.count}" />
							<label for="questIdx_${questIdx}_${status2.count}">${j.quest_detail_title}
								<c:if test="${j.quest_content ne null}"> (<tag:cutStr cutNum="40" inStr="${j.quest_order - j.cnt}" />번 문항으로 이동)</c:if>
							</label>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>
							<form:checkbox id="questIdx_${questIdx}_99" path="answer_list[${questIdx}].quest_idx_list" value="99" />
							<label for="questIdx_${questIdx}_99">기타</label>
							<form:input path="answer_list[${questIdx}].short_answer" size="25" maxlength="20"/>
						</li>
					</c:if>
					</ul>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		<c:set var="questIdx" value="${questIdx + 1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'MATRIX'}">
			<tr>
				<th>${questIdx + 1}</th>
				<td class="aL">
					<p class="current_type">${i.quest_content}</p>
					<table class="in_tbl" summary="매트릭스형의 세부질문과 보기 내용을 확인할 수 있습니다.">
						<caption>매트릭스형 세부질문 및 보기</caption>
						<colgroup>
							<col width="30" />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">세부질문</th>
								<c:forEach var="j" varStatus="status_j" items="${i.quest_detail_list}">
								<th>${j.quest_detail_title}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="j" varStatus="status_j" items="${i.quest_matrix_list}">
							<tr>
								<td>${status_j.count})</td>
								<td>${j.matrix_title}</td>
							<c:forEach var="k" varStatus="status_k" begin="1" end="${fn:length(i.quest_detail_list)}">
								<td><form:radiobutton id="questIdx_${questIdx}_${status_j.count}_${status_k.count}" path="answer_list[${questIdx}].quest_idx_list[${status_j.count}]" value="${status_k.count}" /></td>
							</c:forEach>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		<c:set var="questIdx" value="${questIdx + 1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'DESCRIPTION'}">
			<tr>
				<th>${questIdx + 1}</th>
				<td class="aL">
					<c:set value="필수" var="required"></c:set>
					<c:if test="${i.required_yn eq 'N'}"><c:set value="선택" var="required"></c:set></c:if>
					<p class="current_type">${i.quest_content} (${required})</p>
					<form:input path="answer_list[${questIdx}].short_answer" size="65" />
					<p class="hspace10"></p>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>				
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		<c:set var="questIdx" value="${questIdx + 1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'COMMENT'}">
			<tr>
				<th>주석</th>
				<td class="aL">
					<p class="current_type">${i.quest_content}</p>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		</c:when>
		<c:when test="${i.quest_type eq 'IMAGE'}">
			<tr>
				<th>이미지</th>
				<td class="aL">
					<img src="${i.quest_content}" style="max-width: 470px;" alt="이미지 입니다."/>
				</td>
				<td class="move">
					<c:if test="${!status.first}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index-1].quest_idx}"><img src="/resources/cms/survey/img/btn_up.gif" alt="위로 이동" /></a></span>
					</c:if>
					<c:if test="${!status.last}">
					<span><a href="#" keyValue="${i.quest_idx}" quest_idx_fr="${questList[status.index+1].quest_idx}"><img src="/resources/cms/survey/img/btn_down.gif" alt="아래로 이동" /></a></span>
					</c:if>
				</td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questModify"><img src="/resources/cms/survey/img/btn_edit.gif" alt="수정" /></a></td>
				<td><a href="#" keyValue="${i.quest_idx}" class="questDelete"><img src="/resources/cms/survey/img/btn_del.gif" alt="삭제" /></a></td>
			</tr>
		</c:when>
		</c:choose>
		</c:forEach>
		<c:if test="${fn:length(questList) < 1}">
			<tr>
				<td colspan="5" >문항을 등록하세요.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
</form:form>
<p class="hspace10"></p>

<div id="dialog-4" class="dialog-common" title="설문지 문항설정"></div>