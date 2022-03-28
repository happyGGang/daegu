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

	<%--수정--%>
	$('a.modify').on('click', function(event) {
		if ('${authU}' == 'false') {
			alert('권한이 없습니다.');
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&mediaFactory_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		event.preventDefault();
	});

	<%--대관신청--%>
	$('a#apply').on('click', function(event) {
		$('#dialog-2').load('/cms/module/mediaFactory/apply/edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&mediaFactory_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') +'&start_time=' + $(this).attr('keyValue3') +'&end_time=' + $(this).attr('keyValue4'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		event.preventDefault();
	});

	<%--신청자확인--%>
	$('a#check_apply').on('click', function(event) {
		$('#dialog-3').load('/cms/module/mediaFactory/apply/applyEdit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&mediaFactory_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2') + '&use_time=' + $(this).attr('keyValue3') +'&start_time=' + $(this).attr('keyValue4') +'&end_time=' + $(this).attr('keyValue5'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});

		event.preventDefault();
	});

	$('a#excelDownload').on('click', function(event) {
		event.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#mediaFactory').attr('action','/cms/module/mediaFactory/apply/excelDownloadMonth.do').submit();
	});

	$('a#totalExcelDownload').on('click', function(event) {
		event.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#plan_date').val("");
		$('#mediaFactory').attr('action','/cms/module/mediaFactory/apply/excelDownload.do').submit();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#mediaFactory').attr('action', '/cms/module/mediaFactory/apply/csvDownloadMonth.do').submit();
	});

	$('a#totalCsvDownload').on('click', function(e) {
		e.preventDefault();

		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#plan_date').val("");
		$('#mediaFactory').attr('action', '/cms/module/mediaFactory/apply/csvDownload.do').submit();
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

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#mediaFactory')));

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

		var planDate = year + '-' + (month < 10 ? '0'+month : month);
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#mediaFactory')));

	});

	$('#plan_year,#plan_month').on('change', function(e) {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#mediaFactory')));
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', 'plan_date=' + $('#plan_date').val()+'&homepage_id='+$('#homepage_id_1').val());
		}

		e.preventDefault();
	});

	$('td.top').height(150);

	var allChecked = false;	
	$('a#allChecked').on('click', function(e) {
		e.preventDefault();
		allChecked = !allChecked;
		$('input[name = mediaFactory_idx_arr]').prop('checked', allChecked);
	});
	
	$('a#checkedDelete').on('click', function(e) {	
		e.preventDefault();
		if ($('input[name=mediaFactory_idx_arr]:checked').length < 1) {
			alert('선택된 일자가 없습니다.');
			return false;
		}
		if(confirm('선택된 신청을 삭제 하시겠습니까?\n삭제시 신청자 정보등 모든 관련된 정보도 같이 삭제되며 복구 불가능합니다.')){
			$('form#mediaFactory').attr('action','save.do');
			$('form#mediaFactory').attr('method','post');
			$('form#mediaFactory input#editMode').val('BATCHDELETE');
			if (doAjaxPost($('form#mediaFactory'))) {
				location.reload();
			}
		}
	});
});
</script>
<form:form modelAttribute="mediaFactory" action="" id="mediaFactory">
<form:hidden path="plan_date"/>
<form:hidden path="editMode"/>
<%--<form:hidden id="homepage_id_1" path="homepage_id"/>--%>

<div class="infodesk">
	<c:choose>
		<c:when test="${fn:length(subHomepageList) > 0}">
			<span>
			도서관 : <form:select id="homepage_id_1" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
			</span>
			<br/>
		</c:when>
		<c:otherwise>
			<form:hidden id="homepage_id_1" path="homepage_id"/>
		</c:otherwise>
	</c:choose>
	<div class="monthYear">
		<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<form:select path="plan_year" class="selectmenu" style="width:100px;"></form:select>
        <form:select path="plan_month" class="selectmenu" style="width:100px;"></form:select>
        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
    </div>
	<div class="button">
		<a href="#" id="allChecked" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체선택/취소</span></a>&nbsp;&nbsp;
		<a href="#" id="checkedDelete" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>선택삭제</span></a>&nbsp;&nbsp;
		<a href="#" id="totalExcelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체 엑셀저장</span></a>&nbsp;&nbsp;
		<a href="#" id="excelDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp;
		<a href="#" id="totalCsvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>전체 CSV저장</span></a>&nbsp;&nbsp;
		<a href="#" id="csvDownload" class="btn btn3"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;
		<c:if test="${authC}">
		<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>신청가능일 관리</span></a>
		</c:if>
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
						<td class="top" style="vertical-align: top;">
							<div style="background: #ff4e4e; color: white; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sun}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.mon eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.mon}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.tue eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.tue}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.wed eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.wed}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.thu eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.thu}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.fri eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #e6e6e6; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.fri}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${i.sat eq null}">
						<td class="top none"></td>
					</c:when>
					<c:otherwise>
						<td class="top" style="vertical-align: top;">
							<div style="background: #dee7f9; margin-bottom: 5px;font-size: 15px;font-weight: bold;">${i.sat}</div>
							<c:set var="plan_date" value="${mediaFactory.plan_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}" />
							<tag:mediaFactory plan_date="${plan_date}" mediaFactoryList="${mediaFactoryList}" mode="admin" />
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="미디어창작소등록">
</div>
<div id="dialog-2" class="dialog-common" title="대관신청">
</div>
<div id="dialog-3" class="dialog-common" title="신청자확인">
</div>