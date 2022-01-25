<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
function cancelReserve(request_number) {
	if(confirm('예약 취소 하시겠습까?')) {
		var ajaxData = {
				'request_number' : request_number
		};
		
		$.ajax({
			type: "POST",
			url: 'cancelReserve.do',
			data: ajaxData,
			success:  function(response) {
				if(response.valid) {
					alert('예약 취소 되었습니다.');
				}
				location.reload();
			},error: function() {
				alert('예약 취소에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
	}
}

function cancelDetail(request_number, member_id, member_name, cancel_reason) {
	alert(cancel_reason + '로 인한 예약취소 입니다.');		
}

function qrCode(locker_password) {

	var ajaxData = {
			'locker_password' : locker_password
	};
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'untactBookQrCode.do',
		method: 'GET',
		data: ajaxData,
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
 			alert('비밀번호 불러오기에 실패 하셨습니다. \n\n관리자에게 문의해 주세요.');
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '사물함 비밀번호 QRCode',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
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
		width: 400,
		height: 510
	});
}
</script>

<form:form modelAttribute="untactBookReservation" method="POST" action="index.do">
<form:hidden id="homepage_id" path="homepage_id"/>
<form:hidden path="menu_idx"/>
<div class="book-list" style="border-top:none;">

	<c:if test="${fn:length(untactBookReservationList) < 1 }"> <h3 style="margin-top:0;">비대면도서대출 내역이 없습니다.</h3></c:if>
	
	<table summary="신청정보">
		<thead>
			<th style="width:6%">순번</th>
			<th style="width:12%">신청일</th>
			<th style="width:8%">예약상태</th>
			<th style="width:16%">책이름</th>
			<th style="width:6%">상태</th>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
			<tr>
				<td>${paging.listRowNum - status.index}</td>
				<td>${i.request_date}</td>
				<td>${i.reservation_step}</td>
				<td>${i.book_name}</td>
				<td>
					<c:choose>
						<c:when test="${i.cancel_yn eq 'Y'}">
						예약취소
						<a href="#" class="btn reserveCancel" onclick="cancelDetail('${i.request_number}','${i.member_id}','${i.member_name}','${i.cancel_reason}')">취소사유</a>
						</c:when>
						<c:otherwise>
						예약중
						<a href="#" class="btn reserveCancel" onclick="cancelReserve('${i.request_number}','${i.member_id}','${i.member_name}')">예약취소</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#untactBookReservation"/>
	</jsp:include>
</div>

</form:form>
