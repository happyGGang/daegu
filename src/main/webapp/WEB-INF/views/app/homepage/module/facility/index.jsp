<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){

	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${facility.plan_date}'.split('-');
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';

		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	
	$('a#monthSelect').on('click', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facility')));
	});


	$(document).ready(function() {
		if(month < 10) {
			month = "0" + month;
		}
		setMonthSelect();



		<%--시설물 이용신청--%>
		$('a.apply').on('click', function(event) {
			doGetLoad('/${homepage.context_path}/module/facility/edit.do', 'editMode=ADD&facility_idx='+$(this).attr('keyValue')+'&menu_idx='+$('input#menu_idx').val());
			event.preventDefault();
		});

		$('.monthYear').prepend(year + "년");
	});

	function setMonthSelect() {
		var plan_date = '${facility.plan_date}';
		for(var i=1; i<= 12; i++) {

			var monthValue = i;
			if(i<10) {
				monthValue = "0" + i;
			}
			var selected = '';
			var value = year+"-"+monthValue;
			if (plan_date == value) {
				selected = 'selected="selected"';
			}
			$('#selectMonth').append("<option value = '"+value+"' " + selected + ">"+monthValue+"월</option>");
		}
	}

	$('#selectMonth').on('change', function(e) {
		doGetLoad('index.do', 'plan_date=' + $(this).find('option:selected').val());
	});

	$('a#before-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').val();
		var month = $('#plan_month').val();

		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month:month);
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facility')));

	});

	$('a#next-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#plan_year').val();
		var month = $('#plan_month').val();

		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month:month);
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facility')));

	});

	/* 달력 제어 시작 */
	$('tr.week').each(function(i, e) {
		var $this = $(this);
		var liCountByTr = $this.find('li').length;

		var date = new Date();
		var day = date.getDate();

		if ( liCountByTr > 0) {
			$this.find('td').each(function(i, e) {
				var liCountByTd = $(this).find('li').length;
				if ( liCountByTd > 0 ) {
					$(this).addClass('data'+liCountByTd);
				}
			});
		} else {
			$this.addClass('noData');
		}

		$this.find('td').each(function(i, e) {
			if($('#plan_year').val() + $('#plan_month').val() == year+""+month) {
				if($(this).find("div").text() == day) {
					$(this).addClass('today');
				}
			}

		});
	});

	function cwFunc(){
		var cw = ($('#calendar td').width())-8;
		$('#calendar td ul').css({'width':cw+'px'}).show();
	}
	cwFunc();

	$(window).resize(function(){
		cwFunc();
	});
	/* 달력 제어 종료 */

});
</script>
<form:form modelAttribute="facility">
<form:hidden path="plan_date"/>
<form:hidden id="menu_idx" path="menu_idx"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="ym_btns">
		<a id="before-btn" href="#prev" class="btn prev new_btn01"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<form:select path="plan_year" class="new_select_box" style="width:80px;"></form:select>
		<form:select path="plan_month" class="new_select_box" style="width:65px;"></form:select>
		<a href="#" id="monthSelect" class="btn btn1">이동</a>
		<a id="next-btn" href="#next" class="btn next new_btn01"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	</div>

	<div id="calendar">
	<table class="cal-tbl">
		<thead>
		<tr>
			<th class="sun">일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th class="sat">토</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${calendarList}">
				<tr class="week">
					<c:choose>
					<c:when test="${i.sun eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="sun">
							<div>${i.sun}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<ul>
								<c:set var="current" value="${fn:length(i.sun) < 2? '0' : ''}${i.sun}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.mon eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="mon">
							<div>${i.mon}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<ul>
								<c:set var="current" value="${fn:length(i.mon) < 2? '0' : ''}${i.mon}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>

					<c:choose>
					<c:when test="${i.tue eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="tue">
							<div>${i.tue}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<ul>
								<c:set var="current" value="${fn:length(i.tue) < 2? '0' : ''}${i.tue}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>

					<c:choose>
					<c:when test="${i.wed eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="wed">
							<div>${i.wed}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<ul>
								<c:set var="current" value="${fn:length(i.wed) < 2? '0' : ''}${i.wed}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>

					<c:choose>
					<c:when test="${i.thu eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="thu">
							<div>${i.thu}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<ul>
								<c:set var="current" value="${fn:length(i.thu) < 2? '0' : ''}${i.thu}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>

					<c:choose>
					<c:when test="${i.fri eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="fri">
							<div>${i.fri}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<ul>
								<c:set var="current" value="${fn:length(i.fri) < 2? '0' : ''}${i.fri}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.sat eq null}">
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="sat">
							<div>${i.sat}</div>
							<c:set var="plan_date" value="${facility.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<ul>
								<c:set var="current" value="${fn:length(i.sat) < 2? '0' : ''}${i.sat}"></c:set>
								<c:set var="closeDate" value="${not empty calendarManageList.dd and fn:contains(calendarManageList.dd, current)}"></c:set>
								<c:choose>
									<c:when test="${closeDate}">
									<li>휴관일</li>
									</c:when>
									<c:otherwise>
										<c:forEach items="${facilityRepo[plan_date]}" var="one">
											<li>[${one.facility_name}]<br/>${one.start_time}~${one.end_time}<br/>
												<c:choose>
													<c:when test="${one.apply_count >= one.limit_count}"><span class="type-e"><i></i><em>정원마감</em></span><br></c:when>
													<c:when test="${one.apply_yn eq 'Y'}">
														<a class="btn1 apply" keyValue="${one.facility_idx}"><span style="type-r"><i></i><em>신청하기</em></span></a><br>
													</c:when>
													<c:when test="${one.apply_yn ne 'Y'}">
														<a class="btn1" keyValue="${one.facility_idx}"><span style="color:red;"><i></i><em>신청불가</em></span><br>
													</c:when>
												</c:choose>
												<c:forEach items="${applyList}" var="apply">
													<c:if test="${plan_date eq apply.use_date}">
													<c:choose>
														<c:when test="${apply.apply_status eq '신청'}">
														<span class="type-h"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '승인'}">
														<span class="type-r"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
														<c:when test="${apply.apply_status eq '취소'}">
														<span class="type-e"><i></i><em>${apply.apply_status}</em></span><br>
														</c:when>
													</c:choose>
													</c:if>
												</c:forEach>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
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
