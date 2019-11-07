<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String formId = request.getParameter("formId");
%>
<form:hidden path="viewPage"/>
<div id="board_paging" class="dataTables_paginate">
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

<div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<label class="blind" for="search_type">검색조건</label>
		<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
			<form:option value="title+content">제목+내용</form:option>
			<form:option value="title">제목</form:option>
			<form:option value="content">내용</form:option>
			<form:option value="user_name">글작성자</form:option>
		</form:select>
		<form:input path="search_text" id="search_text_board" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
		<label for="search_text_board" class="blind">검색어</label>
		<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
	</fieldset>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('<%=formId%>'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('<%=formId%>'));
		doGetLoad('index.do', param);
	});
	
	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('<%=formId%>'));
			doGetLoad('index.do', param);
		}
	});
});
</script>