<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#lockerReqForm').submit();
	});
	
	$('a#dialog-list').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 0) {
			alert('기본설정을 등록해주세요.');
			return;
		}
		
		$('#dialog-2').load('indexApply.do?homepage_id=' + $(this).attr('keyValue2') + '&locker_pre_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
	});
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();		
		$('#dialog-3').load('memberAdd.do?homepage_id=' + $(this).attr('keyValue2') + '&locker_pre_idx=' + $(this).attr('keyValue') + '&locker_idx=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		
	});
	
	$('a#assignCancel').on('click', function(e) {
		if(confirm('해당 사용자의 사물함 배정을 취소하시겠습니까??')) {
			$('#locker_pre_idx').val($(this).attr('keyValue'));
			$('#member_key').val($(this).attr('keyValue2'));
			$('#locker_idx').val($(this).attr('keyValue3'));
			$('#editMode').val("MODIFY");
			$('#lockerReqForm').attr('action','assignmentOne.do');
			doAjaxPost($('#lockerReqForm'));
			$('#lockerReqForm').attr('action','index.do');
			location.reload();
		}
		e.preventDefault();		
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		$('input#homepage_id_1').val($(this).val());
		$('#lockerReqForm').submit();
		
		e.preventDefault();
	});
	
	$('select#locker_pre_idx_1').on('change', function(e) {
		if($(this).val() != '') {
			$('#locker_pre_idx').val($(this).val());
			$('#lockerReqForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form  modelAttribute="lockerReq" id="lockerReqForm" action="index.do" >
	<form:hidden id="homepage_id_1" path="homepage_id"/>
	<form:hidden path="locker_pre_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="member_key"/>
	<form:hidden path="locker_idx"/>

	<div class="search">
		<fieldset>
			<label class="blind">검색</label>			
			<form:select class="selectmenu-search" style="width:200px" id="locker_pre_idx_1" path="locker_pre_idx">
				<option value="">설정을 선택하세요.</option>							
				<c:forEach var="i" varStatus="status" items="${lockerPreList}">
					<option value="${i.locker_pre_idx}" <c:if test="${i.locker_pre_idx eq lockerReq.locker_pre_idx }">selected="selected"</c:if>>${i.locker_pre_name}</option>
				</c:forEach>
			</form:select>
		</fieldset>
	</div>
	<div class="infodesk">
		전체 ${lockerReqCount}건
		<div class="button">
			<a href="" class="btn btn3 left dialog-list" id="dialog-list" keyValue="${lockerReq.locker_pre_idx}" keyValue2="${lockerReq.homepage_id }"><i class="fa fa-plus"></i><span>신청자현황</span></a>
		</div>
	</div>
	<div class="locker_wrap">
		<p class="title">배정 방식 :
		<c:choose>
			<c:when test="${lockerPre.locker_pre_type eq 'SELECT'}">선택배정</c:when>
			<c:when test="${lockerPre.locker_pre_type eq 'FIFO'}">순차배정</c:when>
			<c:when test="${lockerPre.locker_pre_type eq 'RANDOM'}">랜덤배정</c:when>
			<c:when test="${lockerPre.locker_pre_type eq 'LOTTERY'}">추첨배정</c:when>
		</c:choose>
		</p>
		<ul>
			<c:choose>
				<c:when test="${lockerReqCount eq 0}">
					<li class="dataEmpty">등록된 사물함이 없습니다.</li>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" items="${lockerList}" varStatus="status">
					<li>
						<div class="box">
							<div class="box2">
							<p><span>&nbsp;</span></p>
								<div class="info">
									<strong>${i.locker_name}</strong>
									<c:if test="${i.status eq 1}">
										<c:if test="${authC}">
										<a href="" class="btn btn2" id="dialog-add" keyValue="${lockerReq.locker_pre_idx}" keyValue2="${lockerReq.homepage_id }" keyValue3="${i.locker_idx }">비어있음</a>
										</c:if>																		
									</c:if>
									<c:if test="${i.status ne 1}">
										<strong>${i.req_name }</strong>
										<c:if test="${authU or authD}">
										<a href="" class="btn btn5" id="assignCancel" keyValue="${lockerReq.locker_pre_idx}" keyValue2="${i.member_key }" keyValue3="${i.locker_idx }">신청완료</a>
										</c:if>
									</c:if>
								</div>
							</div>
						</div>
					</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</form:form>

<br/>

<c:choose>
	<c:when test="${lockerPre.locker_pre_type eq 'SELECT'}">
		<div class="ui-state-highlight">
			* 선택 배정 : 사용자가 선택하여 신청하고 해당 사물함 즉시 배정 됩니다.
		</div>
	</c:when>
	<c:when test="${lockerPre.locker_pre_type eq 'FIFO'}">
		<div class="ui-state-highlight">
			* 순차 배정 : 사물함 순차, 신청자 순차 방식으로 배정 됩니다.
		</div>
	</c:when>
	<c:when test="${lockerPre.locker_pre_type eq 'RANDOM'}">
		<div class="ui-state-highlight">
			* 랜덤 배정 : 사물함 랜덤, 신청자 랜덤 방식으로 배정 됩니다.
		</div>
	</c:when>
	<c:when test="${lockerPre.locker_pre_type eq 'LOTTERY'}">
		<div class="ui-state-highlight">
			* 추첨 배정 : 사물함 랜덤, 사물함 수 만큼의 선착순 인원에 대하여 랜덤 방식으로 배정 됩니다.
		</div>
	</c:when>
</c:choose>
	
<div id="dialog-2" class="dialog-common" title="신청자현황"></div>
<div id="dialog-3" class="dialog-common" title="미배정 신청자현황"></div>
<div id="dialog-4" class="dialog-common" title="블랙리스트"></div>