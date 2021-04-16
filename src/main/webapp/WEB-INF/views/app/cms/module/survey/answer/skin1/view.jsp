<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/resources/cms/survey/css/skin1.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function() {
	var $form = $('form#quest');
	
	<%--설문조사 완료--%>
	$('a.save').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($form);
	});
	
	$('input[type=checkbox], input[type=radio]').on('click', function() {
		var td = $(this).parents('td.aL');
		var branch = $(this).attr('branchIdx');
		
		$('td.aL[questIdx='+branch+'] input').prop('disabled', false);
		$('td.aL[questIdx='+branch+'] hidden').prop('disabled', false);
		
		
		$(td).find('input').each(function() {
			var checked = $(this).is(':checked');
			
			if(!checked) {
				var branchIdx = $(this).attr('branchIdx');
				
				if(branchIdx != branch) {
					$('td.aL[questIdx='+branchIdx+'] input[type=radio]').prop('checked', false);
					$('td.aL[questIdx='+branchIdx+'] input[type=text]').val('');
					$('td.aL[questIdx='+branchIdx+'] input').prop('disabled', true);
					$('td.aL[questIdx='+branchIdx+'] hidden').prop('disabled', true);
				}
			}
			
		});
	});
	
});

</script>

<c:set var="questIdx" value="0" />
<div class="brdTop_02">
	<div class="survey_info_wrap">
		<div class="survey_info">
			<h1>${survey.survey_title}</h1>
			<div class="description">
			${survey.survey_content}
			</div>
		</div>
<%-- 		<p class="contact"><span><strong>조사문의:</strong>  ${survey.add_user_name} ( ${survey.add_user_tel} )  </span></p> --%>
	</div>
</div>
<!--// 상단 -->

<form:form modelAttribute="quest" action="save.do" method="POST" onsubmit="return false;">
<form:hidden path="survey_idx"/>
<form:hidden path="matrix_count"/>
<form:hidden path="menu_idx"/>

