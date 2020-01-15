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
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=15&isbn=${bestBookList[listNum1].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum1].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum1].MANAGE_CODE)}&booktype=BO" >
		<span class="img">
		<c:choose>
		<c:when test="${empty bestBookList[listNum1].aladin or empty bestBookList[listNum1].aladin.cover}">
		<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." />
		</c:when>
		<c:otherwise>
		<img src="${bestBookList[listNum1].aladin.cover}" alt="${bestBookList[listNum1].TITLE_INFO} 상세보기" />
		</c:otherwise>
		</c:choose>
		</span>
		<span class="contents">
			<c:set var="text01" value="${bestBookList[listNum1].TITLE}"/>
			<p class="title">
			<c:choose>
				<c:when test="${fn:length(text01) > 12}">
					${fn:substring(text01, 0, 12)}...
				</c:when>
				<c:otherwise>
					${text01}
				</c:otherwise>
			</c:choose>
			</p>
			<p><b>저자</b> ${bestBookList[listNum1].AUTHOR}</p>
			<p><b>발행자</b> ${bestBookList[listNum1].PUBLISHER}</p>
		</span>
	</a>
</li>
<li>
	<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=15&isbn=${bestBookList[listNum2].ST_CODE}&regNo=${fn:escapeXml(bestBookList[listNum2].REG_NO)}&manageCode=${fn:escapeXml(bestBookList[listNum2].MANAGE_CODE)}&booktype=BO" >
		<span class="img">
		<c:choose>
		<c:when test="${empty bestBookList[listNum2].aladin or empty bestBookList[listNum2].aladin.cover}">
		<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다." />
		</c:when>
		<c:otherwise>
		<img src="${bestBookList[listNum2].aladin.cover}" alt="${bestBookList[listNum2].TITLE} 상세보기" />
		</c:otherwise>
		</c:choose>
		</span>
		<span class="contents">
			<c:set var="text02" value="${bestBookList[listNum2].TITLE}"/>
			<p class="title">
			<c:choose>
				<c:when test="${fn:length(text02) > 12}">
					${fn:substring(text02, 0, 12)}...
				</c:when>
				<c:otherwise>
					${text02}
				</c:otherwise>
			</c:choose>
			</p>
			<p><b>저자</b> ${bestBookList[listNum2].AUTHOR}</p>
			<p><b>발행자</b> ${bestBookList[listNum2].PUBLISHER}</p>
		</span>
	</a>
</li>