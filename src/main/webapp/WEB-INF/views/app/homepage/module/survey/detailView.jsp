<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/resources/cms/survey/css/common.css" rel="stylesheet" type="text/css" title="style">
<link href="/resources/cms/survey/css/default.css" rel="stylesheet" type="text/css">
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
});

</script>

<style>
	.brdTop_02{max-width:800px;margin:0 auto;height:275px;background:url('/resources/cms/survey/img/bg_top_01.jpg') #244d97 no-repeat 0 0;margin-bottom:10px;}
	.brdTop_02 h1{color:#000;font-weight:bold;font-size:23px;padding:20px 0 13px 30px;background:url('/resources/cms/survey/img/bullet.gif') left 16px no-repeat;}
</style>

<div class="brdTop_02">
	<div class="survey_info">
		<h1>${survey.survey_title}</h1>
		<div class="description">
		${survey.survey_content}
		</div>
<%-- 		<p class="contact"><strong>조사문의:</strong>  ${survey.add_user_name} ( ${survey.add_user_tel} )  </p> --%>
	</div>
</div>
<!--// 상단 -->

<div class="surveyList">
	<table class="list" summary="설문조사 문항에 대한 답변을 작성할 수 있습니다.">
		<caption>설문조사 목록</caption>
		<colgroup>
			<col width="46" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<td class="qustionNum"><span>${quest.quest_order}</span></td>
				<td class="qustion">${quest.quest_content}</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<table class="in_tbl" summary="">
						<caption></caption>
						<colgroup>
							<col width="5%" />
							<col width="95%"/>
						</colgroup>
						<thead>
							<tr>
								<th>순번</th>
								<th>내용</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" varStatus="status" items="${description}">
							<tr>
								<td>${status.count}</td>
								<td>${i.short_answer eq null ? '없음':i.short_answer}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table> 
				</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- 버튼 -->
<div class="brdBtn">
	<a href="#" class="button close">닫기</a>
	<a href="#" class="button print">인쇄</a>
</div>
<!--// 버튼 -->