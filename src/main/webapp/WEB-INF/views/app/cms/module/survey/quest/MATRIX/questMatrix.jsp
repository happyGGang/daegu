<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	
<c:forEach var="i" varStatus="status" items="${questMatrixList}">
<p class="after_click">
	<label for="quest_matrix_title_${status.count}">세부질문${status.count}</label>
	<input id="quest_matrix_title_${status.count}" name="quest_matrix_list[${status.index}].matrix_title" type="text" size="60" value="${i.matrix_title}" />
</p> 
</c:forEach>