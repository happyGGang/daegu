<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				text: "엑셀저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(applyList)}' > 0) {
						$('#apply_edit2').attr('action', '/cms/module/excursions/apply/excelDownload.do').submit();
// 						$('#apply_edit2').attr('action', '/cms/module/excursions/apply/save.do');	
					} else {
						alert('해당 내역이 없습니다.');	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 900,
		height: 500
	});
	
	//신청자 수정버튼
	$('a#apply-modify').on('click', function(event) {
		$('#dialog-2').load('/cms/module/excursions/apply/edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue') + '&date_type=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		event.preventDefault();
	});
	
	//승인처리 버튼
	$('a#state-modify').on('click', function(event) {
		$('#dialog-4').load('/cms/module/excursions/apply/stateEdit.do?editMode=STATEMODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue')  + '&date_type=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
				
		event.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(event) {
		if(confirm('해당 정보를 삭제 하시겠습니까?')) {
			$('input#editMode').val('DELETE');
			$('input#apply_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#apply_edit2'))) {
				$('#dialog-3').load('/cms/module/excursions/apply/applyEdit.do?editMode=VIEW&homepage_id=' + $('#homepage_id').val() + '&excursions_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('plan_date'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}
		}
		event.preventDefault();
	});
	
});
</script>
<form:form modelAttribute="apply" id="apply_edit2" action="/cms/module/excursions/apply/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="apply_idx"/>
<form:hidden path="date_type"/>
<form:hidden path="isSeoguPrivatetour" value="${isSeoguPrivatetour}"/>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="17%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="12%"/>
			<col width="8%"/>
			<c:if test="${apply.homepage_id eq 'h46' and apply.date_type eq '0002'}">
				<col width="12%"/>
			</c:if>
			<col width="10%"/>
			<c:if test="${isSeoguPrivatetour eq false}">
			<col width="12%"/>
			</c:if>
			<col width=""/>

		</colgroup>
		<thead>
		<tr>
			<c:if test="${isSeoguPrivatetour eq false}">
				<th>기관명</th>
			</c:if>
				<th>신청자 성명</th>
				<th>신청자 전화번호</th>
				<th>방문일자</th>
				<th>방문인원</th>
				<c:if test="${apply.homepage_id eq 'h8'}">
					<th>희망시간</th>
				</c:if>
				<c:if test="${apply.homepage_id eq 'h46' and apply.date_type eq '0002'}">
					<th>생년월일</th>
				</c:if>
				<th>승인여부</th>
				<c:if test="${apply.editMode ne 'VIEW' }">
					<th>신청</th>
				</c:if>
			<c:if test="${isSeoguPrivatetour eq false}">
				<th>첨부파일</th>
			</c:if>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${applyList}">
				<c:if test="${fn:length(applyList) < 1}">
				<tr>
				<c:choose>
					<c:when test="${i.homepage_id eq 'h8'}">
						<td colspan="8">데이터가 존재하지 않습니다.</td>
					
					</c:when>
					<c:otherwise>
						<td colspan="7">데이터가 존재하지 않습니다.</td>
					
					</c:otherwise>
				</c:choose>
				</tr>
				</c:if>
				<tr>
					<c:if test="${isSeoguPrivatetour eq false}">
						<td>${i.agency_name}</td>
					</c:if>
					<td>${i.applicant_name}</td>
					<td>${i.applicant_tel}</td>
					<td>${i.start_date}</td>
					<td>${i.personnel}</td>
					<c:if test="${i.homepage_id eq 'h8'}">
						<td>${i.desired_start_time} ~ ${i.desired_end_time }</td>
					</c:if>
					<c:if test="${apply.homepage_id eq 'h46' and apply.date_type eq '0002'}">
						<td>${i.birth_day}</td>
					</c:if>
					<td>
						<c:set var="apply_state" value="${i.apply_state}" />
						<c:choose>
						    <c:when test="${apply_state eq '3'}">
						        승인
						    </c:when>
						    <c:when test="${apply_state eq '2'}">
						        불가
						    </c:when>
						    <c:otherwise>
						        대기
						    </c:otherwise>
						</c:choose>
					</td>
					<c:if test="${apply.editMode ne 'VIEW' }">
						<td>
							<a href="" class="btn" id="state-modify" keyValue="${i.apply_idx}" keyvalue2="${apply.date_type}">승인처리</a>
							<a href="" class="btn" id="apply-modify" keyValue="${i.apply_idx}" keyvalue2="${apply.date_type}">수정</a>
							<a href="" class="btn" id="delete-btn" keyValue="${i.apply_idx}" plan_date="${i.start_date}">삭제</a>
						</td>
					</c:if>
					<c:if test="${isSeoguPrivatetour eq false}">
					<td>
						<a href="/cms/module/excursions/apply/download/${i.homepage_id}/${i.apply_idx }.do"><i class="fa fa-floppy-o"></i>${i.origin_file_name}</a>
					</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-4" class="dialog-common" title="신청자 승인 처리"/>