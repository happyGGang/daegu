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
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${bestBookList[listNum1].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum1].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum1].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
		<c:when test="${empty bestBookList[listNum1].aladin or empty bestBookList[listNum1].aladin.cover}">
		<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." />
		</c:when>
		<c:otherwise>
		<img src="${bestBookList[listNum1].aladin.cover}" alt="${bestBookList[listNum1].TITLE_INFO} 상세보기" />
		</c:otherwise>
		</c:choose>
		<span class="title">${bestBookList[listNum1].TITLE}</span>
	</a>
</li>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${bestBookList[listNum2].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum2].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum2].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
		<c:when test="${empty bestBookList[listNum2].aladin or empty bestBookList[listNum2].aladin.cover}">
		<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." />
		</c:when>
		<c:otherwise>
		<img src="${bestBookList[listNum2].aladin.cover}" alt="${bestBookList[listNum2].TITLE} 상세보기" />
		</c:otherwise>
		</c:choose>
		<span class="title">${bestBookList[listNum2].TITLE}</span>
	</a>
</li>