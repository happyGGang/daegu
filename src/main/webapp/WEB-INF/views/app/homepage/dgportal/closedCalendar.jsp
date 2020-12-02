<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

		<c:if test="${empty closeDayList.dd}">
			<span>등록된 휴일이 없습니다.</span>
		</c:if>
		<c:if test="${not empty closeDayList.dd}">
			<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
				<c:forEach items="${dd}" var="i">
				<span>${i}</span>
				</c:forEach>
		</c:if>

