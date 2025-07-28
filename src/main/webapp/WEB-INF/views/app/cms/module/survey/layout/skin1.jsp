<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>설문조사1</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/survey/resources/css/type1.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/skin1.css">
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/board/js/common.js"></script>

<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<style>
#footer{color:#d4e5f1;font-size:11px;font-family:verdana;clear:both;padding:15px 0;margin:20px 2% 0;background:#4d9fce;text-align:center}
</style>
</head>
<body class="survey">
	<div id="wrap">
		<div id="contArea">

<!-- s : top -->

<div class="brdTop_02">
	<div class="survey_info_wrap">
		<div class="survey_info">
			<h1>학교홈페이지 서비스 향상을 위한 온라인 설문조사(기관용)</h1>
			<div class="description">
			안녕하십니까? 경상북도교육연구원에서는 통합 학교홈페이지 구축·운영 서비스를 통해 학교 업무를 지원하고 있습니다.
<br>본 설문은 새로운 학교 홈페이지 구축 프로그램(웹 빌더) 개발과 관련하여 이용자들의 다양한 의견 수렴을 통해 보다 발전적인 개선 방안을 마련하고 실시하는 것입니다.
<br>설문 결과는 통합 학교홈페이지 서비스 향상 및 웹 빌더 개발을 위한 기초 자료로 활용되며 그 외 다른 목적으로는 사용되지 않습니다. 여러분의 적극적인 참여를 부탁드립니다. 감사합니다
<br>
경상북도교육연구원장
			</div>
		</div>
<!-- 		<p class="contact"><span><strong>조사문의:</strong>  최정임 ( 054-840-2297 )  </span></p> -->
	</div>
</div>
<!--// e : top -->

<!-- s : contents -->
<form id="quest" action="/survey/answer/index.do?survey_idx=10" method="post" onsubmit="return false;">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input id="survey_idx" name="survey_idx" type="hidden" value="10">
<div class="surveyList">
	<table class="list" summary="설문조사 문항에 대한 답변을 작성할 수 있습니다.">
		<caption class="blind">설문조사 목록</caption>
		<colgroup>
			<col style="width:46px"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td class="qustionNum"><span>Q1</span></td>
				<td class="qustion">귀하의 소속 학교급을 선택해 주십시오.</td>
			</tr>
			<tr id="quest_detail_group_1">
				<td></td>
				<td class="aL">
					<ul class="mysurvey_list">
						<li>
							<input id="questIdx_0_1" name="answer_list[0].quest_idx_list" type="radio" value="1">
							<label for="questIdx_0_1">유치원</label>
						</li>
						<li>
							<input id="questIdx_0_2" name="answer_list[0].quest_idx_list" type="radio" value="2">
							<label for="questIdx_0_2">초등학교</label>
						</li>
						<li>
							<input id="questIdx_0_3" name="answer_list[0].quest_idx_list" type="radio" value="3">
							<label for="questIdx_0_3">중학교</label>
						</li>
						<li>
							<input id="questIdx_0_4" name="answer_list[0].quest_idx_list" type="radio" value="4">
							<label for="questIdx_0_4">고등학교</label>
						</li>
						<input id="answer_list0.short_answer" size="25" type="hidden" value=""/>
					</ul>
				</td>
			</tr>
			<tr>
				<td class="qustionNum"><span>Q19</span></td>
				
				
				<td class="qustion">그 외 학교홈페이지의 발전적인 방향을 위해 제안하실 내용이 있으시다면 자유롭게 기술해 주시기 바랍니다. (필수)</td>
			</tr>
			<tr id="quest_detail_group_19">
				<td></td>
				<td class="aL">
					<label for="" class="screen_out">서술형문항</label>
					<input id="answer_list18.short_answer" name="answer_list[18].short_answer" style="width:80%" type="text" value="" size="90" maxlength="100">
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form>
<!--// e : contents -->

<!-- s : btn -->
<div class="brdBtn">
	<a href="javascript:window.close();" class="button close">닫기</a>
	<a href="javascript:print();" class="button print">인쇄</a>
</div>
<!--// e : btn -->

		</div>
		<div id="footer">Copyright &copy; by Gyeongbuk Provincial Public Library, All rights reserved.</div>
	</div>

</body>
</html>