<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
jQuery.fn.monthYearPicker = function(options) {
	  options = $.extend({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    showAnim: "",
	    closeText: "선택",
	    onChangeMonthYear: writeSelectedDate
//	    beforeShow: pickupDate
	  }, options);
	  function writeSelectedDate(year, month, inst ){
	   var thisFormat = jQuery(this).datepicker("option", "dateFormat");
	   var d = jQuery.datepicker.formatDate(thisFormat, new Date(year, month-1, 1));
	   inst.input.val(d);
	  }
	  function hideDaysFromCalendar() {
	    var thisCalendar = $(this);
	    jQuery('.ui-datepicker-calendar').detach();
	    jQuery('.ui-datepicker-close').click(function() {
	      var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	      var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	      thisCalendar.datepicker('setDate', new Date(year, month, 1));
	      thisCalendar.datepicker("hide");
	    });
	  }
//	  function pickupDate() {
//		  var thisCalendar = $(this);
//		  if(thisCalendar.val() != '') {
//			  var date = thisCalendar.val().split('-');
//			  thisCalendar.datepicker('setDate', new Date(date[0], date[1]-1, 1));
//		  }
//	  }
	  jQuery(this).datepicker(options);
	}
	
function formatDate(date, withoutDay) {
  var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();

  if (month.length < 2) month = '0' + month;
  if (day.length < 2) day = '0' + day;
  
  if(withoutDay)
  	return [year, month].join('-');
  else
  	return [year, month, day].join('-');
}

$(document).ready(function() {

	$('input#chk_all').on('click', function() {
		$('input#idx_chk').attr('checked', 'checked');

		if($('input#chk_all').prop('checked')) {
			$('input[name=idx_chk]').prop('checked', true);
		} else {
			$('input[name=idx_chk]').prop('checked', false);
		}
	});

	$('a#modify_status').on('click', function() {
		$('input#circles_idx').val($(this).attr('keyValue'));
		var choice = "status_" + $(this).attr('keyValue');
		$('input#status').val($('select#'+choice).val());

		$('form#circlesRoom').attr('action', 'modifyStatus.do');
		doAjaxPost($('form#circlesRoom'));
	});

	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	$('a#del_btn').on('click', function() {
		console.log($('input[name=idx_chk]:checked').length);
		if($('input[name=idx_chk]:checked').length == 0) {
			alert('삭제할 목록을 선택하세요.');
			return false;
		}
		$('form#circlesRoom').attr('action', 'delSelect.do');
		doAjaxPost($('form#circlesRoom'));
	});

	$('button#search_btn, button#search_btn2').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#circlesRoom')));
	});

	$('select#rowCount').on('change', function() {
		$('button#search_btn').click();
	});

	$('select#orderText').on('change', function() {
		doGetLoad('index.do', serializeCustom($('form#circlesRoom')));
	});
	
	$('input#search_sdt').monthYearPicker();
	$('input#search_edt').monthYearPicker();
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${paging.totalDataCount > 0}' == 'true') {
			doGetLoad('excelDownload.do', serializeCustom($('#circlesRoom')));
		} else {
			alert('해당 내역이 없습니다.');
		}
	});

	$('a#documentDownload').on('click', function(e) {
		e.preventDefault();
		$('input#circles_idx').val($(this).attr('keyValue'));
		if('${paging.totalDataCount > 0}' == 'true') {
			doGetLoad('documentDownload.do', serializeCustom($('#circlesRoom')));
		} else {
			alert('해당 내역이 없습니다.');
		}
	});


	
});

function smsPopUp3()
{
// 	window.open('http://lib.andong.go.kr:8060/sms/sms3.php','SMSPOPUP3','width=650, height=500, menubar=no, status=no, toolbar=no, scrollbars=yes');
}
</script>

