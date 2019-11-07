<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#dialog-searchLayer').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$('#dialog-searchLayer').dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-searchLayer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 850,
		height: 650
	});
	
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		
		doAjaxLoad('#dialog-searchLayer', 'adminSearch.do', $('#deptForm').serialize());
		e.preventDefault();
	});	
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		
		doAjaxLoad('#dialog-searchLayer', 'adminSearch.do', $('#deptForm').serialize());
		e.preventDefault();
	});
	
	$('a#select').on('click', function(e) {
		e.preventDefault();
		
		$('input#admin_id').val($(this).attr('keyValue'));
		$('#dialog-searchLayer').dialog('destroy');
	})
	
	$('a.selected-btn').on('click', function(e) {
		e.preventDefault();
		var member_id = $(this).attr('keyValue');
		$('#boardManageEdit #admin_id').val(member_id);
		$('#dialog-searchLayer').dialog('destroy');
	});
	
});
</script>
	<form:form id="deptForm" modelAttribute="boardManage" action="adminSearch.do" method="get">
	<form:hidden path="viewPage"/>
	<div class="infodesk">
		검색 결과 : 총 ${paging1.totalDataCount}건
	</div>
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
		        <col width="100"/>
		        <col width="150"/>
		        <col width="80"/>
			</colgroup>
			<thead>
				<tr>
					<th>관리자ID</th>
					<th>관리자명</th>
					<th>전화번호</th>
					<th>휴대전화번호</th>
					<th>기능</th>
					<!-- <th>기관구분</th>
					<th>nenis코드</th>
					<th>사용여부</th> -->
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(memberList) < 1}">
				<tr>
					<td colspan="5">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i"  varStatus="status" items="${memberList}">
	            <tr>
		            <td>${i.member_id}</td>
		      		<td>${i.member_name}</td>
		      		<td>${i.phone}</td>
		      		<td>${i.cell_phone}</td>
		      		<td><a class="btn btn1 selected-btn" keyValue="${i.member_id}">선택</a></td>
	            </tr>
            </c:forEach>
			</tbody>
		</table>
		
		<div id="cms_paging" class="dataTables_paginate">
			<c:if test="${paging1.firstPageNum > 0}">
				<a href="" class="paginate_button previous" keyValue="${paging1.firstPageNum}">처음</a>
			</c:if>
			<c:if test="${paging1.prevPageNum > 0}">
				<a href="" class="paginate_button previous" keyValue="${paging1.prevPageNum}">이전</a>
			</c:if>	
			<span>
			<c:forEach var="i" varStatus="status" begin="${paging1.startPageNum}" end="${paging1.endPageNum}">
			<c:choose>
			<c:when test="${i eq paging1.viewPage}">	
				<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="" class="paginate_button" keyValue="${i}">${i}</a>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${paging1.nextPageNum > 0}">
				<a href="" class="paginate_button next" keyValue="${paging1.nextPageNum}">다음</a>
			</c:if>
			<c:if test="${paging1.totalPageCount ne paging1.lastPageNum}">
				<a href="" class="paginate_button next" keyValue="${paging1.totalPageCount}">맨끝</a>
			</c:if>
			</span>
		</div>
	
		<%-- <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<label class="blind">검색</label>
				<form:select path="search_type" >
					<form:option cssClass="ALL" value="" label="==전체=="/>
					<form:option value="dept_cd" label="아이디" />
					<form:option value="dept_nm" label="기관명" />
				</form:select>
				<form:select path="search_dept_div_cd">
					<form:option cssClass="ALL" value="" label="==전체==" />
	      			<form:options items="${member_types}" itemLabel="code_name" itemValue="code_id" />
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div> --%>
	</div>
	</form:form>
