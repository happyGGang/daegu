<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('.search_device').on('change',function(e){
		e.preventDefault();	 
		$('#device_idx').val($('.search_device option:selected').val());
		$('#search_nearbyLib').submit();
	});
	
	$('#manage_code').on('change',function(e){
		$('#viewPage').val(1);
		$('#search_nearbyLib').submit();
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
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [사물함투입]상태로 값을 변경 하시겠습니까?";
			if(Number($(this).attr('keyValue8')) <= 0){
				$('#neighborhoodLibraryEdit #locker_each_idx').val($('#locker_each_idx' + $(this).attr('keyValue7')).val());
			}else{
				$('#neighborhoodLibraryEdit #locker_each_idx').val(Number($(this).attr('keyValue8')));
			}
		}else if($(this).attr('keyValue2') == '4'){
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [대출]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '5'){
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [회수대기]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '6'){
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [회수중]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '7'){
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [회수완료]상태로 값을 변경 하시겠습니까?";
		}else if($(this).attr('keyValue2') == '10'){
			status = "해당기능은 예비기능입니다. 번호 " + $(this).attr('keyValue1') + "번을 [반납완료]상태로 값을 변경 하시겠습니까?";
		}
		
		if (!confirm(status)) {
			return false;
		}
		$('#neighborhoodLibraryEdit #reserve_bundle_idx').val($(this).attr('keyValue6'));
		$('#neighborhoodLibraryEdit #reserve_idx').val($(this).attr('keyValue5'));
		$('#neighborhoodLibraryEdit #device_code').val($(this).attr('keyValue4'));
		$('#neighborhoodLibraryEdit #device_idx').val($(this).attr('keyValue3'));		
		$('#neighborhoodLibraryEdit #reserve_status').val($(this).attr('keyValue2'));
		
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
});
</script>
<style>
.locker_wrap_left{
	background-color: white;
	padding: 39px 26px 26px 26px;
	float:left;
	width:46%;
	height:100%;
}

.locker_wrap_right{
	background-color: white;
    padding: 39px 26px 26px 26px;
	float:right;
	width:46%;
	height:100%;
}
table .type1 td{
	font-size: 12px;
}

</style>
<form:form modelAttribute="nearbyLib" id="neighborhoodLibraryEdit" action="save.do">
	<form:hidden path="reserve_status"/>
	<form:hidden path="reserve_idx"/>
	<form:hidden path="reserve_bundle_idx"/>
	<form:hidden path="device_idx"/>
	<form:hidden path="device_code"/>
	<form:hidden path="locker_each_idx"/>
</form:form>

