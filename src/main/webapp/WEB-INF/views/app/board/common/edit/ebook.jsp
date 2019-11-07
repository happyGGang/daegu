<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.ebook_yn eq 'Y'}">
<tr>
	<th>E-Book URL</th>
	<td colspan="3">
		<form:input path="ebook_url" cssClass="text" cssStyle="width:70%" maxlength="200" /><a href="" class="btn btn3" id="ebook_btn">E-Book 생성</a>
	</td>
</tr>
</c:if>