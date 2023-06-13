<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>

<c:if test="${homepage.context_path eq 'beomeo'}">
<style>
	.tbl-type01 td img{height:170px;}
	.step_box {margin-top:20px;}

	.time_box {margin-bottom:20px;}
	.time_box ul li {margin-bottom: 0;}

	.time_box ul li div {padding-left: 110px;}

	.time_box ul li span {font-size: 18px; letter-spacing: -0.25px;}

	@media all and (max-width: 768px) {
		.m_dp_none {display: none;}
	}

	@media all and (max-width: 767px) {
		.time_box ul li div {padding-left: 0;}
	}
</style>


<h3>이용방법</h3>
<div class="step_box">
  <ol class="no3">
    <li>
      <div class="box">
        <p class="num">STEP 01</p>
        홈페이지 로그인 후 신청<br>
        * 사용 희망일 2일 전(18:00)까지 이용 신청</div>
    </li>
    <li>
      <div class="box">
        <p class="num">STEP 02</p>
        이용 전 사용 매뉴얼<br>영상 시청</div>
    </li>
    <li>
      <div class="box">
        <p class="num">STEP 03</p>
        이용 당일 도서관 방문하여 이용 신청서 및 동의서 작성 후 제출</div>
    </li>
  </ol>
</div>
<p>※ 신청자 포함 최대 4명 이용 가능<br>
  ※ 개인용 이동형저장장치 지참(usb, sd카드 등)
</p>
<br>

<div class="time_box">
  <ul>
    <li class="book02 mb10" style="margin-right:20px;">
      <div>
        <span class="pc_mode">취소방법</span><span class="m_mode">이용시간</span>
        <p>- 예약 2일 전까지 홈페이지 취소 가능강좌<br>
          - 2일전~전일까지는 053-668-1624로 전화 후 취소<br>
          - 당일 취소 및 변경 불가(NO Show 3회 시 신청 제한)</p>
          <br><br><br>
      </div>
    </li>
    <li class="book03 mb10">
      <div>
        <span class="pc_mode">이용시간</span><span class="m_mode">이용시간</span>
        <p>- 오전 09:00~12:00(3시간)<br>
          - 오후 14:00~17:00(3시간)<br>
          - 이용불가: 일요일 및 휴관일, 미디어창작소 사용 프로그램 진행일</p>
          <p>※ 1팀당 월 4회 이용 가능하며 1일 1회 이용 가능합니다.<br>
            ※ 준비 및 철수 시간이 이용시간에 포함됩니다.</p>
      </div>
    </li>
  </ul>
</div>
<br>

<h3>이용수칙</h3>
<div class="time_box">
  <ul>
    <li class="book14 mb10" style="width: 100%;">
      <div>
        <span class="pc_mode">시설 사용이 <span style="color: red;">제한</span>되는 경우</span><span class="m_mode">시설 사용이 <span style="color: red;">제한</span>되는 경우</span>
        <p>- 전도·포교 등 종교적 목적, 정치적 목적 등으로 사회적 논란의 여지가 있는 경우<br>
          - 도서관의 운영목적과 운영방향에 위배되는 경우<br>
          - 영상 제작 외 공간 사용 목적과 부합되지 않는 경우<br>
          - 예약 후 별도의 취소 없이 3회 이상 이용하지 않을 경우<br>
          - 이용시간을 초과하거나 시설을 제3자에게 양도할 경우<br>
          - 장비와 시설을 훼손할 우려가 있거나 부적절한 사용이 예상될 경우</p>
      </div>
    </li>
  </ul>
</div>
<div class="time_box">
  <ul>
    <li class="book10 mb14" style="width: 100%;">
      <div>
        <span class="pc_mode" style="color: red;">금지합니다</span><span class="m_mode" style="color: red;">금지합니다</span>
        <p>- 음식물 반입 및 섭취<br>
          - 대여 범위 외 허가받지 않은 물품의 사용 (전열기 및 커피포트 등 화재위험이 있는 물품 등)<br>
          - 대리 신청 및 제3자에게 양도<br>
          - 그 외 도서관 조례나 운영규정에 위배되는 행위</p>
      </div>
    </li>
  </ul>
</div>
<br>

<h3>참고사항</h3>

<div class="time_box">
  <ul>
    <li class="book13 mb13" style="width: 100%;">
      <div>
        <span class="pc_mode">이용 범위: 미디어 창작소 내부 시설 및 장비</span><span class="m_mode">이용 범위: 미디어 창작소 내부 시설 및 장비</span>
        <p>- 영상장비 및 오디오장비, 영상 편집 프로그램 등<br>
          - 프리미어프로 계정 공유 불가<br>
          - 장비 외부 유출 불가</p>
      </div>
    </li>
  </ul>
