<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">	
$(document).ready(function() {
	
	<%-- 업무등록 --%>
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	<%--부서등록--%>
	$('a#dialog-dept').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('deptEdit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	<%-- 사용자수정 --%>
	$('a.dialog-mod').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&work_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	<%-- 사용자삭제 --%>
	$('a.dialog-del').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('input#del_work_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#deptMngDel'))) {
				doGetLoad('index.do');
			}
		}
		
	});
	
	<%-- 미리보기 --%>
	$('a#sample-btn').on('click', function(e) {
		e.preventDefault();
		window.open('/${homepage.context_path}/module/deptMng/index.do?menu_idx=192');
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#deptMng')));
	});
	
	$('table.tspan').rowspan(0);
});

$.fn.rowspan = function(colIdx, isStats) {
	return this.each(function() {
		var that;
		$('tr', this).each(function(row) {
			$('td', this).eq(colIdx).each(function(col) {
				if($(this).html() == $(that).html()) {
					rowspan = $(that).attr('rowspan') || 1;
					rowspan = Number(rowspan)+1;
					
					$(that).attr('rowspan', rowspan);
					
					$(this).hide();
				} else {
					that = this;
				}
				
				that = (that == null) ? this : that;
			});
		});
	});
}
</script>
<form:form modelAttribute="deptMng" id="deptMngDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="del_homepage_id"/>
	<form:hidden path="work_idx" id="del_work_idx"/>
</form:form> 
<form:form modelAttribute="deptMng" action="index.do" method="GET">
	<form:hidden path="homepage_id"/>
	<div class="infodesk">
		검색 결과 : ${deptMng.totalDataCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn1 left" id="sample-btn"><span>미리보기</span></a>&nbsp;
				<a href="" class="btn btn3 left" id="dialog-dept"><i class="fa fa-plus"></i><span>부서관리</span></a>&nbsp;
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>업무등록</span></a>
			</c:if>
		</div>
	</div>
	
	<c:forEach items="${deptList}" var="i">
		<h3>${i.dept_name}</h3>
		<table class="center tspan" summary="${i.dept_name}의 직원현황입니다.">
			<colgroup>
				<col width="180">
				<col width="120">
				<col width="">
				<col width="180">
				<col width="120">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="th1">직  위(급)</th>
					<th scope="col" class="th2">성 명</th>
					<th scope="col" class="th3">담   당   업   무</th>
					<th scope="col" class="th4">전 화</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${workList}" var="j">
				<c:if test="${i.dept_idx eq j.dept_idx}">
				<tr>
					<td>${j.position}</td>
					<td>${j.worker}</td>
					<td class="left">${j.work_info}</td>
					<td>${j.phone}</td>
					<td>
						<a href="#" class="btn dialog-mod" keyValue="${j.work_idx}">수정</a>
						<a href="#" class="btn dialog-del" keyValue="${j.work_idx}">삭제</a>
					</td>
				</tr>
				</c:if>
				</c:forEach>
				<c:if test="${fn:length(workList) < 1}">
				<tr>
					<td colspan="5">등록된 데이터가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		<br>
		</c:forEach>
</form:form>

<div id="dialog-1" class="dialog-common" title="업무관리"></div>
<div id="dialog-2" class="dialog-common" title="부서관리"></div>