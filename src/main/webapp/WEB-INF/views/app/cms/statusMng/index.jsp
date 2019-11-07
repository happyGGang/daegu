<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">	
$(document).ready(function() {
	
	<%-- 구분등록 --%>
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	<%-- 현황등록 --%>
	$('a#dialog-status').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('status.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	<%-- 현황수정 --%>
	$('a.dialog-mod').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('status.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&status_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	<%-- 현황삭제 --%>
	$('a.status-del').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('form#statusMngDel input#status_idx_d').val($(this).attr('keyValue'));
			$('form#statusMngDel input#div_idx_d').val($(this).attr('keyValue2'));
			doAjaxPost($('form#statusMngDel'));
		}
	});
	
	<%-- 미리보기 --%>
	$('a#sample-btn').on('click', function(e) {
		e.preventDefault();
		window.open('/${homepage.context_path}/module/deptMng/index.do?menu_idx=192');
	});
	
});
</script>
<form:form modelAttribute="statusMng" id="statusMngDel" action="statusDelete.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_d"/>
	<form:hidden path="status_idx" id="status_idx_d"/>
	<form:hidden path="div_idx" id="div_idx_d"/>
</form:form>
<form:form modelAttribute="statusMng" action="index.do" method="GET">
	<form:hidden path="homepage_id"/>
	<div class="infodesk">
		검색 결과 : ${statusMng.totalDataCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn1 left" id="sample-btn"><span>미리보기</span></a>&nbsp;
				<a href="" class="btn btn3 left" id="dialog-add"><i class="fa fa-plus"></i><span>직렬관리</span></a>&nbsp;&nbsp;
				<a href="" class="btn btn5 left" id="dialog-status"><i class="fa fa-plus"></i><span>조직현황등록</span></a>
			</c:if>
		</div>
	</div>
	<c:choose>
		<c:when test="${fn:length(statusList) > 0}">
		<table class="center">
			<thead>
				<tr>
					<th rowspan="2" width="80">구분</th>
					<c:forEach items="${divList}" var="i">
					<th colspan="${i.col_cnt}">${i.div_name}</th>
					</c:forEach>
					<th rowspan="2" width="80">계</th>
				</tr>
				<tr>
					<c:forEach items="${statusList}" var="i">
					<th scope="col" class="btw">
						<span>${i.rating}</span>
						<div>
							<a href="#" class="btn dialog-mod" keyValue="${i.status_idx}">수정</a>
							<a href="#" class="btn status-del" keyValue="${i.status_idx}" keyValue2="${i.div_idx}">삭제</a>
						</div>
					</th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>정원</td>
					<c:forEach items="${statusList}" var="i">
					<td>${i.max_cnt}</td>
					</c:forEach>
					<td>${totalCnt.max_cnt}</td>
				</tr>
				<tr>
					<td>현원</td>
					<c:forEach items="${statusList}" var="i">
					<td>${i.cur_cnt}</td>
					</c:forEach>
					<td>${totalCnt.cur_cnt}</td>
				</tr>
			</tbody>
		</table>
		</c:when>
		<c:otherwise>
		<table class="center">
			<thead>
				<tr>
					<th rowspan="2" width="120">구분</th>
					<th></th>
					<th rowspan="2" width="120">계</th>
				</tr>
				<tr>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>정원</td>
					<td rowspan="2">등록된 데이터가 없습니다.</td>
					<td>0</td>
				</tr>
				<tr>
					<td>현원</td>
					<td>0</td>
				</tr>
			</tbody>
		</table>
		</c:otherwise>
	</c:choose>
</form:form>

<div id="dialog-1" class="dialog-common" title="직렬관리"></div>
<div id="dialog-2" class="dialog-common" title="조직현황관리"></div>