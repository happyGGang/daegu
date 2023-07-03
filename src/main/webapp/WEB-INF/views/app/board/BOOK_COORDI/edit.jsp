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
	<caption>질문과 답변 글쓰기 내용 입력</caption>
		<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/notice.jsp" flush="false" />
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>제목</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" title="제목입력"/>
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
			<c:if test="${boardManage.secret_use_yn eq 'Y'}">
				<c:if test="${board.group_depth > 0}">
				<input type="hidden" name="secret_yn" value="${empty requestBoard.secret_yn ? board.secret_yn : requestBoard.secret_yn}"/>
				</c:if>
				<c:if test="${board.group_depth == 0}">
			<tr>
				<th>비밀글 여부</th>
				<td colspan="3">
					<form:radiobutton path="secret_yn" id="secret_yn_yes" value="Y"/>
					<label for="secret_yn_yes">예</label>
					<form:radiobutton path="secret_yn" id="secret_yn_no" value="N" />
					<label for="secret_yn_no">아니오</label>
				</td>
			</tr>

				</c:if>

			</c:if>
			<c:if test="${!authMBA and ((not empty sessionScope.board and sessionScope.board eq 'o') or board.add_id eq 'ANONYMOUS') and board.editMode ne 'REPLY'}">
			<tr>
				<th>
					<c:if test="${board.editMode eq 'ADD'}">임시 비밀번호</c:if>
					<c:if test="${board.editMode eq 'MODIFY'}">비밀번호 확인</c:if>
				</th>
				<td colspan="3">
					<form:password path="user_password" cssStyle="width:35%" Class="text" maxlength="20"/>
					<c:if test="${board.editMode eq 'MODIFY'}">글 등록 시 입력한 비밀번호를 입력해주세요.</c:if>
				</td>
			</tr>
			</c:if>
			<tr>
				<th>성별</th>
				<td colspan="3"><form:input path="imsi_v_1" cssClass="text"/></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td colspan="3"><form:input path="user_phone" cssClass="text"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3"><form:input path="user_email" cssClass="text"/></td>
			</tr>
			<tr>
				<td colspan="4" class="editor">
					<div class="bbs-textarea">
						<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}" title="qna글쓰기 내용 입력"/>
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