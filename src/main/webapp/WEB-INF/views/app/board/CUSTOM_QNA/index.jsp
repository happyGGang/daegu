<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
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
			<thead>
				<tr>
					<th>번호</th>
				<c:forEach var="i" varStatus="status" items="${fieldList}">
					<th>${i.board_content}</th>
				</c:forEach>
				<c:if test="${boardManage.file_use_yn eq 'Y'}">
					<th class="mmm1">파일</th>
				</c:if>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
					<td class="num notice"><span>공지</span></td>
				<c:forEach var="j" varStatus="status2" items="${fieldList}">
				<boardTag:customFieldIndex manage_idx="${boardManage.manage_idx}" board_idx="${i.board_idx}" board_column="${j.board_column}" board_value="${i[j.board_column]}" column_type="${j.column_type}" content_link_yn="${j.content_link_yn}" code_mapping="${j.code_mapping}" />
				</c:forEach>
				<c:if test="${boardManage.file_use_yn eq 'Y'}">
					<td class="file mmm1">${i.file_count > 0?'<i class="fa fa-floppy-o"></i>':''}</td>
				</c:if>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<td class="num">${paging.listRowNum - status.index}</td>
				<c:forEach var="j" varStatus="status2" items="${fieldList}">
				<c:choose>
				<c:when test="${boardManage.manage_idx eq 110 and j.board_column eq 'imsi_v_5'}">
					<boardTag:customQnaFieldIndex manage_idx="${boardManage.manage_idx}" board_idx="${i.board_idx}" board_column="${j.board_column}" board_value="${i[j.board_column]}" content_link_yn="${j.content_link_yn}"/>
				</c:when>
				<c:when test="${boardManage.manage_idx eq 110 and j.board_column eq 'user_name' and i['imsi_v_6'] eq '20'}">
					<td>비공개</td>
				</c:when>
				<c:otherwise>
					<boardTag:customFieldIndex manage_idx="${boardManage.manage_idx}" board_idx="${i.board_idx}" board_column="${j.board_column}" board_value="${i[j.board_column]}" column_type="${j.column_type}" content_link_yn="${j.content_link_yn}" code_mapping="${j.code_mapping}" />
				</c:otherwise>
				</c:choose>	
				</c:forEach>
				<c:if test="${boardManage.file_use_yn eq 'Y'}">
					<td class="file mmm1">${i.file_count > 0?'<i class="fa fa-floppy-o"></i>':''}</td>
				</c:if>
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

	<div class="button bbs-btn right">
	<c:if test="${authMBA}">
	<c:choose>
	<c:when test="${board.delete_yn eq 'Y'}">
		<a href="" class="btn btn2" id="board_normal_btn"></i><span>일반 게시물 보기</span></a>
	</c:when>
	<c:otherwise>
		<a href="" class="btn btn4" id="board_deleteRecovery_btn"><span>삭제 게시물 보기</span></a>
	</c:otherwise>
	</c:choose>
	</c:if>
	<c:if test="${boarManage.manage_idx ne 110}">
		<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
	</c:if>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>