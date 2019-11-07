<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="button bbs-btn right">
<c:choose>
<c:when test="${board.delete_yn  eq 'Y' and authMBA}">
	<a href="" class="btn btn5" id="board_recovery_btn">게시물복구</a>
</c:when>
<c:otherwise>
<c:if test="${authMBA and boardManage.reply_use_yn eq 'Y'}">
	<a href="" class="btn reply" id="board_reply_btn"><i class="fa fa-pencil"></i><span>답변하기</span></a>
</c:if>
<c:if test="${authMBA or authD}">
	<c:choose>
		<c:when test="${authMBA}">
	<a href="" class="btn delete" id="board_delete_btn"><i class="fa fa-trash-o"></i><span>삭제</span></a>
		</c:when>
		<c:otherwise>
			<c:if test="${member.member_id eq board.add_id or member.web_id eq board.add_id}">
	<a href="" class="btn delete" id="board_delete_btn"><i class="fa fa-trash-o"></i><span>삭제</span></a>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${authMBA or authU}">
	<c:choose>
		<c:when test="${authMBA}">
	<a href="" class="btn modify" id="board_edit_btn"><i class="fa fa-pencil-square-o"></i><span>수정</span></a>
		</c:when>
		<c:otherwise>
			<c:if test="${member.member_id eq board.add_id or member.web_id eq board.add_id}">
	<a href="" class="btn modify" id="board_edit_btn"><i class="fa fa-pencil-square-o"></i><span>수정</span></a>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>
</c:otherwise>
</c:choose>
	<a href="" class="btn scrab" id="board_scrab_btn"><i class="fa fa-star"></i><span>스크랩</span></a>
	<a href="" class="btn print" id="board_print_btn"><i class="fa fa-print"></i><span>인쇄</span></a>
	<a href="" class="btn btn1 list" id="board_index_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>
<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" id="editMode_1" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${board.title}">
	<input type="hidden" id="item_type" name="item_type" value="2">
	<input type="hidden" id="img_url" name="img_url" value="">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>