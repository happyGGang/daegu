<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	
<c:forEach var="i" varStatus="status" items="${questDetailList}">
<p class="after_click" style="padding-bottom: 10px;">
	<label for="quest_detail_title_${status.count}">보기${status.count}</label>
	<input id="quest_detail_title_${status.count}" name="quest_detail_list[${status.index}].quest_detail_title" type="text" size="50" value="${i.quest_detail_title}" />
	<span style="padding-left: 15px;">
		분기 : 
		<select style="max-width: 200px;" name="quest_detail_list[${status.index}].branch_idx" >
			<option value="0">없음</option>
			<c:forEach var="j" varStatus="statusJ" items="${questList}">
			<c:if test="${j.quest_type ne 'DESCRIPTION'}">
			<option value="${j.quest_idx}"<c:if test="${i.branch_idx eq j.quest_idx}"> selected="selected"</c:if>><tag:cutStr cutNum="38" inStr="${j.quest_order}. ${j.quest_content}" /></option>
			</c:if>
			</c:forEach>
		</select>
	</span>
</p>
</c:forEach>
<p class="after_click">
	<label for="quest_detail_free_yn_N">기타(자유응답형) 추가</label>
	<input type="radio" id="quest_detail_free_yn_N" name="quest_detail_free_yn" value="N" ${quest.quest_detail_free_yn eq 'N'?'checked':''}  /><label for="quest_detail_free_yn_N">아니오</label>
	<input type="radio" id="quest_detail_free_yn_Y" name="quest_detail_free_yn" value="Y" ${quest.quest_detail_free_yn eq 'Y'?'checked':''}/><label for="quest_detail_free_yn_Y">예</label>
</p>