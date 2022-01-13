<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('a.modify-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('detail.do', 'editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&teacher_idx=' + $(this).attr('keyValue2') + '&menu_idx=' + $('#teacherListForm #menu_idx').val());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#teacherListForm').submit();
	});
});
</script>
<form:form id="teacherListForm" modelAttribute="teacher" action="index.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="auto-scroll">
		<table class="bbs center">
			<thead>
				<tr>
					<th width="50">번호</th>
					<th class="important">강사명</th>
					<th class="important">과목명</th>
					<th>성별</th>
					<th>국적</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${teacherListCount > 0 }">
						<c:forEach items="${teacherList}" var="i" varStatus="status">
							<tr>
								<td width="50" class="num">${i.teacher_idx}</td>
								<td class="important"><a class="modify-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">${i.teacher_name}</a></td>
								<td class="important">${i.teacher_subject_name}</td>
								<td class="num">${i.teacher_sex}</td>
								<td class="file">${i.teacher_nationality}</td>
							</tr>
						</c:forEach>	
					</c:when>
					<c:otherwise>
					<tr>
						<td colspan="5">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#teacherListForm"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
					<form:option value="TEACHER_NAME">강사명</form:option>
					<form:option value="TEACHER_SEX">성별</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
	</div>
</form:form>