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
	var planDate = '${facility.plan_date}'.split('-');
	for ( var i = 0; i < 15; i ++ ) {
		var optionYear = (year + 1 - i);
		var selectedAttr = '';

		if ( optionYear == planDate[0] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#facilityListForm #plan_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == planDate[1] ) {
			selectedAttr = 'selected="selected"';
		}

		$('#facilityListForm #plan_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}

	$('a#before-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#facilityListForm #plan_year').val();
		var month = $('#facilityListForm #plan_month').val();

		if(month == 1) {
			year = parseInt(year)-1;
			month = 12;
		} else {
			month =  parseInt(month)-1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#facilityListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityListForm')));

	});

	$('a#next-btn').on('click', function(event) {
		event.preventDefault();

		var year = $('#facilityListForm #plan_year').val();
		var month = $('#facilityListForm #plan_month').val();

		if(month == 12) {
			year = parseInt(year)+1;
			month = 1;
		} else {
			month =  parseInt(month)+1;
		}

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#facilityListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityListForm')));

	});

	$('#facilityListForm #plan_year,#facilityListForm #plan_month').on('change', function(e) {
		var planDate = $('#facilityListForm #plan_year').val() + '-' + $('#facilityListForm #plan_month').val();
		$('#facilityListForm #plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#facilityListForm')));
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#facilityListForm').submit();
		}
		e.preventDefault();
	});

	$('a#dialog-add').on('click', function(e) {
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&facility_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 시설물을 삭제 하시겠습니까?') ) {
			$('#hiddenForm #facility_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a.dialog-req').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('editApply.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&facility_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	$('a.dialog-apply-list').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('applyList.do?homepage_id=' + $('#homepage_id_1').val() + '&facility_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});

	$('a#excelDownload').on('click', function(e) {
		$('#hiddenForm #excel_type').val('PLAN');
		$('#hiddenForm #plan_date').val($('#facilityListForm #plan_date').val());
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#totalExcelDownload').on('click', function(e) {
		$('#hiddenForm #excel_type').val('FULL');
		$('#hiddenForm #plan_date').val($('#facilityListForm #plan_date').val());
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		alert('CSV 다운로드는 시설물 리스트와 신청자리스트가 한 페이지 안에서 보여집니다.');
		$('#hiddenForm #excel_type').val('PLAN');
		$('#hiddenForm #plan_date').val($('#facilityListForm #plan_date').val());
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
		e.preventDefault();
	});

	$('a#totalCsvDownload').on('click', function(e) {
		alert('CSV 다운로드는 시설물 리스트와 신청자리스트가 한 페이지 안에서 보여집니다.');
		$('#hiddenForm #excel_type').val('FULL');
		$('#hiddenForm #plan_date').val($('#facilityListForm #plan_date').val());
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
		e.preventDefault();
	});

	$('td.top').height(150);
});
</script>
<form:form id="hiddenForm" modelAttribute="facility" action="save.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="plan_date"/>
	<form:hidden path="excel_type"/>
</form:form>
<form:form id="facilityListForm"  modelAttribute="facility" action="index.do" >
	<form:hidden path="plan_date"/>
	<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		<div class="monthYear">
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<form:select path="plan_year" class="selectmenu" style="width:100px;"></form:select>
	        <form:select path="plan_month" class="selectmenu" style="width:100px;"></form:select>
	        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	    </div>
		<div class="button">
			<a href="#" id="totalExcelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체 엑셀저장</span></a>&nbsp;&nbsp;
			<a href="#" id="excelDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp;
			<a href="#" id="totalCsvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체 CSV저장</span></a>&nbsp;&nbsp;
			<a href="#" id="csvDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>신청가능일 관리</span></a>
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
									<c:set var="planDate" value="${facility.plan_date}-${i.sun < 10?'0':''}${i.sun}"/>
									<div style="background: #ff4e4e; color: white; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sun}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.mon eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.mon < 10?'0':''}${i.mon}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.mon}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.tue eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.tue < 10?'0':''}${i.tue}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.tue}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.wed eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.wed < 10?'0':''}${i.wed}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.wed}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.thu eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.thu < 10?'0':''}${i.thu}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.thu}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.fri eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.fri < 10?'0':''}${i.fri}"/>
									<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.fri}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${i.sat eq null}">
								<td class="top none"></td>
							</c:when>
							<c:otherwise>
								<td class="top" style="vertical-align: top; max-width: 80px;">
									<c:set var="planDate" value="${facility.plan_date}-${i.sat < 10?'0':''}${i.sat}"/>
									<div style="background: #dee7f9; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sat}</div>
									<c:forEach items="${facilityRepo[planDate]}" var="one">
										<div style="margin-bottom:5px; text-align:left;">
											<a class="btn btn4 dialog-modify" keyValue="${one.facility_idx}">${one.facility_name}</a><br/>
											<a class="btn btn3 dialog-req" keyValue="${one.facility_idx}">신청</a><a class="btn btn1 dialog-apply-list list_${one.facility_idx}" keyValue="${one.facility_idx}">현황(${one.apply_count})</a><a class="btn delete-btn" keyValue="${one.facility_idx}">삭제</a><br/>
										</div>
									</c:forEach>
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="시설물 정보"></div>
<div id="dialog-2" class="dialog-common" title="시설물 신청 정보"></div>
<div id="dialog-3" class="dialog-common" title="시설물 신청 현황"></div>