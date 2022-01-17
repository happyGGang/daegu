<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function() {
	
	$('div#initSearch a').on('click', function(e) {
		e.preventDefault();
		$('input#initSearch').val($(this).data('init'));
		$('a#board_btn_search').click();
	});
	
	$('div#initSearch a').each(function() {
		var kv = $(this).data('init');
		if ('${board.initSearch}' == kv) {
			$(this).parent('li').addClass('on');
		}
	});
	
});
</script>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>

<style>
.tab-board-odb {text-align:center;padding:38px 0;}
.tab-board-odb li {display:inline-block;}
.tab-board-odb li a {display:block;border:1px solid #ddd;box-sizing:border-box;padding:5px 10px;}
.tab-board-odb li.on a {background:#0060ff;color:#fff;}
</style>

<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y'}"></c:set>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="initSearch"/>

<div class="tab-board-odb" id="initSearch">
	<ul>
		<li><a href="#" title="search04" data-init="">전체</a></li>
		<li><a href="#" class="btn" title="가나" data-init="ㄱ">ㄱ</a></li>
		<li><a href="#" class="btn" title="나다" data-init="ㄴ">ㄴ</a></li>
		<li><a href="#" class="btn" title="다라" data-init="ㄷ">ㄷ</a></li>
		<li><a href="#" class="btn" title="라마" data-init="ㄹ">ㄹ</a></li>
		<li><a href="#" class="btn" title="마바" data-init="ㅁ">ㅁ</a></li>
		<li><a href="#" class="btn" title="바사" data-init="ㅂ">ㅂ</a></li>
		<li><a href="#" class="btn" title="사아" data-init="ㅅ">ㅅ</a></li>
		<li><a href="#" class="btn" title="아자" data-init="ㅇ">ㅇ</a></li>
		<li><a href="#" class="btn" title="자차" data-init="ㅈ">ㅈ</a></li>
		<li><a href="#" class="btn" title="차카" data-init="ㅊ">ㅊ</a></li>
		<li><a href="#" class="btn" title="카타" data-init="ㅋ">ㅋ</a></li>
		<li><a href="#" class="btn" title="타파" data-init="ㅌ">ㅌ</a></li>
		<li><a href="#" class="btn" title="파하" data-init="ㅍ">ㅍ</a></li>
		<li><a href="#" class="btn" title="하" data-init="ㅎ">ㅎ</a></li>
		<li><a href="#" class="btn" title="기타" data-init="A">기타</a></li>
	</ul>
</div>

<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center">
			<caption>게시물 목록(간행물)</caption>
			<colgroup>
				<c:if test="${member.admin or authMBA}">
				<col width="5%">
				</c:if>
				<col width="10%">
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<c:if test="${member.admin or authMBA}">
					<th><input type="checkbox" id="checkAll"></th>
					</c:if>
					<th>번호</th>
					<th>간행물명</th>
					<th>발행처</th>
					<th>간별</th>
					<th>자료실명</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
				<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr>
					<c:if test="${member.admin or authMBA}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td scope="row">${paging.listRowNum - status.index}</td>
					<td>
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">${i.title}</a>
					</td>
					<td>${i.imsi_v_1}</td>
					<td>${i.imsi_v_2}</td>
					<td>${i.imsi_v_3}</td>
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

	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>