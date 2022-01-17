<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>

<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp"
	flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp"
		flush="false" />
	<div class="wrapper-bbs">
		<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp"
			flush="false" />
		<div class="table-wrap">
			<table class="bbs center" summary="분실 게시판">
				<caption>분실게시판</caption>
				<colgroup>
					<c:if test="${board.delete_yn eq 'Y'}">
						<col width="5%">
					</c:if>
					<col width="5%">
					<col width="20%">
					<col width="5%">
					<col width="5%">
					<col width="5%">
				</colgroup>
				<thead>
					<tr>
						<c:if test="${board.delete_yn eq 'Y'}">
							<th><input type="checkbox" id="checkAll"> </th>
						</c:if>
						<th>번호</th>
						<th class="">제목</th>
						<th class="">작성자</th>
						<th class="">작성일</th>
						<th>처리상태</th>
					</tr>
				<thead>
				<tbody id="board_tbody">
					<c:forEach var="i" varStatus="status" items="${boardList}">
						<tr ${i.group_depth > 0?' class="reply"':''}>
							<c:if test="${board.delete_yn eq 'Y'}">
								<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
							</c:if>
							<td class="num">${paging.listRowNum - status.index}</td>
							<td class="important left title"
								style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
								<a href="" keyValue="${i.board_idx}"> <!-- 답글 일경우 이미지  --> <c:if
										test="${i.group_depth > 0}">
										<i class="fa fa-reply"></i>
									</c:if> <span>${i.title} </span> ${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
									<c:if test="${i.date_gap <= boardManage.new_date_count}">
										<em class="new">새글</em>
									</c:if> <c:if test="${i.comment_count > 0}">
										<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
									</c:if>
							</a>
							</td>
							<c:set var="user_name"
								value="${fn:substring(i.user_name, -1, 1)}**" />
							<td class="mmm2 username">${user_name}</td>
							<td class="important num adddate"><fmt:formatDate
									value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
							<td class="num mmm1">
									<c:choose>
										 <c:when test="${i.request_state eq '1'}">
								          	  접수완료
								         </c:when>
											<c:when test="${i.request_state eq '2'}">
								           	 처리완료
								         </c:when>
											<c:otherwise>
								                      분실
								         </c:otherwise>
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
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp"
		flush="false" />

	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp"
		flush="false">
		<jsp:param name="formId" value="#board" />
	</jsp:include>
</form:form>