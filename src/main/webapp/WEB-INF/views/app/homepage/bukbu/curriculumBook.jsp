<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:choose>
    <c:when test="${fn:length(curriculumBookList) > 0}">
        <div class="section3-slide">
            <c:forEach var="i" items="${curriculumBookList}" varStatus="status">
                <div class="section3-slide-item">
                    <a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=120&isbn=${i.ISBN}&regNo=${i.REG_NO}&manageCode=${i.MANAGE_CODE}&booktype=BOOK">
                        <c:choose>
                            <c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
                                <img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/bukbu/img/common/dummy.png'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/seobu/img/common/dummy.png'"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <div class="section3-slide-title">${i.TITLE_INFO}</div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="book-nodata">등록된 신착도서가 없습니다.</div>
    </c:otherwise>
</c:choose>


