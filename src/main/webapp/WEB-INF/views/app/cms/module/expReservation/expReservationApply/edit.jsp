<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					<c:if test="${expApply.reservation_type eq 'individual'}">
						$('input#application_people').val('1');
					</c:if>
					<c:if test="${expApply.reservation_type eq 'team'}">
						if( $('input#application_people').val() == '0') {
							$('input#application_people').focus();
							alert('신청인원은 0보다 큰 값을 입력하세요.');
							return false;
						}
					</c:if>
					if(doAjaxPost($('#apply_edit'))) {
						<c:choose>
							<c:when test="${expApply.editMode eq 'ADD'}">
								location.reload();
							</c:when>
							<c:when test="${expApply.editMode eq 'MODIFY'}">
								$(this).dialog('destroy');
								$('#dialog-3').load('/cms/module/expReservation/expReservationApply/applyEdit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&reservation_idx=${expApply.reservation_idx}&program_list_idx=${expApply.program_list_idx}', function(response, status, xhr) {
									$('#dialog-3').dialog('open');
								});
							</c:when>
						</c:choose>
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	// 연락처, 신청인원 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 600
	});
	
	<c:if test="${expApply.reservation_type eq 'individual'}">
		$('tr.hidden').hide();
	</c:if>
});
</script>
<form:form modelAttribute="expApply" id="apply_edit" action="/cms/module/expReservation/expReservationApply/save.do" method="post">
 <form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="program_list_idx"/>
<form:hidden path="reservation_idx"/>
<form:hidden path="member_yn" value="${expApply.member_yn}"/>

<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>프로그램명</th>
			<td>${expApply.program_name}</td>
		</tr>
		<tr>
			<th>비회원 신청여부</th>
			<td>${expApply.member_yn eq 'Y' ? '예' : '아니요'}</td>
		</tr>
		<tr>
		<tr>
			<th>신청구분</th>
			<td>
				${expApply.reservation_type eq 'individual' ? '개인신청' : '단체신청'}
			</td>
		</tr>
		<tr>
			<th>신청현황</th>
			<td>
				총신청인원 ( 신청한 인원 / 최대 가능 인원 ) : 
				<c:choose>
					<c:when test="${expApply.total_people ne 0}">
						<span style="font-weight:bold;"> ${totalPeople eq null or empty totalPeople ? '0' : totalPeople} / ${expApply.total_people}</span><br/>
					</c:when>
					<c:otherwise>
						<span style="font-weight:bold;">제한없음</span><br/>
					</c:otherwise>
				</c:choose>
				<c:if test="${expApply.reservation_type eq 'team'}">
					신청가능팀수 ( 신청한 팀수 / 최대신청가능 팀수 ) : 
					<c:choose>
						<c:when test="${expApply.enable_number_of_team ne 0}">
							<span style="font-weight:bold;"> ${totalTeam eq null or empty totalTeam ? '0' : totalTeam} / ${expApply.enable_number_of_team}</span><br/>
						</c:when>
						<c:otherwise>
							<span style="font-weight:bold";>제한없음</span><br/>
						</c:otherwise>
					</c:choose> 
					팀별 최대신청 인원수 :
					<c:choose>
						<c:when test="${expApply.maximum_people_of_team ne 0}">
							<span style="font-weight:bold;">${expApply.maximum_people_of_team}</span>
						</c:when>
						<c:otherwise>
							<span style="font-weight:bold;">제한없음</span>
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>예약일</th>
			<td>
				<fmt:parseDate value="${expApply.reservation_date}" pattern="yyyyMMdd" var="reservationDate" />
				<fmt:formatDate value="${reservationDate}" pattern="yyyy-MM-dd" />
			</td>
		</tr>
		<tr>
			<th>이용시간</th>
			<td>${expApply.use_time}</td>
		</tr>
		<tr>
			<th>공지사항 확인(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>${expApply.notice}</td>
		</tr>
		<tr>
			<th>
				개인정보 수집 및 이용동의(<span style="color: red; font-weight: bold;">*</span>)
			</th>
			<td>
				${expApply.usage_agreement}<br/><br/>
				<form:checkbox path="usage_agreement_yn" value="Y" label="개인정보 수집 및 이용에 동의합니다."/>
			</td>
		</tr>
		<tr>
			<th>아이디(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="member_id" class="text" />
				<div class="ui-state-highlight">
					<em>* 해당 프로그램이 비회원 신청 가능할 때 아이디가 없다면 입력하지 않으셔도 됩니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="member_name" class="text" />
			</td>
		</tr>
		<tr>
			<th>연락처(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="member_phone" class="text" maxlength="20" numberonly="true" />
			</td>
		</tr>
		<tr>
			<th>이메일(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="member_email" class="text"/>
			</td>
		</tr>
		<tr class="hidden">
			<th>신청인원(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="application_people" class="text" numberonly="true" />
			</td>
		</tr>
		<tr>
			<th>참고사항</th>
			<td>
				<form:textarea path="reference" class="text" cssStyle="width:100%; height: 50px;"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>