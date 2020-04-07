<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<%@ taglib prefix="customTag" uri="/WEB-INF/config/tld/customTag.tld"%>
<script type="text/javascript">
$(document).ready(function() {

	if ('${board.editMode}' == 'ADD') {
		$('input[name=secret_yn][value=Y]').prop('checked', true);
	}
});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/edit/script.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/edit/terms.jsp" flush="false" />
<form:form modelAttribute="board" action="save.do" method="post" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="group_idx"/>
<form:hidden path="parent_idx"/>
<div class="wrapper-bbs">
	<table class="bbs-edit">
		<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/notice.jsp" flush="false" />
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>작성자</th>
				<td>
					<jsp:include page="/WEB-INF/views/app/board/common/edit/userName.jsp" flush="false" />
				</td>
				<th>작성일</th>
				<td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<c:forEach var="i" varStatus="status" items="${fieldList}">
			<c:if test="${i.board_column ne 'view_count' and !(i.admin_only eq 'Y' and board.parent_idx eq 0) and i.column_type ne 'cate'}">
			<tr>
				<th>${i.board_content}</th>
				<td colspan="3">
				<c:choose>
				<c:when test="${i.column_type eq 'radi'}">
					<customTag:getCodeList attibuteName="codeListByRadio" group_id="${i.code_mapping}"/>
					<form:radiobuttons path="${i.board_column}" items="${codeListByRadio}" itemValue="code_id" itemLabel="code_name" delimiter=" " cssStyle="cursor:pointer;" />
				</c:when>
				<c:when test="${i.column_type eq 'chec'}">
					<customTag:getCodeList attibuteName="codeListByCheckbox" group_id="${i.code_mapping}"/>
					<form:checkboxes path="${i.board_column}" items="${codeListByCheckbox}" itemValue="code_id" itemLabel="code_name" delimiter=" " />
				</c:when>
				<c:when test="${i.column_type eq 'date'}">
					<form:input type="text" path="${i.board_column}" cssClass="text ui-calendar customCalendar" readonly="true"/>
				</c:when>
				<c:when test="${i.column_type eq 'area'}">
					<c:if test="${i.board_column eq 'content'}">
					<div class="bbs-textarea">
					</c:if>
					<form:textarea path="${fn:toLowerCase(i.board_column)}" rows="10" cols="100" cssStyle="width:95%; ${boardManage.editor_use_yn eq 'Y'?' display:none':''}"/>
					<c:if test="${i.board_column eq 'content'}">
					</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<form:input path="${i.board_column}" cssStyle="width:90%;" cssClass="text" />
				</c:otherwise>
				</c:choose>
				</td>
			</tr>
			</c:if>
			</c:forEach>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/ebook.jsp" flush="false" />
			<c:if test="${boardManage.file_use_yn eq 'Y'}">
			<tr>
				<td colspan="4" class="file_attach mmm1">
					<jsp:include page="/WEB-INF/views/app/board/common/edit/jqueryFileUpload.jsp" flush="false">
						<jsp:param name="formId"  value="#board"/>
					</jsp:include>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/board/common/edit/button.jsp" flush="false" />

</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>