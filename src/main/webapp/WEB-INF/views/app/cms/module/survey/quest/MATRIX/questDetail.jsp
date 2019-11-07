<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	
<c:forEach var="i" varStatus="status" items="${questDetailList}">
<p class="after_click">
	<label for="quest_detail_title_${status.count}">보기${status.count}</label>
	<input id="quest_detail_title_${status.count}" name="quest_detail_list[${status.index}].quest_detail_title" type="text" size="60" value="${i.quest_detail_title}" />
</p>
</c:forEach>