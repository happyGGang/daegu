<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	<%--검색--%>
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#archiveBookListForm').serialize());
	});

	$('a.open_viewer').on('click', function(e) {
		var win = window.open('view.do?book_idx=' + $(this).data('book_idx'), '', 'scrollbars=no,toolbar=no,menubar=no,location=no,width=1000,height=650,location=no');
	});
});

</script>

<form:form id="archiveBookListForm" modelAttribute="archive" action="index.do" >
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="category"/>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${count}" pattern="#,###" />건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">20개씩 보기</form:option>
			<form:option value="50">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="10%" />
			<col width="25%" />
			<col width="15%" />
			<col width="20%" />
			<col width="20%"/>
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th></th>
				<th>서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>청구기호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${archiveBookList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td>
						<a href="#" class="open_viewer" data-book_idx="${i.book_idx}">
							<img src="/data/archive/${i.homepage_id}/${i.book_idx}/${i.server_file_name}" alt="${i.subject}" style="width:100%;">
						</a>
					</td>
					<td><a href="#" class="open_viewer" data-book_idx="${i.book_idx}">${i.subject}</a></td>
					<td>${i.author}</td>
					<td>${i.publisher}</td>
					<td>${i.callnumber}</td>
				</tr>
			</c:forEach>
			<c:if test="${count eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#archiveBookListForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="regnumber">등록번호</form:option>
				<form:option value="callnumber">청구기호</form:option>
				<form:option value="subject">제목</form:option>
				<form:option value="year">발행년도</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
