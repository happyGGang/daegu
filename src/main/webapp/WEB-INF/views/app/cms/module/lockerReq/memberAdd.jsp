<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#dialog-3').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $(this).dialog('destroy');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 750,
		height: 500
	});
	
	
	$('a#assign').on('click', function(e) {
		
		if(confirm('해당 사용자를 사물함에 배정하시겠습니까?')) {
			$('#unassignList #member_key').val($(this).attr('keyValue'));
			$('#unassignList #req_idx').val($(this).attr('keyValue2'));
			doAjaxPost($('#unassignList'));
// 			$(this).dialog('destroy');
		}
		e.preventDefault();
	});
	
});
</script>
<form:form modelAttribute="lockerReq" id="unassignList" action="assignmentOne.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="member_key"/>
<form:hidden path="req_idx"/>
<form:hidden path="locker_idx"/>
<form:hidden path="locker_pre_idx"/>

<div class="table-wrap">
	<div class="infodesk">
		검색 결과 : 총 ${lockerReqApplyCount}건
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="90"/>
			<col width="160"/>
			<col width="120"/>					
			<col width="120"/>
			<col width=""/>
		</colgroup>
		<thead>
			<tr>
				<th>사물함</th>
				<th>신청자명</th>
				<th>신청자ID</th>
				<th>전화번호</th>
				<th>휴대전화번호</th>				
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${lockerReqApplyList}">
				<c:if test="${fn:length(lockerReqApplyList) < 1}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<tr>
					<td>
						<c:if test="${i.locker_idx eq 0 }">
							대기자
						</c:if>
						<c:if test="${i.locker_idx ne 0 }">
							${i.locker_idx }
						</c:if>
					</td>
					<td>${i.req_name }</td>
					<td>${i.apply_id }</td>
					<td>${i.phone }</td>
					<td>${i.cell_phone }</td>
					<td>
						<a href="" class="btn" id="assign" keyValue="${i.member_key}" keyValue2="${i.req_idx }">선택</a>
						<c:if test="${i.black_count > 0 }">
							<span class="btn" style="color:red;">블랙리스트</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
