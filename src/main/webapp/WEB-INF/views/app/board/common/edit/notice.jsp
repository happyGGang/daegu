<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${authMBA}">
<tr>
	<th>공지사항</th>
	<td colspan="3">
		<div class="checkbox-original">
			<form:checkbox id="notice_yn" path="notice_yn" value="Y"/>
			<label for="notice_yn">공지 사용여부</label>
			<em class="info">체크 시 목록 상단에 표시됩니다.</em>
		</div>
		<form:input type="text" path="notice_start_date" cssClass="text ui-calendar"/> ~ 
		<form:input type="text" path="notice_end_date" cssClass="text ui-calendar"/>
	</td>
</tr>
</c:if>
<c:if test="${authMBA and (boardManage.manage_idx eq 521 or boardManage.manage_idx eq 523)}">
<tr>
	<c:if test="${boardManage.manage_idx eq 521}"><c:set var="boardName" value="공지사항"></c:set></c:if>
	<c:if test="${boardManage.manage_idx eq 523}"><c:set var="boardName" value="도서관뉴스"></c:set></c:if>
	<th>개별도서관 배포</th>
	<td colspan="3">
		<div class="checkbox-original">
			<form:radiobutton path="imsi_v_1" value="Y" label="예"/>
			<form:radiobutton path="imsi_v_1" value="N" label="아니오"/>
			<em class="info">체크 시 개별도서관 ${boardName} 목록 상단에 표시됩니다.</em>
		</div>
	</td>
</tr>
</c:if>