<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/chartist.min.css"/>
<link href="/resources/cms/survey/css/common.css" rel="stylesheet" type="text/css" title="style">
<link href="/resources/cms/survey/css/default.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resources/cms/survey/js/chartist.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/cms/survey/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/resources/cms/survey/js/common.js"></script>

<script>
$(document).ready(function() {
	
	$('a.close').on('click', function(e) {
		e.preventDefault();
		window.close();
	});
	$('a.print').on('click', function(e) {
		e.preventDefault();
		window.print();
	});
	
	$('a.viewDescription').on('click', function(e) {
		e.preventDefault();
		var param = 'survey_idx='+$(this).attr('surveyIdx');		
		param += '&quest_idx='+$(this).attr('questIdx'); 
		param += '&homepage_id=${param.homepage_id}'; 
		window.open('/${homepage.context_path}/module/survey/detail.do?'+param, 'survey_quest_description', 'width=820, height=700, status=no, menubar=no, toolbar=no. scrollbars=yes');
	});
	
	var data = {
	  series: [5, 3, 4]
	};

	var sum = function(a, b) { return a + b };

	new Chartist.Pie('.chart_one', data, {
	  labelInterpolationFnc: function(value) {
	    return Math.round(value / data.series.reduce(sum) * 100) + '%';
	  }
	});
	
});

</script>

<style>
	.brdTop_02{max-width:800px;margin:0 auto;height:275px;background:url('/resources/cms/survey/img/bg_top_01.jpg') #244d97 no-repeat 0 0;margin-bottom:10px;}
	.brdTop_02 h1{color:#000;font-weight:bold;font-size:23px;padding:20px 0 13px 30px;background:url('/resources/cms/survey/img/bullet.gif') left 16px no-repeat;}
</style>

<div class="brdTop_02">
	<div class="survey_info_wrap">
		<div class="survey_info">
			<h1>${survey.survey_title}</h1>
			<div class="description">
			${survey.survey_content}
			</div>
		</div>
<%-- 		<p class="contact"><span><strong>조사문의:</strong>  담당자 ( ${survey.add_user_tel} )  </span></p> --%>
	</div>
</div>

<div class="surveyList">
	<table class="list" summary="설문조사 문항에 대한 답변을 작성할 수 있습니다.">
		<caption>설문조사 목록</caption>
		<colgroup>
			<col width="46" />
			<col width="" />
		</colgroup>
		<tbody>
		
		<c:forEach var="i" varStatus="status" items="${statistics}">
		<c:choose>

		<c:when test="${i.quest_type eq 'ONE'}">
			<tr>
				<td class="qustionNum"><span>${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content} (응답자: ${i.quest_detail_list[0].total_cnt}명)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL">
					<div class="chart_wrap">
						<ul class="mysurvey_list">
							<c:set var="ratio" value="0"></c:set>
							<c:set var="totalCount" value="0"></c:set>
							<c:set var="total_cnt" value="0"></c:set>
							<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
								<li>
									${j.quest_detail_title} <span class="countPersent">(${j.cnt}명:${j.ratio}%)</span>
									<c:set var="ratio" value="${ratio + j.ratio}"></c:set>
									<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
									<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
								</li>
							</c:forEach>
							<c:if test="${i.quest_detail_free_yn eq 'Y'}">
								<li>
									기타 (<span class="countPersent">${total_cnt-totalCount}명:<fmt:formatNumber value="${(i.quest_detail_list[0].total_cnt > 0) ? (total_cnt-totalCount == 0 ? 0 : 100-ratio) : 0}" pattern="##.##"  />
									%</span>) <a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription">&lt;응답보기&gt;</a>
								</li>
							</c:if>
						</ul> 
						<div class="chart_one"></div>
					</div>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MULTI'}">
			<tr>
				<td class="qustionNum"><span>${questIdx + 1}</span></td>
				<td class="qustion">${i.quest_content} (응답자: ${i.quest_detail_list[0].total_cnt}명)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL">
					<ul class="mysurvey_list">
					<c:set var="ratio" value="0"></c:set>
					<c:set var="totalCount" value="0"></c:set>
					<c:set var="total_cnt" value="0"></c:set>
					<c:forEach var="j" varStatus="status2" items="${i.quest_detail_list}">
						<li>
							${j.quest_detail_title} <span class="countPersent">(${j.cnt}명)</span>
							<c:set var="totalCount" value="${totalCount+j.cnt}"></c:set>
							<c:set var="total_cnt" value="${j.total_cnt}"></c:set>
						</li>
					</c:forEach>
					<c:if test="${i.quest_detail_free_yn eq 'Y'}">
						<li>
							기타 (${total_cnt-totalCount})<a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription"> &lt;응답보기&gt;</a>
						</li>
					</c:if>
					</ul>
				</td>
			</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		
		<c:when test="${i.quest_type eq 'MATRIX'}">
			<tr>
				<td class="qustionNum"><span>${questIdx+1}</span></td>
				<td class="qustion">${i.quest_content} (응답자: <fmt:formatNumber value="${i.quest_detail_list[0].total_cnt/fn:length(i.quest_matrix_list)}"/>명)</td>
			</tr>
			<tr>
				<td></td>
				<td class="aL">
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
								
								<c:forEach var="k" varStatus="status_k" items="${j.statisticsList}">
								<td><span class="countPersent">${k.cnt}명:${k.ratio}%</span></td>
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
		<c:set value="필수" var="required"></c:set>
		<c:if test="${i.required_yn eq 'N'}"><c:set value="선택" var="required"></c:set></c:if>
		<tr>
			<td class="qustionNum"><span>${questIdx+1}</span></td>
			<td class="qustion">${i.quest_content} (${required}) (응답자: ${i.quest_detail_list[0].total_cnt}명)</td>
		</tr>
		<tr>
			<td></td>
			<td class="aL">
				<a href="#" questIdx="${i.quest_idx}" surveyIdx="${i.survey_idx}" class="viewDescription">&lt;응답보기&gt;</a>
			</td>
		</tr>
		<c:set var="questIdx" value="${questIdx+1}" />
		</c:when>
		</c:choose>
		</c:forEach>

		</tbody>
	</table>
</div>

<!-- 버튼 -->
<div class="brdBtn">
	<a href="#" class="button close">닫기</a>
	<a href="#" class="button print">인쇄</a>
</div>
<!--// 버튼 -->