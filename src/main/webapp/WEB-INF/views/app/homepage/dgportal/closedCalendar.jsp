<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:if test="${not empty closeDayList and not empty closeDayList.dd}">
	<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
	<c:forEach items="${dd}" var="i" varStatus="status">
	<span class="">${i}</span>
	<c:if test="${status.count % 6 == 0}"><br/></c:if>
	</c:forEach>
</c:if>
