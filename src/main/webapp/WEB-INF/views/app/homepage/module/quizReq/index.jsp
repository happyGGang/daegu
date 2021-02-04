<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
	.join-wrap h1 {position: relative;}
</style>
<script type="text/javascript">
$(function() {

	$('a.quiz-type-btn').on('click', function(e) {
		$('#quizReq #search_quiz_type').val($(this).attr('keyValue'));
		doGetLoad('index.do', serializeCustom($('#quizReq')));
		e.preventDefault();
	});

	$('a.before-month').on('click', function(e) {
		var curYear = parseInt($('#quizReq #search_quiz_year').val());
		var curMonth = parseInt($('#quizReq #search_quiz_month').val());

		if ( curMonth < 2 ) {
			$('#quizReq #search_quiz_year').val((curYear - 1));
			$('#quizReq #search_quiz_month').val('12');
		}
		else {
			$('#quizReq #search_quiz_month').val((curMonth - 1));
		}

		doGetLoad('index.do', serializeCustom($('#quizReq')));
		e.preventDefault();
	});

	$('a.next-month').on('click', function(e) {
		var curYear = parseInt($('#quizReq #search_quiz_year').val());
		var curMonth = parseInt($('#quizReq #search_quiz_month').val());

		if ( curMonth > 11 ) {
			$('#quizReq #search_quiz_year').val((curYear + 1));
			$('#quizReq #search_quiz_month').val('1');
		}
		else {
			$('#quizReq #search_quiz_month').val((curMonth + 1));
		}

		doGetLoad('index.do', serializeCustom($('#quizReq')));
		e.preventDefault();
	});

	$('a.save-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#quizReq #quiz_idx').val() == 0 ) {
			alert('해당하는 퀴즈 정보가 없습니다.');
			return;
		}

		var agreeLength = $('div.agree_codes input.agree_check').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked') && $('#terms'+i).attr('keyValue2') == 'Y') {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

		var answerList = [];
		$('div.txt-box').each(function(i, divE) {
			var $this = $(this);
			var type = $this.attr('keyValue');
			if ( type == 'TEXT' ) {
				answerList.push($this.find('textarea').val());
			}
			else if ( type == 'RADIO' ) {
				answerList.push($this.find('input:radio:checked').val());
			}
			else if ( type == 'CHECK' ) {
				var checkAnswer = [];
				$this.find('input:checkbox:checked').each(function(i, checkE) {
					checkAnswer.push($(this).val());
				});
				answerList.push(checkAnswer.join(','));
			}
		});
		$('#quizReq #quiz_answer').val(answerList.join('|'));

		var $form = $('#quizReq').clone();
		if ( $form.find('#hak').val() == '' ) {
			$form.find('#hak').val(0);
		}
		if ( $form.find('#ban').val() == '' ) {
			$form.find('#ban').val(0);
		}

		if ( doAjaxPost($form) ) {
			location.reload();
		}
	});
});
</script>

<div class="tabmenu tab1">
	<ul>
	<c:forEach items="${quizTypeList}" var="i" varStatus="status">
		<li <c:if test="${quizReq.search_quiz_type eq i.code_id}">class="active"</c:if>><a href="" class="quiz-type-btn" keyValue="${i.code_id}">${i.code_name}</a></li>
	</c:forEach>
	</ul>
