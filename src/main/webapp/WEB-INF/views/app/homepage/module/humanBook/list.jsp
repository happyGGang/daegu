<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap.min.css?3.3.6"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap-multiselect.css"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/mir_home_sub_community.css" />
<script type="text/javascript">
$(function(){

	$('a.view-btn').on('click', function(e) {
		e.preventDefault();
		$('input#human_book_idx').val($(this).data('human_book_idx'));
		doGetLoad('detail.do', serializeCustom($('form#humanBook')));
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('input#human_book_idx').remove();
		$('#humanBook').submit();
	});

	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = $('form#humanBook').serialize();
		doGetLoad('list.do', param);
		e.preventDefault();
	});

});
</script>

<!-- 검색시작 -->
<form:form modelAttribute="humanBook" action="list.do" method="GET">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="human_book_idx"/>
<form:hidden path="viewPage"/>
<div id="top_box">
	<p>
		<div class="well well-sm hidden-xs">
			<div class="form-inline">

				<span style="letter-spacing:9px;">주제</span>:

				<div class="form-group">
					<form:select path="activity_category" class="form-control input-sm">
						<form:option value="">전체</form:option>
						<form:options items="${activityCateList}" itemLabel="code_name" itemValue="code_id"/>
					</form:select>
				</div>

			</div>

			<div class="form-inline"> 검색어 :
				<div class="form-group">
					<form:select path="search_type" cssClass="form-control input-sm" style="width:150px;" title="검색분류선택">
						<form:option value="human_book_title">사람책 제목</form:option>
						<form:option value="teacher_name">사람책 이름</form:option>
					</form:select>

					<form:input path="search_text" cssClass="form-control input-sm" placehold="검색어를 입력해주세요" style="width:300px;" title="검색어 입력"/>
					<button id="search_btn" class="btn btn_mir_search btn-sm" >검색</button>
				</div>
			</div>
		</div>
	</p>
</div>
<!-- 검색끝 -->

<div class="table_top_box">
	<div class="text-info">
		총 <span class="text_style">${paging.totalDataCount}</span>( ${paging.viewPage}/${paging.totalPageCount} 페이지 )건이 검색되었습니다.
	</div>
</div>


<div class="humanbook_list cf">
	<table>
		<tbody>
			<c:forEach var="i" items="${humanBookList}">
			<div class="humanbook_list_box col-md-6 cf">
				<a href="#" class="img_box view-btn" data-human_book_idx="${i.human_book_idx}">
					<c:choose>
						<c:when test="${not empty i.server_file_name}">
						<img src="/data/humanBook/${i.homepage_id}/${i.server_file_name}" alt="${i.human_book_title}">
						</c:when>
						<c:otherwise>
						<img src="/resources/common/img/img_empty_user.png" alt="${i.human_book_title}"/>
						</c:otherwise>
					</c:choose>
				</a>
				<dl>
					<dt class="title"><a href="#" class="view-btn" data-human_book_idx="${i.human_book_idx}">${i.human_book_title}</a></dt>
					<dd><span class="label label-default name">사람책</span> ${i.teacher_name}</dd>
					<dd><span class="label label-default category">주제</span>
						<c:forEach items="${activityCateList}" var="code">
							<c:if test="${code.code_id eq i.activity_category}">
							${code.code_name}
							</c:if>
						</c:forEach>
					</dd>
					<dd><span class="label label-default day">가능요일</span>
						<c:forTokens items="${i.activity_day}" delims="," var="day">
							<c:if test="${day eq '1'}">일</c:if>
							<c:if test="${day eq '2'}">월</c:if>
							<c:if test="${day eq '3'}">화</c:if>
							<c:if test="${day eq '4'}">수</c:if>
							<c:if test="${day eq '5'}">목</c:if>
							<c:if test="${day eq '6'}">금</c:if>
							<c:if test="${day eq '7'}">토</c:if>
						</c:forTokens>
					</dd>
					<dd><span class="label label-default time">가능시간</span>
						<c:forTokens items="${i.activity_time}" delims="," var="time">
							<c:if test="${time eq '1'}">오전(10:00~12:00)</c:if>
							<c:if test="${time eq '2'}">오후(13:00~17:00)</c:if>
							<c:if test="${time eq '3'}">${i.activity_time_txt}</c:if>
						</c:forTokens>
					</dd>
				</dl>
			</div>
			</c:forEach>
		</tbody>
	</table>
</div>

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




