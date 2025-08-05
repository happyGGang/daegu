<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function() {

	// 조직
	<%-- 구분등록 --%>
	$('a#dialog-division').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('divisionEdit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
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
	$('a.dialog-status-mod').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('status.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&status_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	<%-- 현황삭제 --%>
	$('a.status-del').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('form#statusDelete input#status_idx_d').val($(this).attr('keyValue'));
			$('form#statusDelete input#division_idx_d').val($(this).attr('keyValue2'));
			doAjaxPost($('form#statusDelete'));
		}
	});

	// 업무
	<%-- 업무등록 --%>
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});

	<%--부서등록--%>
	$('a#dialog-organization').on('click', function(e) {
		e.preventDefault();
		$('#dialog-4').load('organizationEdit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
	});

	<%-- 사용자수정 --%>
	$('a.dialog-mod').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&organization_work_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});

	<%-- 사용자삭제 --%>
	$('a.dialog-del').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('input#del_organization_work_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#organizationWorkDel'))) {
				doGetLoad('index.do');
			}
		}

	});

	<%-- 미리보기 --%>
	$('a#sample-btn').on('click', function(e) {
		e.preventDefault();
		window.open('/${homepage.context_path}/module/organization/index.do?menu_idx=100');
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#organization')));
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
<div class="container-box">
    <div class="page-header">
        <div>조직/업무관리</div>
    </div>

    <div style="padding: 20px 40px 40px 40px">
<form:form modelAttribute="organization" id="statusDelete" action="statusDelete.do" method="POST">
	<form:hidden path="homepage_id" id="homepage_id_d"/>
	<form:hidden path="status_idx" id="status_idx_d"/>
	<form:hidden path="division_idx" id="division_idx_d"/>
</form:form>
<form:form modelAttribute="organization" action="index.do" method="GET">
	<form:hidden path="homepage_id"/>


            <div class="btn-wrapper" style="justify-content: flex-end; margin-top: 10px; display: flex">
                <c:if test="${authC}">
                    <a class="icon-btn black" href="" id="sample-btn">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>미리보기</div>
                    </a>
                    <a class="icon-btn navy" href="" id="dialog-division">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>직렬관리</div>
                    </a>
                    <a class="icon-btn navy" href="" id="dialog-status">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>조직현황등록</div>
                    </a>
                    <a class="icon-btn navy" href="" id="dialog-organization">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>부서관리</div>
                    </a>
                    <a class="icon-btn navy" href="" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>업무등록</div>
                    </a>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${fn:length(statusList) > 0}">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th rowspan="2">구분</th>
                            <c:forEach items="${divisionList}" var="i">
                            <th colspan="${i.column_cnt}">${i.division_name}</th>
                            </c:forEach>
                            <th rowspan="2">계</th>
                        </tr>
                        <tr>
                            <c:forEach items="${statusList}" var="i">
                            <th scope="col" class="btw">
                                <span>${i.rating}</span>
                                <div>
                                    <a href="#" class="btn dialog-status-mod" keyValue="${i.status_idx}">수정</a>
                                    <a href="#" class="btn status-del" keyValue="${i.status_idx}" keyValue2="${i.division_idx}">삭제</a>
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
                            <td>${i.current_cnt}</td>
                            </c:forEach>
                            <td>${totalCnt.current_cnt}</td>
                        </tr>
                    </tbody>
                </table>
                </c:when>
                <c:otherwise>
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th rowspan="2" width="120">구분</th>
                            <th rowspan="2"></th>
                            <th rowspan="2" width="120">계</th>
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

<form:form modelAttribute="organization" id="organizationWorkDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="del_homepage_id"/>
	<form:hidden path="organization_work_idx" id="del_organization_work_idx"/>
</form:form>
<form:form modelAttribute="organization" action="index.do" method="GET">
	<form:hidden path="homepage_id"/>

	<c:forEach items="${organizationList}" var="i">
		<h3 class="total-count">${i.organization_name}</h3>
		<table class="custom-table" summary="${i.organization_name}의 직원현황입니다.">
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
				<c:if test="${i.organization_idx eq j.organization_idx}">
				<tr>
					<td>${j.position}</td>
					<td>${j.worker}</td>
					<td>${j.work_info}</td>
					<td>${j.phone}</td>
					<td>
						<a href="#" class="custom-btn" id="dialog-modify" keyValue="${j.organization_work_idx}">수정</a>
						<a href="#" class="custom-btn" id="delete" keyValue="${j.organization_work_idx}">삭제</a>
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
</div>
</div>

<div id="dialog-1" class="dialog-common" title="직렬관리"></div>
<div id="dialog-2" class="dialog-common" title="조직현황관리"></div>
<div id="dialog-3" class="dialog-common" title="업무관리"></div>
<div id="dialog-4" class="dialog-common" title="부서관리"></div>