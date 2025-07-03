<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:choose>
    <c:when test="${fn:length(randomBooks) > 0}">
        <c:set var="totalCount" value="${fn:length(randomBooks)}"/>

        <div class="main-book-slide slider-for">
            <c:forEach var="book" items="${randomBooks}" varStatus="status">
                <div class="main-book-slide-item">
                    <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${book.ISBN}&regNo=${book.REG_NO}&manageCode=${book.MANAGE_CODE}&booktype=BO">
                        <c:choose>
                            <c:when test="${(empty book.aladin or empty book.aladin.cover)
                                           and empty book.imageUrl}">
                                <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt="등록된 이미지가 없습니다. 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${book.imageUrl}" alt="${book.TITLE} 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </c:forEach>
        </div>

        <div class="book-slide-wrapper">
            <img class="book-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/arrow-left.svg" alt="이전">
            <div class="book-slide slider-nav">
                <c:forEach var="j" begin="0" end="${totalCount - 1}">
                    <c:set var="idx" value="${(j + 1) % totalCount}"/>
                    <c:set var="navBook" value="${randomBooks[idx]}"/>

                    <div class="book-slide-item">
                        <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${book.ISBN}&regNo=${book.REG_NO}&manageCode=${book.MANAGE_CODE}&booktype=BO">
                            <c:choose>
                                <c:when test="${(empty book.aladin or empty book.aladin.cover)
                                           and empty book.imageUrl}">
                                    <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt="등록된 이미지가 없습니다. 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${book.imageUrl}" alt="${book.TITLE} 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
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

