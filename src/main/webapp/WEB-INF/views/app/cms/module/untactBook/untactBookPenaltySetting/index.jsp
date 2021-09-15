<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
/* function edit(){
	modal_layer_add('dialog_layer');
	
	$.ajax({
		url : 'edit.do',
		method : 'GET',
		success : function(html){
			
		}, error : function(html){
		}
		
	});
	
	$(#'dialog_layer').dialog({
		resizable : false,
		modal : true,
		title : '비대면 도서 대출 패널티 설정',
		open : function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		buttons: [
			{
				text : '저장'
				"class" : 'btn btn1',
				click : function(){
					save();
				}
			},
			{
				text : '취소'
				"class" : 'btn',
				click : function(){
					$(this).dialog('close');
				}
			}
		]
	});
	
	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 290,
	});
	
} */
	
	
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지를 선택해주세요.');
			return false;
		} else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}

		e.preventDefault();
	});
	
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue') + '&penalty_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	
	$('a#delete').on('click', function(e) {
		if(confirm('선택된 패널티를 삭제 하시겠습니까?')) {
			$('input#homepage_id_1').val($(this).attr('keyValue'));
			$('input#penalty_idx_1').val($(this).attr('keyValue2'));

			$.ajax({
				url : 'delete.do',
				async : false,
				data : serializeObject($('#PenaltySettingForm')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					} else {
						if ( data.message != null ) {
							alert(data.message);
						} else {
							alert(data.result);
						}
					}
				}
			});
		}

		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('#homepage_id_1').val($(this).val());
			$('#PenaltySettingForm').attr('action', 'index.do');
			doGetLoad('index.do', serializeCustom($('#PenaltySettingForm')));
		}
		e.preventDefault();
	});
	
});

</script>

<form:form modelAttribute="untactBookPenaltySetting" id="PenaltySettingForm" method="POST" action="save.do">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden id="penalty_idx_1" path="penalty_idx"/>

	<div class="infodesk">
		검색 결과 : 총 ${untactBookPenaltySettingCount}건, 홈페이지 ID : ${untactBookPenaltySetting.homepage_id}
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<div class="ui-state-highlight">비대면 사물함 도서 대출 패널티</div>

	<table class="type1 center">
		<thead>
			<tr>
				<th width="5">순번</th>
				<th width="20">시작기간</th>
				<th width="20">종료기간</th>
				<th width="20">패널티횟수</th>
				<th width="20">패널티일수</th>
				<th width="10">사용여부</th>
				<th width="20">최근수정일</th>
				<th width="5">기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${untactBookPenaltySettingList}">
				<tr>
					<td>${untactBookPenaltySetting.listRowNum - status.index}</td>
					<td>${i.start_date}</td>
					<td>${i.end_date}</td>
					<td>${i.penalty_count}</td>
					<td>${i.penalty_day}</td>
					<td>${i.use_yn eq 'Y'?'사용함':'사용안함'}</td>
					<td>${i.save_date}</td>
					<td>
					<c:if test="${authU}">	
						<a href="#" class="btn" id="dialog-modify" keyValue="${i.homepage_id}" keyValue2="${i.penalty_idx}" >수정</a>
					</c:if>
					<c:if test="${authD}">
						<a href="#" class="btn" id="delete" keyvalue="${i.homepage_id}" keyValue2="${i.penalty_idx}" >삭제</a>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(untactBookPenaltySettingList) < 1}">
				<tr style="height:100%">
					<td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#PenaltySettingForm"/>
	</jsp:include>
</form:form>

<div id="dialog-1" class="dialog-common" title="패널티 등록">
</div>
