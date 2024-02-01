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
	var planDate = '${excursions.plan_date}'.split('-');
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
		if($('#pageType').val() == 'ajax') {
			$('#excursions #pageType').val('ajax');
			$('#tabCon2').load('module/excursions/index.do?'+serializeCustom($('#excursions')));
		} else {
			doGetLoad('index.do', serializeCustom($('#excursions')));
		}
	});

	$('a.modify').on('click', function(event) {
		if($(this).attr('type') == 'calendar') {
			doGetLoad('/${homepage.context_path}/module/calendarManage/edit.do', 'editMode=MODIFY&category_idx='+$(this).attr('keyValue2')+'&teach_idx='+$(this).attr('keyValue3')+'&homepage_id=' + $('input#homepage_id_1').val());
		} else if ($(this).attr('type') == 'teach') {
			doGetLoad('/${homepage.context_path}/module/teach/edit.do', 'editMode=MODIFY&category_idx=' + $(this).attr('keyValue') + '&teach_idx=' + $(this).attr('keyValue2')+ '&menu_idx=' + $('#menu_idx').val()+'&homepage_id=' + $('input#homepage_id_1').val());
		}
		event.preventDefault();
	});

	$(document).ready(function() {
		if(month < 10) {
			month = "0" + month;
		}
		setMonthSelect();

	<%--견학신청--%>
	$('a#apply').on('click', function(event) {
		if($('#pageType').val() == 'ajax') {
			$('#tabCon2').load('/${homepage.context_path}/module/excursions/edit.do', 'editMode=ADD&excursions_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') + '&date_type=' + $(this).attr('keyValue3') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val()+'&homepage_id=' + $('input#homepage_id_1').val());
		} else {
			doGetLoad('/${homepage.context_path}/module/excursions/edit.do', 'editMode=ADD&excursions_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') + '&date_type=' + $(this).attr('keyValue3') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val() +'&homepage_id=' + $('input#homepage_id_1').val());
		}

		event.preventDefault();
	});

	$('.monthYear').prepend(year + "년");
	});

	function setMonthSelect() {
		var plan_date = '${excursions.plan_date}';
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
		doGetLoad('index.do', serializeCustom($('#excursions')));
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

		if( month < 10 ) {
			var planDate = year + '-0' + month;
		} else {
			var planDate = year + '-' + month;
		}
		$('#plan_date').val(planDate);

		if($('#pageType').val() == 'ajax') {
			$('#excursions #pageType').val('ajax');
			$('#tabCon2').load('module/excursions/index.do?' + serializeCustom($('#excursions')));
		} else {
			doGetLoad('index.do', serializeCustom($('#excursions')));
		}

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

		if( month < 10 ) {
			var planDate = year + '-0' + month;
		} else {
			var planDate = year + '-' + month;
		}
		$('#plan_date').val(planDate);

		if($('#pageType').val() == 'ajax') {
			$('#excursions #pageType').val('ajax');
			$('#tabCon2').load('module/excursions/index.do?' + serializeCustom($('#excursions')));
		} else {
			doGetLoad('index.do', serializeCustom($('#excursions')));
		}

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

	<c:if test="${fn:length(subHomepageList) > 0}">
	var a = '${fn:escapeXml(excursions.homepage_id)}';
	$('div.tab_menu a[data-hid="'+a+'"]').parent().addClass('active');

	$('div.tab_menu a').on('click', function(e) {
		e.preventDefault();
		var hid = $(this).data('hid');
		$('input#homepage_id_1').val(hid);
		doGetLoad('index.do', serializeCustom($('#excursions')));
	});
	</c:if>
});
</script>
<form:form modelAttribute="excursions">
<form:hidden path="plan_date"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pageType"/>
<form:hidden path="date_type"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<c:if test="${fn:length(subHomepageList) > 0}">
		<div class="tab_menu on">
			<ul class="no${fn:length(subHomepageList)}">
				<c:forEach items="${subHomepageList}" var="i" varStatus="status">
					<c:choose>
						<c:when test="${i.homepage_id eq 'h73'}">
							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">안심도서관</a></li>
						</c:when>
						<c:when test="${i.homepage_id eq 'h59'}">
							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">신천도서관</a></li>
						</c:when>
						<c:when test="${i.homepage_id eq 'h60'}">
							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">작은도서관</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
		<div class="mg30t"></div>
	</c:if>

	<c:if test="${homepage.context_path eq 'dalseolib'}">
		<c:choose>
			<c:when test="${param.homepage_id eq 'h72' || param.homepage_id eq '' || param.homepage_id eq null}">
			<!-- 도원 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			<ul class="con">
			  <li>일시: 매달 마지막 수요일 11:00~12:00
			  <li>장소: 도원도서관 1층 유아자료실</li>
			  <li>인원: 15명 이내</li>
			  <li>문의: 667-4821</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:when test="${param.homepage_id eq 'h66'}">
			<!-- 어린이 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
			  </div>
			</div>
			<p style="color:#ff0000;font-weight:bold;margin-bottom:10px;font-size:18px;">
				달서어린이도서관 일반견학은 책이랑놀이랑 프로그램으로 대체합니다.</span>
			</p>
			<ul class="con">
			  <li>일시: 매주 월요일, 목요일 10:30~11:30</li>
			  <li>장소: 달서어린이도서관 1층 책놀이터</li>
			  <li>인원: 20명 이내(반드시 만3세 이상, 15명 이상 지도교사 3명 필수)</li>
			  <li>문의: 667-4852</li>
        <li>신청기간: 견학일 이전 월 1일~마지막 주 수요일</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:when test="${param.homepage_id eq 'h68'}">
			<!-- 성서 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			<ul class="con">
			  <li>일시: 매주 화요일 10:30~11:30</li>
			  <li>장소: 본리도서관 1층 유아열람실</li>
			  <li>인원: 20명 이하</li>
			  <li>문의: 667-4915</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:when test="${param.homepage_id eq 'h69'}">
			<!-- 달서가족 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			<ul class="con">
			  <li>장소: 달서가족문화도서관 1층</li>
			  <li>유아자료실인원: 20명 이내</li>
			  <li>문의: 667-4968</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:when test="${param.homepage_id eq 'h70'}">
			<!-- 영어 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			<ul class="con">
			  <li>일시: 매주 목요일 10:00~11:00</li>
			  <li>장소: 달서영어도서관 3층 키즈룸</li>
			  <li>인원: 20명 이내</li>
			  <li>문의: 667-4875</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:when test="${param.homepage_id eq 'h67'}">
			<!-- 성서 -->
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			<ul class="con">
			  <li>일시: 매주 목요일 10:00~11:00</li>
			  <li>장소: 성서도서관 1층 책나라 여행&도란도란 샘터</li>
			  <li>인원: 20명 이내</li>
			  <li>문의: 667-4886</li>
			  <li>주의사항
			  	<ul class="con2">
					<li>견학 시간 준수</li>
				</ul>
			  </li>
			</ul>
			</c:when>
			<c:otherwise>
			<div class="roomicon">
			  <div class="inner icowrap"><span class="ico ico6"></span> <strong>도서관 견학신청</strong>
				<p>어린이,청소년들이 도서관에 대한 이해와 흥미를 높이고, 보다 편리하게 도서관을 이용할 수 있도록 도움을 주기 위한 견학 프로그램 운영</p>
				<!-- <p style="color:#ff0000;">코로나-19 확산 방지를 위해 별도 공지 시까지 단체 견학신청을 받지 않습니다.</p> -->
			  </div>
			</div>
			</c:otherwise>
		</c:choose>
	</c:if>

	<c:if test="${homepage.context_path eq 'dalseong'}">
		<div class="summaryDesc">
			<div class="innerBox">
				<div class="img ticon_05"></div>
				<div class="desc">
					<h3>도서관체험학습</h3>
					<p>올바른 도서관 이용법 교육하고, 자라나는 어린이들에게 책 읽는 즐거움과 흥미를 심어주고자 도서관체험학습을 운영합니다.</p>
				</div>
			</div>
		</div>
		<h3>도서관체험학습안내</h3>
		<ul class="con">
			<li><strong>운영대상</strong> : 도서관 인근 유치원 및 어린이집(만2세~만5세(4~7세))</li>
			<li><strong>운영기간</strong> : 상반기(3~6월) / 하반기(9~11월) 매주 수,목요일</li>
			<li><strong>운영방법</strong> : 1일 1회 15명 내외, 기관별 4회 이내(20명 초과 시 장소 협소할 수 있음)</li>
			<li><strong>운영내용</strong> : 도서관 이용교육 및 자율독서 등</li>
			<li><strong>참가신청</strong> : 로그인 → ‘신청’ 버튼이 활성화되어 있는 날짜 선택 후 신청 → 신청 양식 작성 → 견학 신청 후 ‘승인완료’ 처리 여부를 반드시 확인</li>
			<li><strong>유의사항</strong>
				<ul class="con2">
					<li>견학 취소 시 사전에 미리 알려주셔야 하며, 견학 일정은 도서관사정에 따라 변경될 수 있습니다.</li>
					<li>신청은 온라인을 통해서만 가능합니다.</li>
				</ul>
			<li>
			<li><strong>문 의 처</strong> : 053-231-2175~6</li>
		</ul>
		<ul class="btns_wrap_tac">
			<li>
			<a href="/board/boardFile/download/19/510110/340144.do" class="btn_link02" title="도서관 체험학습 신청서" target="_blank">
				<span>신청서 다운로드</span><span class="ico ico_link"></span>
			</a>
			</li>
		</ul>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${excursions.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<ul>
								<tag:excursionsUser plan_date="${plan_date}" excursionsList="${excursionsList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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