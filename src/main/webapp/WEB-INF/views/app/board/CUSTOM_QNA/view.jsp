<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<script>
$(document).ready(function() {
    <%-- 답변 수정하기 --%>
    $('a#board_reply_edit_btn').on('click', function(e) {
    	$('#editMode').val('MODIFY');
    	$('#board_idx').val($(this).attr('keyValue'));
		var url = 'edit.do';
		var formData = serializeCustom($('#board'));
		doGetLoad(url, formData);
		e.preventDefault();
	});
    
    <%-- 답변 삭제하기 --%>
    $('a#board_reply_delete_btn').on('click', function(e) {
    	e.preventDefault();
    	$('#board_idx').val($(this).attr('keyValue'));
    	if(confirm('답변을 삭제 하시겠습니까?')) {
    		$('#board').attr('action', 'delete.do');
    		doAjaxPost($('#board'));	
    	}
	});
});
</script>
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="parent_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>
<div class="wrapper-bbs">
	<c:if test="${boardManager.board_add_html_yn eq 'Y'}">
	${boardManager.board_top_add_html}
	</c:if>
	<div class="bbs-view">
		<div class="bbs-view-header">
			<dl>
				<dt>${board.title}</dt>
				<jsp:include page="/WEB-INF/views/app/board/common/view/ebook.jsp" flush="false" />
				<dd class="info">
					<div class="panel-left">
						<i>작성자</i><span>${board.user_name}</span>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
					<c:if test="${fn:length(fieldList) > 1}">
					<div class="add-fields">
					<c:forEach var="i" varStatus="status" items="${fieldList}">
					<c:if test="${i.board_column ne 'title' and i.board_column ne 'view_count' and i.board_column ne 'user_name' and i.board_column ne 'add_date'}">
						<boardTag:customFieldView manage_idx="${boardManage.manage_idx}" board_content="${i.board_content}" board_value="${board[i.board_column]}" column_type="${i.column_type}" code_mapping="${i.code_mapping}" />
					</c:if>
					</c:forEach>
					</div>
					</c:if>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(board.content, crlf, '<br/>')}
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
	</div>
	<div class="button bbs-btn right">
	<c:if test="${authMBA or (authU and board.imsi_v_5 eq 10 and fn:length(boardQnaList) eq 0)}">
		<a href="" class="btn modify" id="board_edit_btn"><i class="fa fa-pencil-square-o"></i><span>수정</span></a>
	</c:if>
	<c:if test="${fn:length(boardQnaList) eq 0 and authMBA}">
		<a href="" class="btn reply" id="board_reply_btn"><i class="fa fa-pencil"></i><span>답변하기</span></a>
	</c:if>
	<c:if test="${fn:length(boardQnaList) eq 0 and authD}">
		<a href="" class="btn delete" id="board_delete_btn"><i class="fa fa-trash-o"></i><span>삭제</span></a>
	</c:if>
		<a href="" class="btn btn1 list" id="board_index_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
	</div>
</div>
<div class="wrapper-bbs">
	<c:forEach var="j" varStatus="status" items="${boardQnaList}" end="1">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<dl>
				<dt>${j.title}</dt>
				<dd class="info">
					<div class="panel-left">
						<i>작성자</i><span>${j.user_name}</span>
						<i>작성일</i><span><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
					</div>
					<c:if test="${fn:length(fieldList) > 1}">
					<div class="add-fields">
					<c:forEach var="i" varStatus="status" items="${fieldList}">
					<c:if test="${i.board_column ne 'title' and i.board_column ne 'view_count' and i.board_column ne 'user_name' and i.board_column ne 'add_date'}">
						<boardTag:customFieldView manage_idx="${boardManage.manage_idx}" board_content="${i.board_content}" board_value="${j[i.board_column]}" column_type="${i.column_type}" code_mapping="${i.code_mapping}" />
					</c:if>
					</c:forEach>
					</div>
					</c:if>
				</dd>
				<c:if test="${fn:length(boardFile) > 0}">
				<dd class="file">
					<ul>
					<c:forEach var="i" varStatus="status" items="${boardFile}"> 
						<li><a href="${getContextPath}/board/boardFile/download/${j.manage_idx}/${i.board_idx}/${i.file_idx}.do"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.file_name}</span></a></li>
					</c:forEach>
					</ul>
				</dd>
				</c:if>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(j.content, crlf, '<br/>')}
		</div>
	</div>
	<div class="button bbs-btn right">
	<c:choose>
	<c:when test="${board.delete_yn  eq 'Y'}">
		<a href="" class="btn btn5" id="board_recovery_btn">게시물복구</a>
	</c:when>
	<c:otherwise>
	
	<c:if test="${fn:length(boardQnaList) > 0 and authMBA}">
		<a href="" class="btn modify" id="board_reply_edit_btn" keyValue="${boardQnaList[0].board_idx}"><i class="fa fa-pencil-square-o"></i><span>답변수정</span></a>
		<a href="" class="btn delete" id="board_reply_delete_btn" keyValue="${boardQnaList[0].board_idx}"><i class="fa fa-trash-o"></i><span>답변삭제</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<a href="" class="btn btn1 list" id="board_index_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
	</div>
	</c:forEach>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>