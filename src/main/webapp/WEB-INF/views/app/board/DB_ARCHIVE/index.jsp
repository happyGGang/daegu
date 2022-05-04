<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="categoryMovae" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y'}"></c:set>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center" summary="낙육재(게시판)">
			<caption>낙육재(게시판)</caption>
			<colgroup>
			<%--<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
				<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
				<col width="5%">
				</c:if>
				<col width="6%">
				<col width="*">
				<col width="12%">
				<col width="8%">
				<col width="7%">
				<col width="7%">
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
<%-- 					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th>번호</th>
					<th class="">제목</th>
					<!-- <th>처리상태</th> -->
					<th class="mmm2">등록번호</th>
					<th class="mmm2">작성자</th>
					<th class="">작성일</th>
					<th class="mmm1">조회수</th>
					<th class="mmm1">ebook 파일명</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
<%-- 					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td></td>
					</c:if>
					<td class="num notice"><span>공지</span></td>
					<td class="important left title">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<a href="${i.imsi_v_6 }" target="_blank">
							<span>${i.title}</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="mmm2">
					<td class="mmm2 username">${i.secret_yn ne 'Y'? i.user_name:'비공개'}</td>
					<td class="important num adddate"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
<%-- 					<c:if test="${board.delete_yn eq 'Y' or categoryMovae}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important left title" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<c:if test="${fn:length(category1List) > 0 and board.manage_idx eq '212'}">
							<c:forEach items="${category1List}" var="cate1">
								<c:if test="${i.category1 eq cate1.code_id}">
									<span style="color: #979797;">[${cate1.code_name}]</span>
								</c:if>
							</c:forEach>
						</c:if>
						<a href="${i.imsi_v_6 }" target="_blank">

						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>${i.title}</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td>${i.imsi_v_4 }</td>
				
					<c:choose>
						<c:when test="${authMBA or portalAuth eq '2'}">
							<c:set var="user_name" value="${i.user_name}"/>
						</c:when>
						<c:when test="${boardManage.anonymize_yn eq 'Y'}">
							<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
							<c:set var="user_name" value="${i.user_name}"/>
						</c:otherwise>
					</c:choose>
					<td class="mmm2 username">${i.secret_yn ne 'Y'? user_name : (authMBA or portalAuth eq '2' ? i.user_name : '비공개')}</td>
					<td class="important num adddate"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td>${i.imsi_v_7}</td>
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