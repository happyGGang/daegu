<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
String formId = request.getParameter("formId");
String pagingUrl = request.getParameter("pagingUrl")==null?"index.do":request.getParameter("pagingUrl");
%>
<form:hidden path="viewPage"/>

<div class="custom-pagination" id="cms_paging">
    <!--    <c:if test="${paging.firstPageNum > 0}">-->
    <!--        <a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>-->
    <!--    </c:if>-->
    <c:if test="${paging.prevPageNum > 0}">
        <a class="pagination-btn previous" href="" keyValue="${paging.prevPageNum}" style="margin-right: 28px">
            <img src="/resources/cms/img/main/prev.svg" alt="">
        </a>
    </c:if>
        <c:forEach begin="${paging.startPageNum}" end="${paging.endPageNum}" var="i" varStatus="status">
            <c:choose>
                <c:when test="${i eq paging.viewPage}">
                    <a class="pagination-btn current" href="" keyValue="${i}">${i}</a>
                </c:when>
                <c:otherwise>
                    <a class="pagination-btn" href="" keyValue="${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${paging.nextPageNum > 0}">
            <a class="pagination-btn next" href="" keyValue="${paging.nextPageNum}" style="margin-left: 28px">
                <img src="/resources/cms/img/main/next.svg" alt="">
            </a>
        </c:if>
        <!--        <c:if test="${paging.totalPageCount ne paging.lastPageNum}">-->
        <!--            <a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>-->
        <!--        </c:if>-->
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $('div#cms_paging a').on('click', function (e) {
            $('#viewPage').attr('value', $(this).attr('keyValue'));
            var param = $('<%=formId%>').serialize();
            doGetLoad('<%=pagingUrl%>', param);
            e.preventDefault();
        });
    });
</script>