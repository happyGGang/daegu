<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#projectManageListForm').submit();
	});
	
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&req_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		$('#hiddenForm #req_idx').val($(this).attr('keyValue'));
		if(doAjaxPost($('#hiddenForm'))) {
			location.reload();
		}
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="projectManage" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="req_idx"/>
</form:form>
<form:form id="projectManageListForm"  modelAttribute="projectManage" action="index.do" >
	<div class="infodesk">
		검색 결과 : 총 ${projectManageListCount}건
		<div class="button">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="100" />
			<col width="" />
			<col width="100" />
			<col width="100" />
			<col width="200" />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>	
				<th>제목</th>
				<th>상태</th>	
				<th>담당자</th>
				<th>등록일</th>
				<th>완료일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${projectManageList}">
				<tr>
					<td>${i.req_idx}</td>
					<td>${i.type}</td>
					<td>${i.title}</td>
					<td>${i.status}</td>
					<td>${i.person}</td>
					<td>${i.add_date}</td>
					<td>${i.end_date}</td>
					<td>
						<a href="" class="btn" id="dialog-modify" keyValue="${i.req_idx}">수정</a>
						<a href="" class="btn" id="delete-btn" keyValue="${i.req_idx}">삭제</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${projectManageListCount eq 0}">
				<tr>
					<td colspan="8">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#projectManageListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="select">
				<form:option value="HOMEPAGE_ID">기관명</form:option>
				<form:option value="TYPE">분류</form:option>
				<form:option value="TITLE">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="신청 정보"></div>