<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<select id="siteList" class="cmsHomepageList" style="width:200px;">
	<c:forEach items="${member.authorityHomepageList}" var="i" varStatus="status">
		<c:if test="${i.homepage_id ne 'c0' and i.homepage_id ne 'c1' and i.homepage_id ne 'h27'}">
			<option value="${i.homepage_id}" label="${i.homepage_name}"<c:if test="${i.homepage_id eq adminMenu.homepage_id}"> selected="selected"</c:if>></option>
		</c:if>
	</c:forEach>
</select>