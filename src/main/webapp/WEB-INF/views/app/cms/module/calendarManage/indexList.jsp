<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var planDate = '${calendarManage.plan_date}'.split('-');
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

	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		event.preventDefault();
	});

	//모달창 링크 버튼
	$('a#dialog-add-las').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		var date = $('select#plan_year option:selected').val() + '년 ' + $('select#plan_month option:selected').val() + '월';
		if (confirm(date + '\n자료관리에서 휴관일정보를 가져오시겠습니까?\n\n* 자료관리에서 가져온 휴관일은 자동 등록되며 기존 등록된 데이터와 중복 될 수 있습니다.')) {
			$('form#calendarManage').attr('action', 'getLasHolidays.do');
			$('form#calendarManage').attr('method', 'POST');
			if (doAjaxPost($('form#calendarManage'))) {
				location.reload();
			}
		}

		event.preventDefault();
	});

	//모달창 링크 버튼
	$('a#dialog-add-las-year').on('click', function(event) {
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		var date = $('select#plan_year option:selected').val() + '년 ';
		if (confirm(date + '\n자료관리에서 휴관일정보를 가져오시겠습니까?\n\n* 자료관리에서 가져온 휴관일은 자동 등록되며 기존 등록된 데이터와 중복 될 수 있습니다.')) {
			$('form#calendarManage').attr('action', 'getLasHolidaysYear.do');
			$('form#calendarManage').attr('method', 'POST');
			if (doAjaxPost($('form#calendarManage'))) {
				location.reload();
			}
		}

		event.preventDefault();
	});

	<%--수정--%>
	$('a.modify').on('click', function(event) {
		if($(this).attr('type') == 'calendar') {
			$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id_1').val()+'&cm_idx=' + $(this).attr('keyValue') + '&date_type=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		} else if ($(this).attr('type') == 'teach') {
			$('#dialog-2').load('/cms/module/teach/edit.do?editMode=VIEW&homepage_id='+$('#homepage_id_1').val()+ '&group_idx=' +$(this).attr('keyValue3')+'&category_idx=' + $(this).attr('keyValue') + '&teach_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});
		} else if ($(this).attr('type') == 'excursions') {
			$('#dialog-3').load('/cms/module/excursions/apply/applyEdit.do?editMode=VIEW&homepage_id=' + $('#homepage_id_1').val() + '&excursions_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
				$('#dialog-3').dialog('open');
			});
		}

		event.preventDefault();
	});

	$('#plan_year,#plan_month').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('indexList.do', serializeCustom($('#calendarManage')));
	});

	$('select#homepage_id_1').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('indexList.do', serializeCustom($('#calendarManage')));
		}

		e.preventDefault();
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
		month = month < 10 ? "0"+month : month;
		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('indexList.do', serializeCustom($('#calendarManage')));

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

		month = month < 10 ? "0"+month : month;

		var planDate = year + '-' + month;
		$('#plan_date').val(planDate);
		doGetLoad('indexList.do', serializeCustom($('#calendarManage')));

	});

	$('a#changeView').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', serializeCustom($('#calendarManage')));
	});


});
</script>
<c:set var="plan_date" value="${fn:split(calendarManage.plan_date, '-')}" />
<div class="container-box">
    <div class="page-header">
        <div>일정관리</div>
    </div>
    <div class="main-content">
        <div style="width: 100%">
            <form:form modelAttribute="calendarManage">
            <form:hidden path="plan_date"/>
            <c:choose>
                <c:when test="${fn:length(subHomepageList) > 0}">
                    도서관 :
                    <form:select id="homepage_id_1" path="homepage_id">
                        <c:forEach items="${subHomepageList}" var="i">
                            <form:option value="${i.homepage_id}">${i.homepage_name}</form:option>
                        </c:forEach>
                        <c:if test="${asideHomepageId eq 'h53'}">
                            <form:option value="h78">작은도서관</form:option>
                        </c:if>

                    </form:select>
                </c:when>
                <c:otherwise>
                    <form:hidden id="homepage_id_1" path="homepage_id"/>
                </c:otherwise>
            </c:choose>

            <div class="table-action-wrapper">
                <div class="monthYear btn-wrapper">
                    <a id="before-btn" href="#prev" class="custom-btn" style="padding: 8px 10px"><span class="blind" ><img src="/resources/cms/img/main/arrow.svg" alt="" style="transform: rotate(180deg)"/> </span></a>
                    <form:select path="plan_year" class="custom-filter" style="width:100px;"></form:select>
                    <form:select path="plan_month" class="custom-filter" style="width:100px;"></form:select>
                    <a id="next-btn" href="#next" class="custom-btn" style="padding: 8px 10px"><span class="blind"><img src="/resources/cms/img/main/arrow.svg" alt=""/> </span></a>
                </div>
                <div class="btn-wrapper">
                    <div class="button btn-group inline">
                        <a href="" class="icon-btn navy" id="changeView"><img src="/resources/cms/img/main/plus.svg" alt=""><span>달력형 전환</span></a>
                    </div>
                    <div class="button btn-group inline">
                        <a href="" class="icon-btn navy" id="dialog-add"><img src="/resources/cms/img/main/plus.svg" alt=""><span>일정등록</span></a>
                    </div>
                    <c:if test="${calendarManage.homepage_id ne 'h78'}">
                    <div class="button btn-group inline">
                        <a href="" class="icon-btn navy" id="dialog-add-las"><img src="/resources/cms/img/main/plus.svg" alt=""><span>자료관리 휴관일 가져오기(월단위)</span></a>
                    </div>
                    <div class="button btn-group inline">
                        <a href="" class="icon-btn navy" id="dialog-add-las-year"><img src="/resources/cms/img/main/plus.svg" alt=""><span>자료관리 휴관일 가져오기(년단위)</span></a>
                    </div>
                    </c:if>
                </div>
            </div>
        </form:form>
            <div class="table-wrap" id="calTable">
		<table class="custom-table">
			<thead>
				<tr>
					<th scope="col" style="width: 200px">일자</th>
					<th scope="col">내용</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="i" varStatus="status" items="${calendarListType}">
				<tr>
					<fmt:formatDate value="${i.days}" pattern="yyyy-MM-dd" var="dateStr"/>
					<c:choose>
						<c:when test="${i.weekday eq 1}">
					<th class="center" style="color: red;">${dateStr}</th>
						</c:when>
						<c:when test="${i.weekday eq 7}">
					<th class="center" style="color: blue;">${dateStr}</th>
						</c:when>
						<c:otherwise>
					<th class="center">${dateStr}</th>
						</c:otherwise>
					</c:choose>
					<td class="top" style="text-align: left;">
						<tag:calendarManage plan_date="${dateStr}" calendarManageList="${calendarManageList}" okApplyList="${okApplyList}"  teachList="${teachList}" facilityReqList="${facilityReqList}" moveList="${moveList}" mode="admin" dayCode="${i.weekday}"/>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
        </div>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="일정등록">
</div>
<div id="dialog-2" class="dialog-common" title="강좌상세보기">
</div>
<div id="dialog-3" class="dialog-common" title="견학신청자내역">
</div>