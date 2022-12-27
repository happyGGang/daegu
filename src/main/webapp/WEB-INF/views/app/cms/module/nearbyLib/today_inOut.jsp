<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {

	$('.search_device').on('change',function(e){
		
		if(doAjaxPost($('#nearbyLibSave'))) {
				location.reload();
		}
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
<form:form modelAttribute="nearbyLib" id="search_nearbyLib" action="index.do">
	<form:hidden path="device_idx"/>
	<div class="">
			<h3>내집앞도서관예약 반입/반출 목록</h3><br/>
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
					</colgroup>
					<thead>
						<tr>
							<th colspan="10" style="height: 36px;">반출 목록</th>						
						</tr>
						<tr style="outline:white 1px solid">
							<th>번호</th>
							<th>사물함번호</th>
							<th>예약번호</th>
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
						<c:forEach var="j" items="${outList }" varStatus="status">
							<tr>
								<td>${outCount - status.index }</td>
								<td>${j.locker_idx }</td>
								<td>${j.pk }</td>
								<td>${j.book_name }</td>
								<td>${j.lib_name }</td>
								<td>${j.reg_no }</td>
								<td>${j.member_id }</td>
								<td><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd" /></td>
								<td><fmt:formatDate value="${j.lend_date}" pattern="yyyy.MM.dd" /></td>
								<td>
									<c:if test="${j.reserve_status eq '2'}">
										<p>예약확정</p>
									</c:if>
								</td>
							</tr>
						</c:forEach>
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
							<th>큰책유무</th>
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
						<c:forEach var="k" items="${inList }" varStatus="statusIn">
							<tr>
								<td>${inCount - statusIn.index }</td>
								<td>${k.locker_idx }</td>
								<td>${k.pk }</td>
								<td>${k.book_name }</td>
								<td>${k.lib_name }</td>
								<td>${k.reg_no }</td>
								<td>${k.member_id }</td>
								<td><fmt:formatDate value="${k.add_date}" pattern="yyyy.MM.dd" /></td>
								<td><fmt:formatDate value="${k.lend_date}" pattern="yyyy.MM.dd" /></td>
								<td>
									<c:if test="${k.reserve_status eq '5'}">
										<p>회수대기</p>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		</div>
	</div>
</form:form>