<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:choose>
    <c:when test="${fn:length(randomBooks) > 0}">
        <c:set var="loopCount" value="${fn:length(randomBooks) > 10 ? 10 : fn:length(randomBooks)}"/>

        <div class="main-book-slide slider-for">
            <c:forEach var="idx" begin="0" end="${loopCount - 1}" varStatus="status">
                <c:set var="currentBook" value="${randomBooks[idx]}"/>
                <div class="main-book-slide-item">
                    <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${currentBook.ISBN}&regNo=${fn:escapeXml(currentBook.REG_NO)}&manageCode=${fn:escapeXml(currentBook.MANAGE_CODE)}&booktype=BO">
                        <c:choose>
                            <c:when test="${(empty currentBook.aladin or empty currentBook.aladin.cover) and empty currentBook.imageUrl}">
                                <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png"
                                     alt="등록된 이미지가 없습니다. 상세보기"
                                     onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${currentBook.imageUrl}"
                                     alt="${currentBook.TITLE} 상세보기"
                                     onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </c:forEach>
        </div>

        <div class="book-slide-wrapper">
            <img class="book-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/arrow-left.svg" alt="이전">
            <div class="book-slide slider-nav">
                <c:forEach var="j" begin="0" end="${loopCount - 1}" varStatus="status">
                    <c:set var="navIndex" value="${(j + 1) % loopCount}"/>
                    <c:set var="navBook" value="${randomBooks[navIndex]}"/>
                    <div class="book-slide-item">
                        <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${navBook.ISBN}&regNo=${fn:escapeXml(navBook.REG_NO)}&manageCode=${fn:escapeXml(navBook.MANAGE_CODE)}&booktype=BO">
                            <c:choose>
                                <c:when test="${(empty navBook.aladin or  empty navBook.aladin.cover) and  empty navBook.imageUrl}">
                                    <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png"
                                         alt="등록된 이미지가 없습니다. 상세보기"
                                         onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${navBook.imageUrl}"
                                         alt="${navBook.TITLE} 상세보기"
                                         onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <img class="book-slide-next" src="/resources/homepage/${homepage.context_path}/img/book/arrow-right.svg" alt="다음">
        </div>
    </c:when>
    <c:otherwise>
        <div class="book-nodata">등록된 대출베스트가 없습니다.</div>
    </c:otherwise>
</c:choose>

