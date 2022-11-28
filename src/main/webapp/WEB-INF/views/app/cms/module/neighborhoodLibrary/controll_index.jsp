<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {	
	$('#locker_td').css('rowspan', $('#row_no').val() - $('#add_row_no').val());
	
	$('a.use_edit').on('click',function(e){
		$('#dialog-1').load('use_edit.do?use_yn=N&device_idx=' + $(this).attr('keyValue1') + '&locker_idx=' + $(this).attr('keyValue2') + '&locker_each_idx=' + $(this).attr('keyValue3') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});	
		e.preventDefault();	
	});
		
	$('a.use_locker').on('click',function(e){
		if (confirm($(this).attr('keyValue2') + '번 사물함을 사용하시겠습니까?')) {
			$('#lockerUseEdit #use_yn').val('Y');
			$('#lockerUseEdit #locker_idx').val($(this).attr('keyValue1'));
			if(doAjaxPost($('#lockerUseEdit'))) {
				location.reload();
			}
		}
		e.preventDefault();	
	});			

});


</script>
<style>
.locker_wrap_left{
	float:left;
	width:49%;
	height:100%;
}

.locker_wrap_left tr{
	height:50px;	
}
.locker_wrap_right{
	float:right;
	width:49%;
	height:100%;
}

</style>

<form:form modelAttribute="neighborhoodLibraryLocker" id="lockerUseEdit" action="locker_each_edit.do">

</form:form>

<form:form modelAttribute="neighborhoodLibraryLocker" id="reserveConfig">
	<div class="page-subtitle">
		<h3>${locker.device_name}  : 내집앞도서관예약 관리</h3>
	</div>
	<div>
	장비명 : 
	<form:select class="selectmenu-search" style="width:300px" path="device_idx">
		<c:forEach var="i" varStatus="status" items="${deviceList}">
			<option value="${i.device_idx}" <c:if test="${i.device_idx eq neighborhoodLibrary.device_idx }">selected="selected"</c:if>>${i.device_name}</option>
		</c:forEach>
	</form:select>
	</div>
 	<div class="locker_wrap_left">
		<table class="type1 table_left">
			<thead>
				<tr>
					<th colspan="6">사물함별 대출정보</th>						
				</tr>		
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
				</tr>
			</thead>
			<tbody>			
				<tr>
					<td>7</td>
					<td colspan=4 rowspan=3 style="background-color: #8080803b;">
					<td>8</td>
				</tr>
				<tr>
					<td>9</td>					
					<td>10</td>
				</tr>
				<tr>
					<td>11</td>
					<td>12</td>
				</tr>
				<tr>
					<td colspan=2>13</td>
					<td colspan=2>14</td>
					<td colspan=2>15</td>
				</tr>
			</tbody>
		</table>	
	</div>
	<div class="locker_wrap_right">
		<table class="type1 center">
			<colgroup>
				<col width="50" />
				<col width="50" />			
				<col width="200" />
				<col width="120" />
				<col width="110" />
				<col width="90" />
				<col width="90" />
				<col width="80" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="8">사물함별 대출정보</th>						
				</tr>
				<tr style="outline:white 1px solid">
					<th>번호</th>
					<th>사물함번호</th>
					<th>도서명</th>
					<th>소장도서관</th>
					<th>등록번호</th>				
					<th>대출자ID</th>
					<th>예약확정일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${true}">
	 			<c:forEach var="i" items="${neighborhoodLibraryList}" varStatus="status"> 
					<tr>
	 					<td>${neighborhoodLibraryCount - status.index }</td>
						<td><select class="selectmenu-search" style="width:300px" name="locke_each_idx" id="locke_each_idx">
							<c:forEach var="j" varStatus="status" items="${lockerOneList}">
								<option value="${j.locker_each_idx }" <c:if test="${i.locker_idx eq j.locker_each_idx }">selected="selected"</c:if>/>
							</c:forEach>
						</select></td>
						<td>${i.book_name} </td>
						<td>${i.lib_name} </td>
						<td>${i.reg_no} </td>					
						<td>${i.member_id}</td>					
						<td>
	 						<fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd" />
						</td>
						<td>						
							<c:choose>
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
					</tr>
	 			</c:forEach>
				</c:if>
				<c:if test="${neighborhoodLibraryCount <= 0}">
					<tr>
						<td colspan=7>데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>		
			</tbody>
		</table>
	</div>	
</form:form>

<div id="dialog-1" class="dialog-common" title="사물함 사용중지 설정"></div>

