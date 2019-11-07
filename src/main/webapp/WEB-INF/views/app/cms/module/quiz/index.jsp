<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#quizListForm').submit();
	});
	
	
	$('a.dialog-add').on('click', function(e) {
		
		if($('#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&quiz_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 퀴즈를 삭제 하시겠습니까?') ) {
			$('#hiddenForm #quiz_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a.dialog-question').on('click', function(e) {
		$('#dialog-2').load('editQuestion.do?homepage_id=' + $('#homepage_id').val() + '&quiz_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.dialog-reqList').on('click', function(e){
		$('#dialog-3').load('reqList.do?homepage_id=' + $('#homepage_id').val() + '&quiz_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		e.preventDefault();
	});
	
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#quizListForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="quiz" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="quiz_idx"/>
</form:form>
<form:form id="quizListForm"  modelAttribute="quiz" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${quizListCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 dialog-add" ><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="150" />
			<col width="" />
			<col width="" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>타입</th>
				<th>제목</th>
				<th>책이름</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>현황</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${quizList}">
				<tr>
					<td>${i.quiz_idx}</td>
					<td>${quizTypeList[i.quiz_type].code_name}</td>
					<td>${i.quiz_name}</td>
					<td>${i.book_name}</td>
					<td>${i.quiz_start_date}</td>
					<td>${i.quiz_end_date}</td>
					<td>${i.quiz_req_count} <a href="" class="btn btn2 dialog-reqList" keyValue="${i.quiz_idx}">보기</a></td>
					<td>
						<c:if test="${authC or authU}">
							<a href="" class="btn btn2 dialog-question" keyValue="${i.quiz_idx}">문항</a>
						</c:if>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" keyValue="${i.quiz_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue="${i.quiz_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${quizListCount eq 0}">
				<tr>
					<td colspan="8">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#quizListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="QUIZ_NAME">제목</form:option>
				<form:option value="QUIZ_TYPE">타입</form:option>
				<form:option value="BOOK_NAME">책이름</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="퀴즈 정보"></div>
<div id="dialog-2" class="dialog-common" title="퀴즈 문항 정보"></div>
<div id="dialog-3" class="dialog-common" title="퀴즈 문항 정보"></div>