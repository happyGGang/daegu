<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('#dialog-dept').dialog({ 
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	        if ( '${deptListCount}' == 1 ) {
	    		$('a.btn_select').click();
	    	}
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
	
	$("#dialog-dept").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 600
	});
	
	$('a.btn_select').on('click', function(e) {
		e.preventDefault();
		$('#support_edit #req_name').val($(this).attr('keyValue'));
		$('#support_edit #req_organ_code').val($(this).attr('keyValue2'));
		$('#dialog-dept').dialog('destroy');
	});
	
	$('#search-btn').on('click', function(e) {
		$('#dept #viewPage_ajax').val(1);
		$('#dialog-dept').load('searchDept.do?'+$('#dept').serialize());
	});
	
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('#dept').serialize();
		$('#dialog-dept').load('searchDept.do?' + param);
		e.preventDefault();
	});
	
});
</script>
<form:form modelAttribute="dept" id="dept" action="searchDept.do" method="get" onsubmit="return false;">
<div class="search">
	<fieldset>
		<label class="blind">검색</label>
		<form:select path="search_type" class="selectmenu">
			<form:option value="GROUP_NAME">관할조직명</form:option>
			<form:option value="CODE_NAME">조직명</form:option>
		</form:select>		
		<form:input path="search_text" class="text" />
		<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>

<table class="type2 center">
	<colgroup>
       	<col width="*" />
       	<col width="*"/>
       	<col width="100"/>
     	</colgroup>
     	<thead>
     		<tr>
     			<th>관할조직명</th>
     			<th>조직명</th>
     			<th>기능</th>
     		</tr>
     	</thead>
     	<tbody>
     		<c:forEach items="${deptList}" var="i">
      		<tr>
      			<td>${i.group_name}</td>
				<td>${i.code_name}</td>
				<td><a class="btn btn_select" keyValue="${i.code_name}" keyValue2="${i.code_id}">선택</a></td>
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