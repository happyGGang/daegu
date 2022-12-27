<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="line1">
	<div class="line1_1 line1_all">${fn:replace(param.lockerEachKey, 'no', '')}</div>
	<div class="line1_2 line1_all">
		<c:if test="${lockerEach[param.lockerEachKey].reserve_status ne 'no-data'}">
			<c:choose>
				<c:when test="${lockerEach[param.lockerEachKey].reserve_status eq '2'}">
					<p style="background-color: #439bed; border-radius: 10px 10px 10px 10px; color:white; width:73px; text-align: center;">예약확정</p>
				</c:when>
				<c:when test="${lockerEach[param.lockerEachKey].reserve_status eq '3'}">
					<p style="background-color: #f5a639; border-radius: 10px 10px 10px 10px; color:white; width:88px; text-align: center;">사물함투입</p>
				</c:when>
				<c:when test="${lockerEach[param.lockerEachKey].reserve_status eq '5'}">
					<p style="background-color: #888; border-radius: 10px 10px 10px 10px; color:white; width:73px; text-align: center;">회수대기</p>
				</c:when>
			</c:choose>
		</c:if>
	</div>
	<div class="line1_3 line1_all">
		<c:choose>
			<c:when test="${lockerEach[param.lockerEachKey].reserve_status ne 'no-data'}">
				<p>${lockerEach[param.lockerEachKey].sameReserve} 권</p>
			</c:when>
			<c:when test="${lockerEach[param.lockerEachKey].reserve_status eq 'no-data' and lockerEach[param.lockerEachKey].use_yn eq 'N'}">
				<p class="overText" style="text-overflow:ellipsis;" title="${lockerEach[param.lockerEachKey].unused_reason}">${lockerEach[param.lockerEachKey].unused_reason}</p>
			</c:when>
		</c:choose>
	</div>
</div>
<div class="line2">
	<div class="line2_1 line2_all">
		<c:if test="${lockerEach[param.lockerEachKey].reserve_status eq 'no-data' and lockerEach[param.lockerEachKey].use_yn eq 'N'}">
			<a href="javascript:void(0);" class="use_locker" keyValue1="${lockerEach[param.lockerEachKey].device_idx }" keyValue2="${lockerEach[param.lockerEachKey].locker_idx }" keyValue3="${lockerEach[param.lockerEachKey].locker_each_idx }">
				<span style="border-radius:5px 5px 5px 5px; border:1px gray solid;">사용하기</span> 
			</a>
		</c:if>
	</div>
	<div class="line2_2 line2_all">
		<c:if test="${lockerEach[param.lockerEachKey].reserve_status eq 'no-data' and lockerEach[param.lockerEachKey].use_yn eq 'Y'}">
			<a href="javascript:void(0);" class="use_edit" keyValue1="${lockerEach[param.lockerEachKey].device_idx }" keyValue2="${lockerEach[param.lockerEachKey].locker_idx }" keyValue3="${lockerEach[param.lockerEachKey].locker_each_idx }">
				<span style="border-radius:5px 5px 5px 5px; border:1px gray solid;">사용중지</span>
			</a>
		</c:if>
	</div>	
</div>