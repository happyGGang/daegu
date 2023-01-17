<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	
	$("div.locker_wrap_left").load("deviceOne.do?device_idx=${nearbyLibLocker.device_idx}");
	
	$('.search_device').on('change',function(e){
		e.preventDefault();	 
		$('#lockerSearch #device_idx').val($('.search_device option:selected').val());
		$('#lockerSearch').submit();
	});
	
	$('input#checkAll').on('click', function(e) {
		$('input[type = checkbox].reserve_idx_arr').prop('checked', $(this).is(':checked'));
	});

	$('a.check-save').on('click', function(e) {
		if($('input:checkbox[name = reserve_idx_arr]:checked').length < 1) {
			alert('사물함 자동배정 할 예약 건 수를 체크해주세요.');
			return false;
		}
		
		if (confirm("체크박스 선택으로 사물함 배정은 모두 자동 배정됩니다. 예약 확정 하시겠습니까?")) {
			var checkboxarr = $('input:checkbox[name = reserve_idx_arr]:checked');
			var reserve_idx_arr = "";
			var reserve_idx = "";
			
			checkboxarr.each(function(i) {
				if(i == 0){
					reserve_idx_arr = $(this).val().toString();
				}else{
					reserve_idx_arr = reserve_idx_arr + "_" + $(this).val().toString();
				}
				
			});
			$('#nearbyLibSaveArr #device_idx').val(parseInt($(this).attr('keyValue1')));
			$('#nearbyLibSaveArr #device_code').val($(this).attr('keyValue2'));
			$('#nearbyLibSaveArr #reserve_status').val($(this).attr('keyValue3').toString());
 			$('#nearbyLibSaveArr #reserve_idx_arr').val(reserve_idx_arr.toString());
			
			if(doAjaxPost($('#nearbyLibSaveArr'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a.nearbyLib-save').on('click',function(e){
		e.preventDefault();
		if (confirm("예약번호 " + $(this).attr('keyValue4')+"번을 " + $('#locker_each_idx'+$(this).attr('keyValue2')).val() + "번 사물함에 배정하여 확정 하시겠습니까?")) {
			$('#nearbyLibSave #device_code').val($(this).attr('keyValue7'));
			$('#nearbyLibSave #reserve_bundle_idx').val(parseInt($(this).attr('keyValue6')));
			$('#nearbyLibSave #reserve_status').val($(this).attr('keyValue5'));
			$('#nearbyLibSave #device_idx').val(parseInt($(this).attr('keyValue3')));
 			$('#nearbyLibSave #locker_each_idx').val(parseInt($('#locker_each_idx' + $(this).attr('keyValue2')).val()));
 			$('#nearbyLibSave #reserve_idx').val(parseInt($(this).attr('keyValue1')));
 			
			if(doAjaxPost($('#nearbyLibSave'))) {
 				location.reload();
 			}
		}
	});
	
	$('select.large_book_yn').on('change',function(e){
		e.preventDefault();
		$('#large_book_yn').val($('#large_book_yn'+ $(this).attr('keyValue2')).val());
		$('#reserve_idx').val($(this).attr('keyValue1'));
 		if(doAjaxPost($('#updateBookSize'))) {
 				location.reload();
 			}	
	});

});


</script>
<style>
.locker_wrap_left{
	float:left;
	width:46%;
	min-height: 10px;
}

.locker_wrap_left tr{
	height:50px;	
}
.locker_wrap_right{
	background-color: white;
    padding: 39px 26px 26px 26px;
	float:right;
	width:50%;
	height:100%;
}

table thead th, table tbody td {font-size:12px;}

@media all and (max-width:1280px){
	.locker_wrap_left, .locker_wrap_right {float:none; width:100%;box-sizing:border-box;}

}
</style>

<form id="updateBookSize" action="book_update.do" method="post">
	<input type="hidden" name="reserve_idx" id="reserve_idx"/>
	<input type="hidden" name="large_book_yn" id="large_book_yn"/>
</form>

<form id="nearbyLibSaveArr" action="lockerUpdate.do" method="post">
	<input type="hidden" name="editMode" id="editMode" value="lockerAll"/>
	<input type="hidden" name="device_idx" id="device_idx"/>
	<input type="hidden" name="reserve_status" id="reserve_status"/>
	<input type="hidden" name="reserve_idx_arr" id="reserve_idx_arr"/>
	<input type="hidden" name="device_code" id="device_code"/>
</form>

<form id="nearbyLibSave" action="lockerUpdate.do" method="post">
	<input type="hidden" name="editMode" id="editMode" value="lockerOne"/>
	<input type="hidden" name="device_idx" id="device_idx"/>
	<input type="hidden" name="reserve_status" id="reserve_status"/>
	<input type="hidden" name="reserve_idx" id="reserve_idx"/>
	<input type="hidden" name="locker_each_idx" id="locker_each_idx"/>
	<input type="hidden" name="reserve_idx_arr" id="reserve_idx_arr"/>
	<input type="hidden" name="reserve_bundle_idx" id="reserve_bundle_idx"/>
	<input type="hidden" name="device_code" id="device_code"/>
</form>

<form:form modelAttribute="nearbyLibLocker" id="lockerSearch" action="controll_index.do">
<form:hidden path="device_idx"/>
</form:form>

<form:form modelAttribute="nearbyLibLocker" id="reserveConfig">
	<div class="">
		<h3>대출관리(사물함배정)</h3><br/>
		사물함 명 : 
		<form:select class="search_device" style="width:300px" path="device_idx">
			<c:forEach var="i" varStatus="status" items="${deviceList}">
				<option value="${i.device_idx}"<c:if test="${i.device_idx eq deviceOne.device_idx }">selected="selected"</c:if>>${i.device_name}</option>
			</c:forEach>
		</form:select>
		<div style="float:right;">
			<a href="javascript:void(0);" class="btn check-save" keyValue1="${deviceOne.device_idx}" keyValue2="${deviceOne.device_code }" keyValue3="2">자동 사물함배정</a></br>
		</div>
		<div class="ui-state-highlight" style="float:right;">
			<em>* 체크박스로 선택 후 자동예약은 사물함을 선택했더라도 자동배정 됩니다.</em>
		</div>
	</div>
 	<div class="locker_wrap_left">

	</div>
	<div class="locker_wrap_right">
		<table class="type1 center">
			<colgroup>
				<col width="30" />
				<col width="60" />
				<col width="60" />
				<col width="40" />
				<col width="150" />
				<col width="100" />
				<col width="100" />
				<col width="90" />
				<col width="90" />
				<col width="80" />
				<col width="80" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="11" style="height: 36px;">사물함별 대출정보</th>						
				</tr>
				<tr style="outline:white 1px solid">
					<th><input type="checkbox" id="checkAll"></th>
					<th>번호</th>
					<th>사물함번호</th>
					<th>큰책여부</th>
					<th>도서명</th>
					<th>소장도서관</th>
					<th>등록번호</th>
					<th>대출자ID</th>
					<th>예약확정일</th>
					<th>상태</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${neighborhoodLibraryCount > 0}">
	 			<c:forEach var="i" items="${neighborhoodLibraryList}" varStatus="status"> 
					<tr>
						<td>
							<c:if test="${i.reserve_status eq '2' and i.locker_idx <= 0}">
								<form:checkbox path="reserve_idx_arr" value="${i.reserve_idx}" class="reserve_idx_arr"/>
							</c:if>
						</td>
	 					<td>${neighborhoodLibraryCount - status.index }</td>
						<td>
							<c:choose>
								<c:when test="${i.reserve_status eq '2'}">
									<c:choose>
										<c:when test="${i.locker_idx > 0}">
											${i.locker_idx }
										</c:when>
										<c:otherwise>
											<select class="" style="width:50px" name="locker_each_idx" id="locker_each_idx${status.index + 1}">
												<option value="0"> --</option>
												<c:forEach var="j" items="${lockerOneList}">
													<option value="${j.locker_each_idx }" <c:if test="${j.locker_each_idx eq i.locker_idx }">selected="selected"</c:if>>${j.locker_each_idx }</option>
												</c:forEach>
											</select>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${i.locker_idx > 0}">
											${i.locker_idx }
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>	
								</c:otherwise>
							</c:choose>
							
						</td>
						<td>
							<select style="width:50px" name="large_book_yn" class="large_book_yn" id="large_book_yn${status.index + 1}" keyValue1="${i.reserve_idx }" keyValue2="${status.index + 1}">
								<option value="N" <c:if test="${i.large_book_yn eq 'N' }">selected="selected"</c:if>>X</option>
								<option value="Y" <c:if test="${i.large_book_yn eq 'Y' }">selected="selected"</c:if>>O</option>
							</select>
						</td>
						<td>${i.book_name} </td>
						<td>${i.lib_name} </td>
						<td>${i.reg_no} </td>
						<td>${i.member_id}</td>
						<td>
							<c:choose>
								<c:when test="${i.lend_date ne null and i.lend_date ne '' }">
			 						<fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd" />
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${i.reserve_status eq '1'}">
									예약
								</c:when>
								<c:when test="${i.reserve_status eq '2'}">
									예약확정
								</c:when>
								<c:when test="${i.reserve_status eq '3'}">
									사물함투입
								</c:when>
								<c:when test="${i.reserve_status eq '5'}">
									회수대기
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${i.reserve_status eq '1'}">
<%-- 									<a href="javascript:void(0);" class="btn nearbyLib-save" keyValue1="${i.reserve_idx }" keyValue2="${status.index + 1}" keyValue3="${i.device_idx }" keyValue4="${neighborhoodLibraryCount - status.index }" keyValue5="2" keyValue6="${i.reserve_bundle_idx }" keyValue7="${i.device_code }">예약확정</a> --%>
								</c:when>
								<c:when test="${i.reserve_status eq '2'}">
									<c:if test="${i.locker_idx eq null or i.locker_idx eq '' }">
										<a href="javascript:void(0);" class="btn nearbyLib-save" keyValue1="${i.reserve_idx }" keyValue2="${status.index + 1}" keyValue3="${i.device_idx }" keyValue4="${neighborhoodLibraryCount - status.index }" keyValue5="2" keyValue6="${i.reserve_bundle_idx }" keyValue7="${i.device_code }">사물함배정</a>
									</c:if>
								</c:when>
								<c:when test="${i.reserve_status eq '3'}">
									
								</c:when>
								<c:when test="${i.reserve_status eq '5'}">
									
								</c:when>
							</c:choose>
						</td>
					</tr>
	 			</c:forEach>
				</c:if>
				<c:if test="${neighborhoodLibraryCount <= 0}">
					<tr>
						<td colspan=11>데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</form:form>

