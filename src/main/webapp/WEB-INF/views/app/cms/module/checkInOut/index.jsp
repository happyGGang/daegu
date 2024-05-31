<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function checkAll($this) { 
	$('input:checkbox[name=checkInOut_arr]').prop('checked', $this.is(':checked'));
}

$(function(){
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#checkInOut').serialize());
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${checkInOut.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${checkInOut.end_date}');
	
	$('a#excelDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'excelDownload.do').submit();
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#checkInOut').attr('action', 'csvDownload.do').submit();
		e.preventDefault();
	});
	
});

function checkOutAll() {
	if($('input:checkbox[name=checkInOut_arr]:checked').length < 1) {
		alert('체크아웃 처리할 아이디를 선택해 주세요.');
	} else {
		if(confirm('체크아웃 하시겠습니까?\n체크아웃 시간은 금일 마감시간으로 할당됩니다.')) {
			$.ajax({
				type: "POST",
				url: 'checkOutAll.do',
				data: $('input[name=checkInOut_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('체크아웃처리 되었습니다.');
					} else {
						alert(response.message);
					}
					location.reload();
				},
				error : function() {
					alert('체크아웃처리에 실패했습니다.\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}
</script>

<form:form id="checkInOut" modelAttribute="checkInOut" action="index.do">
	
	<div class="search">
		검색 결과 : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> 건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		체크인 기간 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		<a href="#" id="checkOutAll" class="btn btn1" onclick="checkOutAll();"><span>일괄체크아웃</span></a>
	</div>
	
	<table class="type1 center">
		<colgroup>
 			<col width="50%" />
 			<col width="50%" />
		</colgroup>
		<thead>
			<tr>
				<th>상태</th>
				<th>인원수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>이용완료(체크아웃 완료)</td>
				<td>${checkOutCount}</td>
			</tr>
			<tr>
				<td>이용중(체크인만 완료)</td>
				<td>${checkInCount}</td>
			</tr>
		</tbody>
	</table><br/>
	
	<table class="type1 center">
		<colgroup>
				<col width="3%"/>
	 			<col width="3%"/>
	 			<col width="10%"/>
	 			<col width="10%"/>
	 			<col width="7%"/>
				<col width="6%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="5%"/>
				<col width="5%"/>
			</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" onchange="checkAll($(this));"></th>
				<th></th>
				<th>대출자번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>생일연도</th>
				<th>성별</th>
				<th>지역구</th>
				<th>체크인 시간</th>
				<th>체크아웃 시간</th>
				<th>이용시간</th>
				<th>상태</th>
				<th>방문구분</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${checkInOutList}">
			<tr>
				<td>
					<c:if test="${empty i.checkInOut_time}">
						<form:checkbox path="checkInOut_arr" id="checkInOut_arr" cssClass="checkInOut_idx" value="${i.checkInOut_idx}"/>
					</c:if>
				</td>
				<td>${paging.listRowNum - status.index}</td>
				<td>${i.user_no}</td>
				<td>${i.member_id}</td>
				<td>${i.member_name}</td>
				<td>${i.member_birth}</td>
				<td>${i.member_sex}</td>
				<td>${i.member_area}</td>
				<td>${i.checkIn_time}</td>
				<td>${i.checkOut_time}</td>
				<td>${i.checkInOut_time}<c:if test="${not empty i.checkInOut_time}">분</c:if></td>
				<c:set var="status" value="${i.checkOut_time eq '' || empty i.checkOut_time ? '이용중' : '이용완료'}"/>
				<td>${status}</td>
				<c:set var="gubun" value="${i.visit_status eq 'Y' ? '처음방문' : '재방문'}"/>
				<td>${gubun}</td>
			</tr>
		</c:forEach>
		<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="12">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#checkInOut"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="user_no">대출자번호</form:option>
				<form:option value="member_id">ID</form:option>
				<form:option value="member_name">이름</form:option>
				<form:option value="member_sex">성별</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	
</form:form>