<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:forEach items="${newBookList}" var="i" varStatus="status" begin="0" end="3">
	<li>
		<a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO" >
			<span class="con-image">
				<c:choose>
					<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
						<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
					</c:when>
					<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
						<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
					</c:when>
					<c:otherwise>
						<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
					</c:otherwise>
				</c:choose>
			</span>
			<span class="con-title">${i.TITLE_INFO}</span>
		</a>
	</li>
</c:forEach>