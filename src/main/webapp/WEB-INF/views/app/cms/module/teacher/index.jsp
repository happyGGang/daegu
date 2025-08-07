<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#teacherListForm').submit();
	});


	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&teacher_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 강사를 정말 삭제 하시겠습니까?') ) {
			$('#hiddenForm #editMode').val('DELETE');
			$('#hiddenForm #homepage_id').val($(this).attr('keyValue1'));
			$('#hiddenForm #teacher_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
	});

	$('a.dialog-history').on('click', function(e) {
		$('#dialog-2').load('history.do?homepage_id=' + $('#homepage_id_1').val() + '&teacher_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		e.preventDefault();
	});

	$('a.cert-down-btn').on('click', function(e) {
		$('#hiddenForm #homepage_id').val($(this).attr('keyValue1'));
		$('#hiddenForm #teacher_idx').val($(this).attr('keyValue2'));
		$('#hiddenForm').attr('action', 'certDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(e) {
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#teacherListForm').submit();
		}

		e.preventDefault();
	});

});
</script>
<form:form id="hiddenForm" modelAttribute="teacher" action="save.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
</form:form>
<div class="container-box">
    <div class="page-header">
        <div>강사관리</div>
    </div>
    <div class="main-content">
        <form:form id="teacherListForm"  modelAttribute="teacher" action="index.do" style="width:100%;">
<%--	<form:hidden id="homepage_id_1" path="homepage_id"/>--%>
	<c:choose>
		<c:when test="${fn:length(subHomepageList) > 0}">
			도서관 : <form:select id="homepage_id_1" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
		</c:when>
		<c:otherwise>
			<form:hidden id="homepage_id_1" path="homepage_id"/>
		</c:otherwise>
	</c:choose>

	<div class="table-action-wrapper">
        <p class="total-count">총 ${teacherListCount}건</p>
        <div class="btn-wrapper">
            <c:if test="${authC}">
                <a href="" class="icon-btn navy" id="dialog-add" >
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>등록</div>
                </a>
            </c:if>
            <div>
                <a href="#" id="excelDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/excel.svg" alt="">
                    <div>엑셀저장</div>
                </a>
                <a href="#" id="csvDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/csv.svg" alt="">
                    <div>CSV저장</div>
                </a>
            </div>
        </div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="custom-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>강사명</th>
				<th>성별</th>
				<th>전화번호</th>
				<th>휴대전화번호</th>
				<th>첨부파일</th>
				<th>이력</th>
				<th>신청일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${teacherList}">
				<tr>
					<td>${teacher.listRowNum - status.index}</td>
					<td>${i.teacher_name}</td>
					<td>${i.teacher_sex}</td>
					<td>${i.teacher_phone}</td>
					<td>${i.teacher_cell_phone}</td>
					<td>
						<c:if test="${i.org_file_name ne null and i.org_file_name ne ''}">
							<a href="/cms/module/teacher/download/${i.homepage_id}/${i.teacher_idx}.do"><i class="fa fa-floppy-o"></i> ${i.org_file_name}</a>
						</c:if>
					</td>
					<td>
						<a href="" class="custom-btn dialog-history" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">이력</a>
						<a href="" class="custom-btn btn1 cert-down-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">경력증명서</a>
					</td>
					<td>${i.add_date}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="custom-btn dialog-modify" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="custom-btn delete-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${teacherListCount eq 0}">
				<tr>
					<td colspan="10">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#teacherListForm"/>
	</jsp:include>
            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="TEACHER_NAME">강사명</form:option>
                        <form:option value="TEACHER_CELL_PHONE">휴대전화번호</form:option>
                    </form:select>
                    <form:input path="search_text" cssClass="custom-search"/>
                    <div id="search_btn" class="icon-btn black">
                        <img alt="" src="/resources/cms/img/main/search.svg">
                        <div>검색</div>
                    </div>
                </fieldset>
            </div>
</form:form>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="강사 정보"></div>
<div id="dialog-2" class="dialog-common" title="강사 이력"></div>