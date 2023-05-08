<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('edit.do', $('form#nearbyLibRaffleEditForm').serialize());
	});
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibRaffle.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLibRaffle.end_date}');
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		if('${nearbyLibRaffle.start_date}' == '${nearbyLibRaffle.end_date}'){
			alert('검색일의 시작시간과 종료시간은 같을수 없습니다.');
			return;
		}
		
		doGetLoad('edit.do', $('form#nearbyLibRaffleEditForm').serialize());
	});
});

function nearbyLibRaffle() {
	if('${nearbyLibRaffleCount}' == 0){
		alert('검색결과가 없어 추첨이 불가능합니다.');
	} else {
		if(confirm('검색하신 날짜 ${nearbyLibRaffle.start_date} ~ ${nearbyLibRaffle.end_date}로 추첨을 진행하시겠습니까?')) {
			var raffleCount = parseInt(prompt('추첨할 당첨자 인원을 입력해주세요.')) || -1;
			var totalCount = '${nearbyLibRaffleCount}';
			
			if(raffleCount == 0) {
				alert('숫자(양의 정수)를 입력해주세요.');
				return;
			} else if(parseInt(raffleCount) > parseInt(totalCount)){
				alert('당첨 인원은 추첨인원보다 클수 없습니다.');
				return;
			} else if(raffleCount == -1) {
				return;
			}
			
			var raffleName = prompt('추첨명을 입력해주세요\n미입력시 해당추첨 날짜로 추첨명이 생성됩니다.');
			
			var ajaxData = {
				'start_date' : '${nearbyLibRaffle.start_date}',
				'end_date' : '${nearbyLibRaffle.end_date}',
				'editMode' : 'RAFFLE',
				'win_count' : raffleCount,
				'raffle_name' : raffleName
			};
			
			$.ajax({
				url: 'raffleList.do',
				method: 'GET',
				data : ajaxData,
				success: function(html) { 
					modal_layer_add('dialog_layer');
					$('#dialog_layer').html(html);
					
					$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
						resizable: false,
						modal: true,
						title: '당첨자 리스트',
						open: function(){
							$('.ui-widget-overlay').addClass('custom-overlay');
						},
						close: function(){
							$(this).dialog('close');
							var url = 'index.do';
							var param = 'editMode=ADD';
							alert('추첨이 완료되었습니다. 당첨자 확인 페이지로 이동합니다.');
							doGetLoad(url, param);
						},
						buttons: [
							{
								text : '확인',
								'class' : 'btn btn1',
								click : function() {
									$(this).dialog('close');
								}
							}
						]
					});

					$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
						width: 1200,
						height: 800
					});
				},error: function(html) {
				}
			});
		}
	}
}

function viewMember(member_id) {
	var ajaxData = {
		'member_id' : member_id
	};

	$.ajax({
		url: 'viewMember.do',
		method: 'GET',
		data : ajaxData,
		success: function(html) { 
			modal_layer_add('dialog_layer');
			$('#dialog_layer').html(html);
			
			$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
				resizable: false,
				modal: true,
				title: '내집앞도서관 예약 정보',
				open: function(){
					$('.ui-widget-overlay').addClass('custom-overlay');
				},
				close: function(){
					$(this).dialog('close');
				},
				buttons: [
					{
						text: "확인",
						"class": 'btn btn_round btn_gray',
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});

			$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
				width: 1200,
				height: 800
			});
		},error: function(html) {
		}
	});
}
</script>
<form:form id="nearbyLibRaffleEditForm" modelAttribute="nearbyLibRaffle" method="post" action="edit.do" >
	<div class="search">
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		검색일 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
	</div>
	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${nearbyLibRaffleCount}" pattern="#,###" />건
		<div class="button">
			<a href="javascript:void(0);" class="btn btn5" onclick="nearbyLibRaffle();"><i class="fa fa-plus"></i><span>추첨</span></a>
		</div>
	</div>
	
	<table class="type1 center">
		<colgroup>
			<col width="50"/>
			<col width="29%"/>
			<col width="29%"/>
			<col width="29%">
			<col width="110"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>회원ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${nearbyLibRaffleList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td><a href="javascript:void(0);"  onclick="viewMember('${i.member_id}');">${i.member_id}</a></td>
					<td><a href="javascript:void(0);" onclick="viewMember('${i.member_id}');">${i.name}</a></td>
					<td><a href="javascript:void(0);" onclick="viewMember('${i.member_id}');">${i.member_phone}</a></td>
					<td>
						<a href="javascript:void(0);" class="btn btn1" onclick="viewMember('${i.member_id}');">예약내역보기</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${nearbyLibRaffleCount eq 0}">
				<tr>
					<td colspan="5">추첨할 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#nearbyLibRaffleEditForm"/>
		<jsp:param name="pagingUrl" value="edit.do"/>
	</jsp:include>
</form:form>
<br/>
<div class="ui-state-highlight">
	* 검색된 결과는 이미 내집앞도서관 추첨에 당첨된 회원을 제외하고 나오는 결과입니다.<br/>
	* 검색된 결과에 맞춰 추첨을 진행합니다.
</div>
