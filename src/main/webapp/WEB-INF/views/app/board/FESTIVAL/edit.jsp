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
<div class="wrapper-bbs">
	<table class="bbs-edit">
		<tbody>
			<jsp:include page="/WEB-INF/views/app/board/common/edit/category.jsp" flush="false" />
			<tr>
				<th>제목</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" />
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<jsp:include page="/WEB-INF/views/app/board/common/edit/userName.jsp" flush="false" />
				</td>
				<th>작성일</th>
				<c:choose>
          <c:when test="${homepage.context_path eq 'gw'}">
            <td><form:input path="add_date_sample" cssClass="text" cssStyle="width:30%" maxlength="100" /></td>
          </c:when>
          <c:otherwise>
            <td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
          </c:otherwise>
        </c:choose>
			</tr>
			<tr>
				<th>축제기간</th>
				<td colspan="3">
					<form:checkbox path="imsi_v_1" value="JAN" checked="${fn:contains(board.imsi_v_1, 'JAN') ? 'checked' : ''}" label="1월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="FED" checked="${fn:contains(board.imsi_v_1, 'FED') ? 'checked' : ''}" label="2월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="MAR" checked="${fn:contains(board.imsi_v_1, 'MAR') ? 'checked' : ''}" label="3월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="APR" checked="${fn:contains(board.imsi_v_1, 'APR') ? 'checked' : ''}" label="4월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="MAY" checked="${fn:contains(board.imsi_v_1, 'MAY') ? 'checked' : ''}" label="5월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="JUN" checked="${fn:contains(board.imsi_v_1, 'JUN') ? 'checked' : ''}" label="6월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="JUL" checked="${fn:contains(board.imsi_v_1, 'JUL') ? 'checked' : ''}" label="7월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="AUG" checked="${fn:contains(board.imsi_v_1, 'AUG') ? 'checked' : ''}" label="8월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="SEP" checked="${fn:contains(board.imsi_v_1, 'SEP') ? 'checked' : ''}" label="9월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="OCT" checked="${fn:contains(board.imsi_v_1, 'OCT') ? 'checked' : ''}" label="10월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="NOV" checked="${fn:contains(board.imsi_v_1, 'NOV') ? 'checked' : ''}" label="11월"></form:checkbox>
					<form:checkbox path="imsi_v_1" value="DEC" checked="${fn:contains(board.imsi_v_1, 'DEC') ? 'checked' : ''}" label="12월"></form:checkbox>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="1">
					<form:input path="imsi_v_2" cssStyle="width:90%" cssClass="text"></form:input>
				</td>
				<th>전화번호</th>
				<td colspan="1">
					<form:input path="imsi_v_3" cssStyle="width:30%" cssClass="text"></form:input>
				</td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td colspan="3">
					<form:input path="imsi_v_4" cssStyle="width:37%" cssClass="text"></form:input>
				</td>
			</tr>
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