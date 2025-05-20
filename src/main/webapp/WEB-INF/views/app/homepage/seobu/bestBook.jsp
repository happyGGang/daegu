<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:choose>
    <c:when test="${fn:length(randomBooks) > 0}">
        <img class="book-slide-prev" src="/resources/homepage/seobu/img/book/arrow-left.svg" alt="">
        <div class="tab-list">
            <c:forEach var="i" items="${randomBooks}" varStatus="status">
                <div class="tab-list-item">
                    <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${i.ISBN}&regNo=${i.REG_NO}&manageCode=${i.MANAGE_CODE}&booktype=BO">
                        <c:choose>
                            <c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
                                <img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/seobu/img/common/dummy.png'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${i.imageUrl}" alt="${i.TITLE} 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/seobu/img/common/dummy.png'"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <div class="title">${i.TITLE}</div>
                </div>
            </c:forEach>
        </div>
        <img class="book-slide-next" src="/resources/homepage/seobu/img/book/arrow-right.svg" alt="">
    </c:when>
    <c:otherwise>
        <div class="book-nodata">등록된 대출베스트가 없습니다.</div>
    </c:otherwise>
</c:choose>
