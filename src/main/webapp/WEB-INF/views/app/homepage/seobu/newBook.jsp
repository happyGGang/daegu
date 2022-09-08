<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${newBookList[listNum1].ST_CODE}&regNo=${fn:escapeXml(newBookList[listNum1].REG_NO)}&manageCode=${fn:escapeXml(newBookList[listNum1].MANAGE_CODE)}&booktype=BO" >
		<span class="img">
		<c:choose>
			<c:when test="${(empty newBookList[listNum1].aladin or empty newBookList[listNum1].aladin.cover) and empty newBookList[listNum1].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
			</c:when>
			<c:when test="${not empty newBookList[listNum1].aladin or not empty newBookList[listNum1].aladin.cover}">
				<img src="${newBookList[listNum1].aladin.cover}" alt="${newBookList[listNum1].TITLE_INFO} 상세보기">
			</c:when>
			<c:otherwise>
				<img src="${newBookList[listNum1].imageUrl}" alt="${newBookList[listNum1].TITLE_INFO} 상세보기"/>
			</c:otherwise>
		</c:choose>
		</span>
		<span class="contents">
			<c:set var="texts01" value="${newBookList[listNum1].TITLE_INFO}"/>
			<p class="title">
			<c:choose>
				<c:when test="${fn:length(texts01) > 12}">
					${fn:substring(texts01, 0, 12)}...
				</c:when>
				<c:otherwise>
					${texts01}
				</c:otherwise>
			</c:choose>
			</p>
			<p><b>저자</b> ${newBookList[listNum1].AUTHOR}</p>
			<p><b>발행자</b> ${newBookList[listNum1].PUBLISHER}</p>
		</span>
	</a>
</li>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${newBookList[listNum2].ST_CODE}&regNo=${fn:escapeXml(newBookList[listNum2].REG_NO)}&manageCode=${fn:escapeXml(newBookList[listNum2].MANAGE_CODE)}&booktype=BO" >
		<span class="img">
		<c:choose>
			<c:when test="${(empty newBookList[listNum2].aladin or empty newBookList[listNum2].aladin.cover) and empty newBookList[listNum2].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기"/>
			</c:when>
			<c:when test="${not empty newBookList[listNum2].aladin or not empty newBookList[listNum2].aladin.cover}">
				<img src="${newBookList[listNum2].aladin.cover}" alt="${newBookList[listNum2].TITLE_INFO} 상세보기">
			</c:when>
			<c:otherwise>
				<img src="${newBookList[listNum2].imageUrl}" alt="${newBookList[listNum2].TITLE_INFO} 상세보기"/>
			</c:otherwise>
		</c:choose>
		</span>
		<span class="contents">
			<c:set var="texts02" value="${newBookList[listNum2].TITLE_INFO}"/>
			<p class="title">
			<c:choose>
				<c:when test="${fn:length(texts02) > 12}">
					${fn:substring(texts02, 0, 12)}...
				</c:when>
				<c:otherwise>
					${texts02}
				</c:otherwise>
			</c:choose>
			</p>
			<p><b>저자</b> ${newBookList[listNum2].AUTHOR}</p>
			<p><b>발행자</b> ${newBookList[listNum2].PUBLISHER}</p>
		</span>
	</a>
</li>