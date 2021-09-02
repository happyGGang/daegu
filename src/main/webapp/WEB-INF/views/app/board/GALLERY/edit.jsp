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


	$('input#imsi_v_2').datepicker({
		maxDate: $('input#imsi_v_3').val(),
		onClose: function(selectedDate) {
			$('input#imsi_v_3').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#imsi_v_3').datepicker({
		minDate: $('input#imsi_v_2').val(),
		onClose: function(selectedDate) {
			$('input#imsi_v_2').datepicker('option', 'maxDate', selectedDate);
		}
	});
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
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>제목</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" />
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
				<th>행사일</th>
				<td colspan="3">
					<div class="checkbox-original">
						<form:checkbox id="imsi_v_1" path="imsi_v_1" value="Y"/>
						<label for="imsi_v_1">행사일 사용여부</label>
						<em class="info">체크 시 게시글에 표시됩니다.</em>
					</div>
					<form:input type="text" path="imsi_v_2" cssClass="text ui-calendar"/> ~
					<form:input type="text" path="imsi_v_3" cssClass="text ui-calendar"/>
				</td>
			</tr>
				<c:if test="${sessionScope.member.anonymous}">
					<th>
						<c:if test="${board.editMode eq 'ADD'}">임시 비밀번호</c:if>
						<c:if test="${board.editMode eq 'MODIFY'}">비밀번호 확인</c:if>
					</th>
				</c:if>
				<c:if test="${sessionScope.member.anonymous}">
					<td>
						<form:password path="user_password" cssStyle="width:40%" Class="text" maxlength="20"/>
						<c:if test="${board.editMode eq 'MODIFY'}"><p>글 등록 시 입력한 비밀번호를 입력해주세요.</p></c:if>
					</td>
				</c:if>
			<tr>
				<td colspan="4" class="editor">
					<div class="bbs-textarea">
						<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}"/>
					</div>
				</td>
			</tr>
			<c:if test="${boardManage.file_use_yn eq 'Y'}">
			<tr>
				<td colspan="4" class="file_attach">
					<jsp:include page="/WEB-INF/views/app/board/common/edit/jqueryFileUpload.jsp" flush="false">
						<jsp:param name="formId"  value="#board"/>
					</jsp:include><br/>
					* 가장 먼저 등록된 이미지가 섬네일로 등록되어 보여집니다.<br/>
					* 게시판 본문 내용에 이미지를 추가 하실 경우 첨부파일을 추가 후 '에디터에 넣기' 버튼을 클릭하셔야 게시판 본문에 이미지가 보여집니다.
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