<form:form modelAttribute="nearbyLib" id="search_nearbyLib" action="today_inOut.do">
<%-- 	<form:hidden path="device_idx"/> --%>
	<div class="">
			<h3>대출관리(투입/회수목록)</h3><br/>
			<c:if test="${asideHomepageId eq 'h45'}">
				도서관 :
				<form:select id="manage_code" path="manage_code">
					<form:option value="">전체</form:option>
					<form:option value="CA">동구통합 안심도서관</form:option>
					<form:option value="CB">동구통합 신천도서관</form:option>
				</form:select>
			</c:if>
			<c:if test="${asideHomepageId eq 'h90'}">
				도서관 :
				<form:select id="manage_code" path="manage_code">
					<form:option value="">전체</form:option>
					<form:option value="AA">대구2·28기념학생도서관</form:option>
					<form:option value="BA">북구구수산도서관</form:option>
					<form:option value="AH">대구광역시립 동부도서관</form:option>
					<form:option value="CA">동구통합 안심도서관</form:option>
					<form:option value="CB">동구통합 신천도서관</form:option>
				</form:select>
			</c:if>
			사물함 명 : 
			<form:select class="search_device" style="width:300px" path="device_idx">
				<c:forEach var="i" items="${deviceList}">
					<option value="${i.device_idx}"<c:if test="${i.device_idx eq nearbyLib.device_idx }">selected="selected"</c:if>>${i.device_name}</option>
				</c:forEach>
			</form:select>
		</div>
	<div style="width:100%; height:100%;">
		<div class="locker_wrap_left">
			<table class="type1 center">
					<colgroup>
						<col width="30" />
						<col width="60" />
						<col width="100" />
						<col width="150" />
						<col width="120" />
						<col width="90" />
						<col width="90" />
						<col width="90" />
						<col width="90" />
						<col width="80" />
						<col width="80" />
					</colgroup>
					<thead>
						<tr>
							<th colspan="11" style="height: 36px;">
							반출 목록<br/>
							${start_time} ~ ${end_time }
							</th>						
						</tr>
						<tr style="outline:white 1px solid">
							<th>번호</th>
							<th>사물함번호</th>
							<th>예약번호</th>
							<th>도서명</th>
							<th>소장도서관</th>
							<th>등록번호</th>
							<th>청구기호</th>
							<th>대출자ID</th>
							<th>예약날짜</th>
							<th>예약확정일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${outCount > 0}">
						<c:forEach var="j" items="${outList}" varStatus="status">
							<tr>
								<td>${outCount - status.index}</td>
								<td>${j.locker_idx}</td>
								<td>${j.pk}</td>
								<td>${j.book_name}</td>
								<td>${j.lib_name}</td>
								<td>${j.reg_no}</td>
								<td>${j.call_no}</td>
								<td>${j.member_id}</td>
								<td><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd" /></td>
								<td><fmt:formatDate value="${j.lend_date}" pattern="yyyy.MM.dd" /></td>
								<td>
									<c:if test="${j.reserve_status eq '1'}">
										<a href="#" class="btn reserve_save" keyValue1="${outCount - status.index}" keyValue2="2" keyValue3="${j.reserve_bundle_idx }" keyValue4="${j.device_idx}" keyValue5="${j.device_code }" keyValue6="${j.reserve_idx }">예약확정</a>
									</c:if>
									<c:if test="${j.reserve_status eq '2'}">
										<p>예약확정</p>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${outCount <= 0 }">
							<tr>
								<td colspan=10>반출 데이터가 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
		</div>
		<div class="locker_wrap_right">
			<table class="type1 center">
					<colgroup>
						<col width="30" />
						<col width="60" />
						<col width="100" />
						<col width="150" />
						<col width="120" />
						<col width="90" />
						<col width="90" />
						<col width="90" />
						<col width="90" />
						<col width="80" />
					</colgroup>
					<thead>
						<tr>
							<th colspan="11" style="height: 36px;">반입 목록</th>						
						</tr>
						<tr style="outline:white 1px solid">
							<th>번호</th>
							<th>사물함번호</th>
							<th>큰책여부</th>
							<th>도서명</th>
							<th>소장도서관</th>
							<th>등록번호</th>
							<th>대출자ID</th>
							<th>예약날짜</th>
							<th>예약확정일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${inCount > 0}">
						<c:forEach var="k" items="${inList}" varStatus="statusIn">
							<tr>
								<td>${inCount - statusIn.index}</td>
								<td>${k.locker_idx}</td>
								<td>${k.pk}</td>
								<td>${k.book_name}</td>
								<td>${k.lib_name}</td>
								<td>${k.reg_no}</td>
								<td>${k.member_id}</td>
								<td><fmt:formatDate value="${k.add_date}" pattern="yyyy.MM.dd" /></td>
								<td><fmt:formatDate value="${k.lend_date}" pattern="yyyy.MM.dd" /></td>
								<td>
									<c:if test="${k.reserve_status eq '5'}">
										<a href="#" class="btn reserve_edit" keyValue1="${inCount - statusIn.index}" keyValue2="6" keyValue3="${k.device_idx }" keyValue4="${k.device_code}" keyValue5="${k.reserve_idx }" keyValue6="${k.reserve_bundle_idx }">회수중</a>
									</c:if>
									<c:if test="${k.reserve_status eq '6'}">
										<a href="#" class="btn reserve_edit" keyValue1="${inCount - statusIn.index}" keyValue2="7" keyValue3="${k.device_idx }" keyValue4="${k.device_code}" keyValue5="${k.reserve_idx }" keyValue6="${k.reserve_bundle_idx }">회수완료</a>
									</c:if>
									<c:if test="${k.reserve_status eq '7'}">
										<p>회수완료</p>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${inCount <= 0 }">
							<tr>
								<td colspan=10> 반입 데이터가 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
		</div>
	</div>
</form:form>