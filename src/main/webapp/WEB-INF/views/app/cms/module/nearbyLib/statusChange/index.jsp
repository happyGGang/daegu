<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#neighborhoodLibrary').serialize());
	});
	
	$('.selectmenu-search').on('change',function(e){
		$('#viewPage').val(1);
		$('#neighborhoodLibrary').submit();
		e.preventDefault();
	});
	
	$('#manage_code').on('change',function(e){
		$('#viewPage').val(1);
		$('#neighborhoodLibrary').submit();
		e.preventDefault();
	});

	$('.reserve_save').on('click',function(e){
		e.preventDefault();
		if (!confirm('번호 ' + $(this).attr('keyValue1') + '번을 예약확정 하시겠습니까?')) {
			return false;
		}
		$('#neighborhoodLibraryEdit #reserve_idx').val($(this).attr('keyValue6'));
		$('#neighborhoodLibraryEdit #device_code').val($(this).attr('keyValue5'));
		$('#neighborhoodLibraryEdit #device_idx').val($(this).attr('keyValue4'));
		$('#neighborhoodLibraryEdit #reserve_bundle_idx').val($(this).attr('keyValue3'));
		$('#neighborhoodLibraryEdit #reserve_status').val($(this).attr('keyValue2'));
		if (doAjaxPost($('form#neighborhoodLibraryEdit'))) {
			location.reload();
		}
	});	
	
	$('.reserve_edit').on('click',function(e){
		e.preventDefault();
		var status = "default message";
		if($(this).attr('keyValue2') == '3'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [사물함투입]상태로 값을 변경 하시겠습니까?";
			if(Number($(this).attr('keyValue8')) <= 0){
				$('#neighborhoodLibraryEdit #locker_each_idx').val($('#locker_each_idx' + $(this).attr('keyValue7')).val());
			}else{
				$('#neighborhoodLibraryEdit #locker_each_idx').val(Number($(this).attr('keyValue8')));
			}
		}else if($(this).attr('keyValue2') == '4'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [대출]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '5'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [회수대기]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '6'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [회수중]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '7'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [회수완료]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '10'){
			status = "번호 " + $(this).attr('keyValue1') + "번을 [반납완료]상태로 값을 변경 하시겠습니까?";
		}
		
		if (!confirm(status)) {
			return false;
		}
		$('#neighborhoodLibraryEdit #reserve_bundle_idx').val($(this).attr('keyValue6'));
		$('#neighborhoodLibraryEdit #reserve_idx').val($(this).attr('keyValue5'));
		$('#neighborhoodLibraryEdit #device_code').val($(this).attr('keyValue4'));
		$('#neighborhoodLibraryEdit #device_idx').val($(this).attr('keyValue3'));		
		$('#neighborhoodLibraryEdit #reserve_status').val($(this).attr('keyValue2'));
		console.log();
		if (doAjaxPost($('form#neighborhoodLibraryEdit'))) {
			location.reload();
		}
	});
	
	
	$('.reserve_cancel').on('click',function(e){
		$('#dialog-1').load('delete.do?reserve_idx=' + $(this).attr('keyValue1') + '&reserve_status=' + $(this).attr('keyValue2') + '&device_idx=' + $(this).attr('keyValue3') + '&device_code=' + $(this).attr('keyValue4') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		e.preventDefault();
	});

	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLib.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${nearbyLib.end_date}');
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#neighborhoodLibrary').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#neighborhoodLibrary').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
});

