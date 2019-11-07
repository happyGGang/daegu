<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${authMBA || authC}">
<c:if test="${fn:length(boardManageAll) > 0}">
<dl class="mmm1 admin_btn">
	<dt>
		<select id="moveTarget_manage_idx" class="selectmenu-search" style="width:70%">
			<option value="">::게시판 선택(게시물 이동용)::</option>
		<c:forEach var="i" varStatus="status" items="${boardManageAll}">
			<option value="${i.manage_idx}">${i.board_name}</option>
		</c:forEach>	
		</select>
		
		<a href="" class="btn btn5" id="board_move_btn">게시물이동</a>
	</dt>
</dl>
</c:if>
</c:if>