<form:form modelAttribute="circlesRoom" action="index.do" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="circles_idx"/>
<form:hidden path="status"/>
<div>

	<div class="infodesk search">
		검색 결과 : ${paging.totalDataCount}건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
		</form:select>
		&nbsp;&nbsp;
		정렬 :&nbsp;
		<form:select path="orderText" class="selectmenu" style="width:120px;">
			<form:option value="visit_date">사용희망일</form:option>
			<form:option value="add_date">신청일자</form:option>
		</form:select>
		&nbsp;&nbsp;
		동아리 구분 :&nbsp;
		<form:select path="circles_div">
			<form:option value="">전체</form:option>
			<form:options items="${circlesDivCode}" itemLabel="code_name" itemValue="code_id"/>
		</form:select>
		&nbsp;&nbsp;
		조회 기간:&nbsp;
		<form:input path="search_sdt" cssClass="text ui-calendar" placeholder="조회시작일 선택"/>
		<form:input path="search_edt" cssClass="text ui-calendar" placeholder="조회종료일 선택"/>
		<button id="search_btn2"><i class="fa fa-search"></i><span>검색</span></button>
	</div>
	
	<div class="infodesk">
		<span>※ 상태값은 신청으로 되돌릴 수 없습니다.</span>
		<div class="button">
<!-- 			<a href="#" class="btn btn1 left" onclick="smsPopUp3();" style="margin-right: 5px;"><i class="fa fa-phone"></i><span>SMS발송</span></a> -->
			<a href="#" class="btn btn5 right" id="dialog-add"><i class="fa fa-plus"></i><span>등록하기</span></a>
			<a href="#" class="btn btn4" id="del_btn">선택삭제</a>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
		</div>
	</div>

	<table class="type1 center">
		<thead>
			<tr>
				<th width="10"><input type="checkbox" id="chk_all"></th>
				<th width="30">번호</th>
				<th width="80">이름</th>
				<th width="80">휴대폰</th>
				<th width="80">동아리방</th>
				<th width="80">사용희망일</th>
				<th width="30">방문인원</th>
				<th width="120">신청일자</th>
				<th width="200">사용목적</th>
				<th width="80">사용시간</th>
				<th width="100">상태</th>
				<th width="100">파일</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(circlesRoomList) < 1}">
			<tr style="height:100%">
				<td colspan="10" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="varStatus" items="${circlesRoomList}">
			<tr>
				<td><form:checkbox path="idx_chk" value="${i.circles_idx}"/></td>
				<td>${paging.listRowNum - varStatus.index}</td>
				<td>${i.user_name}</td>
				<td class="left">${i.user_phone}</td>
				<c:choose>
					<c:when test="${i.circles_div eq '1'}">
						<td>소담방1</td>
					</c:when>
					<c:when test="${i.circles_div eq '2'}">
						<td>소담방2</td>
					</c:when>
					<c:when test="${i.circles_div eq '3'}">
						<td>소담방3</td>
					</c:when>
					<c:when test="${i.circles_div eq '4'}">
						<td>소담방4</td>
					</c:when>
					<c:when test="${i.circles_div eq '5'}">
						<td>소담방5~6</td>
					</c:when>
					<c:when test="${i.circles_div eq '6'}">
						<td>소담방7</td>
					</c:when>
				</c:choose>
				<td>${i.visit_date}</td>
				<td>${i.visit_num}명</td>
				<td>
					<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${i.etc}</td>
				<td>
					<c:forTokens items="${i.visit_time}" var="reqTime" delims=",">
						<c:forEach items="${reqTimeCode}" var="code">
							<c:if test="${code.code_id eq reqTime}">
							<p>${code.code_name}</p>
							</c:if>
						</c:forEach>
					</c:forTokens>
				</td>
				<td>
					<select id="status_${i.circles_idx}">
						<option value="0" ${i.status eq 0 ? 'selected="selected"' : ''} disabled="disabled">신청</option>
						<option value="1" ${i.status eq 1 ? 'selected="selected"' : ''}>승인</option>
						<option value="2" ${i.status eq 2 ? 'selected="selected"' : ''}>미승인</option>
					</select>
					<a href="#" id="modify_status" keyValue="${i.circles_idx}">변경</a>
				</td>
				<td>
					<c:choose>
						<c:when test="${not empty i.origin_file_name}">
							<a href="#" id="documentDownload" class="btn" keyValue="${i.circles_idx}">다운로드</a>
						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#circlesRoom"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="user_name">성명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="동아리방 신청"></div>
