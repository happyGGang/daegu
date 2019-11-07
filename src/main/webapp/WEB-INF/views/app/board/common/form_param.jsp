<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form:hidden path="menu_idx"/>
<form:hidden path="manage_idx"/>
<form:hidden path="board_idx"/>
<form:hidden path="group_idx"/>
<c:if test="${board.module ne ''}">
<form:hidden path="module"/>
</c:if>