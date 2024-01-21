<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content=""/>
<meta id="_csrf_header" name="_csrf_header" th:content=""/>
<title>WBuilder - 더블유빌더</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="icon" type="image/x-icon" href="/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/cms/js/design.js"></script>

<script type="text/javascript">
//체크박스 전체선택
function checkAll($this) { 
	$('input:checkbox[name=request_number_arr]').prop('checked', $this.is(':checked'));
}

$(function() {
	//검색버튼
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookReservation').serialize());
	});
	
	//엑셀저장
	$('a#excelDownload').on('click', function(e) {
		$('#untactBookReservation').attr('action', 'excelDownload.do').submit();
		$('#untactBookReservation').attr('action', 'index.do');
		e.preventDefault();
	});
});

//신청 -> 접수버튼
function receiptReservationStep() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('접수할 아이디를 선택해 주세요.');
	} else {
		if(confirm('접수처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'receiptReservationStep.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('접수처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('접수에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

function receiptReservationStepToday() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('접수할 아이디를 선택해 주세요.');
	} else {
		if(confirm('접수처리 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'receiptReservationStepToday.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('접수처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('접수에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

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

//신청 -> 접수버튼 한개
function receiptReservationStepOne(request_number) {
	var ajaxData = {
		'request_number_arr' : request_number
	};
	if(confirm('접수처리 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'receiptReservationStep.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('접수처리 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('접수에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	} 
}

function receiptReservationStepOneToday(request_number) {
	var ajaxData = {
		'request_number_arr' : request_number
	};
	if(confirm('접수처리 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'receiptReservationStepToday.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('접수처리 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('접수에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
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

function randomPasswordToday(passwordCount, nonPasswordCount) {
	if(confirm('비밀번호를 생성하시겠습니까?')) {
		var ajaxData = {
				'passwordCount' : passwordCount,
				'nonPasswordCount' : nonPasswordCount
		};
		
		$.ajax({
			type: "POST",
			url: 'randomPasswordToday.do',
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

//사물함 번호변경
function changeLockerNumber(member_id, locker_number, $this) {

	var unused_locker_number = $this.val();
	
	var ajaxData = {
			'member_id' : member_id,
			'locker_number' : locker_number
	};
	
	if(confirm('사물함 번호를 '+locker_number+'번에서 '+unused_locker_number+'번으로 변경하시겠습니까?')){
		$.ajax({
			type: "POST",
			url: 'changeLockerNumber.do',
			data: {'member_id' : member_id, 'locker_number' : locker_number, 'unused_locker_number':unused_locker_number},
			success: function(response) {
				if(response.valid) {
					alert('변경 되었습니다.');
				} else {
					alert('대기상태의 사물함은 사물함 번호 수정이 불가능합니다.');
				}
				location.reload();
			},
			error : function() {
				alert('사물함 번호 변경에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
	}
}
</script>

<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/ie-old.css"/>
<![endif]-->
</head>
<body>
	<!--해당 화면만 대구 및 경북에 사용을 위해 스타일을 별도로 빼지 않음-->
	<style>
	/*비대면관련 스타일*/
	.wrapper {overflow:hidden;}
	.wrapper.wrapper-white {padding:0;margin:0;}
	.wrapper.wrapper-white .cont-box::after {
		content: '';
		display: block;
		width: 100%;
		clear: both;
	}
	.wrapper.wrapper-white .cont-box {
		width: 100%;
		padding: 0 20px;
		box-sizing:border-box;
	}
	.wrapper.wrapper-white .cont-box .locker-box-wrap{
		position:relative;
		float:left;
		width: 40%;
		background:#eee;
		margin: 0;
		padding:13px 7px 7px 13px;
		box-sizing: border-box;
	}
	.wrapper.wrapper-white .cont-box .untact-box {
		float:left;
		width: 60%;
		padding-left:20px;
		box-sizing:border-box;
	}
		
	.untact-box tbody td {height:45px;line-height:45px;}
	.locker-box {box-sizing:border-box;overflow-y:auto;}
	.locker-box ul {font-size:0;overflow:hidden;}
	.locker-box li {position:relative;margin-right:6px !important;margin-bottom:6px !important;display:inline-block;background:#fff;height:145px;padding:0;margin:0;border:1px solid #ccc;box-sizing:border-box;border-radius:5px;}
	.locker-box li p {display:block;box-sizing:border-box;text-align:center;}
	.locker-box li p.locknumber {position:absolute;top:10px;left:10px;font-size:12px;color:#fff;font-weight:bold;background:#223c63;border-radius:50%;width:27px;height:27px;line-height:27px;}
	.locker-box li p.name {font-size:15px;color:#333;text-align:center;margin-top:70px;}
	.locker-box li.divide2 {width:calc(50% - 6px);}
	.locker-box li.divide3 {width:calc(33.33333333333% - 6px);}
	.locker-box li.divide4 {width:calc(25% - 6px);}
	.locker-box li.divide5 {width:calc(20% - 6px);}
	.locker-box li.notuse {background:#2e2e2e url('/resources/common/img/locker-no-bg.png') no-repeat center center;}
	.locker-box li.use {background:#BDBDBD no-repeat center center;}
	a.btnuntact {border-radius:0;padding:7px 10px;}

	@media all and (max-width:1280px){
		.locker-box, .untact-box {max-height:720px;}
		.locker-box li {height:180px;line-height:180px;}
	}

	@media all and (max-width:1024px){
		.locker-box, .untact-box {max-height:600px;}
		.locker-box li {height:150px;line-height:150px;}
	}

	@media all and (max-width:768px){
		.locker-box{width:100%;float:none;}
		.wrapper.wrapper-white .cont-box .untact-box {
			width:100%;
			margin:0 0 30px;
		}
		.wrapper.wrapper-white .cont-box .locker-box-wrap {
			width:100%;
			margin:0;
		}
	}

	@media all and (max-width:600px){
		.locker-box, .untact-box {max-height:520px;}
		.locker-box li {height:130px;line-height:130px;}
	}

	@media all and (max-width:425px){
		.locker-box, .untact-box {max-height:480px;}
		.locker-box li {height:120px;line-height:120px;}
	}

	@media all and (max-width:330px){

	}
	
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

	<div id="wrap">
		<div id="container">
			<form:form id="untactBookReservation" modelAttribute="untactBookReservation" method="POST" action="index.do">
			<form:hidden id="homepage_id" path="homepage_id"/>
			<div class="wrapper wrapper-white">

				<div class="cont-box">
					<div class="locker-box-wrap">
						<div class="locker-box">
							<ul>
								<c:choose>
									<c:when test="${untactBookSetting.locker_type eq 'R'}">
										<!-- 3 x n 으로 혹은 4 x n으로 갈떄 CLASS를 divide3 혹은 divide4 등으로 주면 됩니다. 즉 3xn하면 divide3, 4xn하면 divide4 -->
										<!-- 가로 -->
										<c:forEach var="i" varStatus="status" items="${untactLockerSettingList}">
										<li class="divide${untactBookSetting.row_count} <c:if test="${i.locker_type eq '사용안함'}">notuse</c:if>
										<c:if test="${i.reservation_step eq '1' || i.reservation_step eq '2' || i.reservation_step eq '3'}">use</c:if>">
											<p class="locknumber">${i.locker_number}</p>
											<p class="name">
												<c:choose>
												<c:when test="${i.locker_type eq '사용안함'}">&nbsp;</c:when>
												<c:otherwise>${i.locker_type}</c:otherwise>
												</c:choose>
											</p>
										</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<!-- 세로 -->
										<c:forEach var="j" varStatus="status" begin="0" end="${quotient-1}">
											<c:forEach var="i" varStatus="status" items="${untactLockerSettingList}" begin="${j}"  step="${quotient}">
											<li class="divide${untactBookSetting.row_count} <c:if test="${i.locker_type eq '사용안함'}">notuse</c:if>
											<c:if test="${i.reservation_step eq '1' || i.reservation_step eq '2' || i.reservation_step eq '3'}">use</c:if>">
												<p class="locknumber">${i.locker_number}</p>
												<p class="name">
												<c:choose>
												<c:when test="${i.locker_type eq '사용안함'}">&nbsp;</c:when>
												<c:otherwise>${i.locker_type}</c:otherwise>
												</c:choose>
											</p>
											</li>
											</c:forEach>
											<br>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
						<!--수성도서관
						<div class="locker-box">
							<ul>
								<li class="divide4">
									<p class="locknumber">1</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">2</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">9</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">10</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4 notuse">
									<p class="locknumber" style="background:#2e2e2e;">&nbsp;</p>
									<p class="name">&nbsp;</p>
								</li>
								<li class="divide4 notuse">
									<p class="locknumber" style="background:#2e2e2e;">&nbsp;</p>
									<p class="name">&nbsp;</p>
								</li>
								<li class="divide4">
									<p class="locknumber">11</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">12</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4 notuse">
									<p class="locknumber" style="background:#2e2e2e;">&nbsp;</p>
									<p class="name">&nbsp;</p>
								</li>
								<li class="divide4 notuse">
									<p class="locknumber" style="background:#2e2e2e;">&nbsp;</p>
									<p class="name">&nbsp;</p>
								</li>
								<li class="divide4">
									<p class="locknumber">13</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">14</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">3</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">4</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">15</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">16</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">5</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">6</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">17</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide4">
									<p class="locknumber">18</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide2">
									<p class="locknumber">7</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide2">
									<p class="locknumber">19</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide2">
									<p class="locknumber">8</p>
									<p class="name">도서대출</p>
								</li>
								<li class="divide2">
									<p class="locknumber">20</p>
									<p class="name">도서대출</p>
								</li>
							</ul>
						</div>
						//수성도서관-->
					</div>
					
					<!--좌측-->
					<div class="untact-box">
						<div class="tab">
							<ul class="tabnav">
								<li><a href="/cms/module/untactBook/adminMode/index.do" class="active" style="font-size: 13px;">예약, 대기 항목</a></li>
								<li><a href="/cms/module/untactBook/adminMode/index2.do" style="font-size: 13px;">대출, 만기처리 항목</a></li>
								<li><a href="/cms/module/untactBook/adminMode/index3.do" style="font-size: 13px;">미처리 항목</a></li>
							</ul>
						</div>
						<div style="text-align:right;padding-top:10px;padding-bottom:10px;">
							<c:if test="${authU}">
							<c:choose>
								<c:when test="${untactBookSetting.night_loan_yn eq 'Y'}">
									<a href="javascript:void(0);" class="btn btn1 btnuntact" onclick="randomPasswordToday('${passwordCount}', '${nonPasswordCount}');">비밀번호랜덤생성</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="btn btn1 btnuntact" onclick="randomPassword('${passwordCount}', '${nonPasswordCount}');">비밀번호랜덤생성</a>
								</c:otherwise>
							</c:choose>
							</c:if>
						</div>
						<div class="table-wrap">
							<table class="type1 center">
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="checkbox" onchange="checkAll($(this));"></th>
										<th scope="col">신청자아이디</th>
										<th scope="col">신청자명</th>
										<th scope="col">도서명</th>
										<th scope="col">도서등록번호</th>
										<th scope="col">사물함번호</th>
										<th scope="col">비밀번호</th>
										<th scope="col">관리</th>
										<th scope="col">상태</th>
										<th scope="col">자관/통합 대출가능권수</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${fn:length(untactBookReservationList) < 1}">
									<tr style="height:100%">
										<td colspan="11" style="background:#f8fafb;">비대면 사물함 신청내역이 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
									<tr>
										<td>
											<c:if test="${i.reservation_step eq '1' || i.reservation_step eq '2' || i.reservation_step eq '3'}">
												<form:checkbox path="request_number_arr" id="request_number_arr" cssClass="request_idx" value="${i.request_number}"/>
											</c:if>
										</td>
										<td>${i.member_id}</td>
										<td>${i.member_name}</td>
										<c:choose>
											<c:when test="${fn:length(i.book_name) > 8}">
												<td><a href="javascript:void(0);" id="bookName" onclick="bookName('${i.book_name}');">${fn:substring(i.book_name,0,7)}..</a></td>
											</c:when>
											<c:otherwise>
												<td>${i.book_name}</td>
											</c:otherwise>
										</c:choose>
										<td>${i.reg_no}</td>
										<td>
											<c:choose>
												<c:when test="${(i.reservation_step eq '1' || i.reservation_step eq '2') and authU}">
												<form:select path="locker_number" id="locker_number" data-number="${i.unused_locker_number}" onchange="changeLockerNumber('${i.member_id}', '${i.locker_number}', $(this));">
													<c:forEach var="j" varStatus="status" items="${unusedLockerList}">
														<option value="${j.unused_locker_number}"<c:if test="${i.locker_number eq j.unused_locker_number}">selected</c:if>>${j.unused_locker_number}</option>
													</c:forEach>
												</form:select>
												</c:when>
												<c:otherwise>
												${i.locker_number}
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${i.locker_password eq 0}">
												미등록
												</c:when>
												<c:otherwise>
												${i.locker_password}
												</c:otherwise>
											</c:choose>
										</td>
										<td>
										<div class="button">
										<c:if test="${authU}">
										<c:choose>
											<c:when test="${i.reservation_step eq '1'}">
												<c:choose>
													<c:when test="${untactBookSetting.night_loan_yn eq 'Y'}">
														<a href="javascript:void(0);" id="setBook" class="btn btn1 btnuntact" onclick="receiptReservationStepOneToday('${i.request_number}');">접수</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:void(0);" id="setBook" class="btn btn1 btnuntact" onclick="receiptReservationStepOne('${i.request_number}');">접수</a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${i.reservation_step eq '2'}">
												<a href="javascript:void(0);" id="waitingBook" class="btn btn2 btnuntact" onclick="waitingReservationStepOne('${i.request_number}');">대기</a>
											</c:when>
											<c:when test="${i.reservation_step eq '3'}">
												<a href="javascript:void(0);" id="loanBook" class="btn btn4 btnuntact" onclick="bookReservationOne('${i.request_number}');">대출</a>
												<a href="javascript:void(0);" id="cancelBook" class="btn btn5 btnuntact" onclick="cancelReservationOne('${i.request_number}');">만기</a>
											</c:when>
										</c:choose>
											<a href="javascript:void(0);" id="penaltyBook" class="btn btn5 btnuntact" onclick="blackListSettingEdit('${i.member_id}', '${i.member_name}', '${i.request_number}');">패널티부여</a>
										</c:if>
										</div>
										</td>
										<td>
											<span id="reservationStep">${i.reservation_step_code_name}</span>
										</td>
										<td>
											${i.local_loanable_cnt - i.local_loan_cnt} / ${i.unity_loanable_cnt - i.unity_loan_cnt}
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
						
						<div style="padding-top:10px;">
							<c:if test="${authU}">
							<c:choose>
								<c:when test="${untactBookSetting.night_loan_yn eq 'Y'}">
									<a href="javascript:void(0);" id="receiptReservationStepAll" class="btn btn1 btnuntact" onclick="receiptReservationStepToday();">접수</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" id="receiptReservationStepAll" class="btn btn1 btnuntact" onclick="receiptReservationStep();">접수</a>
								</c:otherwise>
							</c:choose>
							<a href="javascript:void(0);" id="waitingReservationStepAll" class="btn btn2 btnuntact" onclick="waitingReservationStep();">대기</a>
							<a href="javascript:void(0);" id="bookReservationAll" class="btn btn4 btnuntact" onclick="bookReservation();">대출</a>
							<a href="javascript:void(0);" id="cancelReservationAll" class="btn btn5 btnuntact" onclick="cancelReservation();">만기</a>
							</c:if>
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
						
						<div class="ui-state-highlight">
							<em>* 패널티 부여는 비대면 블랙리스트관리에서 확인 하실수 있습니다.</em>
						</div>
						
					</div>
					<!--좌측-->
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>	