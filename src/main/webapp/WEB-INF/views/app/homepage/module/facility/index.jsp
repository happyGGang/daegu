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
<form:hidden path="date_type"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<c:if test="${homepage.context_path eq 'daegubl'}">
		<h3>시설물(회의, 녹음) 사용 신청 안내</h3>
		<ul class="con">
			<li>사용 가능 대상: 시각장애인 이용자만 신청 가능합니다.</li>
			<li>예약 시기: 사용일 기준 최소 한 달 전 사전 예약 필수</li>
			<li>예약 확인: 신청 후 반드시 도서관으로 전화하여 예약 완료 여부를 확인해주세요.</li>
			<li>문의: [053-256-8877]</li>
		</ul>
	</c:if>

	<c:if test="${homepage.context_path eq 'yonghak'}">
		<c:if test="${param.menu_idx eq '143'}">
			<h3 style="margin-top:0;">이용방법</h3>
			<ul class="con">
				<li>신청서 작성 후 도서관 승인을 받고 해당시간 이용가능</li>
				<li>사전신청을 해야 하며, 신청일로부터 한 달간 예약 가능</li>
			</ul>

			<h3>신청인원</h3>
			<ul class="con">
				<li>2명 이상 신청가능<br />(※ 코로나19로 인해 최대이용가능 인원 : 4명)</li>
			</ul>

			<h3>이용시간</h3>
			<div class="rsv-info"></div>
			<div class="auto-scroll">
				<table class="tbl-type01" summary="용학도서관 독서토론실 이용시간을 안내해 드립니다.">
				  <caption class="disnone">
				  독서토론실 이용시간
				  </caption>
				  <colgroup>
				  <col width="*" class="col1">
				  <col width="25%" class="col2">
				  <col width="25%" class="col3">
				  <col width="25%" class="col4">
				  </colgroup>
				  <thead>
					<tr class="first">
					  <th scope="col" class="first th1">요일</th>
					  <th scope="col" class="th2" colspan="3">시간대</th>
					</tr>
				  </thead>
				  <tbody>
					<tr class="first">
					  <th scope="row" class="first th1">화~금요일</th>
					  <td class="td1">09:00~12:00</td>
					  <td class="td2">13:00~16:00</td>
					  <td class="last td3">17:00~20:00</td>
					</tr>
					<tr class="first">
					  <th scope="row" class="first th1">토·일요일</th>
					  <td class="td1">09:00~12:00</td>
					  <td colspan="2" class="last td2">13:00~16:00</td>
					</tr>
				  </tbody>
				</table>
			</div>

			<h3>유의사항</h3>
			<ul class="con">
				<li>독서토론과 관련 없는 활동은 사용불가 (종교, 보험, 사익 목적 등)</li>
				<li>두 차례 예약시간을 지키지 않을 경우, 두 달간 이용 제한</li>
				<li>시설 및 설비를 변경할 수 없으며, 특별한 경우 사전승인 요청</li>
				<li>마스크 착용 필수, 음식물 섭취 금지</li>
			</ul>

			<h3>신청</h3>
			<ul class="con">
				<li>전화 (053-668-1728) 및 방문 신청</li>
			</ul>
		</c:if>

		<c:if test="${param.menu_idx eq '185'}">
			<style>
				.img-box img{width:49%;}
			</style>

			<h3 style="margin-top:0;">대여 공간</h3>
			<ul class="con">
				<li>미디어콘텐츠랩 스튜디오 내부 시설 및 장비(편집실 제외)</li>
			</ul>
			<div class="img-box">
				<img src="/data/menuResources/h51/185/1677130442542.jpg">
				<img src="/data/menuResources/h51/185/1677130464919.jpg">
				<img src="/data/menuResources/h51/185/1677130473395.jpg">
				<img src="/data/menuResources/h51/185/1677130479584.jpg">
			</div>
			<br />
			<div class="rsv-info"></div>
			<div class="auto-scroll">
			<table class="tbl-type01" summary="용학도서관 시설물 제공 장비 안내">
			  <caption class="disnone">
				용학도서관 시설물 제공 장비 안내
			  </caption>
			  <colgroup>
			  <col width="25%">
			  <col width="15%">
			  <col width="5%">
			  <col width="25%">
			  <col width="15%">
			  <col width="5%">
			  </colgroup>
			  <thead>
				<tr>
				  <th colspan="3">기본 제공 장비</th>
				  <th colspan="3">신청 시 제공 장비</th>
				</tr>
				<tr>
				  <th class="no-line">항목</th>
				  <th class="no-line">규격</th>
				  <th class="no-line">수량</th>
				  <th class="no-line">항목</th>
				  <th class="no-line">규격</th>
				  <th class="no-line">수량</th>
				</tr>
			  </thead>
			  <tbody>
				  <tr>
					<td>크로마키 배경</td>
					<td>120&lsquo;</td>
					<td>1</td>
					<td>테이블</td>
					<td></td>
					<td>1</td>
				  </tr>
				  <tr>
					<td>카메라</td>
					<td>HXR-NX80</td>
					<td>1</td>
					<td>테이블보</td>
					<td></td>
					<td>1</td>
				  </tr>
				  <tr>
					<td>붐마이크</td>
					<td></td>
					<td>1</td>
					<td>의자</td>
					<td></td>
					<td>4</td>
				  </tr>
				  <tr>
					<td>카메라 삼각대</td>
					<td></td>
					<td>1</td>
					<td>조명</td>
					<td>EX600U</td>
					<td>2</td>
				  </tr>
				  <tr>
					<td>콘솔데스크</td>
					<td></td>
					<td>1</td>
					<td>무선마이크</td>
					<td>VWP-D21</td>
					<td>1</td>
				  </tr>
				  <tr>
					<td>모니터</td>
					<td>24&lsquo;</td>
					<td>1</td>
					<td>마이크(콘덴서)</td>
					<td>AKG C214</td>
					<td>2</td>
				  </tr>
				  <tr>
					<td></td>
					<td></td>
					<td></td>
					<td>마이크(다이나믹)</td>
					<td></td>
					<td>2</td>
				  </tr>
				  <tr>
					<td></td>
					<td></td>
					<td></td>
					<td>오디오인터페이스</td>
					<td></td>
					<td>1</td>
				  </tr>
			  </tbody>
			</table>
			</div>

			<h3>이용방법</h3>
			<ul class="con">
				<li>용학도서관 홈페이지 로그인 후 신청 가능</li>
				<li>매월 1일 09:00부터 신청 가능하며, 사용 희망일 2일 전(18:00 마감)까지 홈페이지 예약 시스템을 통해 이용 신청</li>
				<li>이용 당일 도서관에 방문하여 이용 신청서 및 이용 동의서 작성 후 제출</li>
				<li>신청자를 포함하여 최대 6명까지 이용 가능</li>
			</ul>

			<h3>이용 시간</h3>
			<ul class="con">
				<li>휴관일을 제외한 매주 수, 금 9:00~12:00 / 14:00~17:00 (회차별 3시간)</li>
				<li>오전 및 오후 각 1회 1팀 신청 가능, 1팀당 월 2회 이용가능 (단, 자관 및 협력 단체에 한하여 도서관장의 승인 후 특정 시간 및 요일의 반복적 사용 가능)</li>
				<li>이용 시간에는 준비 시간, 작업 시간, 종료 후 정리 시간을 포함한다.</li>
			</ul>

			<h3>취소 및 변경</h3>
			<ul class="con">
				<li>예약 2일전까지는 홈페이지에서, 2일전~전일까지는 전화(053-668-1721)로 취소 가능</li>
				<li>당일 취소 및 변경 불가</li>
				<li>예약 후 별도의 취소없이 대여를 하지 않은 경우 주의조치하며, 3회 누적 시 신청 제한</li>
			</ul>

			<h3>이용 수칙</h3>
			<ul class="con">
				<li>종교적·정치적인 목적 등 사회적으로 논란의 여지가 있는 경우 사용을 제한함</li>
				<li>입실 및 퇴실 절차는 본인이 직접하며 대리 신청 또는 타인에게 양도 할 수 없음</li>
				<li>예약 시간과 기일을 지켜 타 대여자에게 불이익이 생기지 않도록 함</li>
				<li>대여 중 사용자의 귀책 사유료 발생한 파손 및 분실에 대해서는 손해배상이나 원상회복을 해야 함</li>
				<li>미디어콘텐츠랩 내 음식물 반입 및 섭취를 금지함</li>
				<li>전열기 및 커피포트 등 화재 위험이 있는 물품 반입을 금지함</li>
				<li>대여 종료 후 시설은 원상복구하여야 하며, 쓰레기는 완전히 수거하여야 함</li>
			</ul>
		</c:if>
	</c:if>

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
										<!-- 20210903 YUNHAESU forEach break문 생성 -->
											<c:set var="loop_flag" value="false" />
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
													<c:if test="${not loop_flag}">
														<c:if test="${plan_date eq apply.use_date}">
														<c:choose>
															<c:when test="${apply.apply_status eq '신청'}">
															<span class="type-h"><i></i><em>${applyList[0].apply_status}</em></span><br>
															</c:when>
															<c:when test="${applyList[0].apply_status eq '승인'}">
															<span class="type-r"><i></i><em>${applyList[0].apply_status}</em></span><br>
															</c:when>
															<c:when test="${applyList[0].apply_status eq '취소'}">
															<span class="type-e"><i></i><em>${applyList[0].apply_status}</em></span><br>
															</c:when>
														</c:choose>
														<c:set var="loop_flag" value="true" />
														</c:if>
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
