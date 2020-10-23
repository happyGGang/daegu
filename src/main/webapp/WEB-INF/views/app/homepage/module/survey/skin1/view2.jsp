<%-- <%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script>
$(document).ready(function() {
// 	var href = location.href.replace('view2.do', 'view3.do');
// 	location.href=href;
window.close();
});
</script>
</head>
<div class="brdTop_02">
	<div class="survey_info_wrap">
		<div class="survey_info">
			<h1>${survey.survey_title}</h1>
			<div class="description">
			${survey.survey_content}
			</div>
		</div>
	</div>
</div>
<c:set var="questIdx" value="0" />
<div class="surveyList">
	<table class="list">
		<colgroup>
			<col width="46" />
			<col  />
		</colgroup>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${questList}">
		<c:choose>

		<c:when test="${i.quest_type eq 'ONE'}">
			<tr>
				<td></td>
			</tr>
			<tr>
				<td class="qustionNum"><span>Q${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
					<ul class="mysurvey_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<label for="questIdx_${questIdx}_${status2.count}">${status2.count}) ${j.quest_detail_title}</label>
							<c:if test="${j.branch_idx > 0}">
								<c:set var="branch_idx" value="${j.branch_idx}"></c:set>
								<c:forEach var="k" varStatus="kStatus" items="${questList}">
									<c:if test="${j.branch_idx eq k.quest_idx}">
										<c:set var="branch_idx" value="${kStatus.count}"></c:set>
									</c:if>
								</c:forEach>
							(${j.branch_idx}번으로 이동)
							</c:if>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>${j.branch_idx}
							<label for="questIdx_${questIdx}_99">${fn:length(i.quest_detail_list)+1}) 기타</label>
						</li>
					</c:if>
					</ul>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MULTI'}">
			<tr>
				<td></td>
			</tr>
			<tr>
				<td class="qustionNum"><span>Q${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content}(복수선택)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
					<ul class="mysurvey_list">
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							<label for="questIdx_${questIdx}_${status2.count}">${status2.count}) ${j.quest_detail_title}</label>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>
							<label for="questIdx_${questIdx}_99">${fn:length(i.quest_detail_list)+1}) 기타</label>
						</li>
					</c:if>
					</ul>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		<c:when test="${i.quest_type eq 'MATRIX'}">
			<tr>
				<td></td>
			</tr>
			<tr>
				<td class="qustionNum"><span>Q${questIdx+1}</span></td>
				<td class="qustion">${i.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL" questIdx="${i.quest_idx}">
					<table class="in_tbl" summary="매트릭스형의 세부질문과 보기 내용을 확인할 수 있습니다.">
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
								<td style="text-align: center;">○</td>
							</c:forEach>
							</tr>
							</c:forEach>
						</tbody>
					</table> 
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}"/>
		</c:when>
		
		<c:when test="${i.quest_type eq 'DESCRIPTION'}">
		<tr>
				<td></td>
			</tr>
		<tr>
			<td class="qustionNum"><span>Q${questIdx+1}</span></td>
			<c:set value="필수" var="required"></c:set>
			<c:if test="${i.required_yn eq 'N'}"><c:set value="선택" var="required"></c:set></c:if>
			<td class="qustion">${i.quest_content} (${required})</td>
		</tr>
		<tr>
			<td></td>
			<td class="aL" questIdx="${i.quest_idx}">
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
				<td class="qustion"><img src="${getContextPath}${i.quest_content}" style="max-width: 730px;" alt="noImage"/></td>
			</tr>
		</c:when>
		</c:choose>
		</c:forEach>

		</tbody>
	</table>
</div>
<!--// 버튼 -->
<%
response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=survey.xls");
%>
