<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="categoryMove" value="${not empty authMBA and authMBA and boardManage.category_use_yn eq 'Y' and boardManage.manage_idx ne '195'}"></c:set>
<div class="button bbs-btn right" style="clear: both;">
<c:choose>
	<c:when test="${member.admin or authMBA or supportAdmin or portalAuth eq '2'}">
		<c:choose>
			<c:when test="${board.delete_yn eq 'Y'}">
				<a href="" class="btn btn2" id="board_normal_btn"></i><span>일반 게시물 보기</span></a>
				<a href="" class="btn btn1" id="board_recovery_btn"></i><span>게시물 복구</span></a>
				<a href="" class="btn btn5" id="board_delete_btn"></i><span>완전 삭제</span></a>
			</c:when>
			<c:otherwise>
				<c:if test="${categoryMove}">
					<a href="" class="btn btn5" id="board_move_btn" data-idx="${boardManage.manage_idx}"></i><span>분류 변경</span></a>
					<form:hidden path="moveCategory1Target"/>
				</c:if>
				<a href="" class="btn btn4" id="board_deleteRecovery_btn"><span>삭제 게시물 보기</span></a>
				<c:if test="${authC or supportAuth or portalAuth ne 0}">
				<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
				</c:if>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:if test="${authC}">
		<c:choose>
			<c:when test="${sessionScope.member.login}">
			<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:when>
			<c:when test="${supportAuth or portalAuth eq '4'}">
			<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:when>
			<c:when test="${sessionScope.member.anonymous}">
			<a href="" class="btn btn1 write" id="anonymous_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:when>
		</c:choose>
		</c:if>
	</c:otherwise>
</c:choose>
</div>

<div id="categoryMoveDialog" style="display: none;" title="카테고리 변경">
	<c:if test="${fn:length(category1List) > 0}">
	<div>
		<div style="text-align: center;">분류1</div>
		<ul>
			<c:forEach items="${category1List}" var="i" varStatus="status">
			<li><input type="radio" id="moveCategory1Target${i.code_id}" name="moveCategory1Target_" value="${i.code_id}" /><label for="moveCategory1Target${i.code_id}">${i.code_name}</label> </li>
			</c:forEach>
		</ul>
	</div>
	</c:if>

	<div class="button bbs-btn center" style="clear: both;">
		<a href="#" class="btn btn2" id="moveCategory"></i><span>변경적용</span></a>
		<a href="#" class="btn btn2" id="moveCategoryCancel"></i><span>닫기</span></a>
	</div>
</div>