</div>
<div class="time_box">
  <ul>
    <li class="book10 mb10" style="width: 100%;">
      <div>
        <span class="pc_mode">유의사항</span><span class="m_mode">유의사항</span>
        <p>- 신청자와 담당자가 함께 사용전·후 품목, 작동상태, 파손여부를 점검해야 한다. 대여자의 귀책사유로 시설(장비포함)을 파손·분실하였을 경우에는 동일한 시설(장비)로 변상해야한다. 다만, 단종된 장비는 그와 동등한 장비로 변상해야 한다.</p>
        <p>- 시설(장비포함)을 대여하여 제작한 콘텐츠에 대한 저작권 분쟁 발생 시 범어도서관은 이에 대해 책임을 지지 않는다.</p>
        <p>- 대여자에게 매뉴얼 외 별도의 이용교육을 제공하지 않는다.</p>
      </div>
    </li>
  </ul>
</div>
<br>
</c:if>


<script type="text/javascript">
$(function(){

	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${mediaFactory.plan_date}'.split('-');
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
			$('#mediaFactory #pageType').val('ajax');
			$('#tabCon2').load('module/mediaFactory/index.do?'+serializeCustom($('#mediaFactory')));
		} else {
			doGetLoad('index.do', serializeCustom($('#mediaFactory')));
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

	<%--대관신청--%>
	$('a#apply').on('click', function(event) {
		if($('#pageType').val() == 'ajax') {
			$('#tabCon2').load('/${homepage.context_path}/module/mediaFactory/edit.do', 'editMode=ADD&mediaFactory_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') + '&start_time=' + $(this).attr('keyValue3') +'&end_time=' + $(this).attr('keyValue4') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val()+'&homepage_id=' + $('input#homepage_id_1').val());
		} else {
			doGetLoad('/${homepage.context_path}/module/mediaFactory/edit.do', 'editMode=ADD&mediaFactory_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') + '&start_time=' + $(this).attr('keyValue3') +'&end_time=' + $(this).attr('keyValue4') + '&menu_idx=' + $('#menu_idx').val() + '&pageType=' + $('#pageType').val() + '&date_type=' + $('#date_type').val()+'&homepage_id=' + $('input#homepage_id_1').val());
		}

		event.preventDefault();
	});

	$('.monthYear').prepend(year + "년");
	});

	function setMonthSelect() {
		var plan_date = '${mediaFactory.plan_date}';
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
		doGetLoad('index.do', serializeCustom($('#mediaFactory')));
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
			$('#mediaFactory #pageType').val('ajax');
			$('#tabCon2').load('module/mediaFactory/index.do?' + serializeCustom($('#mediaFactory')));
		} else {
			doGetLoad('index.do', serializeCustom($('#mediaFactory')));
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
			$('#mediaFactory #pageType').val('ajax');
			$('#tabCon2').load('module/mediaFactory/index.do?' + serializeCustom($('#mediaFactory')));
		} else {
			doGetLoad('index.do', serializeCustom($('#mediaFactory')));
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
	var a = '${fn:escapeXml(mediaFactory.homepage_id)}';
	$('div.tab_menu a[data-hid="'+a+'"]').parent().addClass('active');

	$('div.tab_menu a').on('click', function(e) {
		e.preventDefault();
		var hid = $(this).data('hid');
		$('input#homepage_id_1').val(hid);
		doGetLoad('index.do', serializeCustom($('#mediaFactory')));
	});
	</c:if>
});
</script>
<form:form modelAttribute="mediaFactory">
<form:hidden path="plan_date"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pageType"/>
<form:hidden path="date_type"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<c:choose>
		<c:when test="${homepage.context_path eq 'donggu'}">
			<div class="tab_menu on">
				<ul class="no1">
					<li class="active" style="width:100%;"><a href="#tabCon1" data-hid="h73">안심도서관</a></li>
				</ul>
			</div>
			<div class="mg30t"></div>
		</c:when>
		<c:otherwise>
			<c:if test="${fn:length(subHomepageList) > 0}">
				<div class="tab_menu on">
					<ul class="no${fn:length(subHomepageList)}">
						<c:forEach items="${subHomepageList}" var="i" varStatus="status">
							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="mg30t"></div>
			</c:if>
		</c:otherwise>
	</c:choose>
<%-- 	<c:if test="${fn:length(subHomepageList) > 0}"> --%>
<!-- 		<div class="tab_menu on"> -->
<%-- 			<ul class="no${fn:length(subHomepageList)}"> --%>
<%-- 				<c:forEach items="${subHomepageList}" var="i" varStatus="status"> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${i.homepage_id eq 'h73'}"> --%>
<%-- 							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">안심도서관</a></li> --%>
<%-- 						</c:when> --%>
<%-- 						<c:when test="${i.homepage_id eq 'h59'}"> --%>
<%-- 							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">신천도서관</a></li> --%>
<%-- 						</c:when> --%>
<%-- 						<c:when test="${i.homepage_id eq 'h60'}"> --%>
<%-- 							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">반야월역사</a></li> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 				</c:forEach> --%>
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 		<div class="mg30t"></div> -->
<%-- 	</c:if> --%>

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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />							
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin" />
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<ul>
								<tag:mediaFactoryUser member_id="${member_id}" plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" calendarManageList="${calendarManageList}" applyList="${applyList}" mode="admin"/>
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
