<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y'}"></c:set>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center" summary="일반 게시판">
			<caption>일반게시판</caption>
			<colgroup>
				<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
				<col width="5%">
				</c:if>
				<col width="6%">
				<col width="14%">
				<col width="*">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="8%">
			</colgroup>
			<thead>
				<tr>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th>번호</th>
					<th class="">이미지</th>
					<th class="mmm2">제목</th>
					<th class="mmm1">습득장소</th>
					<th class="mmm1">습득일자</th>
					<th class="mmm1">보관장소</th>
					<th class="mmm1">상태</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>
					<c:choose>
						<c:when test="${i.preview_img ne null}">
						<a href="" keyValue="${i.board_idx}">
							<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
						</a>
						</c:when>
						<c:otherwise>
						<a href="" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}"></a>
						</c:otherwise>
					</c:choose>
					</td>
					<td class="important left title" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
						<span>${i.title}</span>
						<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
						<c:if test="${i.comment_count > 0}">
						<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
						</c:if>
						</a>
					</td>
					<td class="mmm2">${i.imsi_v_1}</td>
					<td class="mmm2">${i.imsi_v_2}</td>
					<td class="mmm2">${i.imsi_v_3}</td>
					<td class="mmm2">
					<c:choose>
						<c:when test="${i.imsi_v_4 eq '1'}">보관중</c:when>
						<c:when test="${i.imsi_v_4 eq '2'}">재기증</c:when>
						<c:when test="${i.imsi_v_4 eq '3'}">찾아감</c:when>
						<c:when test="${i.imsi_v_4 eq '4'}">폐기</c:when>
					</c:choose>
					</td>
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