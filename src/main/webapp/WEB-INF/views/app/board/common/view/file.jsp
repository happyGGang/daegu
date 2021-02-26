<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<c:if test="${fn:length(boardFile) > 0}">
<dd class="file">
	<ul style='height:110px;overflow-y:scroll;'>
	<c:forEach var="i" varStatus="status" items="${boardFile}">
		<li>
			<a href="${getContextPath}/board/boardFile/download/${board.manage_idx}/${i.board_idx}/${i.file_idx}.do"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.org_file_name}</span></a>
			<c:if test="${not empty authMBA and authMBA}">
			다운로드 수 : ${i.file_down_count}
			</c:if>
		</li>
	</c:forEach>
	</ul>
</dd>
</c:if>