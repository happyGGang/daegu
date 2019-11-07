<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function() {
	<%-- 대분류 등록/수정--%>
	$('a.rootGroupSave').on('click', function(e) {
		e.preventDefault();
		save('codeSave.do', serializeObject($('#rootGroupCode')), null, true);
	});
});

</script>

<form:form modelAttribute="code" id="rootGroupCode" onsubmit="return false;" action="codeSave.ws">
<form:hidden path="editMode"/>
<div id="accordionEdit">
<div class="acc_content">
	<div class="item">
		<label>
			<span>대분류ID :</span>
		</label>
		<form:input path="teach_code_id" cssClass="i_text" readonly="true"/>
<%-- 		<input type="text" readonly="readonly" class="i_text teach_code_id" value="${i.teach_code_id}" /> --%>
		<label>
			<span>대분류명 :</span>
		</label>
<%-- 		<input type="text" class="i_text teach_code_name" value="${i.teach_code_name}" /> --%>
		<form:input path="teach_code_name" cssClass="i_text"/>
		<label>
			<span>순서 :</span>
		</label>
		<form:input path="print_seq" cssClass="i_text" size="2"/>
<%-- 		<input type="text" size="2" class="i_text print_seq" value="${i.print_seq}"/> --%>
		<span class="in_btn">
			<c:choose>
			<c:when test="${code.editMode eq 'rootGroupModify'}">
			<a href="#" title="코드수정" class="rootGroupSave"><img width="67" height="20" src="${getContextPath}/resources/img/wsm/btn_codeEdit.gif" alt="코드수정" /></a>
			</c:when>
			<c:otherwise>
			<a href="#" title="코드신규등록" class="rootGroupSave"><img width="88" height="20" src="/resources/img/wsm/btn_codeNew.gif" alt="코드신규등록" /></a>
			</c:otherwise>
			</c:choose>
		</span>
	</div>
</div>
</div>
</form:form>