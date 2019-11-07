<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

$(document).ready(function() {
	$('#tabs').tabs();
	$('.accordion').each(function() {
		$(this).accordion({
			heightStyle: 'content'
		});
	});
	
	<%-- 중분류 등록 --%>
	$('a.new_group_save').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parents('div.item');
		$('input#editMode').val('add');
		$('input#teach_group_id').val(parent.find('input.teach_group_id').val());
		$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
		$('input#up_teach_code_id').val(parent.find('input.up_teach_code_id').val());
		$('input#remark').val(parent.find('input.remark').val());
		
		save('groupSave.do', serializeObject($('#code')), null, true);
	});
	
	<%-- 대분류 등록 --%>
	$('a.rootGroupSave').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parents('div.item');
		$('input#editMode').val('rootGroupAdd');
		$('input#teach_code_id').val(parent.find('input.teach_code_id').val());
		$('input#teach_code_name').val(parent.find('input.teach_code_name').val());
		$('input#print_seq').val(parent.find('input.print_seq').val());
		$('input#remark').val(parent.find('input.remark').val());
		
		save('codeSave.do', serializeObject($('#code')), null, true);
	});
	
	<%-- 대분류 수정 Dialog --%>
	$('ul#rootGroup > li > a').on('dblclick', function(e) {
		e.preventDefault();
		if ($(this).attr('id') == 'addRootGroup') {
			return false;
		} else {
			$('input#editMode').val('rootGroupModify');
		}
		$('input#teach_code_id').val($(this).attr('codeId'));
		$formEdit = $('form#code');
		var url = 'rootGroupEdit.do?' + $formEdit.serialize();
		$('div#rootGroupEditDialog > div').load(url, function() {
			rootGroupEditDialog = $('div#rootGroupEditDialog > div').dialog({
				title: '대분류 수정',
				modal: true,
				width: 'auto',
				position : {
					my: 'center',
					at: 'center',
					of: window
				},
				close: function() {
					rootGroupEditDialog.dialog('destroy');
				}
			});
		});
	});
	
	$('h4.middleGroup').on('click', function(e) {
		var url = 'edit.do';
		var param = 'teach_group_id='+$(this).attr('groupId')+'&teach_code_id='+$(this).attr('codeId');
		var body = 'div.content_' + $(this).attr('keyValue');
		doAjaxLoad(body, url, param);
	});
	
// 	$('div.accordion').find('h4:eq(0)').click();
});
function save(url, formData, h4, reload) {
	jQuery.ajaxSettings.traditional = true;
	$.ajax({
        type: "POST",
        url: url,
        data: formData,
        success: function(response){
            if(response.valid) {
				if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
					alert(response.message);
				}
				if (h4 != null) {
					h4.click();
				}
				if (reload) {
					location.reload();
				}
			} else {
                for(var i =0 ; i < response.result.length ; i++) {
					alert(response.result[i].code);
					$('#'+response.result[i].field).focus();
					break;
				}
			}
         },
         error: function(jqXHR, textStatus, errorThrown) {
             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
         }
    });
}
</script>
<!-- Tabs -->
<div id="tabs">
<form:form modelAttribute="code" method="POST" action="">
<form:hidden path="editMode"/>
<form:hidden path="teach_group_id"/>
<form:hidden path="teach_code_id"/>
<form:hidden path="teach_code_name"/>
<form:hidden path="remark"/>
<form:hidden path="up_teach_code_id"/>
<form:hidden path="print_seq"/>
</form:form>
	<ul style="height:28px; " id="rootGroup">
		<c:forEach var="i" varStatus="status" items="${rootGroupList}">
			<li><a href="#tabs-${status.count}" codeId="${i.teach_code_id}">${i.teach_code_name}</a></li>
		</c:forEach>
		<li><a href="#tabs-99" id="addRootGroup" onclick="return false;">+</a></li>
	</ul>
	
	<c:forEach var="i" varStatus="status" items="${rootGroupList}">
		<div id="tabs-${status.count}">
			<div class="accordion">
				<h4>신규 중분류 코드 추가</h4>
				<div class="acc_content">
					<div class="item">
						<input type="hidden" class="i_text up_teach_code_id" value="${i.teach_code_id}" />
						<label>
							<span>중분류ID :</span>
						</label>
						<input type="text" class="i_text teach_group_id" value="" />
						<label>
							<span>중분류명 :</span>
						</label>
						<input type="text" class="i_text teach_code_name" value="" />
						<label>
							<span>비고 :</span>
						</label>
						<input type="text" class="i_text remark" value="" />
						<span class="in_btn">
							<a href="#" title="코드신규등록" class="new_group_save"><img width="88" height="20" src="/resources/img/wsm/btn_codeNew.gif" alt="코드신규등록" /></a>
						</span>
					</div>
				</div>
				<c:forEach var="j" varStatus="Jstatus" items="${middleGroupList}">
				<c:if test="${i.teach_code_id eq j.up_teach_code_id}">
				<h4 class="middleGroup" keyValue="${Jstatus.count}" groupId="${j.teach_group_id}" codeId="${i.teach_code_id}">${j.teach_code_name}</h4>
				<div class="acc_content content_${Jstatus.count}">
				</div>
				</c:if>
				</c:forEach>
			</div>
		</div>
		<c:set var="rootPrintSeq" value="${i.print_seq}"></c:set>
	</c:forEach>

<!-- 	<div id="tabs-2">tabs-2....</div> -->
<!-- 	<div id="tabs-3">tabs-3....</div> -->
	<div id="tabs-99">
	<h4>신규 대분류코드 추가</h4>
		<div class="acc_content">
			<div class="item">
				<label>
					<span>대분류ID :</span>
				</label>
				<input type="text" class="i_text teach_code_id" value="" />
				<label>
					<span>대분류명 :</span>
				</label>
				<input type="text" class="i_text teach_code_name" value="" />
				<label>
					<span>순서 :</span>
				</label>
				<input type="text" class="i_text print_seq" value="${rootPrintSeq+10}" />
				<span class="in_btn">
					<a href="#" title="코드신규등록" class="rootGroupSave"><img width="88" height="20" src="/resources/img/wsm/btn_codeNew.gif" alt="코드신규등록" /></a>
				</span>
			</div>
		</div>
	</div>

<div id="rootGroupEditDialog" style="display: none;">
	<div></div>
</div>