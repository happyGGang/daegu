<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content=""/>
<meta id="_csrf_header" name="_csrf_header" th:content=""/>
<title>SJS</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
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
$(function() {
	//체크박스 전체선택
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.request_idx').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.request_idx').prop('checked', false);
		}
	});
	
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

//진행상황 변경 버튼
function reservationStepChange(member_id, member_name, reservation_step, request_number, $this) {
	
	var ajaxData = {
		'member_id' : member_id,
		'member_name' : member_name,
		'reservation_step' : reservation_step,
		'request_number' : request_number
	};
	
	if(confirm(reservation_step + ' 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'modifyReservationStep.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert(reservation_step + ' 되었습니다.'); 
					if(reservation_step == '비치') {
						$this.hide();
						$this.parent().children('a#cancelBook').show();
						$this.parent().parent().next().children('#reservationStep').text('비치');
					} 
				} else {
					alert('사물함 비밀번호가 등록되어있지 않습니다. \n\n비밀번호 랜덤생성 버튼을 눌러주세요.');
				}
			},
			error : function() {
				alert(reservation_step + ' 에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
	}
}

//취소버튼
function cancelSettingEdit(member_id, member_name, request_number) {
	if(confirm(member_name + '(' + member_id + ')님의 신청을 취소하시겠습니까?')) {

		var ajaxData = {
			'member_id' : member_id,
			'member_name' : member_name,
			'request_number' : request_number
		};
	
		$.ajax({
			url: 'cancelSettingEdit.do',
			method: 'GET',
			data : ajaxData,
			success: function(html) { 
					modal_layer_add('dialog_layer');
					$('#dialog_layer').html(html);
					
					$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
						resizable: false,
						modal: true,
						title: '신청 취소',
						open: function(){
							$('.ui-widget-overlay').addClass('custom-overlay');
						},
						close: function(){
						},
						buttons: [
							{
								text : '저장',
								'class' : 'btn btn1',
								click : function() {
									cancelSettingSave();
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
						height: 300
					});
			},error: function(html) {
			}
		});
	}
}

//체크박스 전체삭제
function allChange() {
	if($('input:checkbox[name=request_number_arr]:checked').length < 1) {
		alert('삭제할 아이디를 선택해 주세요.');
	} else {
		if(confirm('전체 삭제 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'deleteAll.do',
				data: $('input[name=request_number_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('전체삭제 되었습니다.');
					}
					location.reload();
				},
				error : function() {
					alert('전체 삭제에 실패했습니다.\n\n관리자에게 문의해 주세요.');
				}
			});
		} 
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
					alert(member_name + '(' + member_id + ')님은 이미 페널티가 부여되었습니다.\n\n패널티 부여는 한 아이디당 하루에 한번만 가능합니다.');
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
	/*비대변관련 스타일*/
	.wrapper {overflow:hidden;}
	.wrapper.wrapper-white {padding:0;margin:0;}
	.untact-box tbody td {height:45px;line-height:45px;}
	a.btnuntact {border-radius:0;padding:7px 10px;}
</style>
<div id="wrap">
	<div id="container">
		<form:form id="untactBookReservation" modelAttribute="untactBookReservation" method="POST" action="index.do">
		<form:hidden id="homepage_id" path="homepage_id"/>
		<div class="wrapper wrapper-white">
				<div class="untact-box">
					<div class="ui-state-highlight">
						<em>* 패널티 부여는 비대면 블랙리스트관리에서 확인 하실수 있습니다.</em>
					</div>
					<div class="table-wrap">
						<table class="type1 center">
							<thead>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">번호</th>
									<th scope="col">신청자아이디</th>
									<th scope="col">대출번호</th>
									<th scope="col">신청자명</th>
									<th scope="col">신청일</th>
									<th scope="col">도서명</th>
									<th scope="col">관리</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${fn:length(untactBookReservationList) < 1}">
								<tr style="height:100%">
									<td colspan="10" style="background:#f8fafb;">비대면 사물함 신청내역이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach var="i" varStatus="status" items="${untactBookReservationList}">
								<tr>
									<td><form:checkbox path="request_number_arr" cssClass="request_idx" value="${i.request_number}"/></td>
									<td>${paging.listRowNum - status.index}</td>
									<td>${i.member_id}</td>
									<td>${i.reg_no}</td>
									<td>${i.member_name}</td>
									<td>${i.request_date}</td>
									<td>${i.book_name}</td>
									<td>
									<div class="button">
										<a href="javascript:void(0);" id="setBook" class="btn btn1 btnuntact" onclick="reservationStepChange('${i.member_id}', '${i.member_name}', '비치', '${i.request_number}', $(this));" ${i.reservation_step eq '접수'?'':' style="display:none;"'}>비치</a>
										<a href="javascript:void(0);" id="cancelBook" class="btn btnuntact" onclick="cancelSettingEdit('${i.member_id}', '${i.member_name}', '${i.request_number}');" ${i.reservation_step eq '비치'?'':' style="display:none;"'}>취소</a>
										<a href="javascript:void(0);" id="penaltyBook" class="btn btn5 btnuntact" onclick="blackListSettingEdit('${i.member_id}', '${i.member_name}', '${i.request_number}');">패널티부여</a>
									</div>
									</td>
									<td>
										<span id="reservationStep">${i.reservation_step}</span>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					
					<div style="padding-top:10px;">
						<a href="#" class="btn btn3 btnuntact" id="all-check" keyValue="N">전체선택</a>
						<a href="#" id="deleteAll" class="btn btn4 btnuntact" onclick="allChange();">전체삭제</a>
						<a href="#" id="excelDownload" class="btn btn2 btnuntact">엑셀저장</a>
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
					
				</div>
			</div>
		</form:form>
	</div>
</div>
</body>
</html>	