<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${authMBA or sessionScope.member.admin}">
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
					<c:when test="${authMBA or sessionScope.member.admin}">
						<form:input path="user_name" value="${member.member_name }" cssClass="text"/>
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
	<c:when test="${not empty loginSupport.login and loginSupport.login}">
		<c:if test="${board.editMode eq 'MODIFY'}">
			${board.user_name}
		</c:if>
		<c:if test="${board.editMode eq 'ADD'}">
			${loginSupport.school_name}
			<form:hidden path="user_name" value="${loginSupport.school_name}" cssClass="text"/>
		</c:if>
	</c:when>
	<c:when test="${not empty loginPortal and loginPortal.login}">
		<c:if test="${board.editMode eq 'MODIFY'}">
			${board.user_name}
		</c:if>
		<c:if test="${board.editMode eq 'ADD'}">
			${loginPortal.agency_name}
			<form:hidden path="user_name" value="${loginPortal.agency_name}" cssClass="text"/>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${sessionScope.member.anonymous and board.editMode eq 'MODIFY'}">
${board.user_name}
		</c:if>
		<c:if test="${sessionScope.member.anonymous and board.editMode eq 'ADD'}">
${sessionScope.certMember.member_name}
<form:hidden path="user_name" value="${sessionScope.certMember.member_name}" cssClass="text"/>
		</c:if>
		<c:if test="${!sessionScope.member.anonymous}">
${sessionScope.member.member_name}
		</c:if>
	</c:otherwise>
</c:choose>