<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
int listNum3 = 0;
int listNum4 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
do {
	listNum3 = rnd.nextInt(10);
} while (listNum1 == listNum3 || listNum2 == listNum3);
do {
	listNum4 = rnd.nextInt(10);
} while (listNum1 == listNum4 || listNum2 == listNum4 || listNum3 == listNum4);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>
<c:set var="listNum4" value="<%=listNum4%>"></c:set>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=15&isbn=${bestBookList[listNum1].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum1].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum1].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
			<c:when test="${(empty bestBookList[listNum1].aladin or empty bestBookList[listNum1].aladin.cover) and empty bestBookList[listNum1].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" />
			</c:when>
			<c:when test="${not empty bestBookList[listNum1].aladin or not empty bestBookList[listNum1].aladin.cover}">
				<img src="${bestBookList[listNum1].aladin.cover}" alt="${bestBookList[listNum1].TITLE} 상세보기">
			</c:when>
			<c:otherwise>
				<img src="${bestBookList[listNum1].imageUrl}" alt="${bestBookList[listNum1].TITLE} 상세보기"/>
			</c:otherwise>
		</c:choose>
		<span class="title">${bestBookList[listNum1].TITLE}</span>
		<span class="author">${bestBookList[listNum1].AUTHOR}</span>
	</a>
</li>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=15&isbn=${bestBookList[listNum2].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum2].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum2].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
			<c:when test="${(empty bestBookList[listNum2].aladin or empty bestBookList[listNum2].aladin.cover) and empty bestBookList[listNum2].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" />
			</c:when>
			<c:when test="${not empty bestBookList[listNum2].aladin or not empty bestBookList[listNum2].aladin.cover}">
				<img src="${bestBookList[listNum2].aladin.cover}" alt="${bestBookList[listNum2].TITLE} 상세보기">
			</c:when>
			<c:otherwise>
				<img src="${bestBookList[listNum2].imageUrl}" alt="${bestBookList[listNum2].TITLE} 상세보기"/>
			</c:otherwise>
		</c:choose>
		<span class="title">${bestBookList[listNum2].TITLE}</span>
		<span class="author">${bestBookList[listNum2].AUTHOR}</span>
	</a>
</li>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=15&isbn=${bestBookList[listNum3].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum3].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum3].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
			<c:when test="${(empty bestBookList[listNum3].aladin or empty bestBookList[listNum3].aladin.cover) and empty bestBookList[listNum3].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" />
			</c:when>
			<c:when test="${not empty bestBookList[listNum3].aladin or not empty bestBookList[listNum3].aladin.cover}">
				<img src="${bestBookList[listNum3].aladin.cover}" alt="${bestBookList[listNum3].TITLE} 상세보기">
			</c:when>
			<c:otherwise>
				<img src="${bestBookList[listNum3].imageUrl}" alt="${bestBookList[listNum3].TITLE} 상세보기"/>
			</c:otherwise>
		</c:choose>
		<span class="title">${bestBookList[listNum3].TITLE}</span>
		<span class="author">${bestBookList[listNum3].AUTHOR}</span>
	</a>
</li>

