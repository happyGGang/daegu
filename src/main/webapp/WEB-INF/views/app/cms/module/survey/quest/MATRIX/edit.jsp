<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="cms" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<script type="text/javascript">
$(function() {
<c:if test="${quest.editMode eq 'modify'}">
	$('span#questMatrix').load('/cms/survey/quest/questMatrix.do?editMode=modify&quest_idx=${quest.quest_idx}&homepage_id=${param.homepage_id}&survey_idx=${quest.survey_idx}');
	$('span#questDetail').load('/cms/survey/quest/questDetail.do?editMode=modify&quest_type=MATRIX&quest_idx=${quest.quest_idx}&homepage_id=${param.homepage_id}&survey_idx=${quest.survey_idx}');
</c:if>	
	
	$('select#matrix_count').on('change', function(e) {
		$('span#questMatrix').load('/cms/survey/quest/questMatrix.do?matrix_count=' + $('select#matrix_count option:selected').val());
	});
	$('a#matrixCount').on('click', function(e) {
		$('span#questMatrix').load('/cms/survey/quest/questMatrix.do?matrix_count=' + $('select#matrix_count option:selected').val());
	});
	
	$('select#quest_count').on('change', function(e) {
		$('span#questDetail').load('/cms/survey/quest/questDetail.do?quest_type=MATRIX&homepage_id=${param.homepage_id}&quest_count=' + $('select#quest_count option:selected').val());
	});
	$('a#questCountA').on('click', function(e) {
		$('span#questDetail').load('/cms/survey/quest/questDetail.do?quest_type=MATRIX&homepage_id=${param.homepage_id}&quest_count=' + $('select#quest_count option:selected').val());
	});
	
	<c:if test="${quest.editMode eq 'add'}">
	$('select#matrix_count').val('3');
	$('select#quest_count').val('3');
	$('a#questCount').click();
	$('a#matrixCount').click();
	</c:if>
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				text: "저장",
				"class": 'btn',
				click: function() {
					doAjaxPost($('#questEdit'));
					$(this).dialog('destroy');
					$('#dialog-3').load('/cms/survey/quest/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
						$('#dialog-3').dialog('open');
					});
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
	
	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 820,
		height: 750
	});
	
});
</script>

<div class="brdTop_01">
	<h1>매트릭스형 문항</h1>
</div>

<div class="guide">
	<ul class="list">
		<li><em>[매트릭스형]</em>은 다수의 세부문항을 동일한 척도로 측정하고자 할 때 사용하는 표형태의 질문입니다.</li>
		<li>세부질문의 수를 입력하고 문항내용을 등록하십시오.</li>
		<li>보기의 수를 입력하고 보기명을 등록하십시오.</li>
	</ul>
</div>
<p class="hspace10"></p>
<form:form modelAttribute="quest" id="questEdit" action="/cms/survey/quest/save.do" method="POST"  onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/cms/module/survey/quest/common/form_param.jsp" flush="false" />

<div class="boardEdit mysurvey">
	<table class="edit" summary="설문항 세부 목록을 작성할 수 있습니다.">
		<colgroup>
			<col width="80" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>질문명</th>
				<td class="aL">
					<div class="item">
						<form:textarea path="quest_content" cssClass="i_text" rows="10" cols="100" />
					</div>	
				</td>
			</tr>
			<tr>
				<th>세부질문명</th>
				<td class="aL">
					<p class="before_click">
						<label for="matrix_count" style="margin:0">세부질문 수를 입력하세요</label>
						<form:select path="matrix_count">
						<c:forEach var="i" varStatus="status" begin="1" end="20" >
						<form:option value="${i}">${i}개</form:option>
						</c:forEach>
						</form:select>
						<span class="btn"><a href="#" id="matrixCount"><img src="/resources/cms/survey/img/btn_question.gif" alt="세부질문 입력" /></a></span>
					</p>
					<span id="questMatrix">
					</span>
				</td>
			</tr>
			<tr>
				<th>보기내용</th>
				<td class="aL">
					<p class="before_click">
						<label for="quest_count" style="margin:0">보기의 수를 입력하세요</label>
						<form:select path="quest_count">
						<c:forEach var="i" varStatus="status" begin="1" end="20" >
						<form:option value="${i}">${i}개</form:option>
						</c:forEach>
						</form:select>
						<span class="btn"><a href="#" id="questCountA"><img src="/resources/cms/survey/img/btn_answer.gif" alt="보기 입력" /></a></span>
					</p>
					<span id="questDetail">
					</span>
				</td>
			</tr>
			<tr style="display: none;">
				<th>권한설정</th>
				<td class="aL">
					<table>
						<tr>
							<td rowspan="2">
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ALL" id="auth_ALL" />
								<label for="auth_ALL">전체</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="STUDENT" id="auth_STUDENT" />
								<label for="auth_STUDENT">학생</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="TEACHER" id="auth_TEACHER" />
								<label for="auth_TEACHER">교사</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="SPECIAL" id="auth_SPECIAL" />
								<label for="auth_SPECIAL">전문직</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="GENERAL" id="auth_GENERAL" />
								<label for="auth_GENERAL">일반직</label>
							</td>
						</tr>
						<tr>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="PARENT" id="auth_PARENT" />
								<label for="auth_PARENT">학부모</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="REGULAR" id="auth_REGULAR" />
								<label for="auth_REGULAR">일반</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ORGAN" id="auth_ORGAN" />
								<label for="auth_ORGAN">기관</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ETC" id="auth_ETC" />
								<label for="auth_ETC">기타</label>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form:form>
<p class="hspace10"></p>