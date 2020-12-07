<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function() {
	$('#save-btn').on('click', function() {
		<c:if test="${expApply.member_yn eq 'Y'}">
			
		</c:if>
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

		$.ajax({
			url : '/${homepage.context_path}/module/expReservation/save.do',
			async : false,
			data : serializeObject($('#apply_edit')),
			method : 'POST',
			dataType : 'json',
			success : function(data) {
				if(data.valid) {
	                 if(data.message != null && data.message.replace(/\s/g,'').length!=0) {
	                	 alert(data.message);
	                 }
    				if(data.targetOpener) {
    					window.open(data.url, '', 'width=500,height=510');
    					return false;
    				}
					if($('#pageType').val() == 'ajax') {
						$('#tabCon2').load('module/expReservation/index.do?pageType=ajax');
					} else {
						if($('input#editMode').val() == 'ADD'){
							doGetLoad('/${homepage.context_path}/module/expReservation/index.do', '&menu_idx=' + $('#menu_idx').val());
						} else if($('input#editMode').val() == 'MODIFY') {
							doGetLoad('/${homepage.context_path}/module/expReservation/apply.do', '&menu_idx=' + $('#menu_idx').val());
						}
					}
				} else {
	   				if(data.targetOpener) {
						window.open(data.url, '', 'width=500,height=510');
						return false;
					}

					if (data.message != null && data.message.replace(/\s/g, '').length != 0) {
						alert(data.message);
					} else {
						for (var i = 0; i < data.result.length; i++) {
							alert(data.result[i].code);
							$('#' + data.result[i].field).focus();
							break;
						}
					}
				}
			}
		});
	});
	
	$('#cancel-btn').on('click', function() {
		if($('input#editMode').val() == 'ADD'){
			var url = '/${homepage.context_path}/module/expReservation/index.do';
		} else if($('input#editMode').val() == 'MODIFY') {
			var url = '/${homepage.context_path}/module/expReservation/apply.do';
		}
		var formData = serializeParameter(['menu_idx', 'date_type']);
		doGetLoad(url, formData);
	});
	
	// 연락처, 신청인원 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
	<c:if test="${expApply.reservation_type eq 'individual'}">
		$('tr.hidden').hide();
	</c:if>

});
</script>
<form:form modelAttribute="expApply" id="apply_edit" action="/${homepage.context_path}/module/expReservation/save.do" method="post" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="program_list_idx" value="${expApply.program_list_idx}"/>
<form:hidden path="reservation_idx"  value="${expApply.reservation_idx}"/>
<form:hidden path="member_yn" value="${expApply.member_yn}"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pageType"/>

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
			<th>신청구분</th>
			<td>${expApply.reservation_type eq 'individual' ? '개인신청' : '단체신청'}</td>
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
							<span style="font-weight:bold;"> ${totalTeam} / ${expApply.enable_number_of_team}</span><br/>
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
			<th>공지사항 확인</th>
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
		<c:if test="${expApply.member_yn eq 'N' || sessionScope.member.login}">
		<tr>
			<th>아이디</th>
			<td>
				${sessionScope.member.member_id}
			</td>
		</tr>
		</c:if>
		<tr>
			<th>성명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="member_name" class="text" value="${sessionScope.member.member_name}"/>
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
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">
		<c:if test="${expApply.editMode eq 'ADD'}">
			신청하기
		</c:if>
		<c:if test="${expApply.editMode eq 'MODIFY'}">
			수정하기
		</c:if>
	</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>