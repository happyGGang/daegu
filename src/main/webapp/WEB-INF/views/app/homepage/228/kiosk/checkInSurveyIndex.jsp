<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
	function getCheckboxValue()  {
		if ($('input:checkbox[name="checkinout_survey_answer"]').is(":checked") == false) {
			alert('이용하신 공간을 체크해주세요.');
			return false;
		}

		var checkAnswer = [];
		$('input:checkbox[name=checkinout_survey_answer]:checked').each(function() {
			checkAnswer.push(this.value);
		});

		$('input#checkinout_survey_answer').val(checkAnswer);

		$('form#checkInOutSurveyReqForm').submit();
	}
</script>

<form:form id="checkInOutSurveyReqForm" modelAttribute="checkInOutSurveyReq" action="/${homepage.context_path}/module/checkInOutSurveyReq/save.do">
	<form:hidden id="checkinout_survey_idx" path="checkinout_survey_idx" value="${checkInOutSurveyReq.checkinout_survey_idx}"/>
	<form:hidden id="homepage_id" path="homepage_id" value="${checkInOutSurveyReq.homepage_id}"/>
	<form:hidden id="member_age" path="member_age" value="${checkInOutSurveyReq.member_age}"/>
	<form:hidden id="member_sex" path="member_sex" value="${checkInOutSurveyReq.member_sex}"/>
	<form:hidden id="checkOut_msg" path="checkOut_msg" value="${checkInOutSurveyReq.checkOut_msg}"/>
	<input type="hidden" name="checkinout_survey_answer" id="checkinout_survey_answer"/>
</form:form>

<div class="survey-wrap">
	<div class="header">
		<img src="/resources/common/img/kiosk/checkin-logo-new.png" alt="그린대로 로고"/>
	</div>
	<div class="content">
		<div class="check-box">
			<div class="title-box">
				<div class="q-circle">
					<div class="q-txt">q</div>
				</div>
				<div class="t-txt">오늘은 어떤 공간들을 이용하였나요?</div>
			</div>

			<form id="" method="post">
				<div id="useList" class="use-list">
					<ul>
						<c:choose>
							<c:when test="${fn:length(checkInOutSurveyQuestionList) > 0}">
								<c:forEach items="${checkInOutSurveyQuestionList}" var="i" varStatus="status">
									<li>
										<span class="image-box">
											<img src="/resources/common/img/kiosk/checking.png" alt="선택" class="checking" id="checking${status.count}">
											<img src="/data/checkInOutSurvey/${i.homepage_id}/${i.server_file_name}" class="green-img" alt="${i.origin_file_name}">
										</span>
										<span class="contents-box">
											<input type="checkbox" name="checkinout_survey_answer" value="${status.count}" id="userListchk${status.count}" class="userListchk" />
											<label for="userListchk${status.count}">${i.checkinout_survey_question_title}</label>
										</span>
									</li>
								</c:forEach>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</form>
			<div class="survey-btn-box">
				<a href="javascript:void(0);" class="survey-btn" onclick='getCheckboxValue();'>답변제출하기</a>
			</div>
		</div>
	</div>
	<div class="footer">
		Memorial Library for 2.28 Students' Movement
	</div>
</div>

<tiles:insertAttribute name="footer" />