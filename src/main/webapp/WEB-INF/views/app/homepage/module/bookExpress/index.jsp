<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bookExpress')));
	});
	
	
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.book_check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.book_check').prop('checked', false);
		}
	});
	
	$('#express-check').on('click', function(e) {
		e.preventDefault();
		
		if($('.book_check:checked').length == 0) {
			alert('신청할 도서를 선택하세요.');
			return false;
		}
		
		if(confirm('선택 도서 택배신청 하시겠습니까?')) {
			if(doAjaxPost($('#bookExpress'))) {
				location.reload();
			}
		}
	});
	
	$('#delete-check').on('click', function(e) {
		e.preventDefault();
		if($('.book_check:checked').length == 0) {
			alert('삭제할 리스트를 선택하세요.');
			return false;
		}
		if(confirm('선택 항목들을 삭제하시겠습니까?')) {
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bookExpress'))) {
				location.reload();
			}
		}
	});
	
});
</script>

<form:form modelAttribute="bookExpress" action="save.do" method="POST">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode" value="MODIFY"/>

<div>
	<table class="type1 center">
		<colgroup>
			<col width="80" />
			<col width="100" />
			<col width="*" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>도서정보</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${interestBookList}" var="i" varStatus="status">
			<tr>
				<td><form:checkbox path="book_express_arr" cssClass="book_check" value="${i.book_express_idx}"/></td>
				<td class="num">${paging.listRowNum - status.index}</td>
				<td>${i.book_name}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(interestBookList) < 1}">
			<tr>
				<td colspan="4">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<c:if test="${loginPortal.login}">
		<a href="#" id="all-check" class="btn" keyValue="N">전체 선택/해제</a>
		<a href="#" id="express-check" class="btn">선택 도서택배신청</a>
		<a href="#" id="delete-check" class="btn" style="color: red;">선택 게시글삭제</a>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookExpress"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="book_name">도서명</form:option>
			<form:option value="book_call_no">청구기호</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
</form:form>