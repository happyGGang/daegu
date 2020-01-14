<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){

	<%--검색--%>
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#member_index').serialize());
	});

	<%--사용자등록--%>
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	<%--사용자수정--%>
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	<%--사용자삭제--%>
	$('a.delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 사용자(' + $(this).attr('keyValue') + ')를 정보를 삭제 하시겠습니까?')) {
			$('input#editMode_index').val('DELETE');
			$('input#member_id_index').val($(this).attr('keyValue'));
			if(doAjaxPost($('#member_index'))) {
				location.reload();
			}
		}
	});

	<%--그룹설정--%>
	$('a.grouping').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('grouping_ajax.do?member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});

	<%--10개씩보기--%>
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#member_index').serialize());
	});

	$('a.recovery').on('click', function(e) {
		if(confirm('복원하시겠습니까?')) {
			$('input#recoverValue').val($(this).attr('keyValue'));
			doAjaxPost($('form#recoveryForm'));
		}
	});
});
</script>
<form id="recoveryForm" action="recovery.do" method="post">
<input type="hidden" id="recoverValue" name="work_date" value="">
</form>

<form:form modelAttribute="menuLog" action="index.do" method="post" onsubmit="return false;">
<div class="infodesk">
	검색 결과 : ${paging.totalDataCount}건
	<form:select path="rowCount" class="selectmenu" style="width:150px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="100">100개씩 보기</form:option>
		<form:option value="${paging.totalDataCount}">전체 보기</form:option>
	</form:select>
</div>


	<table class="type1 center">
		<thead>
			<tr>
				<th width="50">순번</th>
				<th width="100">작업유형</th>
				<th width="150">작업일시</th>
				<th width="100">작업자ID</th>
				<th width="130">작업자IP</th>
				<th width="130">도서관</th>
				<th width="50">메뉴IDX</th>
				<th width="">메뉴명</th>
				<th width="130">메뉴유형</th>
				<th width="100">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(menuLogList) < 1}">
			<tr>
				<td colspan="8">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${menuLogList}">
			<tr>
				<td width="50">${paging.listRowNum - status.index}</td>
				<td width="50" class="left">${i.work_type}</td>
				<td width="150">${i.work_date}</td>
				<td width="100">${i.member_id}</td>
				<td width="130">${i.work_ip}</td>
				<td width="100">${i.homepage_id}</td>
				<td width="50">${i.menu_idx}</td>
				<td width="100">${i.menu_name}</td>
				<td width="130">${i.menu_type}</td>
				<td width=""><a href="#" class="btn btn3 recovery" keyValue="${i.work_date}">복원</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#menuLog"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>

</form:form>

<div id="dialog-1" class="dialog-common" title="사용자 정보">
</div>
<div id="dialog-2" class="dialog-common" title="">
</div>
<div id="dialog-3" class="dialog-common" title="그룹설정">
</div>