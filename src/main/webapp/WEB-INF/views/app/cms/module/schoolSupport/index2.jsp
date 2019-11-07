<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
table.supportTable td {
padding : 0px;
}
table.supportTable td a{
height : 100%;
}
td.data {
	background: #6990cc  !important;
    color: white !important;
}
td.day_1 {
	color:#f59393 !important;
	
}
td.day_7 {
	color:#a4bff6 !important;
}
div.detail-view {
	position:absolute;
	width:350px;
	height:230px;
	background:#dadfe4;
	padding:1px;
	
}
</style>
<script type="text/javascript">
$(function() {
	$('a#before-btn').on('click', function(e) {			
		e.preventDefault();
		var curYear = parseInt($('form#schoolSupport #support_year').val());
		$('form#schoolSupport #support_year').val(curYear - 1);
		$('form#schoolSupport').submit();
	});	
	
	$('a#next-btn').on('click', function(e) {
		var curYear = parseInt($('form#schoolSupport #support_year').val());
		$('form#schoolSupport #support_year').val(curYear + 1);
		$('form#schoolSupport').submit();
		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		e.preventDefault();
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#schoolSupport').submit();
		}
	});
	
	$('a.add-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.mod-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&support_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
	});
	
	$('a.list-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('list.do?support_status=0&homepage_id=' + $('#homepage_id_1').val() + '&support_year=' + $('form#schoolSupport #support_year').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});	
	});
	
	$('td.day_td').on('mouseover', function() {
		$('div.detail-view').hide();
		$(this).find('div.detail-view').show();
	});
	$('td.day_td').on('mouseout', function() {
		$('div.detail-view').hide();
	});
	
});
</script>

<form:form modelAttribute="schoolSupport" action="index.do">
	<form:hidden path="support_year"/>
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</form:form>
<div class="infodesk">
	<div class="button">
		<a href="" class="btn btn5 left add-btn" ><i class="fa fa-plus"></i><span>등록</span></a>
		<a href="" class="btn btn1 left list-btn" ><i class="fa"></i><span>신청현황</span></a>		
	</div>
</div>
<div class="ui-state-highlight">
	* 1지망 또는 2지망 확정된 항목만 달력에 표시됩니다.<br/>
	* 우측 상단 "신청현황" 버튼으로 현재 출력중인 년도에 대해 모든 신청 정보를 조회 가능합니다.

</div>

<table class="center type1 supportTable">
	<thead>
		<tr>
			<th colspan="32" style="border-bottom:2px solid white; font-size:20px">
				<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
					${schoolSupport.support_year}
				<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
			</th>
		</tr>
		<tr>
			<th width="25"></th>
			<c:forEach var="day_i" begin="1" end="31">
				<th width="25">${day_i}</th>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="month_i" begin="1" end="12">
			<tr>
				<th height="30">${month_i}</th>
				<c:forEach var="month_of_day_i" begin="1" end="31" varStatus="status">
					<c:set var="key" value="${month_i}_${month_of_day_i}" />
					
					<td width="25" class="day_${schoolSupport.calendar[key]} day_td ${schoolSupportRepo[key] ne null ? 'data':''}">
						<c:choose>
							<c:when test="${schoolSupport.calendar[key] eq '7'}">토</c:when>
							<c:when test="${schoolSupport.calendar[key] eq '1'}">일</c:when>
							<c:when test="${schoolSupportRepo[key] ne null }">
								<c:forEach items="${areaList}" var="oneArea">
									<c:if test="${oneArea.code_id eq schoolSupportRepo[key].area_code}">
										<c:set var="areaName" value="${oneArea.code_name}"/>${areaName}<br/>
									</c:if>
								</c:forEach>
								<div class="detail-view auto-scroll" style="display:none;">
									<table class="type2">
										<c:choose>
											<c:when test="${schoolSupportRepo[key].support_status eq '1'}">
												<tr>
													<th width="80">지원상태</th>
													<td>1순위 확정 </td>
												</tr>
												<tr>
													<th width="80">1순위</th>
													<td>${schoolSupportRepo[key].support_req_first}</td>
												</tr>
												<tr>
													<th width="80">1순위 일자</th>
													<td>${schoolSupportRepo[key].first_start_date} ~ ${schoolSupportRepo[key].first_end_date}</td>
												</tr>
											</c:when>
											<c:when test="${schoolSupportRepo[key].support_status eq '2'}">
												<tr>
													<th width="80">지원상태</th>
													<td>2순위 확정 </td>
												</tr>
												<tr>
													<th width="80">2순위</th>
													<td>${schoolSupportRepo[key].support_req_second}</td>
												</tr>
												<tr>
													<th width="80">2순위 일자</th>
													<td>${schoolSupportRepo[key].second_start_date} ~ ${schoolSupportRepo[key].second_end_date}</td>
												</tr>
											</c:when>
											<c:when test="${schoolSupportRepo[key].support_status eq '3'}">
												<tr>
													<th width="80">지원상태</th>
													<td>1순위 확정 </td>
												</tr>
												<tr>
													<th width="80">1순위</th>
													<td>${schoolSupportRepo[key].support_req_first}</td>
												</tr>
												<tr>
													<th width="80">1순위 일자</th>
													<td>${schoolSupportRepo[key].first_start_date} ~ ${schoolSupportRepo[key].first_end_date}</td>
												</tr>
												<tr>
													<th width="80">지원상태</th>
													<td>2순위 확정 </td>
												</tr>
												<tr>
													<th width="80">2순위</th>
													<td>${schoolSupportRepo[key].support_req_second}</td>
												</tr>
												<tr>
													<th width="80">2순위 일자</th>
													<td>${schoolSupportRepo[key].second_start_date} ~ ${schoolSupportRepo[key].second_end_date}</td>
												</tr>
											</c:when>
										</c:choose>
										
										<tr>
											<th width="50">지역</th>
											<td>${areaName}</td>
										</tr>
										<tr>
											<th>학교명</th>
											<td>${schoolSupportRepo[key].school_name}</td>
										</tr>
										<tr>
											<th>담당자명</th>
											<td>${schoolSupportRepo[key].member_name}</td>
										</tr>
										<tr>
											<th>담당자전화</th>
											<td>${schoolSupportRepo[key].member_phone}</td>
										</tr>
										<tr>
											<th>담당자휴대전화</th>
											<td>${schoolSupportRepo[key].member_cell_phone}</td>
										</tr>
									</table>
								</div>
								<%-- <a class="btn btn1 mod-btn" keyValue1="${schoolSupportRepo[key].homepage_id}" keyValue2="${schoolSupportRepo[key].support_idx}">수정</a> --%>
							</c:when>
							<c:when test="${schoolSupport.calendar[key] ne null}">
								
							</c:when>
						</c:choose>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="dialog-1" class="dialog-common" title="학교도서관 지원 정보"></div>
<div id="dialog-2" class="dialog-common" title="학교도서관 지원 신청 정보"></div>
