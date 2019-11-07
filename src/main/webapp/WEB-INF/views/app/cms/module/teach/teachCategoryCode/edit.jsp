<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(document).ready(function() {

	<%--코드등록--%>
	$('span.in_btn > a.new_code_save').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parents('div.item');
		var idx = $('a.new_code_save').index($(this));
		var prevParent = parent.prev().prev('div.item');
		var h4 = $(this).parents('div.acc_content').prev('h4');
		$('input#editMode').val('add');
		$('input#teach_group_id').val(parent.find('input.teach_group_id').val());
		$('input#teach_code_id').val(parent.find('input.teach_code_id').val());
		$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
		$('input#print_seq').val(parent.find('input.print_seq').val());
		
		save('codeSave.do', serializeObject($('#code')), h4);
	});
	
	<%--코드수정--%>
	$('a.code_save').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parents('div.item');
		var h4 = $(this).parents('div.acc_content').prev('h4');
		$('input#editMode').val('modify');
		$('input#teach_group_id').val(parent.find('input.teach_group_id').val());
		$('input#teach_code_id').val(parent.find('input.teach_code_id').val());
		$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
		$('input#print_seq').val(parent.find('input.print_seq').val());
		
		save('codeSave.do', serializeObject($('#code')), h4);
	});
	
	<%--중분류 수정--%>
	$('a.group_save').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parents('div.item');
		$('input#editMode').val('modify');
		$('input#teach_group_id').val(parent.find('input.teach_group_id').val());
		$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
		$('input#remark').val(parent.find('input.remark').val());
		save('groupSave.do', serializeObject($('#code')));
	});
	
	$('select.up_teach_code_id').on('change', function() {
		var teach_code_name = $(this).find('option:selected').text();
		if (confirm('\'' + teach_code_name + '\' 대분류로 이동하시겠습니까?')) {
			up_teach_code_id = $(this).find('option:selected').val();
			var parent = $(this).parents('div.item');
			$('input#editMode').val('modify');
			$('input#teach_group_id').val(parent.find('input.teach_group_id').val());
			$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
			$('input#remark').val(parent.find('input.remark').val());
			$('input#up_teach_code_id').val(parent.find('select.up_teach_code_id option:selected').val());
			save('groupSave.do', serializeObject($('#code')), null, true);
		}
	});
});

</script>


<form:form modelAttribute="code" id="codeEdit" onsubmit="return false;">
<c:forEach var="i" varStatus="status" items="${codeList}">
	<c:if test="${status.first}">
	<div class="item">	
		<label>
			<span>그룹ID :</span>
		</label>
		<input type="text" readonly="readonly" class="i_text teach_group_id" value="${middleGroup.teach_group_id}" />
		<label>
			<span>그룹명 :</span>
		</label>
		<input type="text" class="i_text teach_code_name" value="${middleGroup.teach_code_name}" />
		<label>
			<span>비고 :</span>
		</label>
		<input type="text"  style="width:200px;" class="i_text remark" value="${middleGroup.remark}" /> 
		<label>
			<span>상위 대분류 :</span>
		</label>
		<select class="i_text up_teach_code_id">
			<c:forEach var="j" varStatus="Jstatus" items="${rootGroupList}">
			<option value="${j.teach_code_id}" <c:if test="${j.teach_code_id eq code.teach_code_id}">selected="selected"</c:if>>${j.teach_code_name}</option>
			</c:forEach>
		</select>
		<span class="in_btn"><a href="#" title="코드그룹저장" class="group_save"><img width="88" height="20" src="${getContextPath}/resources/img/wsm/btn_codegrSave.gif" alt="코드그룹저장" /></a></span>
	</div>
	
	<hr class="border" />
	</c:if>
	
	<div class="item">
		<input type="hidden" class="i_text teach_group_id" value="${i.teach_group_id}" />
		<label>
			<span>코드ID :</span>
		</label>
		<input type="text" readonly="readonly" class="i_text teach_code_id" value="${i.teach_code_id}" />
		<label>
			<span>코드명 :</span>
		</label>
		<input type="text" class="i_text teach_code_name" value="${i.teach_code_name}" />
		
		<label>
			<span>순서 :</span>
		</label>
		<input type="text" size="2" class="i_text print_seq" value="${i.print_seq}"/>
		<span class="in_btn">
			<a href="#" title="코드수정" class="code_save"><img width="67" height="20" src="${getContextPath}/resources/img/wsm/btn_codeEdit.gif" alt="코드수정" /></a>
		</span>
		<c:set var="print_seq" value="${i.print_seq}"></c:set>
	</div>
	</c:forEach>
	
	<c:if test="${fn:length(codeList) < 1}">
	<div class="item">	
		<label>
			<span>그룹ID :</span>
		</label>
		<input type="text" readonly="readonly" class="i_text teach_group_id" value="${middleGroup.teach_group_id}" />
		<label>
			<span>그룹명 :</span>
		</label>
		<input type="text" class="i_text teach_code_name" value="${middleGroup.teach_code_name}" />
		<label>
			<span>비고 :</span>
		</label>
		<input type="text"  style="width:200px;" class="i_text remark" value="${middleGroup.remark}" /> 
		<label>
			<span>상위 대분류 :</span>
		</label>
		<select class="i_text up_teach_code_id">
			<c:forEach var="j" varStatus="Jstatus" items="${rootGroupList}">
			<option value="${j.teach_code_id}" <c:if test="${j.teach_code_id eq code.up_teach_code_id}">selected="selected"</c:if>>${j.teach_code_name}</option>
			</c:forEach>
		</select>
		<span class="in_btn"><a href="#" title="코드그룹저장" class="group_save"><img width="88" height="20" src="${getContextPath}/resources/img/wsm/btn_codegrSave.gif" alt="코드그룹저장" /></a></span>
	</div>
	
	<hr class="border" />
	</c:if>
	
	<hr class="border" />
	
	<div class="item">
		<input type="hidden" class="i_text teach_group_id" value="${code.teach_group_id}" />
		<label>
			<span>코드ID :</span>
		</label>
		<input type="text" class="i_text teach_code_id" value="" />
		<label>
			<span>코드명 :</span>
		</label>
		<input type="text" class="i_text teach_code_name" value="" />
		<label>
			<span>순서 :</span>
		</label>
		<input type="text" size="2" class="i_text print_seq" value="${print_seq+10}"/>
		<span class="in_btn">
			<a href="#" title="코드신규등록" class="new_code_save" ><img width="88" height="20" src="/resources/img/wsm/btn_codeNew.gif" alt="코드신규등록" /></a>
		</span>
	</div>
	
</form:form>