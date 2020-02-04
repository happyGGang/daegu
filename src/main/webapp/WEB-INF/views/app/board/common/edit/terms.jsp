<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="terms${status.count}" name="agree_codes" type="checkbox" keyValue="${terms.title}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의</label><br>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>