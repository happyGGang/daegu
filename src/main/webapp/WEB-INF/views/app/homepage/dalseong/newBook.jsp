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
		<span class="title">${newBookList[listNum1].TITLE_INFO}</span>
	</a>
</li>
