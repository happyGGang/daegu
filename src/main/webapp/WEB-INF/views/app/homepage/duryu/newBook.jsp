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
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${newBookList[listNum1].ST_CODE}&regNo=${fn:escapeXml(newBookList[listNum1].REG_NO)}&manageCode=${fn:escapeXml(newBookList[listNum1].MANAGE_CODE)}&booktype=BO" >
		<c:choose>
			<c:when test="${(empty newBookList[listNum1].aladin or empty newBookList[listNum1].aladin.cover) and empty newBookList[listNum1].imageUrl}">
				<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" width="100px" height="150px"/>
			</c:when>
			<c:when test="${not empty newBookList[listNum1].aladin or not empty newBookList[listNum1].aladin.cover}">
				<img src="${newBookList[listNum1].aladin.cover}" alt="${newBookList[listNum1].TITLE_INFO} 상세보기" width="100px" height="150px">
			</c:when>
			<c:otherwise>
				<img src="${newBookList[listNum1].imageUrl}" alt="${newBookList[listNum1].TITLE_INFO} 상세보기" width="100px" height="150px"/>
			</c:otherwise>
		</c:choose>
		<c:set var="text01" value="${newBookList[listNum1].TITLE_INFO}"/>
		<span class="title">
		<c:choose>
			<c:when test="${fn:length(text01) > 12}">
				${fn:substring(text01, 0, 12)}...
 			</c:when>
			<c:otherwise>
				${text01}
			</c:otherwise>
		</c:choose>
		</span>
	</a>
</li>

