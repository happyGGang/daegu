<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Random" %>
<%
    // 랜덤 인덱스 배열 생성
    Random rnd = new Random();
    int[] listNums = new int[10];
    int maxIndex = 10; // 기본값 10, newBookList 크기에 따라 조정됨

    for (int i = 0; i < maxIndex; i++) {
        int num;
        boolean unique;
        do {
            unique = true;
            num = rnd.nextInt(maxIndex);
            for (int j = 0; j < i; j++) {
                if (listNums[j] == num) {
                    unique = false;
                    break;
                }
            }
        } while (!unique);
        listNums[i] = num;
    }
%>

<c:set var="listNums" value="<%=listNums%>"/>

<c:choose>
    <c:when test="${fn:length(newBookList) > 0}">
        <c:set var="loopCount" value="${fn:length(newBookList) > 10 ? 10 : fn:length(newBookList)}"/>

        <div class="main-book-slide slider-for">
            <c:forEach var="idx" begin="0" end="${loopCount - 1}" varStatus="status">
                <c:set var="randomIndex" value="${listNums[idx]}"/>
                <c:set var="currentBook" value="${newBookList[randomIndex]}"/>
                <div class="main-book-slide-item">
                    <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${currentBook.ST_CODE}&regNo=${fn:escapeXml(currentBook.REG_NO)}&manageCode=${fn:escapeXml(currentBook.MANAGE_CODE)}&booktype=BO">
                        <c:choose>
                            <c:when test="${(empty currentBook.aladin or empty currentBook.aladin.cover) and empty currentBook.imageUrl}">
                                <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png"
                                     alt="등록된 이미지가 없습니다. 상세보기"
                                     onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${currentBook.imageUrl}"
                                     alt="${currentBook.TITLE_INFO} 상세보기"
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
                    <c:set var="navIdx" value="${(j + 1) % loopCount}"/>
                    <c:set var="navRandomIndex" value="${listNums[navIdx]}"/>
                    <c:set var="navBook" value="${newBookList[navRandomIndex]}"/>
                    <div class="book-slide-item">
                        <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=14&isbn=${navBook.ST_CODE}&regNo=${fn:escapeXml(navBook.REG_NO)}&manageCode=${fn:escapeXml(navBook.MANAGE_CODE)}&booktype=BO">
                            <c:choose>
                                <c:when test="${(empty navBook.aladin or empty navBook.aladin.cover) and empty navBook.imageUrl}">
                                    <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png"
                                         alt="등록된 이미지가 없습니다. 상세보기"
                                         onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${navBook.imageUrl}"
                                         alt="${navBook.TITLE_INFO} 상세보기"
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
        <div class="book-nodata">등록된 신착도서가 없습니다.</div>
    </c:otherwise>
</c:choose>

