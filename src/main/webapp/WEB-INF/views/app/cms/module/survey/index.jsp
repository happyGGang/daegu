<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	$(function () {
		$('select#homepage_id_1').on('change', function() {
			if($(this).val() != '') {
				var url = 'index.do';
				var param = 'homepage_id=' + $(this).val();
				doGetLoad(url, param);
			}
		});

		<%-- 등록 --%>
		$('a#dialog-add').on('click', function(e) {
			if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
				alert("홈페이지를 선택 해 주세요.");
				return false;
			}
			var url = 'edit.do';
			var param = 'eidtMode=ADD&homepage_id='+$('#homepage_id').val();
			doGetLoad(url, param);

			e.preventDefault();
		});

 		<%--보기 --%>
 		$('a#edit-btn').on('click', function(e) {
			var url = 'edit.do';
			var param = 'editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&survey_idx=' + $(this).attr('keyValue');
			doGetLoad(url, param);

			e.preventDefault();
		});

 		<%-- 설문기본 수정 --%>
 		$('a#dialog-view').on('click', function(e) {
			$('#dialog-2').load('view.do?homepage_id=' + $('#homepage_id').val() + '&survey_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});

			e.preventDefault();
		});

 		<%--설문삭제--%>
 		$('a#delete-btn').on('click', function(e) {
 			e.preventDefault();
 			if (confirm('삭제된 설문조사는 복구가 불가능합니다.\n\n정말로 삭제하시겠습니까?')) {
 				$('form#surveyForm').attr('action', 'delete.do');
 				$('#survey_idx').val($(this).attr('keyValue'));
 				doAjaxPost($('form#surveyForm'));
 			}
 		});
 		
 		<%--설문복사--%>
 		$('a#copy-btn').on('click', function(e) {
 			e.preventDefault();
 			
 			var survey_title = $(this).attr('survey_title');
 			
 			var copy_survey_title = "- 설문조사명 : "+survey_title+"_복사본";
 			
 			if (confirm("선택한 설문지가 아래의 설정으로 복사 됩니다. \n\n"+copy_survey_title+"\n- 설문조사 공개여부 : 비공개 \n\n복사하시겠습니까?")) {
 				$('form#surveyForm').attr('action', 'copy.do');
 				$('#survey_idx').val($(this).attr('keyValue'));
 				doAjaxPost($('form#surveyForm'));
 			}
 		});
	});
</script>
<form:form modelAttribute="survey" id="surveyForm" action="index.do">
<form:hidden path="homepage_id" id="homepage_id"/>
<form:hidden path="survey_idx"/>
<form:hidden path="editMode"/>

	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center" summary="설문조사명과 등록자, 작성일 및 응답수와 조사여부를 알 수 있습니다.">
		<colgroup>
			<col width="50" />
			<col width="200" />
<%-- 			<col width="150" /> --%>
			<col width="150" />
			<col width="150" />
			<col width="150" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>설문조사명</th>
<!-- 				<th>조사자</th> -->
				<th>응답수</th>
				<th>설문조사 시작일</th>
				<th>설문조사 종료일</th>
				<th>공개여부</th>
				<th>조사여부</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${surveyList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td><a href="#" id="dialog-view" keyValue="${i.survey_idx}">${i.survey_title}</a></td>
<%-- 				<td>${i.add_id}</td> --%>
					<td>${i.answer_count}명</td>
					<td>${i.survey_start_date}</td>
					<td>${i.survey_end_date}</td>
					<td>
						<c:if test="${i.survey_private_yn eq 'N'}">비공개</c:if>
						<c:if test="${i.survey_private_yn eq 'Y'}">공개</c:if>
					</td>
					<td>
						<c:if test="${i.survey_open_yn eq 'N'}">조사완료</c:if>
						<c:if test="${i.survey_open_yn eq 'Y'}">미완료</c:if>
					</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:if test="${authC or authU}">
							<a href="" class="btn" id="edit-btn" keyValue="${i.survey_idx}">수정</a>
						</c:if>
						
						<c:if test="${authC or authU}">
							<a href="" class="btn" id="dialog-view" keyValue="${i.survey_idx}">설정</a>
						</c:if>
						<c:if test="${authC or authU}">
							<a href="" class="btn" id="copy-btn" keyValue="${i.survey_idx}" survey_title="${i.survey_title}">복사</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.survey_idx}">삭제</a>
						</c:if>
						
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(surveyList) < 1}">
				<tr>
					<td colspan="9">등록된 설문조사가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#surveyForm"/>
	</jsp:include>
	<div id="my-chart">

	</div>
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:hidden path="search_type" value="survey_title"/>
			설문조사명 :
			<form:input path="search_text" cssClass="text" cssStyle="width:150px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="설문등록"></div>
<div id="dialog-2" class="dialog-common" title="설문내용보기"></div>