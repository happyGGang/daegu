<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${facilityBook.plan_date}'.split('-');
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';

		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#facilityBookListForm #plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#facilityBookListForm #plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}

	$('a#before-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#facilityBookListForm #plan_year').val();
		var month = $('#facilityBookListForm #plan_month').val();

		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#facilityBookListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityBookListForm')));

	});

	$('a#next-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#facilityBookListForm #plan_year').val();
		var month = $('#facilityBookListForm #plan_month').val();

		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#facilityBookListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityBookListForm')));

	});

	$('#facilityBookListForm #plan_year,#facilityBookListForm #plan_month').on('change', function(e) {
		var planDate = $('#facilityBookListForm #plan_year').val() + '-' + $('#facilityBookListForm #plan_month').val();
		$('#facilityBookListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityBookListForm')));
	});
	
	$('a#dialog-close').on('click', function(e) {
		e.preventDefault();
		
		var formData = 'homepage_id='+$('#homepage_id').val();
		
		$('#dialog-2').load('close.do?' + formData, function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	$('a.btn-edit').on('click', function(e) {
		e.preventDefault();
		var select_day = $(this).attr('keyValue2');
		var plan_date = $('#plan_date').val() + '-' + (select_day < 10 ? 0 + select_day : select_day);
		
		var sysdate = new Date();
		var currYear = sysdate.getFullYear();
		var currMonth = sysdate.getMonth()+1;
		var currDate = sysdate.getDate();
		
		// 해당 달에는 등록가능
		var compareMonth = currYear + '-' + (currMonth < 10 ? '0' + currMonth : currMonth);
		
		// 다음 달 부터는 20일 이후에 가능하도록
		var nY = currYear;
		var nM = currMonth;
		
		if(nM == 12) {
			nY += 1;
			nM = 1;
		} else {
			nM += 1;
		}
		nM = nM < 10 ? '0' + nM : nM;
		var nPlanDate = nY + '-' + nM;
		if((nPlanDate != $('#plan_date').val() || currDate < 20) && ($('#plan_date').val() != compareMonth)) {
			alert('20일 이전에는 다음달 예약을 하실 수 없습니다.');
			return false;
		}
		
		// 지난 일정은 등록이 되지 않게
		if(new Date(plan_date) - sysdate < 0) {
			alert('지난 시설은 이용하실 수 없습니다.');
			return false;
		}
		
		var formData = 'homepage_id='+$('#homepage_id').val()+'&editMode=ADD&plan_date='+plan_date
			+'&apply_time_code='+$(this).attr('keyValue');
		$('#dialog-1').load('edit.do?' + formData, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.btn-modify').on('click', function(e) {
		e.preventDefault();
		var select_day = $(this).attr('keyValue2');
		var plan_date = $('#plan_date').val() + '-' + (select_day < 10 ? 0 + select_day : select_day);
		
		var formData = 'homepage_id='+$('#homepage_id').val()+'&editMode=MODIFY'+'&facility_book_idx='+$(this).attr('keyValue');
		$('#dialog-1').load('edit.do?' + formData, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.btn-modify-close').on('click', function(e) {
		e.preventDefault();
		return false;
	});

	$('td.top').height(150);
});
</script>
<form:form id="facilityBookListForm"  modelAttribute="facilityBook" action="index.do" >
	<form:hidden path="plan_date"/>
	<form:hidden path="homepage_id"/>

	<div class="infodesk">
		<div class="monthYear">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<form:select path="plan_year" class="selectmenu" style="width:100px;"></form:select>
	        <form:select path="plan_month" class="selectmenu" style="width:100px;"></form:select>
	        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	    </div>
	    <div class="button">
			<a href="" class="btn btn5 left" id="dialog-close"><i class="fa fa-plus"></i><span>휴관일</span></a>
		</div>
	</div>
	
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col width="100px" span="7"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일요일</th>
					<th scope="col">월요일</th>
					<th scope="col">화요일</th>
					<th scope="col">수요일</th>
					<th scope="col">목요일</th>
					<th scope="col">금요일</th>
					<th scope="col">토요일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${calendarList}">
					<tr>
						<c:choose>
							<c:when test="${i.sun eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.sun < 10?'0':''}${i.sun}"/>
									<div style="background: #ff4e4e; color: white; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sun}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.sun}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<c:if test="${applyList[planDate].PM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].PM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.sun}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.mon eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.mon < 10?'0':''}${i.mon}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.mon}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.mon}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.mon}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.tue eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.tue < 10?'0':''}${i.tue}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.tue}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.tue}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.tue}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.wed eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.wed < 10?'0':''}${i.wed}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.wed}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.wed}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.wed}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.thu eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.thu < 10?'0':''}${i.thu}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.thu}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.thu}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.thu}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.fri eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.fri < 10?'0':''}${i.fri}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.fri}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.fri}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.fri}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.sat eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facilityBook.plan_date}-${i.sat < 10?'0':''}${i.sat}"/>
									<div style="background: #dee7f9; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sat}</div>
									<ul style="display: block;">
										<li>
											<span><img alt="오전" src="/resources/module/am.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].AM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].AM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].AM}">
												<span>
													<a href="#" class="" keyValue="${applyList[planDate].AM.facility_book_idx}">
														<c:if test="${applyList[planDate].AM.apply_status eq '1'}">
														<img alt="승인" src="/resources/module/4f_sn.gif">
														</c:if>
														<c:if test="${applyList[planDate].AM.apply_status ne '1'}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
														</c:if>
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="0" keyValue2="${i.sat}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
										<li>
											<span><img alt="오후" src="/resources/module/pm.gif"></span>
											<c:choose>
												<c:when test="${not empty closeList[planDate].PM}">
												<span>
													<a href="#" class="btn-modify-close" keyValue="${applyList[planDate].PM.close_idx}">
														<img alt="휴관" src="/resources/module/4f_hu.gif">
													</a>
												</span>
												</c:when>
												<c:when test="${not empty applyList[planDate].PM}">
												<span>
													<a href="#" class="" keyValue="${applyList[planDate].PM.facility_book_idx}">
														<img alt="4층" src="/resources/module/4f_dae.gif">
													</a>
												</span>
												</c:when>
												<c:otherwise>
												<span>
													<a href="#" class="btn-edit" keyValue="1" keyValue2="${i.sat}">
														<img alt="4층" src="/resources/module/4f_me.gif">
													</a>
												</span>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="토론실대여"></div>
<div id="dialog-2" class="dialog-common" title="휴관일"></div>