<div class="surveyList">
	<table class="list" summary="설문조사 문항에 대한 답변을 작성할 수 있습니다.">
		<caption>설문조사 목록</caption>
		<colgroup>
			<col width="46" />
			<col width="" />
		</colgroup>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${questList}">
		<c:choose>

		<c:when test="${i.quest_type eq 'ONE'}">
			<tr>
				<td class="qustionNum"><span>Q${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
				<form:hidden path="answer_list[${questIdx}].quest_type" value="${i.quest_type}" disabled="${i.branch > 0 ? true : false}"/>
				<form:hidden path="answer_list[${questIdx}].quest_idx" value="${i.quest_idx}" disabled="${i.branch > 0 ? true : false}"/>
					<ul class="mysurvey_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<form:radiobutton id="questIdx_${questIdx}_${status2.count}" path="answer_list[${questIdx}].quest_idx_list" value="${status2.count}" branchIdx="${j.branch_idx}" disabled="${i.branch > 0 ? true : false}" />
							<label for="questIdx_${questIdx}_${status2.count}">${j.quest_detail_title}</label>
							<c:if test="${j.branch_idx > 0}">
							(${j.quest_order - j.cnt}번으로 이동)
							</c:if>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>${j.branch_idx}
							<form:radiobutton id="questIdx_${questIdx}_99" path="answer_list[${questIdx}].quest_idx_list" value="99" disabled="${i.branch > 0 ? true : false}"/>
							<label for="questIdx_${questIdx}_99">기타</label>
							<form:input path="answer_list[${questIdx}].short_answer" size="25" maxlength="20" disabled="${i.branch > 0 ? true : false}"/>
						</li>
					</c:if>
					<%-- <c:if test="${i.quest_detail_free_yn eq 'N'}">
						<form:hidden path="answer_list[${questIdx}].short_answer" size="25" maxlength="20" disabled="${i.branch > 0 ? true : false}"/>
					</c:if> --%>
					</ul>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MULTI'}">
			<tr>
				<td class="qustionNum"><span>Q${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
				<form:hidden path="answer_list[${questIdx}].quest_type" value="${i.quest_type}" disabled="${i.branch > 0 ? true : false}"/>
				<form:hidden path="answer_list[${questIdx}].quest_idx" value="${i.quest_idx}" disabled="${i.branch > 0 ? true : false}"/>
					<ul class="mysurvey_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<form:checkbox id="questIdx_${questIdx}_${status2.count}" path="answer_list[${questIdx}].quest_idx_list" value="${status2.count}" branchIdx="${j.branch_idx}" disabled="${i.branch > 0 ? true : false}" />
							<label for="questIdx_${questIdx}_${status2.count}">${j.quest_detail_title}</label>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>
							<form:checkbox id="questIdx_${questIdx}_99" path="answer_list[${questIdx}].quest_idx_list" value="99" disabled="${i.branch > 0 ? true : false}"/>
							<label for="questIdx_${questIdx}_99">기타</label>
							<form:input path="answer_list[${questIdx}].short_answer" size="25" maxlength="20" disabled="${i.branch > 0 ? true : false}"/>
						</li>
					</c:if>
					<%-- <c:if test="${i.quest_detail_free_yn eq 'N'}">
						<form:hidden path="answer_list[${questIdx}].short_answer" size="25" maxlength="20" disabled="${i.branch > 0 ? true : false}"/>
					</c:if> --%>
					</ul>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'MATRIX'}">
			<tr>
				<td class="qustionNum"><span>Q${questIdx+1}</span></td>
				<td class="qustion">${i.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
				<form:hidden path="answer_list[${questIdx}].quest_type" value="${i.quest_type}" disabled="${i.branch > 0 ? true : false}"/>
				<form:hidden path="answer_list[${questIdx}].quest_idx" value="${i.quest_idx}" disabled="${i.branch > 0 ? true : false}"/>
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
								<th scope="col" colspan="2">세부질문</th>
								<c:forEach var="j" varStatus="status_j" items="${i.quest_detail_list}">
								<th scope="col">${j.quest_detail_title}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="j" varStatus="status_j" items="${i.quest_matrix_list}">
							<tr>
								<td>${status_j.count})</td>
								<td class="aL">${j.matrix_title}</td>
							<c:forEach var="k" varStatus="status_k" begin="1" end="${fn:length(i.quest_detail_list)}">
								<td><form:radiobutton id="questIdx_${questIdx}_${status_j.count}_${status_k.count}" path="answer_list[${questIdx}].quest_idx_list[${status_j.index}]" value="${j.matrix_idx}-${status_k.count}"  disabled="${i.branch > 0 ? true : false}"/></td>
							</c:forEach>
							</tr>
							</c:forEach>
							<form:hidden path="answer_list[${questIdx}].short_answer" size="25" maxlength="20"  disabled="${i.branch > 0 ? true : false}"/>
						</tbody>
					</table> 
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}"/>
		</c:when>
		
		<c:when test="${i.quest_type eq 'DESCRIPTION'}">
		<tr>
			<td class="qustionNum"><span>Q${questIdx+1}</span></td>
			<c:set value="필수" var="required"></c:set>
			<c:if test="${i.required_yn eq 'N'}"><c:set value="선택" var="required"></c:set></c:if>
			<td class="qustion">${i.quest_content} (${required})</td>
		</tr>
		<tr>
			<td></td>
			<td class="aL" questIdx="${i.quest_idx}">
				<form:hidden path="answer_list[${questIdx}].required_yn" value="${i.required_yn}"/>
				<form:hidden path="answer_list[${questIdx}].quest_type" value="${i.quest_type}" disabled="${i.branch > 0 ? true : false}"/>
				<form:hidden path="answer_list[${questIdx}].quest_idx" value="${i.quest_idx}" disabled="${i.branch > 0 ? true : false}"/>
				<label for="answer_list[${questIdx}].short_answer" class="screen_out">서술형문항</label>
				<form:input path="answer_list[${questIdx}].short_answer" size="90" maxlength="100" style="width:80%" disabled="${i.branch > 0 ? true : false}"/>
			</td>
		</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'COMMENT'}">
			<tr>
				<td colspan="2" class="qustion" style="font-size: 18px; color: black; padding-bottom: 20px;">${i.quest_content}</td>
			</tr>
		</c:when>
		<c:when test="${i.quest_type eq 'IMAGE'}">
			<tr>
				<td><span>&nbsp;</span></td>
				<td class="qustion"><img src="${i.quest_content}" style="max-width: 730px;" alt="이미지 내용 입니다."/></td>
			</tr>
		</c:when>
		</c:choose>
		</c:forEach>

		</tbody>
	</table>
</div>
</form:form>

<!-- 버튼 -->
<div class="brdBtn">
	<a href="#" class="button save">설문조사 완료</a>
</div>
<!--// 버튼 -->