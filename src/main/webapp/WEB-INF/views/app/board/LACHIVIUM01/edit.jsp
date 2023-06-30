<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<c:if test="${board.editMode eq 'REPLY'}">
		<form:hidden path="group_depth"/>
	</c:if>
	<div class="wrapper-bbs">
		<table class="bbs-edit">
			<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>제목</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" title="제목입력"/>
				</td>
			</tr>
			<tr>
				<th>서브제목</th>
				<td colspan="3">
					<form:input path="imsi_v_1" cssClass="text" cssStyle="width:90%" maxlength="500" title="서브제목입력"/>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<jsp:include page="/WEB-INF/views/app/board/common/edit/userName.jsp" flush="false" />
				</td>
				<th>작성일</th>
				<td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<form:input path="imsi_v_2" cssClass="text" title="기간입력"/>
				</td>
				<th>장소</th>
				<td>
					<form:input path="imsi_v_3" cssClass="text" title="장소입력"/>
				</td>
			</tr>
			<tr>
				<th>작가</th>
				<td>
					<form:input path="imsi_v_4" cssClass="text" title="작가입력"/>
				</td>
				<th>관람료</th>
				<td>
					<form:input path="imsi_v_5" cssClass="text" title="관람료입력"/>
				</td>
			</tr>
			<tr>
				<th>주최</th>
				<td>
					<form:input path="imsi_v_6" cssClass="text" title="주최입력"/>
				</td>
				<th>문의처</th>
				<td>
					<form:input path="imsi_v_7" cssClass="text" title="문의처입력"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="editor">
					<div class="bbs-textarea">
						<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}" title="내용입력"/>
					</div>
				</td>
			</tr>
			<c:if test="${boardManage.file_use_yn eq 'Y'}">
				<tr>
					<td colspan="4" class="file_attach">
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
<div id="addPreview"></div>