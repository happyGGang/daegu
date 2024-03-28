<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#eventListForm').submit();
	});
	
	$('a.dialog-add').on('click', function(e) {
		
		if($('#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&event_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 이벤트를 삭제 하시겠습니까?') ) {
			$('#hiddenForm #event_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a.dialog-question').on('click', function(e) {
		$('#dialog-2').load('editQuestion.do?homepage_id=' + $('#homepage_id').val() + '&event_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.dialog-reqList').on('click', function(e){
		$('#dialog-3').load('reqList.do?homepage_id=' + $('#homepage_id').val() + '&event_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		e.preventDefault();
	});
	
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#eventListForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('select#event_type, select#rowCount, select#event_year, select#event_month').on('change', function() {
		$('#viewPage').val(1);
		$('#eventListForm').submit();
	});
	
// 	$('select#rowCount').on('change', function() {
// 		$('#viewPage').val(1);
// 		$('#eventListForm').submit();
// 	});
	
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	//년도 초기화 (내년 일정 까지 볼수 있게 하려고 + 1함)
	var event_year = '${event.event_year}';
	var event_month = '${event.event_month}';
	for ( var i = year; i >= 2019; i-- ) {
		var optionYear = i;
		var selectedAttr = '';

		if ( optionYear == event_year ) {
			selectedAttr = 'selected="selected"';
		}

		$('#event_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);

		if ( j == event_month ) {
			selectedAttr = 'selected="selected"';
		}

		$('#event_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
});
</script>
<form:form id="hiddenForm" modelAttribute="event" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="event_idx"/>
</form:form>
<form:form id="eventListForm"  modelAttribute="event" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${eventListCount}" pattern="#,###" />건
		<form:select path="event_type" class="selectmenu">
			<option value="">이벤트구분선택</option>
			<form:options items="${eventTypeList}" itemLabel="code_name" itemValue="code_id"/>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">20개씩 보기</form:option>
			<form:option value="50">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
<!-- 		<div class="monthYear"> -->
<!-- 			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a> -->
<%-- 			<form:select path="event_year" class="selectmenu" style="width:100px;"></form:select> --%>
<%-- 	        <form:select path="event_month" class="selectmenu" style="width:100px;"></form:select> --%>
<!-- 	        <a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a> -->
<!-- 	    </div> -->
<%-- 		<form:input path="event_year" size="6"/>년 <form:input path="event_month" size="3"/>월 --%>
		<form:select path="event_year" class="selectmenu" style="width:100px;">
			<form:option value="0">이벤트년도</form:option>
		</form:select>
		<form:select path="event_month" class="selectmenu" style="width:100px;">
			<form:option value="0">이벤트월</form:option>
		</form:select>
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 dialog-add" ><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="150" />
			<col width="120">
			<col width="" />
			<col width="" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>이벤트구분</th>
				<th>이벤트년월</th>
				<th>제목</th>
				<th>도서명</th>
				<th>참여 시작일</th>
				<th>참여 종료일</th>
				<th>현황</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${eventList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td>
						<c:forEach items="${eventTypeList}" var="qt">
							<c:if test="${qt.code_id eq i.event_type}">
								${qt.code_name}
							</c:if>
						</c:forEach>
					</td>
					<td>${i.event_year}년 ${i.event_month}월</td>
					<td>${i.event_name}</td>
					<td>${i.book_name}</td>
					<td>${i.event_start_date}</td>
					<td>${i.event_end_date}</td>
					<td>${i.event_req_count} <a href="" class="btn btn2 dialog-reqList" keyValue="${i.event_idx}">보기</a></td>
					<td>
						<c:if test="${authC or authU}">
							<a href="" class="btn btn2 dialog-question" keyValue="${i.event_idx}">문항</a>
						</c:if>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" keyValue="${i.event_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue="${i.event_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${eventListCount eq 0}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#eventListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="event_name">제목</form:option>
				<form:option value="book_name">책이름</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="이벤트 정보"></div>
<div id="dialog-2" class="dialog-common" title="이벤트 문항 정보"></div>
<div id="dialog-3" class="dialog-common" title="이벤트 문항 정보"></div>