<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&lib_code='+$('#lib_code_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a.modify-btn').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&tid=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('select#lib_code_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#lib_code_1').val($(this).val());
			$('#pushListForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="pushListForm"  modelAttribute="push" action="index.do">
<c:if test="${!member.admin}">
<form:hidden id="lib_code_1" path="lib_code"/>
</c:if>

<c:if test="${member.admin}">
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<form:select class="selectmenu-search" style="width:250px" id="lib_code_1" path="lib_code">
				<form:option value="admin" label="전체"/>
				<c:forEach var="i" varStatus="status" items="${homepageList}">
					<option value="${i.homepage_code}" <c:if test="${(i.homepage_code ne null) and (i.homepage_code eq push.lib_code) }">selected="selected"</c:if>>${i.homepage_name}</option>
				</c:forEach>
			</form:select>
		</fieldset>
	</div>
</c:if>

	<div class="infodesk">
		검색 결과 : 총 ${pushListCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="100" />
			<col width="200" />
			<col width="150" />
			<col width="150" />
			<col width="" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>발송상태</th>
				<th>도서관</th>	
				<th>발송일자</th>	
				<th>발송타입</th>
				<th>메시지</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${pushList}">
				<tr>
					<td class="num">${push.listRowNum - status.index}</td>
					<td>
						<c:choose>
							<c:when test="${i.push_status == 0}">발송 완료</c:when>
							<c:when test="${i.push_status == 1}">발송 대기</c:when>
							<c:when test="${i.push_status == 2}">임시 저장</c:when>
							<c:when test="${i.push_status == 3}">발송 실패</c:when>
							<c:otherwise>
								${i.push_status}
							</c:otherwise>							
						</c:choose>
					</td>
					<td>${i.lib_name}</td>
					<td>${i.push_date} ${i.push_hour}</td>
					<td>${i.push_type}</td>
					<td>${i.push_msg}</td>
					<td>
						<c:if test="${i.push_status != 0 and i.push_status != 3}">
						<c:if test="${authU}">
							<a class="btn modify-btn" keyValue="${i.tid}">수정</a>
						</c:if>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(pushList) < 1}">
				<tr>
					<td colspan="7">조회된 정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
 	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#pushListForm"/>
	</jsp:include>
	
 	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="PUSH_RESERVE_DATE">발송일자</form:option>
				<form:option value="PUSH_TYPE">발송타입</form:option>
				<form:option value="PUSH_MSG">메시지</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="푸쉬 정보"></div>
