<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
//체크박스 전체선택
function checkAll($this) { 
	$('input:checkbox[name=locker_number_arr]').prop('checked', $this.is(':checked'));
}

//사물함 용도변경
function changeStatus($this) {
	var number = $this.data('number');
	var type = $this.val();
	$.ajax({
		type: "POST",
		url: 'save.do',
		data: {'locker_number':number, 'locker_type':type},
		success: function(response) {
			if (response.valid) {
				alert('수정되었습니다.');
			}
		},
		error : function() {
			alert('수정에 실패했습니다.\n\n관리자에게 문의해 주세요.')
		}
	});
}

//체크박스 사물함 용도변경
function allChange() {
	if($('input:checkbox[name=locker_number_arr]:checked').length < 1) {
		alert('수정할 사물함을 선택해 주세요.');
	} else if($('#locker_all_change').val() == '') {
		alert('사물함 용도를 선택해 주세요.');
	} else {
		if(confirm('선택된 사물함들을 수정하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'modifyAll.do',
				data: $('input[name=locker_number_arr], #locker_all_change').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('전체수정 되었습니다.');
					}
					location.reload();
				},
				error : function() {
					alert('전체수정에 실패했습니다.\n\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

function bookSettingEdit() {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'bookSettingEdit.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '비대면 대출 기본설정',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '저장하기',
				'class' : 'btn btn1',
				click : function() {
					bookSettingSave();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 600
	});
}
</script>

<div class="infodesk">
	<div class="button">
		<c:if test="${authC and authU}">
			<a href="javascript:void(0);" class="btn btn5 left" onclick="bookSettingEdit();"><i class="fa fa-plus"></i><span>기본설정</span></a>
		</c:if>
	</div>
</div>

<form:form id="untactLockerSetting_1" modelAttribute="untactLockerSetting" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="homepage_id" path="homepage_id"/>
<form:hidden path="locker_number"/>
<div id="editDisable" class="disableBox">
	<table class="type1 center">
		<thead>
			<tr>
				<th width="20"><input type="checkbox" onchange="checkAll($(this));"></th>
				<th width="30">사물함번호</th>
				<th width="50">사물함용도</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(untactLockerSettingList) < 1}">
			<tr style="height:100%">
				<td colspan="10" style="background:#f8fafb;">기본설정에서 총 사물함 갯수를 설정해주세요.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${untactLockerSettingList}">
			<tr>
				<td width="20"><form:checkbox path="locker_number_arr" value="${i.locker_number}"/></td>
				<td width="30">${i.locker_number}번</td>
				<td width="50">
					<c:choose>
						<c:when test="${authU}">
							<select class="changeStatus" data-number="${i.locker_number}" onchange="changeStatus($(this));">
								<option value="일반사물함" <c:if test="${i.locker_type eq '일반사물함'}">selected</c:if>>일반사물함</option>
								<option value="도서대출" <c:if test="${i.locker_type eq '도서대출'}">selected</c:if>>도서대출</option>
								<option value="사용안함" <c:if test="${i.locker_type eq '사용안함'}">selected</c:if>>사용안함</option>
							</select>
						</c:when>
						<c:otherwise>
							${i.locker_type}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<br>
<c:if test="${authU}">
<div class="ui-state-highlight">
	<em>* 체크박스를 체크하신뒤 변경할 용도를 선택하시고 수정하기 버튼을 누르시면 됩니다.</em>
</div>

<div class="search txt-left" style="margin-top:25px;">
	<fieldset>
		<select id="locker_all_change" name="locker_type">
			<option value="">선택하세요</option>
			<option value="일반사물함">일반사물함</option> 
			<option value="도서대출">도서대출</option>
			<option value="사용안함">사용안함</option>
		</select>
		<button id="search_btn" type="button" onclick="allChange();"><span>수정하기</span></button>
	</fieldset>
</div>
</c:if>
</form:form>