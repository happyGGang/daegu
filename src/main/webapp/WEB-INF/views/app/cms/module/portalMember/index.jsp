<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	var $form = $('form#portalMember');
	
	$('#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.modify-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&portal_member_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$form.attr('action', 'save.do');
			$form.attr('method', 'POST');
			$('#editMode').val('DELETE');
			$('#portal_member_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	$('#allCheck').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.member-check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.member-check').prop('checked', false);
		}
	});
	
	$('#check-delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택 항목들을 삭제하시겠습니까?')) {
			$form.attr('action', 'save.do');
			$form.attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#portalMember')));
	});

});
</script>
<form:form modelAttribute="portalMember" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="portal_member_idx"/>

<div class="infodesk">
	검색 결과 : 총 ${paging.totalDataCount}건
	<div class="button">
		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
	</div>
</div>
<div>
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col width="10%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col />
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>그룹</th>
				<th>최근접속일</th>
				<th>가입일</th>
				<th>보기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${portalMemberList}" var="i" varStatus="status">
			<tr>
				<td>
					<form:checkbox path="portal_member_arr" cssClass="member-check" value="${i.portal_member_idx}"/>
				</td>
				<td class="num">${paging.listRowNum - status.index}</td>
				<td>${i.agency_id }</td>
				<td>${i.agency_name}</td>
				<td>
					<c:choose>
						<c:when test="${i.auth_group eq '2'}">도서관</c:when>
						<c:when test="${i.auth_group eq '3'}">학교기관</c:when>
						<c:when test="${i.auth_group eq '4'}">사서</c:when>
					</c:choose>
				</td>
				<td><fmt:formatDate value="${i.last_connect}" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
				<td>
					<a href="#" class="btn modify-btn" keyValue="${i.portal_member_idx}">수정</a>
					<a href="#" class="btn delete-btn" keyValue="${i.portal_member_idx}">삭제</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(portalMemberList) < 1}">
			<tr>
				<td colspan="8">등록된 회원정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="button">
		<a href="#" id="allCheck" class="btn" keyValue="N">전체 선택/해제</a>
		<a href="#" id="check-delete" class="btn btn3">선택 회원삭제</a>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#portalMember"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="agency_id">아이디</form:option>
				<form:option value="agency_name">학교명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="회원관리 "></div>