<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${fn:length(category1List) > 0}">
<tr>
	<th>분류1</th>
	<td colspan="3">
		<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu">
			<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
		</form:select>
	</td>
</tr>
</c:if>
<c:if test="${fn:length(category2List) > 0}">
<tr>
	<th>분류2</th>
	<td colspan="3">
		<form:select path="category2" cssStyle="width:160px;" cssClass="selectmenu">
			<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
		</form:select>
	</td>
</tr>
</c:if>
<c:if test="${fn:length(category3List) > 0}">
<tr>
	<th>분류3</th>
	<td colspan="3">
		<form:select path="category3" cssStyle="width:160px;" cssClass="selectmenu">
			<form:options itemLabel="code_name" itemValue="code_id" items="${category3List}"/>
		</form:select>
	</td>
</tr>
</c:if>
<c:if test="${fn:length(subHomepageList) > 0}">
	<tr>
		<th>도서관</th>
		<td colspan="3">
			<form:select path="category5" cssStyle="width:160px;" cssClass="selectmenu">
				<form:option value="">==전체==</form:option>
				<form:options itemLabel="homepage_name" itemValue="homepage_id" items="${subHomepageList}"/>
			</form:select>
		</td>
	</tr>
</c:if>