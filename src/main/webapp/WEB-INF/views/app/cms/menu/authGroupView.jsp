<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('div#dialog_auth').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	        $('button.cancel-btn').focus();
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					doAjaxPost($('form#memberGroupAuth'));
					$(this).dialog('destroy');
				}
			},{
				text: "취소",
				"class": 'btn cancel-btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("div#dialog_auth").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 970,
		height: 600
	});

	<%--체크박스선택--%>
	$('input.checkAll').on('click', function() {
		var $myTr = $(this).parents('tr');
		$($myTr).find('input:checkbox').prop('checked', $(this).is(':checked'));
	});

	$('input.checkBoard, input.checkAccess').on('click', function() {
		var type = $(this).data('checktype');
		$('input.'+type).prop('checked', $(this).is(':checked'));
	});

	$('input#masterCheckR, input#masterCheckU, input#masterCheckC, input#masterCheckD').on('click', function() {
		$('input.'+$(this).attr('id')).prop('checked', $(this).is(':checked'));
	});

	$('input#masterCheck').on('click', function() {
		$('input:checkbox').not(':disabled').prop('checked', $(this).is(':checked'));
	});
	<%-- 체크박스 선택 끝 --%>

});

</script>
<form:form modelAttribute="memberGroupAuth" method="POST" action="/cms/memberGroupAuth/menuSave.do">
<form:hidden path="site_id"/>
<form:hidden path="member_group_idx"/>
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="moduleType"/>
<div id="editDisable" class="disableBox">
	<div class="table-wrap">
		<div class="table-scroll-tmp">
			<table class="type1">
				<colgroup>
					<col width="20%"/>
					<col/>
					<col/>
					<col/>
					<col/>
					<col/>
				</colgroup>
				<thead>
					<tr>
						<th class="width200">그룹명</th>
						<th><input type="checkbox" id="masterCheck"/>전체</th>
						<th><input type="checkbox" id="masterCheckR"/><label for="masterCheckR">조회</label></th>
						<th><input type="checkbox" id="masterCheckC"/><label for="masterCheckC">등록</label></th>
						<th><input type="checkbox" id="masterCheckU"/><label for="masterCheckU">수정</label></th>
						<th><input type="checkbox" id="masterCheckD"/><label for="masterCheckD">삭제</label></th>
					</tr>
				</thead>
				<tbody id="authGroupList" style="height: inherit;">
					<c:set var="module_idx" value="${memberGroupAuth.module_idx}"></c:set>
					<c:set var="menu_idx" value="${memberGroupAuth.menu_idx}"></c:set>
					<c:forEach items="${memberGroupList}" var="i" varStatus="status">
					<tr>
						<th class="width200"><span style="padding-left: ${(i.member_group_depth - 2)*16}px;";>${i.member_group_name}</span></th>
						<td>
							<input type="checkbox" class="checkAll" id="checkAll_${status.index}">
							<label for="checkAll_${status.index}">전체</label>
						</td>
						<td>
							<form:checkbox path="authCodeList" id="checkR_${status.index}" value="${i.member_group_idx}_${menu_idx}_${module_idx}_R" class="masterCheckR"/>
							<label for="checkR_${status.index}">조회</label>
						</td>
						<td>
							<form:checkbox path="authCodeList" id="checkC_${status.index}" value="${i.member_group_idx}_${menu_idx}_${module_idx}_C" class="masterCheckC"/>
							<label for="checkC_${status.index}">등록</label>
						</td>
						<td>
							<form:checkbox path="authCodeList" id="checkU_${status.index}" value="${i.member_group_idx}_${menu_idx}_${module_idx}_U" class="masterCheckU"/>
							<label for="checkU_${status.index}">수정</label>
						</td>
						<td>
							<form:checkbox path="authCodeList" id="checkD_${status.index}" value="${i.member_group_idx}_${menu_idx}_${module_idx}_D" class="masterCheckD"/>
							<label for="checkD_${status.index}">삭제</label>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</form:form>