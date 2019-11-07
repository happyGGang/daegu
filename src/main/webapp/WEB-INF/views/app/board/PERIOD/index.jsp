<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center">
			<colgroup>
				<col width="10%">
				<col>
				<col width="12%">
				<col width="12%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="important">간행물명</th>
					<th class="mmm1">대상</th>
					<th class="important mmm2">주제</th>
					<th class="mmm1">간기</th>
					<th class="mmm1">비치장소</th>
					<th class="mmm1">비고</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important left" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}${i.title}</span>
					</td>
					<td class="mmm1">${i.imsi_v_1}</td>
					<td class="important mmm2">${i.imsi_v_2}</td>
					<td class="mmm1">${i.imsi_v_3}</td>
					<td class="mmm1">${i.imsi_v_4}</td>
					<td class="mmm1">${i.imsi_v_5}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(boardList) < 1}">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">등록된 게시물이 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
	
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
			<label class="blind">검색</label>
			<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
				<form:option value="title">간행물명</form:option>
				<form:option value="imsi_v_1">대상</form:option>
				<form:option value="imsi_v_4">비치장소</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" />
			<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
		</fieldset>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {
		$('div#board_paging a').on('click', function(e) {
			$('#viewPage').attr('value', $(this).attr('keyValue'));
			var param = serializeCustom($('#board'));
			doGetLoad('index.do', param);
			e.preventDefault();
		});
		
		$('a#board_btn_search').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('#board'));
			doGetLoad('index.do', param);
		});
		
		$('input#search_text').keyup(function(e) {
			e.preventDefault();
			if(e.keyCode == 13) {
				$('#viewPage').attr('value', '1');
				var param = serializeCustom($('#board'));
				doGetLoad('index.do', param);
			}
		});
	});
	</script>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>