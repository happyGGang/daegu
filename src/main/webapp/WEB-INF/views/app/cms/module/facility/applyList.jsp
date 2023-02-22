<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-3.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 450
	});
 
	$('a.apply-modify-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('editApply.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&facility_idx=' + $(this).attr('keyValue2') + '&facility_req_idx=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	$('a.apply-delete-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 신청자를 정말 삭제 하시겠습니까?') ) {
			$('#facilityApplyListForm #editMode').val('DELETE');
			$('#facilityApplyListForm #homepage_id').val($(this).attr('keyValue1'));
			$('#facilityApplyListForm #facility_idx').val($(this).attr('keyValue2'));
			$('#facilityApplyListForm #facility_req_idx').val($(this).attr('keyValue3'));
			if ( doAjaxPost($('#facilityApplyListForm')) ) {
				$('#dialog-3').load('applyList.do?homepage_id=' + $(this).attr('keyValue1') + '&facility_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}	
		}
	});
	
	$('a.apply-ok-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 신청자를 승인 하시겠습니까?') ) {
			$('#facilityApplyListForm #editMode').val('OK');
			$('#facilityApplyListForm #homepage_id').val($(this).attr('keyValue1'));
			$('#facilityApplyListForm #facility_idx').val($(this).attr('keyValue2'));
			$('#facilityApplyListForm #facility_req_idx').val($(this).attr('keyValue3'));
			if ( doAjaxPost($('#facilityApplyListForm')) ) {
				$('#dialog-3').load('applyList.do?homepage_id=' + $(this).attr('keyValue1') + '&facility_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}	
		}
	});
	
	$('a.apply-cancel-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 신청자를 취소 하시겠습니까?') ) {
			$('#facilityApplyListForm #editMode').val('CANCEL');
			$('#facilityApplyListForm #homepage_id').val($(this).attr('keyValue1'));
			$('#facilityApplyListForm #facility_idx').val($(this).attr('keyValue2'));
			$('#facilityApplyListForm #facility_req_idx').val($(this).attr('keyValue3'));
			if ( doAjaxPost($('#facilityApplyListForm')) ) {
				$('#dialog-3').load('applyList.do?homepage_id=' + $(this).attr('keyValue1') + '&facility_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}	
		}
	});
	
});

</script>
<form:form id="facilityApplyListForm" modelAttribute="facilityReq" method="post" action="saveApply.do" >
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="facility_req_idx"/>
</form:form>

<table class="type1 center">
	<colgroup>
       	<col width="50" />
       	<col width="80" />
       	<col width="120" />
    	<col width="*"/>
    	<col width="80" />
    	<col width="200" />
    </colgroup>
    <thead>
    	<tr>
    		<th>번호</th>
    		<th>신청자명</th>
    		<th>휴대전화번호</th>
    		<th>사용목적</th>
    		<th>신청상태</th>
			<th>대여장비신청현황</th>
    		<th>기능</th>
    	</tr>
    </thead>
    <tbody>
		<c:choose>
			<c:when test="${fn:length(applyList) > 0}">
				<c:forEach items="${applyList}" var="i" varStatus="status">
    				<tr>
         				<td>${status.count}</td>
			         	<td>${i.apply_name}</td>
			         	<td>${i.apply_phone}</td>
			         	<td>${i.apply_desc}</td>
			         	<td>
			         		<c:choose>
			         			<c:when test="${i.apply_status eq '1'}">신청</c:when>
			         			<c:when test="${i.apply_status eq '2'}">승인</c:when>
			         			<c:when test="${i.apply_status eq '3'}">취소</c:when>
			         		</c:choose>
			         	</td>
						<td>
							<c:forEach var="j" items="${facilityEquipmentList}"  >
								<c:if test="${i.facility_idx eq j.facility_idx}">
									이름 : ${j.equipment_name} 개수 : ${j.equipment_need_cnt} / ${j.equipment_cnt} <br/>
								</c:if>
							</c:forEach>
						</td>
			         	<td>
			         		<c:choose>
			         			<c:when test="${i.apply_status eq '1' or i.apply_status eq '3'}">
			         				<a class="btn btn1 apply-ok-btn" keyValue1="${i.homepage_id}" keyValue2="${i.facility_idx}" keyValue3="${i.facility_req_idx}">승인하기</a>	
			         			</c:when>
			         			<c:when test="${i.apply_status eq '2'}">
			         				<a class="btn btn5 apply-cancel-btn" keyValue1="${i.homepage_id}" keyValue2="${i.facility_idx}" keyValue3="${i.facility_req_idx}">취소하기</a>	
			         			</c:when>
			         		</c:choose>
							<a class="btn apply-modify-btn" keyValue1="${i.homepage_id}" keyValue2="${i.facility_idx}" keyValue3="${i.facility_req_idx}">수정</a>
							<a class="btn apply-delete-btn" keyValue1="${i.homepage_id}" keyValue2="${i.facility_idx}" keyValue3="${i.facility_req_idx}">삭제</a>
						</td>
			        </tr>
    			</c:forEach>	
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="6">조회된 정보가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>    
	</tbody>
</table>

<div id="dialog-4" class="dialog-common" title="블랙리스트 추가"></div>