</div>
<c:if test="${fn:length(quiz.top_html) > 0 && quiz.book_name ne '' and quiz.book_name ne null}">
${quiz.top_html}
</c:if>
<div class="tabCon active" id="tabCon1">
	<div class="quiz_wrapper">
		<div class="quiz">
			<h2>${quiz.quiz_name}<c:if test="${empty quiz.quiz_name}">등록된 독서퀴즈가 없습니다.</c:if>
				<div class="quiz_month">
					<a href="" class="before-month"><i class="fa fa-caret-left"></i><span class="blind">이전달</span></a>
					<b><span>${quizReq.search_quiz_year}.</span><em>${quizReq.search_quiz_month}</em></b>
					<a href="" class="next-month"><i class="fa fa-caret-right"></i><span class="blind">다음달</span></a>
				</div>
			</h2>
			<c:forEach items="${quizTypeList}" var="j" >
				<c:if test="${j.code_id eq quiz.quiz_type }">
					<c:if test="${quiz.book_name ne '' and quiz.book_name ne null}">
					<div class="quiz_list">
						<div class="pic">
							<p>
								<img src="${quiz.book_image}" height="154" width="140" alt="${quiz.book_name}" />
							</p>
						</div>
						<div class="data_info">
							<h3>${quiz.book_name}</h3>
							<ul>
								<c:if test="${quiz.book_author ne ''}">
									<li><span class="item"> 저자</span> <span class="value"><span>${quiz.book_author}</span></span></li>
								</c:if>
								<c:if test="${quiz.book_publisher ne ''}">
									<li><span class="item"> 출판사</span> <span class="value"><span>${quiz.book_publisher}</span></span></li>
								</c:if>
								<c:if test="${quiz.call_no ne ''}">
									<li><span class="item"> 청구기호</span> <span class="value"><span>${quiz.call_no}</span></span></li>
								</c:if>
								<c:if test="${quiz.book_desc ne ''}">
									<li><span class="item"> 줄거리</span> <span class="value"><span>${quiz.book_desc}</span></span></li>
								</c:if>
							</ul>
						</div>
					</div>
					</c:if>
					<c:if test="${quiz.book_name eq '' or quiz.book_name eq null}">
					<div class="quiz_list">
						${quiz.top_html}
					</div>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<br/>
	<c:forEach items="${quizQuestionList}" var="oneQuestion" varStatus="questionStatus">
		<div id="question_${questionStatus.index}" class="poll_item">
			<div>${questionStatus.count}. ${oneQuestion.quiz_question_title}</div>
			<c:choose>
				<c:when test="${oneQuestion.quiz_question_type eq 'TEXT'}">
					<div class="txt-box t1" keyValue="TEXT">
						<textarea rows="5" style="width:100%" class="text" title="서술형 입력란" ></textarea>
					</div>
				</c:when>
				<c:when test="${oneQuestion.quiz_question_type eq 'RADIO'}">
					<div class="txt-box t2" keyValue="RADIO">
						<ul>
							<c:forTokens items="${oneQuestion.quiz_question_item}" delims="|" var="oneRadioItem" varStatus="radioItemStatus">
								<li><input type="radio" name="radio_answer_${questionStatus.count}" id="radioItem_${questionStatus.count}_${radioItemStatus.index}" value="${oneRadioItem}"/> <label for="radioItem_${questionStatus.count}_${radioItemStatus.index}">${oneRadioItem}</label></li>
							</c:forTokens>
						</ul>
					</div>
				</c:when>
				<c:when test="${oneQuestion.quiz_question_type eq 'CHECK'}">
					<div class="txt-box t2" keyValue="CHECK">
						<ul>
							<c:forTokens items="${oneQuestion.quiz_question_item}" delims="|" var="oneCheckItem" varStatus="checkItemStatus">
								<li><input type="checkbox" name="check_answer_${questionStatus.count}" id="checkItem_${questionStatus.count}_${checkItemStatus.index}" value="${oneCheckItem}"/> <label for="checkItem_${questionStatus.count}_${checkItemStatus.index}">${oneCheckItem}</label></li>
							</c:forTokens>
						</ul>
					</div>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</div>
	</c:forEach>
	<form:form id="quizReq" modelAttribute="quizReq" method="post" action="save.do">
		<form:hidden path="editMode" value="ADD"/>
		<form:hidden path="homepage_id"/>
		<form:hidden path="quiz_idx"/>
		<form:hidden path="quiz_answer"/>
		<form:hidden path="menu_idx"/>
		<form:hidden path="search_quiz_type"/>
		<form:hidden path="search_quiz_year"/>
		<form:hidden path="search_quiz_month"/>
		<c:if test="${not empty quiz.quiz_name}">

		<table class="nohead quiz-info-table" summary="독서퀴즈" style="margin-bottom: 20px;">
			<caption>독서퀴즈 응모 정보 입력</caption>
			<tbody>
				<c:if test="${quiz.school_yn eq 'Y'}">
					<tr>
						<th>학교</th>
						<td>
							<label for="school"/>
							<form:input path="school" class="text" title="학교 입력" maxlength="15"/></td>
					</tr>
				</c:if>
				<c:if test="${quiz.hak_yn eq 'Y'}">
					<tr>
						<th>학년</th>
						<td>
							<label for="hak"/>
							<input type="text" id="hak" name="hak" class="text" title="학년 입력" cssStyle="width:30px" maxlength="1" /></td>
					</tr>
				</c:if>
				<c:if test="${quiz.ban_yn eq 'Y'}">
					<tr>
						<th>반</th>
						<td>
							<label for="ban"/>
							<input type="text" id="ban" name="ban" class="text" title="반 입력" cssStyle="width:30px" maxlength="2"/></td>
					</tr>
				</c:if>
				<c:if test="${quiz.gender_yn eq 'Y'}">
					<tr>
						<th>성별</th>
						<td>
							<form:radiobutton path="gender" label="남" value="0" checked="true"/>
							<form:radiobutton path="gender" label="여" value="1"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${quiz.age_yn eq 'Y'}">
					<tr>
						<th>연령대</th>
						<td>
							<form:radiobutton path="age" label="성인" value="20" checked="true"/>
							<form:radiobutton path="age" label="청소년" value="14"/>
							<form:radiobutton path="age" label="어린이" value="13"/>
						</td>
					</tr>
				</c:if>
				<tr>
					<th>이름</th>
					<td>
						<label for="name"></label>
						<form:input path="name" cssClass="text" title="이름" value="${member.member_name}"/>
				</tr>
				<tr>
					<th>휴대전화번호 </th>
					<td>
					<c:choose>
						<c:when test="${member.loginType eq 'HOMEPAGE' }">
							<label for="phone"></label>
							${member.cell_phone}
							<form:hidden path="phone" class="text" value="${member.cell_phone}"/>
						</c:when>
						<c:otherwise>
							<label for="phone"></label>
							<form:input path="phone" class="text" title="휴대전화번호 입력" value=""/>
						</c:otherwise>
					</c:choose>
				</tr>
				<%-- <tr>
					<th>주소</th>
					<td>
						<div class="Addr_search">
							<button class="btn btn2 findPostCode" keyValue1="#zip_code" keyValue2="#address">우편번호 찾기</button>
							<form:input path="zip_code" class="text" />
							<div>
								<form:input path="address" class="text addr3" />
							</div>
						</div>
					</td>
				</tr> --%>
			</tbody>
		</table>

		<c:if test="${fn:length(quiz.bottom_html) > 0}">
		${quiz.bottom_html}
		</c:if>

		<c:forEach items="${termsList}" var="terms" varStatus="status">
			<c:if test="${status.first}">
			<div class="join-wrap" style="padding: 0">
			</c:if>
			<h4>${terms.title}</h4>
			<div class="Box" style="max-height:200px" tabindex="0" >
				${terms.contents}
			</div>
			<div class="agree_codes">
				<div class="checkbox">
					<input id="terms${status.count}" class="agree_check" type="checkbox" keyValue="${terms.title}" keyValue2="${terms.required_yn}" keyValue3="${terms.terms_idx}" style="opacity: inherit;">
					<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의 ${terms.required_yn eq 'Y' ? '[필수]' : '[선택]'}</label>
				</div>
			</div>
			<c:if test="${status.last}">
			<br><br>
			</div>
			</c:if>
		</c:forEach>


		</c:if>
	</form:form>
</div>
<div class="btn-area center">
	<a href="" class="btn save-btn">확인</a>
</div>



