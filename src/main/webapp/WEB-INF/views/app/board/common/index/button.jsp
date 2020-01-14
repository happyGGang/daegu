<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="button bbs-btn right" style="clear: both;">

<c:choose>
	<c:when test="${member.admin or authMBA}">
		<c:choose>
			<c:when test="${board.delete_yn eq 'Y'}">
				<a href="" class="btn btn2" id="board_normal_btn"></i><span>일반 게시물 보기</span></a>
				<a href="" class="btn btn1" id="board_recovery_btn"></i><span>게시물 복구</span></a>
				<a href="" class="btn btn5" id="board_delete_btn"></i><span>완전 삭제</span></a>
			</c:when>
			<c:otherwise>
				<a href="" class="btn btn4" id="board_deleteRecovery_btn"><span>삭제 게시물 보기</span></a>
				<c:if test="${authC}">
				<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
				</c:if>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:if test="${authC}">
			<c:if test="${sessionScope.member.login}">
			<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:if>
			<c:if test="${sessionScope.member.anonymous}">
			<a href="" class="btn btn1 write" id="anonymous_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:if>
		</c:if>
	</c:otherwise>
</c:choose>
</div>
