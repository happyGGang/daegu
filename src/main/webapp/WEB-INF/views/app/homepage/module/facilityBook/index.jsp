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
	var plan_date = '${facilityBook.plan_date}'.split('-');
	for(var i = year+1; i > 2017; i--) {
		var optionYear = i;
		var selectedAttr = '';

		if ( optionYear == plan_date[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == plan_date[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}

	$('#plan_year,#plan_month').on('change', function(e) {
		var plan_date = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(plan_date);
		doGetLoad('index.do', serializeCustom($('#facilityBook')));
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
	
		var plan_date = year + '-' + (month < 10 ? '0'+month:month);
		$('#plan_date').val(plan_date);
		doGetLoad('index.do', serializeCustom($('#facilityBook')));
	
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
		
		var plan_date = year + '-' + (month < 10 ? '0'+month:month);
		$('#plan_date').val(plan_date);
		doGetLoad('index.do', serializeCustom($('#facilityBook')));
	
	});
	
	$('a.btn-edit').on('click', function(e) {
		e.preventDefault();
		var select_day = $(this).attr('keyValue2');
		var plan_date = $('#plan_date').val() + '-' + (select_day < 10 ? 0 + select_day : select_day);
		
		var plan_arr = plan_date.split('-');
		var reference = new Date(plan_arr[0], plan_arr[1]-1, 1, 9, 0);
		reference.setDate(reference.getDate() - 1);
		var ref = reference.setDate(20);
		var today = new Date();
		
		if(ref > today.getTime()) {
			alert('20일 이전에는 다음달 예약을 하실 수 없습니다.');
			return false;
		}
		
		// 지난 일정은 등록이 되지 않게
		var sysdate = new Date();
		if(new Date(plan_date) - sysdate < 0) {
			alert('지난 시설은 이용하실 수 없습니다.');
			return false;
		}
		
		var formData = 'menu_idx='+$('#menu_idx').val()+'&homepage_id='+$('#homepage_id').val()+'&editMode=ADD&plan_date='+plan_date
			+'&apply_time_code='+$(this).attr('keyValue');
		doGetLoad('edit.do', formData);
	});

});
</script>

<c:choose>
	<c:when test="${homepage.context_path eq 'jungang'}">

<div class="tabCon active" id="tabCon1">
  <div class="summaryDesc">
    <div class="innerBox">
      <div class="img ticon_02"></div>
      <div class="desc">
        <h3>토론실</h3>
        <p>시민들에게 소모임 문화 활동 및 그룹 학습토론을 할 수 있는 토론실(4층)을 마련하여 개방 운영합니다.</p>
      </div>
    </div>
  </div>
  <h3>토론실 이용안내</h3>
  <ul class="con">
    <li><strong>장소 :</strong> 4층(동편)</li>
    <li><strong>이용대상 :</strong> 4명 이상 단체, 일반인
      (단, 영리, 종교, 정치를 목적으로는 사용할 수 없습니다.)</li>
    <li><strong>이용시간 :</strong> 1일 4시간, 주 1회에 한함<br>
      ※ 휴관일(첫째, 셋째 월요일) 및 법정공휴일 제외 </li>
  </ul>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="토론실 이용시간 안내하는 표">
      <colgroup>
      <col width="*" class="col27">
      </colgroup>
      <caption class="disnone">
      이용시
      </caption>
      <thead>
        <tr class="first">
          <th scope="col" class="first th1">구분</th>
          <th scope="col" class="th2">오전</th>
          <th scope="col" class="th3">오후</th>
        </tr>
      </thead>
      <tbody>
        <tr class="first">
          <th class="first th1">평일, 주말</th>
          <td class="td1">09:30 ~ 13:30</td>
          <td class="td2">13:30 ~ 17:30</td>
        </tr>
      </tbody>
    </table>
  </div>
	<br>
  <h4>신청 및 이용방법</h4>
  <ul class="con">
    <li> <strong>신청방법 :</strong> <strong><font color="red">[인터넷 신청]</font></strong> <strong>http://library.daegu.go.kr</strong> 접속 후 오른쪽 퀵메뉴 → 토론실 사용신청<br>
      익월 신청은 20일 오전 9시부터 선착순 접수<br>
      * 3월 토론실 이용 신청은 2월 20일부터 가능합니다.<br>
    </li>
    <li><strong>이용방법 :</strong> 토론실 이용일에 방문 시 독서문화과(평일), 인문자료실(주말)에 문의 → 신청자 확인 후 개방<br>
    <strong><font color="blue">* 반드시 토론실 신청 승인 확인 후 방문 바랍니다.</font></strong></li>
  </ul>
  <h4>사용 준수 사항</h4>
  <ul class="con">
    <li> 사용신청 목적과 상이한 모임 활동을 금지합니다.<br>
    </li>
    <li> 실내 음식물 반입을 금지하며, 꼭 필요한 경우 사전 승인을 받아야 합니다.<br>
    </li>
    <li> 시설 및 설비 변경을 금지합니다.<br>
    </li>
    <li> 선량한 사용자로서 공중도덕 준수와 함께 실내 청결상태를 유지해야 합니다.<br>
    </li>
    <li> 시설이나 설비에 손해를 끼친 경우 배상해야 합니다.<br>
    </li>
    <li> 사용 준수 사항을 위배할 경우 추후 사용을 금합니다.<br>
      ※ 사전 연락 없이 불참할 경우, 이용시간 30분이 경과된 후에는 자동 취소됩니다.<br>
      ※ 미신청 되었거나 취소된 경우에는 당일 방문신청 가능합니다. (4인 이상)</li>
  </ul>
  <h4>문의처</h4>
  <ul class="con">
    <li>독서문화과(3층, 평일) ☎ 231-2045<br>
    </li>
    <li>인문자료실(3층, 주말) ☎ 231-2060</li>
  </ul>
</div>

	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<form:form modelAttribute="facilityBook">
<form:hidden path="plan_date"/>
<form:hidden path="menu_idx"/>
<form:hidden path="homepage_id"/>
<form:hidden path="facility_book_name"/>

	<div class="ym_btns">
		<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<form:select path="plan_year" class="" style="width:80px;height:28px;"></form:select>
		<form:select path="plan_month" class="" style="width:65px;height:28px;"></form:select>
		<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
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
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="mon">
							<div>${i.mon}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="tue">
							<div>${i.tue}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="wed">
							<div>${i.wed}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="thu">
							<div>${i.thu}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="fri">
							<div>${i.fri}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
						<td><div>&nbsp;</div></td>
					</c:when>
					<c:otherwise>
						<td class="sat">
							<div>${i.sat}</div>
							<c:set var="plan_date" value="${facilityBook.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<ul style="display: block;">
								<li>
									<span><img alt="오전" src="/resources/module/am.gif"></span>
									<c:choose>
										<c:when test="${not empty closeList[plan_date].AM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].AM}">
										<span>
											<c:if test="${applyList[plan_date].AM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].AM.apply_status eq '0'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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
										<c:when test="${not empty closeList[plan_date].PM}">
										<span><img alt="휴관" src="/resources/module/4f_hu.gif"></span>
										</c:when>
										<c:when test="${not empty applyList[plan_date].PM}">
										<span>
											<c:if test="${applyList[plan_date].PM.apply_status eq '1'}">
											<img alt="승인" src="/resources/module/4f_sn.gif">
											</c:if>
											<c:if test="${applyList[plan_date].PM.apply_status ne '1'}">
											<img alt="4층" src="/resources/module/4f_dae.gif">
											</c:if>
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