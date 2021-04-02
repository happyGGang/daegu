<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		if ($('#homepage_id').val() == '') {
			alert('홈페이지정보가 없습니다.');
		} else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}
	});

	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).data('homepage_id') + '&human_book_idx=' + $(this).data('human_book_idx'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택하신 휴번북 신청을 삭제하시겠습니까?')) {
			$('input#homepage_id_d').val($(this).data('homepage_id'));
			$('input#human_book_idx_d').val($(this).data('human_book_idx'));
			doAjaxPost($('form#humanBookDel'));
		}
	});

	$('select[name="apply_status"]').on('change',function(e) {
		var human_book_idx = $(this).data('human_book_idx');
		var formData = 'homepage_id='+$('#homepage_id').val()+'&human_book_idx='+human_book_idx+'&apply_status='+$(this).val()+'&editMode=STATUS';

		doAjaxOption('save.do', formData, 'POST');
	});

	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#humanBook').serialize());
	});

});
</script>

<form id="humanBookDel" action="save.do">
<input type="hidden" name="editMode" value="DELETE">
<input type="hidden" id="homepage_id_d" name="homepage_id">
<input type="hidden" id="human_book_idx_d" name="human_book_idx">
</form>

<form:form modelAttribute="humanBook" action="index.do" >
	<form:hidden path="homepage_id"/>
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<form:select path="activity_category" class="selectmenu">
				<form:option value="" label="분류항목 선택"></form:option>
				<form:options items="${activityCateList}" itemLabel="code_name" itemValue="code_id"/>
			</form:select>
		</fieldset>
	</div>

	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
<!-- 		<div class="button"> -->
<!-- 			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a> -->
<!-- 		</div> -->
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col width="12%" />
			<col />
			<col width="12%" />
			<col width="10%" />
			<col width="10%" />
			<col width="8%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>사람책 제목</th>
				<th>요일 및 시간대</th>
				<th>열람장소</th>
				<th>등록일</th>
				<th>상태</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${humanBookAll}">
				<tr>
					<td>${humanBook.listRowNum - status.index}</td>
					<td>
					<c:forTokens items="${i.activity_category}" delims="," var="ac">
						<c:if test="${ac eq '1'}">기본형</c:if>
						<c:if test="${ac eq '2'}">클래식</c:if>
						<c:if test="${ac eq '3'}">뜨거운감자</c:if>
						<c:if test="${ac eq '4'}">TED</c:if>
						<c:if test="${ac eq '5'}">실속파</c:if>
						<c:if test="${ac eq '6'}">행동파</c:if>
						<c:if test="${ac eq '7'}">챌린지</c:if>
					</c:forTokens>
					</td>
					<td>${i.human_book_title}</td>
					<td>
						<c:forTokens items="${i.activity_day}" delims="," var="day">
							<c:if test="${day eq '1'}">일</c:if>
							<c:if test="${day eq '2'}">월</c:if>
							<c:if test="${day eq '3'}">화</c:if>
							<c:if test="${day eq '4'}">수</c:if>
							<c:if test="${day eq '5'}">목</c:if>
							<c:if test="${day eq '6'}">금</c:if>
							<c:if test="${day eq '7'}">토</c:if>
						</c:forTokens>
						<br>
						<c:forTokens items="${i.activity_time}" delims="," var="time">
							<c:if test="${time eq '1'}">오전(10:00~12:00)</c:if>
							<c:if test="${time eq '2'}">오후(13:00~17:00)</c:if>
							<c:if test="${time eq '3'}">${i.activity_time_txt}</c:if>
							<br>
						</c:forTokens>
					</td>
					<td></td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:choose>
							<c:when test="${i.apply_status eq '0'}">신청</c:when>
							<c:when test="${i.apply_status eq '1'}">미승인</c:when>
							<c:when test="${i.apply_status eq '2'}">승인</c:when>
						</c:choose>
					</td>
					<td>
						<c:if test="${authU}">
						<a href="" class="btn dialog-modify" data-homepage_id="${i.homepage_id}" data-human_book_idx="${i.human_book_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
						<a href="" class="btn delete-btn" data-homepage_id="${i.homepage_id}" data-human_book_idx="${i.human_book_idx}">삭제</a>
						</c:if>
<%-- 						<c:if test="${i.server_file_name ne null and i.server_file_name ne ''}"> --%>
<%-- 							<a href="/cms/module/humanBookManage/download/${i.homepage_id}/${i.human_book_idx}.do"><i class="fa fa-floppy-o"></i></a> --%>
<%-- 						</c:if> --%>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(humanBookAll) < 1}">
				<tr>
					<td colspan="10">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#humanBook"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="human_book_title">제목</form:option>
				<form:option value="teacher_name">성명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="강사 정보"></div>
<div id="dialog-2" class="dialog-common" title="강사 이력"></div>