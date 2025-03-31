<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
// 	$('input#secret_yn_yes').on('click', function() {
// 		$('input#user_phone').prop('disabled', false);
// 	});

// 	$('input#secret_yn_no').on('click', function() {
// 		$('input#user_phone').prop('disabled', true);
// 		$('input#user_phone').val('');
// 	});

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
<div class="rsv-info"></div>
<div class="board-scroll">
	<div class="wrapper-bbs">
		<table class="bbs-edit">
		<caption>시 낭송 글쓰기 내용 입력</caption>
			<tbody>
				<jsp:include page="/WEB-INF/views/app/board/common/edit/notice.jsp" flush="false" />
				<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
				<input type="hidden" name="secret_yn" value="Y"/>
				<tr>
					<th>낭송 시 제목</th>
					<td>
						<form:select path="title" cssClass="selectmenu">
							<form:option value="박인환">박인환</form:option>
							<form:option value="기형도">기형도</form:option>
							<form:option value="윤동주">윤동주</form:option>
							<form:option value="이상">이상</form:option>
							<form:option value="이육사">이육사</form:option>
							<form:option value="김소월">김소월</form:option>
						</form:select>
					</td>
					<th>작성자</th>
					<td>
						<jsp:include page="/WEB-INF/views/app/board/common/edit/userName.jsp" flush="false" />
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<form:input path="user_phone" cssClass="text" />
					</td>
					<th>작성일</th>
					<td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<th>연령대</th>
					<td>
						<form:select path="imsi_v_2" cssClass="selectmenu">
							<form:option value="성인">성인</form:option>
							<form:option value="청소년">청소년</form:option>
							<form:option value="초등학생">초등학생</form:option>
							<form:option value="영유아">영유아</form:option>
						</form:select>
					</td>
					<th>성별</th>
					<td>
						<form:radiobutton path="imsi_v_1" id="imsi_v_1_man" value="남"/>
						<label for="imsi_v_1_man">남</label>
						<form:radiobutton path="imsi_v_1" id="imsi_v_1_woman" value="여" />
						<label for="imsi_v_1_woman">여</label>
					</td>
				</tr>
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
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>