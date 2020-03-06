<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:if test="${not empty closeDayList and not empty closeDayList.dd}">
	<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
	<c:forEach items="${dd}" var="i" varStatus="status" end='10'>
	<span class="">${i}</span>
	<c:if test="${status.count % 6 == 0}"><br/></c:if>
	<c:if test="${status.count % 11 == 0}"><b style="color:#fff;">...</b></c:if>
	</c:forEach>

</c:if>
<c:if test="${empty closeDayList or empty closeDayList.dd}">
	<span class="none-holiday" style="width:250px;">등록된 휴관일이 없습니다.</span>
</c:if>
