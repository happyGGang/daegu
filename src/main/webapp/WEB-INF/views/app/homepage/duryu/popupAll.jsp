<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="/resources/homepage/duryu/js/common/common.js"></script>
    <div class="total-popup-controller">
        <div class="total-popup-controller-btn popup-today-close">
            <div>오늘 하루 열지 않기</div>
            <img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
        </div>
        <div class="total-popup-controller-btn popup-close">
            <div>창 닫기</div>
            <img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
        </div>
    </div>

    <div class="total-popup-content">
        <div class="total-popup-title">POPUP LIST</div>
        <div class="total-popup-slide-wrapper">
            <img class="total-popup-slide-prev" src="/resources/homepage/duryu/img/common/total-popup-left-arrow.svg" alt="">
            <div class="total-popup-slide">
                <c:forEach items="${popupFullList}" var="i" varStatus="status">
                    <div class="total-popup-slide-item">
                        <c:choose>
                            <c:when test="${not empty i.server_file_name}">
                                <img src="${pageContext.request.contextPath}/data/popup/${i.homepage_id}/${i.server_file_name}" alt="${i.alt_text}">
                            </c:when>
                            <c:otherwise>
                                <img src="/resources/homepage/duryu/img/common/dummy.png" alt="${i.alt_text}">
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty i.link_type and i.link_type ne 'NONE'}">
                            <a href="${i.link_url}"> ${i.link_type eq 'APPLY' ? '신청하기' : '자세히보기'} </a>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            <img class="total-popup-slide-next" src="/resources/homepage/duryu/img/common/total-popup-right-arrow.svg" alt="">
        </div>
    </div>
