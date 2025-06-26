<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="value" required="false" %>
<%@ attribute name="condition" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${condition}">
        <div>· ${label} <span>${value}</span></div>
    </c:when>
    <c:otherwise>
        <div>· ${label} <span>-</span></div>
    </c:otherwise>
</c:choose>
