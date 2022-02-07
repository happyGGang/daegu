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
		doGetLoad('index.do', $('form#walkingThruRecord').serialize());
	});
	
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#walkingThruRecord').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#walkingThruRecord').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#walkingThruRecord').attr('action', 'excelDownload.do').submit();
		$('#walkingThruRecord').attr('action', 'save.do');
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

function bookName(book_name) {
	alert('도서명 : '+book_name);
}
</script>

<style>
.tab{float:left; width:100%;}
	.tabnav{font-size:0; width:100%; margin-bottom: 10px; border:1px solid #ddd; border-top:0; border-right:0;}
	.tabnav li{display: inline-block; height:46px; text-align:center; border-right:1px solid #ddd;}
	.tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:3px; }
	.tabnav li a.active:before{background:#7ea21e;}
	.tabnav li a.active{border-bottom:1px solid #fff;}
	.tabnav li a{ 
		position:relative; 
		display:block; 
		background: #f8f8f8; 
		color: #000; 
		padding:0 30px; 
		line-height:46px; 
		text-decoration:none; 
		font-size:16px;
		border-top:1px solid #ddd;
	}
	.tabnav li a:hover,
	.tabnav li a.active{background:#fff; color:#7ea21e; }
	.tabcontent{padding: 20px; height:244px; border:1px solid #ddd; border-top:none;}
</style>

<form:form id="walkingThruRecord" modelAttribute="walkingThruRecord" method="POST" action="save.do">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="tab">
	<ul class="tabnav">
		<li><a href="/cms/module/walkingThru/walkingThruManage/index.do" class="active" style="font-size: 13px;">신청 항목</a></li>
		<li><a href="/cms/module/walkingThru/walkingThruManage/processedIndex.do" style="font-size: 13px;">대기,대출 처리 항목</a></li>
		<li><a href="/cms/module/walkingThru/walkingThruManage/unprocessedIndex.do" style="font-size: 13px;">미처리 항목</a></li>
	</ul>
</div>
<c:if test="${walkingThruSetting.password_yn eq 'Y'}">
	<div style="text-align:right;padding-top:10px;padding-bottom:10px;">
		<a href="javascript:void(0);" class="btn btn1 btnuntact" onclick="randomPassword('${passwordCount}', '${nonPasswordCount}');">비밀번호랜덤생성</a>
	</div>
</c:if>
<table class="type1 center">
	<thead>
		<tr>
			<th width="20"><input type="checkbox" onchange="checkAll($(this));"></th>
			<th width="40">신청자아이디</th>
			<th width="50">대출번호</th>
			<th width="40">신청자명</th>
			<th width="50">도서명</th>
			<th width="50">도서등록번호</th>
			<c:if test="${walkingThruSetting.password_yn eq 'Y'}">
				<th width="50">비밀번호</th>
			</c:if>
			<th width="50">관리</th>
			<th width="50">상태</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(walkingThruRecordList) < 1}">
		<tr style="height:100%">
			<td colspan="9" style="background:#f8fafb;">비대면 도서대출 신청내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${walkingThruRecordList}">
		<tr>
			<td width="10">
				<c:if test="${i.reservation_step eq '1' || i.reservation_step eq '2' || i.reservation_step eq '3'}">
					<form:checkbox path="request_number_arr" id="request_number_arr" cssClass="request_idx" value="${i.request_number}"/>
				</c:if>
			</td>
			<td width="40">${i.member_id}</td>
			<td width="50">${i.reg_no}</td>
			<td width="40">${i.member_name}</td>
			<c:choose>
				<c:when test="${fn:length(i.book_name) > 8}">
					<td><a href="javascript:void(0);" id="bookName" onclick="bookName('${i.book_name}');">${fn:substring(i.book_name,0,7)}..</a></td>
				</c:when>
				<c:otherwise>
					<td>${i.book_name}</td>
				</c:otherwise>
			</c:choose>
			<td>${i.reg_no}</td>
			<c:if test="${walkingThruSetting.password_yn eq 'Y'}">
			<c:choose>
				<c:when test="${i.password ne 0}">
					<td width="50">${i.password}</td>
				</c:when>
				<c:otherwise>
					<td width="50">없음</td>
				</c:otherwise>
			</c:choose>
			</c:if>
			<td>
			<div class="button">
			<c:choose>
				<c:when test="${i.reservation_step eq '1'}">
					<a href="javascript:void(0);" id="waitingBook" class="btn btn2 btnuntact" onclick="waitingReservationStepOne('${i.request_number}');">대기</a>
				</c:when>
				<c:when test="${i.reservation_step eq '3'}">
					<a href="javascript:void(0);" id="loanBook" class="btn btn4 btnuntact" onclick="bookReservationOne('${i.request_number}');">대출</a>
					<a href="javascript:void(0);" id="cancelBook" class="btn btn5 btnuntact" onclick="cancelReservationOne('${i.request_number}');">만기</a>
				</c:when>
			</c:choose>
				<a href="javascript:void(0);" id="penaltyBook" class="btn btn5 btnuntact" onclick="blackListSettingEdit('${i.member_id}', '${i.member_name}', '${i.request_number}');">패널티부여</a>
			</div>
			</td>
			<td width="50">${i.reservation_step_code_name}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<div style="padding-top:10px;">
	<a href="javascript:void(0);" id="waitingReservationStepAll" class="btn btn2 btnuntact" onclick="waitingReservationStep();">대기</a>
	<a href="javascript:void(0);" id="bookReservationAll" class="btn btn4 btnuntact" onclick="bookReservation();">대출</a>
	<a href="javascript:void(0);" id="cancelReservationAll" class="btn btn5 btnuntact" onclick="cancelReservation();">만기</a>
	<a href="javascript:void(0);" id="excelDownload" class="btn btn2 btnuntact">엑셀저장</a>
</div>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="member_id">신청자아이디</form:option>
			<form:option value="reg_no">대출번호</form:option>
			<form:option value="member_name">신청자명</form:option>
			<form:option value="book_name">도서명</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
	
</form:form>