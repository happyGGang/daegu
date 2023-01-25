<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
table thead th, table tbody td {font-size:12px;}
</style>
<script type="text/javascript">
$(function() {
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

	$('#getToBeExported').on('click',function(e){
		$('input#toBeExported').val('Y');
		$('#neighborhoodLibrary').attr('action', 'index.do');
		doGetLoad('index.do', serializeCustom($('#neighborhoodLibrary')));
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

<form:form modelAttribute="nearbyLib" id="neighborhoodLibrary" action="index.do" method="POST">
<form:hidden path="toBeExported" value=""/>
	<div class="search">
			<c:if test="${asideHomepageId eq 'h45'}">
				도서관 :
				<form:select id="manage_code" path="manage_code" class="selectmenu">
					<form:option value="">전체</form:option>
					<form:option value="CA">동구통합 안심도서관</form:option>
					<form:option value="CB">동구통합 신천도서관</form:option>
				</form:select>
			</c:if>
			<c:if test="${asideHomepageId eq 'h90'}">
				도서관 :
				<form:select id="manage_code" path="manage_code" class="selectmenu">
					<form:option value="">전체</form:option>
					<form:option value="AA">대구2·28기념학생도서관</form:option>
					<form:option value="BA">북구구수산도서관</form:option>
					<form:option value="AH">대구광역시립 동부도서관</form:option>
					<form:option value="CA">동구통합 안심도서관</form:option>
					<form:option value="CB">동구통합 신천도서관</form:option>
				</form:select>
			</c:if>
			장비명 : 
			<form:select class="selectmenu-search" style="width:300px" path="device_idx">
				<form:option value="0">전체</form:option>
				<form:option value="1">연경CGV</form:option>
				<form:option value="2">이시아MEGABOX</form:option>
				<form:option value="3">반야월이마트</form:option>
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
			<button id="getToBeExported" class="btn btn1"><span>반출예정목록</span></button>
			&nbsp;&nbsp;&nbsp;
			<c:if test="${not empty nowLocker}">
				<span class="bbs-result">* 현재 사용 가능한 사물함 갯수 : <b><fmt:formatNumber value="${nowLocker}" pattern="#,###"/> </b>개</span>
			</c:if>
	</div>
<!-- 	<div class="status_info"> -->
<!-- 		<p class="status_info_all reserve_status1">예약</p>  -->
<!-- 		<p class="status_info_all reserve_status2">예약확정</p> -->
<!-- 		<p class="status_info_all reserve_status3">사물함투입</p> -->
<!-- 		<p class="status_info_all reserve_status4">대출</p> -->
<!-- 		<p class="status_info_all reserve_status5">회수대기</p> -->
<!-- 		<p class="status_info_all reserve_status6">회수중</p> -->
<!-- 		<p class="status_info_all reserve_status7">회수완료</p> -->
<!-- 		<p class="status_info_all reserve_status8">취소</p> -->
<!-- 		<p class="status_info_all reserve_status9">반납</p> -->
<!-- 		<p class="status_info_all reserve_status10">반납완료</p> -->
<!-- 	</div> -->
	<div class="infodesk">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<span>(페이지 ${paging.viewPage}/${paging.totalPageCount})</span>
<!-- 		<div class="button"> -->
<!-- 				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp; -->
<!-- 				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;						 -->				
<%--  			<c:if test="${fn:length(reserveConfigList) <= 0 }">  --%>
<!--  				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>예약설정 등록</span></a> -->
<%--  			</c:if>							  --%>
<!-- 		</div> -->
	</div>
	<!-- 운영장비관리 table -->
	<table class="type1 center">
		<colgroup>
 			<col width="4%" />
 			<col width="10%" />
 			<col width="4%" />
 			<col width="4%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="11%" />
			<col width="8%" />
			<col width="8%" />
			<col width="4%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
		</colgroup>
		<thead>
			<tr>
 				<th>번호</th>			
				<th>소장처</th>
				<th>사물함</th>
				<th>비밀번호</th>
				<th>회원ID</th>
				<th>등록번호</th>
				<th>청구기호</th>
				<th>수령장소</th>
				<th>도서명</th>
				<th>신청날짜</th>
				<th>예약확정시간</th>
				<th>취소여부</th>
				<th>SMS발송여부</th>
				<th>대출상태</th>
				<th>기능</th>				
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
					<td>${i.call_no }</td>
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
					<!-- (1:예약신청, 2:대출승인(사물함 배정), 3:사물함투입(배송기사가 사물함에 도서 투입), 4:대출(대출신청자가 도서를 가져감), 5:회수대기(대출자가 책을 가져가지 않아 회수로 바뀜), 6:회수(배송기사가 사물함에서 도서 회수), 7:미승인(취소) -->
						<c:choose>
							<c:when test="${i.reserve_status eq '1'}">
								<p class="status_btn reserve_status1">예약</p>
							</c:when>
							<c:when test="${i.reserve_status eq '2'}">
								<p class="status_btn reserve_status2">예약확정</p>
							</c:when>
							<c:when test="${i.reserve_status eq '3'}">
								<p class="status_btn reserve_status3">사물함투입</p>
							</c:when>
							<c:when test="${i.reserve_status eq '4'}">
								<p class="status_btn reserve_status4">대출</p>
							</c:when>
							<c:when test="${i.reserve_status eq '5'}">
								<p class="status_btn reserve_status5">회수대기</p>
							</c:when>
							<c:when test="${i.reserve_status eq '6'}">
								<p class="status_btn reserve_status6">회수중</p>
							</c:when>
							<c:when test="${i.reserve_status eq '7'}">
								<p class="status_btn reserve_status7">회수완료</p>
							</c:when>							
							<c:when test="${i.reserve_status eq '8'}">
								<p class="status_btn reserve_status8">취소</p>
							</c:when>
							<c:when test="${i.reserve_status eq '9'}">
								<p class="status_btn reserve_status9">반납</p>
							</c:when>
							<c:when test="${i.reserve_status eq '10'}">
								<p class="status_btn reserve_status10">반납완료</p>
							</c:when>	
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${i.reserve_status eq '1'}">
								<!-- 예약상태 -->
								<c:choose>
									<c:when test="${nowLocker > 0 }">
										<a href="#" class="btn reserve_save"  style="background-color:#439bed; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="2" keyValue3="${i.reserve_bundle_idx }" keyValue4="${i.device_idx}" keyValue5="${i.device_code }" keyValue6="${i.reserve_idx }">예약확정</a>
										<a href="#" class="btn reserve_cancel" style="background-color: #222; color:white;" keyValue1="${i.reserve_idx}" keyValue2="8"  keyValue3="${i.device_idx }" keyValue4="${i.device_code}">관리자취소</a>
									</c:when>
									<c:when test="${nowLocker <= 0 }">
									</c:when>
								</c:choose>
							</c:when>
							<c:when test="${i.reserve_status eq '2'}">
								<!-- 예약확정상태 -->
								<%-- <a href="#" class="btn reserve_edit"  style="background-color:#f5a639; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="3" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }" keyValue7="${status.index + 1}" keyValue8="${i.locker_idx }">사물함투입</a> --%>
								<a href="#" class="btn reserve_cancel" style="background-color: #222; color:white;" keyValue1="${i.reserve_idx}" keyValue2="8"  keyValue3="${i.device_idx }" keyValue4="${i.device_code}">관리자취소</a>
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
								<a href="#" class="btn reserve_edit" style="background-color:#cc4ae7; color:white; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="7" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">회수완료</a>
							</c:when>
							<c:when test="${i.reserve_status eq '7'}">
								<!-- 배송기사가 도서를 도서관에 반납 한 상태 -->
							</c:when>
							<c:when test="${i.reserve_status eq '8'}">
								<!-- 취소된 상태 -->
							</c:when>
							<c:when test="${i.reserve_status eq '9'}">
								<!-- 반납된 상태 -->
								<a href="#" class="btn reserve_edit" style="border:1px black solid; color:black; " keyValue1="${nearbyLib.listRowNum - status.index}" keyValue2="10" keyValue3="${i.device_idx }" keyValue4="${i.device_code}" keyValue5="${i.reserve_idx }" keyValue6="${i.reserve_bundle_idx }">반납완료</a>
							</c:when>
						</c:choose>	
					</td>					
				</tr>					
			</c:forEach>
			<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="15">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#neighborhoodLibrary"/>
	</jsp:include>
</form:form>

<div id="dialog-1" class="dialog-common" title="예약 취소"></div>