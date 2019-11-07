<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
});
</script>
<form:form id="hiddenForm" modelAttribute="donateBook">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="donate_idx"/>
</form:form>
<form:form id="donateBookListForm"  modelAttribute="donateBook" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>	
	<div class="infodesk">		
		<div class="txt-right">검색 결과 : 총 ${donateBookListCount}건</div>		
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="100"/>
			<col width="150"/>
			<col width=""/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>기증년도</th>
				<th>기증월</th>
				<th>기증자</th>	
				<th>기증도서정보</th>
				<th>기증권수</th>	
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${donateBookList}">
				<tr>
					<td>${i.donate_year}년</td>
					<td>${i.donate_month}월</td>
					<td>${i.masking_name}</td>
					<td>${i.donate_book}</td>
					<td>${i.donate_count}권</td>
				</tr>
			</c:forEach>
			<c:if test="${donateBookListCount eq 0}">
				<tr>
					<td colspan="5">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
<%-- 	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false"> --%>
<%-- 		<jsp:param name="formId" value="#donateBookListForm"/> --%>
<%-- 	</jsp:include> --%>
	
<!-- 	<div class="search txt-center" style="margin-top:25px;">하단 정렬 시 margin-top 입력 -->
<!-- 		<fieldset> -->
<%-- 			<form:select path="search_type" class="selectmenu"> --%>
<%-- 				<form:option value="name">기증자명</form:option> --%>
<%-- 				<form:option value="donate_yn">동의여부</form:option> --%>
<%-- 			</form:select> --%>
<%-- 			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/> --%>
<!-- 			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button> -->
<!-- 		</fieldset> -->
<!-- 	</div> -->
</form:form>