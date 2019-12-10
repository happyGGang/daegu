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

		if ( "${member.loginType eq 'HOMEPAGE' and member.login }" == 'true' ) {
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
			$('#quizReq #quiz_answer').val(answerList.join('<whale>'));

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
		}
		else {
			alert('로그인 후 이용 가능 합니다.');
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
<c:if test="${fn:length(quiz.top_html) > 0}">
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
					<div class="quiz_list">
						<div class="pic">
							<p>
							<c:set value="${quiz.book_image}" var="book_image"></c:set>
							<c:choose>
							    <c:when test = "${fn:contains(book_image, 'http')}">
							         <img src="${quiz.book_image}" height="154" width="140" alt="${quiz.book_name}" />
							    </c:when>
								<c:otherwise>
									<img src="/data/quiz/${quiz.homepage_id}/${quiz.book_image}" height="154" width="140" alt="${quiz.book_name}" />
							   	</c:otherwise>
							</c:choose>

							</p>
						</div>
						<div class="data_info">
							<h3>${quiz.book_name}</h3>
							<ul>
								<c:if test="${quiz.book_author ne ''}">
									<li><span class="item"> 지은이</span> <span class="value"><span>${quiz.book_author}</span></span></li>
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
							<c:forTokens items="${oneQuestion.quiz_question_item}" delims="<whale>" var="oneRadioItem" varStatus="radioItemStatus">
								<li><input type="radio" name="radio_answer_${questionStatus.count}" id="radioItem_${questionStatus.count}_${radioItemStatus.index}" value="${oneRadioItem}"/> <label for="radioItem_${questionStatus.count}_${radioItemStatus.index}">${oneRadioItem}</label></li>
							</c:forTokens>
						</ul>
					</div>
				</c:when>
				<c:when test="${oneQuestion.quiz_question_type eq 'CHECK'}">
					<div class="txt-box t2" keyValue="CHECK">
						<ul>
							<c:forTokens items="${oneQuestion.quiz_question_item}" delims="<whale>" var="oneCheckItem" varStatus="checkItemStatus">
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
				<tr>
					<th>이름</th>
					<td>
						<label for="name"></label>
						${member.member_name}
						<form:hidden path="name" class="text" title="이름" value="${member.member_name}"/>
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
					<span class="info">(퀴즈응모는 한사람당 한번씩만 가능합니다)</span></td>
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

		<c:forEach items="${termsList}" var="terms">
			${terms.contents }
		</c:forEach>
		<c:if test="${fn:length(termsList) > 0}">
		<div style="text-align: right"><b>이용약관 및 개인정보의 수집·이용 동의 여부</b>(<span style="color: red; font-weight: bold;">*</span>)
			<form:select path="terms_yn" cssClass="selectmenu" cssStyle="width : 70px" title="개인정보 이용동의 선택">
				<form:option value="Y" label="동의"/>
				<form:option value="N" label="미동의"/>
			</form:select>
		</div>
		</c:if>
		</c:if>
	</form:form>
</div>
<div class="btn-area center">
	<c:if test="${!member.login}">
		<div class="ui-state-error">
			로그인 후 퀴즈 응모가 가능 합니다.
		</div><br/>
	</c:if>
	<c:if test="${member.login and not empty quiz.quiz_name}">
	<a href="" class="btn save-btn">확인</a>
	</c:if>
</div>



