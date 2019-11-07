<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${authMBA}">
		<c:choose>
			<c:when test="${board.editMode eq 'MODIFY'}">
				<c:choose>
					<c:when test="${board.add_id eq member.member_id}">
						<c:if test="${empty board.user_name}">
<form:input path="user_name" value="${member.member_name }" cssClass="text"/>
						</c:if>
						<c:if test="${not empty board.user_name}">
<form:input path="user_name" cssClass="text"/>
						</c:if>
					</c:when>
					<c:otherwise>
${board.user_name}
					</c:otherwise>
				</c:choose>	
			</c:when>
			
			<c:otherwise>
<form:input path="user_name" value="${member.member_name }" cssClass="text"/>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
${member.member_name}
	</c:otherwise>
</c:choose>