<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
function walkingThruSettingEdit() {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'walkingThruSettingEdit.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '워킹스루 도서대출관리 기본설정',
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
					walkingThruSettingSave();
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
		height: 410
	});
}
</script>

<div class="infodesk">
	<div class="button">
		<a href="javascript:void(0);" class="btn btn5 left" onclick="walkingThruSettingEdit();"><i class="fa fa-plus"></i><span>기본설정</span></a>
	</div>
</div>

<form:form id="walkingThruSetting_1" modelAttribute="walkingThruSetting" method="POST">
<div id="editDisable" class="disableBox">
	<table class="type1 center">
		<thead>
			<tr>
				<th>비밀번호 사용여부</th>
				<th>예약가능시간</th>	
				<th>대출가능시간</th>	
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(walkingThruSettingList) < 1}">
			<tr>
				<td colspan="4" style="background:#f8fafb;">등록된 설정이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${walkingThruSettingList}">
			<tr>
				<c:choose>
					<c:when test="${i.password_yn eq 'Y'}">
						<td>사용함</td>
					</c:when>
					<c:otherwise>
						<td>사용안함</td>
					</c:otherwise>
				</c:choose>
				<td>${i.reservation_time}</td>
				<c:choose>
					<c:when test="${i.loan_time_choice eq 'T'}">
						<td>금일 ${i.loan_time}</td>
					</c:when>
					<c:otherwise>
						<td>익일 ${i.loan_time}</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</form:form>