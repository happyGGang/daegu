<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(function(){
	
	$('a.status_chage').on('click', function(e) {
		e.preventDefault();
		var param = 'editMode=STATUS&homepage_id='+$('#homepage_id').val() + '&human_book_idx='+$(this).data('book_idx') + '&human_apply_idx='+$(this).data('apply_idx');
		$('#dialog-1').load('status.do?'+param, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', serializeCustom($('form#humanApply')));
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(humanScheduleList)}' > 0) {
			$('#humanApply').attr('method', 'POST');
			$('#humanApply').attr('action', 'excelDownload.do').submit();
		} else {
			alert('해당 내역이 없습니다.');
		}
	});
	
});
</script>
<form:form modelAttribute="humanApply" action="index.do" method="GET">
<form:hidden path="homepage_id"/>
<div>
	<table>
		<colgroup>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
			<tr>
				<th>열람일</th>
				<th>열람장소</th>
				<th>사람책</th>
				<th>신청자</th>
				<th>열람인원</th>
				<th>질문사항</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${humanScheduleList}" var="i">
			<tr>
				<td>${i.human_apply_hope_date}</td>
				<td>${i.human_apply_place}</td>
				<td>${i.human_book_title}</td>
				<td>${i.human_apply_name}</td>
				<td>${i.human_apply_people}</td>
				<td>${i.human_apply_content}</td>
				<td>
					<a href="#" class="status_chage" data-book_idx="${i.human_book_idx}" data-apply_idx="${i.human_apply_idx}">
					<c:choose>
						<c:when test="${i.human_apply_status eq '0'}">신청</c:when>
						<c:when test="${i.human_apply_status eq '1'}">승인</c:when>
						<c:when test="${i.human_apply_status eq '3'}">미승인</c:when>
					</c:choose>
					</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(humanScheduleList) < 1}">
			<tr>
				<td colspan="7">조회된 내역이 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#humanApply"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="human_apply_place">열람장소</form:option>
				<form:option value="human_book_title">제목</form:option>
				<form:option value="human_apply_name">신청자</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="신청상태"></div>