<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('#dialog-teacher.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-teacher").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 650
	});
	
	$('a.btn_select').on('click', function(e) {
		e.preventDefault();
		$('#teachForm #teacher_idx').val($(this).attr('keyValue'));
		$('#teachForm #teacher_name').val($(this).attr('keyValue2'));
		$('#dialog-teacher').dialog('destroy');
	});
	
	$('#search-btn').on('click', function(e) {
		$('#dept #viewPage_ajax').val(1);
		$('#dialog-teacher').load('/cms/module/teacher/searchTeacher.do?'+$('#searchTeacher').serialize());
	});
	
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('#searchTeacher').serialize();
		$('#dialog-teacher').load('/cms/module/teacher/searchTeacher.do?' + param);
		e.preventDefault();
	});
});
</script>
<form:form modelAttribute="teacher" id="searchTeacher" action="searchTeacher.do" method="get" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<form:select path="search_type" class="selectmenu">
				<form:option value="TEACHER_NAME">강사명</form:option>
				<form:option value="TEACHER_SUBJECT_NAME">과목명</form:option>
				<form:option value="TEACHER_CELL_PHONE">휴대전화번호</form:option>
			</form:select>		
			<form:input path="search_text" class="text" />
			<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>

	<table class="type2 center">
		<colgroup>
	       	<col width="100" />
	       	<col width="*"/>
	       	<col width="*"/>
	       	<col width="100"/>
	     	</colgroup>
	     	<thead>
	     		<tr>
	     			<th>강사명</th>
	     			<th>과목명</th>
	     			<th>휴대전화번호</th>
	     			<th>기능</th>
	     		</tr>
	     	</thead>
	     	<tbody>
	     		<c:forEach items="${teacherList}" var="i">
	      		<tr>
	      			<td>${i.teacher_name}</td>
					<td>${i.teacher_subject_name}</td>
					<td>${i.teacher_cell_phone}</td>
					<td><a class="btn btn_select" keyValue="${i.teacher_idx}" keyValue2="${i.teacher_name}">선택</a></td>
				</tr>
	    	</c:forEach>
		</tbody>
	</table>

	<form:hidden id="viewPage_ajax" path="viewPage"/>
	<div id="cms_paging" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>	
		<span>
			<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
				<c:choose>
					<c:when test="${i eq paging.viewPage}">	
						<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="" class="paginate_button" keyValue="${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nextPageNum > 0}">
				<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
			</c:if>
			<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
				<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
			</c:if>
		</span>
	</div>
</form:form>