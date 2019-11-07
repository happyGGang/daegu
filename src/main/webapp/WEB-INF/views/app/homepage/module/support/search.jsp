<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" type="text/css" href="/resources/homepage/cd/css/default.css">
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css">
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/homepage/cd/js/common.js"></script>
<script type="text/javascript">
$(function() {
	$('a.btn_select').on('click', function() {
		opener.setReqData($(this).attr("keyValue"),$(this).attr("keyValue2"));
		window.close();
	});
	
	$('#search-btn').on('click', function() {
		$('#dept #viewPage').val(1);
		doGetLoad('/${homepage.context_path}/module/support/searchDept.do',serializeCustom($('#dept')));
	});
});
$(window).ready(function() {
	if ( '${deptListCount}' == 1 ) {
		$('a.btn_select').click();
	}
});
</script>
<form:form modelAttribute="dept" action="searchDept.do" method="get" onsubmit="return false;">
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
				<td><a class="btn btn_select" keyValue="${i.code_id}" keyValue2="${i.code_name}">선택</a></td>
			</tr>
    	</c:forEach>
	</tbody>
</table>
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#dept"/>
	<jsp:param name="pagingUrl" value="searchDept.do"/>
</jsp:include>
</form:form>