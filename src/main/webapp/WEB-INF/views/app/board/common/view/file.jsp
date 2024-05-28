<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>


<c:choose>
	<c:when test="${param.manage_idx eq '897' || param.manage_idx eq '426' || param.manage_idx eq '364' || param.manage_idx eq '1207'}">
		<c:if test="${fn:length(boardFile) > 0}">
		<dd class="file">
			<ul style='height:110px;overflow-y:scroll;'>
			<c:forEach var="i" varStatus="status" items="${boardFile}">
				<li>
					<a href="javascript:alert('다운로드가 불가합니다.');"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.org_file_name}</span></a>
					<c:if test="${not empty authMBA and authMBA}">
					</c:if>
				</li>
			</c:forEach>
			</ul>
		</dd>
		</c:if>
	</c:when>

	<c:otherwise>
		<c:if test="${fn:length(boardFile) > 0}">
		<dd class="file">
			<ul style='height:110px;overflow-y:scroll;'>
			<c:forEach var="i" varStatus="status" items="${boardFile}">
				<li>
					<a href="${getContextPath}/board/boardFile/download/${board.manage_idx}/${i.board_idx}/${i.file_idx}/${i.org_file_name}.do"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.org_file_name}</span></a>
					<c:if test="${not empty authMBA and authMBA}">
					다운로드 수 : ${i.file_down_count}
					</c:if>
				</li>
			</c:forEach>
			</ul>
		</dd>
		</c:if>
	</c:otherwise>
</c:choose>