<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.black_idx').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.black_idx').prop('checked', false);
		}
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookBlackList').serialize());
	});
	
	$('input#start_date').datepicker({
		dateFormat:'yy-mm-dd',
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookBlackList.start_date}');
	$('input#end_date').datepicker({
		dateFormat:'yy-mm-dd',
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker('setDate', '${untactBookBlackList.end_date}');

	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookBlackList').serialize());
	});
	
	$('select#penalty_reason').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#untactBookBlackList').serialize());
	});
	
	$('#searchBtn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#untactBookBlackList').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
			$('#untactBookBlackList').attr('action', 'excelDownload.do').submit();
			$('#untactBookBlackList').attr('action', 'save.do')
		e.preventDefault();
	});
	
});

function allDelete() {
	if($('input:checkbox[name=member_id_arr]:checked').length < 1) {
		alert('삭제할 아이디를 선택해 주세요.');
	} else {
		if(confirm('전체 삭제 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: 'deleteAll.do',
				data: $('input[name=member_id_arr]').serialize(),
				success: function(response) {
					if(response.valid) {
						alert('전체삭제 되었습니다.');
					}
					location.reload();
				},
				error : function() {
					alert('전체 삭제에 실패했습니다.\n\n관리자에게 문의해 주세요.');
				}
			});
		} 
	}
}

function deletePenalty(member_id, member_name) {
	if(confirm(member_name + '(' + member_id + ')님의 패널티를 삭제하시겠습니까?')) {

		var ajaxData = {
			'member_id' : member_id,
			'member_name' : member_name
		};
	
		$.ajax({
			type: "POST",
			url: 'deleteOne.do',
			data : ajaxData,
			success: function(html) { 
					alert(member_name + '(' + member_id + ')님의 페널티가 삭제되었습니다.');
					location.reload();
			},error: function(html) {
			}
		});
		
	}
	
}
</script>
<form:form id="untactBookBlackList" modelAttribute="untactBookBlackList" method="POST" action="save.do">
<form:hidden id="homepage_id" path="homepage_id"/>

<div class="search">
<label class="blind">검색</label>
	검색 결과 : ${untactBookBlackListCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${untactBookBlackListCount}">전체 보기</form:option>
	</form:select>
	패널티 사유 :
	<form:select path="penalty_reason" class="selectmenu" style="width:150px;">
		<form:option value="" label="전체 보기"/>
		<form:option value="신청중지" label="신청중지"/>
		<form:option value="분실및파손" label="분실 및 파손"/>
		<form:option value="기타1" label="기타1"/>
		<form:option value="기타2" label="기타2"/>
		<form:option value="기타3" label="기타3"/>
	</form:select>
	패널티 날짜 : <form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
</div>

<div class="ui-state-highlight">
	<em>* 블랙리스트 삭제는 복구가 불가능합니다.</em>
</div>
<br>

<table class="type1 center">
	<thead>
		<tr>
			<th width="10">선택</th>
			<th width="10">번호</th>
			<th width="50">회원아이디</th>
			<th width="50">회원이름</th>
			<th width="50">패널티사유</th>
			<th width="50">등록일</th>
			<th width="50">등록ID</th>
			<th width="100">기능</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${fn:length(untactBookBlackListList) < 1}">
		<tr style="height:100%">
			<td colspan="8" style="background:#f8fafb;">블랙리스트 내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${untactBookBlackListList}">
		<tr>
			<td width="10"><form:checkbox path="member_id_arr" cssClass="black_idx" value="${i.member_id}"/></td>
			<td width="10">${paging.listRowNum - status.index}</td>
			<td width="50">${i.member_id}</td>
			<td width="50">${i.member_name}</td>
			<td width="50">${i.penalty_reason}</td>
			<td width="50">${i.penalty_day}</td>
			<td width="50">${i.penalty_register_id}</td>
			<td width="100"><a href="javascript:void(0);" class="btn btn5 btnuntact" onclick="deletePenalty('${i.member_id}' ,'${i.member_name}');">패널티부여삭제</a></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div style="padding-top:10px;">
	<a href="#" class="btn btn3 btnuntact" id="all-check" keyValue="N">전체선택</a>
	<a href="#" id="delete_btn" class="btn btn4 btnuntact" onclick="allDelete();">전체삭제</a>
</div>
	
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#untactBookBlackList"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="member_id">회원아이디</form:option>
			<form:option value="member_name">회원이름</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		<a href="#" id="excelDownload" class="btn btn2 btnuntact">엑셀저장</a>
	</fieldset>
</div>
	
</form:form>