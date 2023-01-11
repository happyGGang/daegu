<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('.selectmenu-search').on('change',function(e){
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
	
});
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
<!-- 	&nbsp;&nbsp;&nbsp; -->
<%-- 	<span class="bbs-result">* 현재 사용 가능한 사물함 갯수 : <b><fmt:formatNumber value="${nowLocker}" pattern="#,###"/> </b>개</span> --%>
</div>
<!-- 	<div class="infodesk"> -->
<%-- 		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span> --%>
<%-- 		<span>(페이지 ${paging.viewPage}/${paging.totalPageCount})</span> --%>
<!-- 	</div> -->
	
	<!-- 운영장비관리 table -->
	<table class="type1 center">
		<colgroup>
 			<col width="3%" />
 			<col width="8%" />
 			<col width="4%" />
 			<col width="4%" />
			<col width="5%" />
			<col width="3%" />
			<col width="7%" />
			<col width="7%" />
			<col width="9%" />
			<col width="8%" />
			<col width="8%" />
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
							<c:when test="${i.sms_send_yn eq 'Y'}">
								발송완료
							</c:when>
							<c:otherwise>
								미발송
							</c:otherwise>					
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${i.reserve_status eq '1'}">
								<!-- 예약상태 -->
								<c:choose>
									<c:when test="${nowLocker > 0 }">
										<a href="#" class="btn reserve_save"  keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="2" keyValue3="${i.reserve_bundle_idx }" keyValue4="${i.device_idx}" keyValue5="${i.device_code }" keyValue6="${i.reserve_idx }">예약확정</a>
										<a href="#" class="btn reserve_cancel" keyValue1="${i.reserve_idx}" keyValue2="8"  keyValue3="${i.device_idx }" keyValue4="${i.device_code}">관리자취소</a>
									</c:when>
									<c:when test="${nowLocker <= 0 }">
									</c:when>
								</c:choose>
							</c:when>
							<c:when test="${i.reserve_status eq '2'}">
								<!-- 예약확정상태 -->
								<%-- <a href="#" class="btn reserve_edit"  style="background-color:#f5a639; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="3" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }" keyValue7="${status.index + 1}" keyValue8="${i.locker_idx }">사물함투입</a> --%>
								<a href="#" class="btn reserve_cancel" keyValue1="${i.reserve_idx}" keyValue2="8"  keyValue3="${i.device_idx }" keyValue4="${i.device_code}">관리자취소</a>
							</c:when>
							<c:when test="${i.reserve_status eq '3'}">
								<!-- 사물함투입상태 -->
								<%-- <a href="#" class="btn reserve_edit" style="background-color:#17ad57; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="4" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">대출</a> --%>
								<%-- <a href="#" class="btn reserve_edit" style="background-color:#888; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="5" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">회수대기</a> --%>
							</c:when>
							<c:when test="${i.reserve_status eq '4'}">
								<!-- 대출상태 -->
								
							</c:when>
							<c:when test="${i.reserve_status eq '5'}">
								<!-- 회수대기상태(기간내에 회원이 책을 가져가지 않은 도서) -->
								<%-- <a href="#" class="btn reserve_edit" style="background-color:#fd7a7ad4; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="6" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">회수중</a> --%>
							</c:when>
							<c:when test="${i.reserve_status eq '6'}">
								<!-- 배송기사가 도서를 회수 한 상태 -->
								<a href="#" class="btn reserve_edit" keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="7" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">회수완료</a>
							</c:when>
							<c:when test="${i.reserve_status eq '7'}">
								<!-- 배송기사가 도서를 도서관에 반납 한 상태 -->
							</c:when>
							<c:when test="${i.reserve_status eq '8'}">
								<!-- 취소된 상태 -->
							</c:when>
							<c:when test="${i.reserve_status eq '9'}">
								<!-- 반납된 상태 -->
								<a href="#" class="btn reserve_edit" keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="10" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">반납완료</a>
							</c:when>
						</c:choose>	
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