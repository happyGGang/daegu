<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function checkAll($this) { 
	$('input:checkbox[name=request_number_arr]').prop('checked', $this.is(':checked'));
}

$(function(){
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${checkInOut.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${checkInOut.end_date}');
	
	$('a#excelDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'csvDownload.do').submit();
		e.preventDefault();
	});
	
});

//접수 -> 대기버튼
function waitingReservationStep() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('대기 처리할 아이디를 선택해 주세요.');
	} else {
		if(confirm('대기처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'waitingReservationStep.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('대기처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('대기처리에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

//대기 -> 대출버튼
function bookReservation() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('대출 처리 하실 아이디를 선택해 주세요.');
	} else {
		if(confirm('대출처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'bookReservation.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('대출처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('대출처리에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

//취소버튼
function cancelReservation() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('만기 처리할 아이디를 선택해 주세요.');
	} else {
		if(confirm('만기처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'cancelReservation.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('만기처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('만기처리에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

//접수 -> 대기버튼 한개
function waitingReservationStepOne(request_number) {
	var ajaxData = {
		'request_number_arr' : request_number
	};
	if(confirm('대기처리 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'waitingReservationStep.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('대기처리 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('대기처리에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	} 
}

//대기 -> 대출버튼 한개
function bookReservationOne(request_number) {
	var ajaxData = {
			'request_number_arr' : request_number
	};
	if(confirm('대출처리 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'bookReservation.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('대출처리 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('대출처리에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	} 
}

//취소버튼 한개
function cancelReservationOne(request_number) {
	var ajaxData = {
			'request_number_arr' : request_number
	};
	if(confirm('만기처리 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'cancelReservation.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('만기처리 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('만기처리에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
}

//패널티버튼
function blackListSettingEdit(member_id, member_name, request_number) {
	if(confirm(member_name + '(' + member_id + ')님에 패널티를 부여하시겠습니까?')) {

		var ajaxData = {
			'member_id' : member_id,
			'member_name' : member_name,
			'request_number' : request_number
		};
	
		$.ajax({
			url: 'blackListSettingEdit.do',
			method: 'GET',
			data : ajaxData,
			success: function(html) { 
				if(html == 'penaltyFalse') {
					alert(member_name + '(' + member_id + ')님은 이미 페널티가 부여되었습니다.\n패널티 부여는 한 아이디당 하루에 한번만 가능합니다.');
				} else {
					modal_layer_add('dialog_layer');
					$('#dialog_layer').html(html);
					
					$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
						resizable: false,
						modal: true,
						title: '패널티 부여',
						open: function(){
							$('.ui-widget-overlay').addClass('custom-overlay');
						},
						close: function(){
						},
						buttons: [
							{
								text : '패널티부여',
								'class' : 'btn btn1',
								click : function() {
									blackListSettingSave();
								}
							},
							{
								text: "취소",
								"class": 'btn btn_round btn_gray',
								click: function() {
									$(this).dialog('close');
								}
							}
						]
					});

					$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
						width: 600,
						height: 250
					});
				}
			},error: function(html) {
			}
		});
		
	}
	
}

//비밀번호 랜덤생성 버튼
function randomPassword(passwordCount, nonPasswordCount) {
	if(confirm('비밀번호를 생성하시겠습니까?')) {
		var ajaxData = {
				'passwordCount' : passwordCount,
				'nonPasswordCount' : nonPasswordCount
		};
		
		$.ajax({
			type: "POST",
			url: 'randomPassword.do',
			success: function(html) {
				if(html == 'nonPasswordCheck') {
					alert('비밀번호를 생성할수 없습니다. \n사물함 신청내역이 있을 시에 비밀번호 생성이 가능합니다.');
				}else if(html == 'passwordCheck') {
					alert(passwordCount + '개 모두 이미 비밀번호가 생성되었습니다.');
				} else {
				alert('전체 ' + passwordCount + '개 중 \n 비밀번호 생성이 안된' + nonPasswordCount + '개 비밀번호가 생성되었습니다.');
				location.reload();
				}
			},error: function(html) {
			}
		});
	}
}
</script>

<form:form id="checkInOut" modelAttribute="checkInOut" action="index.do">
	
	<div class="search">
		검색 결과 : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> 건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		체크인 기간 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</div>
	
	<table class="type1 center">
		<colgroup>
 			<col width="50%" />
 			<col width="50%" />
		</colgroup>
		<thead>
			<tr>
				<th>상태</th>
				<th>인원수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>이용완료(체크아웃 완료)</td>
				<td>${checkOutCount}</td>
			</tr>
			<tr>
				<td>이용중(체크인만 완료)</td>
				<td>${checkInCount}</td>
			</tr>
		</tbody>
	</table><br/>
	
	<table class="type1 center">
		<colgroup>
	 			<col width="3%"/>
	 			<col width="10%"/>
	 			<col width="10%"/>
	 			<col width="7%"/>
				<col width="6%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="5%"/>
				<col width="5%"/>
			</colgroup>
		<thead>
			<tr>
				<th></th>
				<th>대출자번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>생일연도</th>
				<th>성별</th>
				<th>지역구</th>
				<th>체크인 시간</th>
				<th>체크아웃 시간</th>
				<th>이용시간</th>
				<th>상태</th>
				<th>방문구분</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${checkInOutList}">
			<tr>
				<td>${paging.listRowNum - status.index}</td>
				<td>${i.user_no}</td>
				<td>${i.member_id}</td>
				<td>${i.member_name}</td>
				<td>${i.member_birth}</td>
				<td>${i.member_sex}</td>
				<td>${i.member_area}</td>
				<td>${i.checkIn_time}</td>
				<td>${i.checkOut_time}</td>
				<td>${i.checkInOut_time}분</td>
				<c:set var="status" value="${i.checkOut_time eq '' || empty i.checkOut_time ? '이용중' : '이용완료'}"/>
				<td>${status}</td>
				<c:set var="gubun" value="${i.gubun eq '1' ? '재방문' : '처음방문'}"/>
				<td>${gubun}</td>
			</tr>
		</c:forEach>
		<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="12">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#checkInOut"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="user_no">대출자번호</form:option>
				<form:option value="member_id">ID</form:option>
				<form:option value="member_name">이름</form:option>
				<form:option value="member_sex">성별</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	
</form:form>