function changeStatus(reserve_idx, reserve_status, $this) {

	var reserve_status = reserve_status;
	var change_status = $this.val();
	
	var status = "default message";
	var changeStatus = "default message";
	
	if(reserve_status == '1'){
		status = "예약";
	} else if(reserve_status == '2'){
		status = "예약확정";
	} else if(reserve_status == '3'){
		status = "사물함투입";
	} else if(reserve_status == '4'){
		status = "대출";
	} else if(reserve_status == '5'){
		status = "회수대기";
	} else if(reserve_status == '6'){
		status = "회수중";
	} else if(reserve_status == '7'){
		status = "회수완료";
	} else if(reserve_status == '8'){
		status = "취소";
	} else if(reserve_status == '9'){
		status = "반납";
	} else if(reserve_status == '10'){
		status = "반납완료";
	}
	
	if(change_status == '1'){
		changeStatus = "예약";
	} else if(change_status == '2'){
		changeStatus = "예약확정";
	} else if(change_status == '3'){
		changeStatus = "사물함투입";
	} else if(change_status == '4'){
		changeStatus = "대출";
	} else if(change_status == '5'){
		changeStatus = "회수대기";
	} else if(change_status == '6'){
		changeStatus = "회수중";
	} else if(change_status == '7'){
		changeStatus = "회수완료";
	} else if(change_status == '8'){
		changeStatus = "취소";
	} else if(change_status == '9'){
		changeStatus = "반납";
	} else if(change_status == '10'){
		changeStatus = "반납완료";
	}
	
	var ajaxData = {
		'reserve_idx' : reserve_idx,
		'reserve_status' : change_status
	};

	if(confirm(status + '상태를 ' + changeStatus + '상태로 변경하시겠습니까?')){
		$.ajax({
			type: "POST",
			url: 'index.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('변경 되었습니다.');
				} else {
					alert(response.message);
				}
				location.reload();
			},
			error : function() {
				alert('대출상태 변경에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
}
</script>
<form:form modelAttribute="nearbyLib" id="neighborhoodLibraryEdit" action="save.do">
	<form:hidden path="reserve_status"/>
	<form:hidden path="reserve_idx"/>
	<form:hidden path="reserve_bundle_idx"/>
	<form:hidden path="device_idx"/>
	<form:hidden path="device_code"/>
	<form:hidden path="locker_each_idx"/>
</form:form>

<form:form modelAttribute="nearbyLib" id="neighborhoodLibrary" action="index.do" method="GET">
	<div class="search">
		검색 결과 : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> 건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		<br/>
		도서관 :
		<form:select id="manage_code" class="selectmenu" path="manage_code">
			<form:option value="">전체</form:option>
			<form:option value="AA">대구2·28기념학생도서관</form:option>
			<form:option value="BA">북구구수산도서관</form:option>
			<form:option value="AH">대구광역시립 동부도서관</form:option>
			<form:option value="CA">동구통합 안심도서관</form:option>
			<form:option value="CB">동구통합 신천도서관</form:option>
		</form:select>
		
		장비명 : 
		<form:select class="selectmenu-search" style="width:300px" path="device_idx">
			<c:forEach var="j" varStatus="status" items="${deviceList}">
				<option value="${j.device_idx}" <c:if test="${j.device_idx eq nearbyLib.device_idx }">selected="selected"</c:if>>${j.device_name}</option>
			</c:forEach>
		</form:select>
		
		대출상태 : 
		<form:select class="selectmenu-search" style="width:150px;" path="reserve_status">
			<form:option value="" label="전체"/>
			<form:option value="1" label="예약"/>
			<form:option value="2" label="예약확정"/>
			<form:option value="3" label="사물함투입"/>
			<form:option value="4" label="대출"/>
			<form:option value="5" label="회수대기"/>
			<form:option value="6" label="회수중"/>
			<form:option value="7" label="회수완료"/>
			<form:option value="8" label="취소(미승인)"/>
			<form:option value="9" label="반납"/>
			<form:option value="10" label="반납완료"/>
		</form:select>
		
		신청일 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
	</div>
	
	<!-- 운영장비관리 table -->
	<table class="type1 center">
		<colgroup>
 			<col width="3%" />
 			<col width="9%" />
 			<col width="3%" />
 			<col width="4%" />
			<col width="5%" />
			<col width="7%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
		</colgroup>
		<thead>
			<tr>
 				<th>번호</th>			
				<th>소장처</th>
				<th>사물함</th>
				<th>비밀번호</th>
				<th>회원ID</th>
				<th>등록번호</th>
				<th>수령장소</th>
				<th>도서명</th>
				<th>신청날짜</th>
				<th>예약확정시간</th>
				<th>취소여부</th>
				<th>SMS발송여부</th>
				<th>대출상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${reserveList }">
				<tr>
					<td>${paging.listRowNum - status.index}</td>				
					<td>${i.lib_name }</td>
					<td>
					<c:choose>
						<c:when test="${i.locker_idx > 0 }">
							${i.locker_idx }
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
					</td>
					<td>
					<c:choose>
						<c:when test="${i.device_password ne null and i.device_password ne ''}">
							${i.device_password }
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
					</td>
					<td>${i.member_id }</td>
					<td>${i.reg_no }</td>
					<td>${i.device_name }</td>
					<td>${i.book_name }</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" /></td>
					<td>
						<c:choose>
							<c:when test="${i.lend_date eq null or i.lend_date eq ''}">
								-
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd HH:mm" />
							</c:otherwise>					
						</c:choose>					
					</td>
					<td>
						<c:choose>
							<c:when test="${i.cancel_yn eq 'Y'}">
								취소
							</c:when>
							<c:otherwise>
							</c:otherwise>					
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${i.sms_send_yn eq 'Y'}">
								발송완료
							</c:when>
							<c:otherwise>
								미발송
							</c:otherwise>					
						</c:choose>
					</td>
					<td>
						<form:select path="reserve_status" cssClass="selectmenu" onchange="changeStatus('${i.reserve_idx}', '${i.reserve_status}', $(this));">
							<option value="1" <c:if test="${i.reserve_status eq '1'}">selected</c:if>>예약</option>
							<option value="2" <c:if test="${i.reserve_status eq '2'}">selected</c:if>>예약확정</option>
							<option value="3" <c:if test="${i.reserve_status eq '3'}">selected</c:if>>사물함투입</option>
							<option value="4" <c:if test="${i.reserve_status eq '4'}">selected</c:if>>대출</option>
							<option value="5" <c:if test="${i.reserve_status eq '5'}">selected</c:if>>회수대기</option>
							<option value="6" <c:if test="${i.reserve_status eq '6'}">selected</c:if>>회수중</option>
							<option value="7" <c:if test="${i.reserve_status eq '7'}">selected</c:if>>회수완료</option>
							<option value="8" <c:if test="${i.reserve_status eq '8'}">selected</c:if>>취소</option>
							<option value="9" <c:if test="${i.reserve_status eq '9'}">selected</c:if>>반납</option>
							<option value="10"<c:if test="${i.reserve_status eq '10'}">selected</c:if>>반납완료</option>
						</form:select>
					</td>					
				</tr>					
			</c:forEach>
			<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="16">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<select id="statusAll" class="selectmenu">
		<option value="">상태전체</option>
		<option value="1">예약</option>   
		<option value="2">예약확정</option> 
		<option value="3">사물함투입</option>
		<option value="4">대출</option>   
		<option value="5">회수대기</option> 
		<option value="6">회수중</option>
		<option value="7">회수완료</option> 
		<option value="8">취소</option>   
		<option value="9">반납</option>   
		<option value="10">반납완료</option>
	</select>
	<a href="#" id="status-change" class="btn btn1">선택상태변경</a>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#neighborhoodLibrary"/>
	</jsp:include>
	
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
</form:form>

<div class="ui-state-highlight">
	<em>* 홈페이지 상태값만 변경되는 페이지입니다. 자료관리처리는 별도처리가 필요합니다.</em>
</div>

<div id="dialog-1" class="dialog-common" title="예약 취소"></div>