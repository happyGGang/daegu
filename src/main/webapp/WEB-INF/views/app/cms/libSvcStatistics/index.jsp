<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
$(function(){
	//달력(통계 기간 선택 오류 방지)
	$('input#dateStart').datepicker({
		maxDate: $('input#dateEnd').val(), 
		onClose: function(selectedDate){
			$('input#dateEnd').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#dateEnd').datepicker({
		minDate: $('input#dateStart').val(), 
		onClose: function(selectedDate){
			$('input#dateStart').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('#searchBtn').on('click', function (e) {
		e.preventDefault();
		var param = 'start_date='+$('#dateStart').val() + '&end_date='+$('#dateEnd').val();
		doGetLoad('index.do', param);
	});
	  
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		$('#menuAccessSearch').attr('action', '/cms/libSvcStatistics/excelDownload.do');
		$('#menuAccessSearch').submit();
	});
	
	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#menuAccessSearch').attr('action', '/cms/libSvcStatistics/csvDownload.do');
		$('#menuAccessSearch').submit();
	});
	
});
</script>

<div class="search">
	<form:form id="menuAccessSearch" modelAttribute="libSvcStatistics" action="/cms/menuAccess/excelDownload.do" method="post" style="display:inline-flex">
<%-- 		<form:hidden path="jsonObj" value="${jsonObj}"/> --%>
		<label class="blind">검색</label>
		<form:input type="text" id="dateStart" path="start_date" class="text ui-calendar"/>
		<span id="tilde" style="font-size:12px">~</span>
		<form:input type="text" id="dateEnd" path="end_date" class="text ui-calendar"/>
		
		<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
	</form:form>
</div>

<div style="clear:both">&nbsp;</div>
<br/>
<table id="accessTableData" class="chartData">
	<colgroup>
		<col width="20%">
		<c:forEach begin="0" end="${trSize * 3+1}" step="1">
		<col>
		</c:forEach>
	</colgroup>
	<thead>
		<tr class="center">
			<th rowspan="3">구분</th>
			<th colspan="${trSize * 4}">프로젝트사이트</th>
			<th colspan="7">구분</th>
		</tr>
		<tr class="center" style="border-top: 1px solid rgb(206, 216, 218); border-bottom: 1px solid rgb(206, 216, 218);">
			<c:forEach items="${codeList}" var="i">
				<c:if test="${i.code_id ne '0000' and i.code_id ne '0040'}">
				<th colspan="4">${i.code_name}</th>
				</c:if>
			</c:forEach>
			<th rowspan="2">통합회원수</th>
			<th rowspan="2">자관회원수</th>
			<th rowspan="2">준회원수</th>
			<th rowspan="2">탈퇴회원수</th>
			<th rowspan="2">반입회원</th>
			<th rowspan="2">전환회원</th>
			<th rowspan="2">대출권수</th>
		</tr>
		<tr class="center">
			<c:forEach items="${codeList}" var="i">
				<c:if test="${i.code_id ne '0000' and i.code_id ne '0040'}">
				<th>요청</th>
				<th>접수</th>
				<th>완료</th>
				<th>합계</th>
				</c:if>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listMap}" var="i">
		<tr class="center">
			<td>${i.homepage_name}</td>	
			<td>${i.I.req_cnt}</td>
			<td>${i.I.reg_cnt}</td>
			<td>${i.I.cmp_cnt}</td>
			<td>${i.I.sum_cnt}</td>
			<td>${i.C.req_cnt}</td>
			<td>${i.C.reg_cnt}</td>
			<td>${i.C.cmp_cnt}</td>
			<td>${i.C.sum_cnt}</td>
			<td>${i.D.req_cnt}</td>
			<td>${i.D.reg_cnt}</td>
			<td>${i.D.cmp_cnt}</td>
			<td>${i.D.sum_cnt}</td>
			<td>${i.E.req_cnt}</td>
			<td>${i.E.reg_cnt}</td>
			<td>${i.E.cmp_cnt}</td>
			<td>${i.E.sum_cnt}</td>
		
			<td>${i.memberCnt.all_member_cnt}</td>
			<td>${i.memberCnt.a_member_cnt}</td>
			<td>${i.memberCnt.b_member_cnt}</td>
			<td>${i.memberCnt.c_member_cnt}</td>
			<td>${i.memberCnt.d_member_cnt}</td>
			<td>${i.memberCnt.e_member_cnt}</td>
			<td>${i.memberCnt.loan_cnt}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 자료 테이블 여기까지 -->