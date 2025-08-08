<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table id="accessTableData" class="chartData custom-table">
    <thead>
    <tr>
        <c:choose>
            <c:when test="${homepageAccess.date_type == 'TIME'}">
                <th width="200">시간</th>
            </c:when>
            <c:when test="${homepageAccess.date_type == 'DAY'}">
                <th width="200">일</th>
            </c:when>
            <c:when test="${homepageAccess.date_type == 'MONTH'}">
                <th width="200">월</th>
            </c:when>
            <c:when test="${homepageAccess.date_type == 'YEAR'}">
                <th width="200">년</th>
            </c:when>
        </c:choose>

        <th colspan="2">접속자 수</th>
        <!-- <th colspan="2">로그인 수</th> -->
    </tr>
    </thead>
    <tbody>
    <c:forEach var="i" varStatus="status" items="${homepageAccessResult}">
        <%-- <tr<% if(j%2==0){ %> class="even"<% } %>> --%>
        <tr>
            <td class="left">${i.result_date}
                <c:choose>
                    <c:when test="${homepageAccess.search_type eq 'OS'}"> / ${i.operating_system}</c:when>
                    <c:when test="${homepageAccess.search_type eq 'BROWSER'}"> / ${i.browser_type}</c:when>
                    <c:when test="${homepageAccess.search_type eq 'DEVICE'}"> / ${i.access_system}</c:when>
                </c:choose>
            </td>
            <td style="width:250px" class="ratioBar">
                <c:if test="${homepageAccessResult[0].total_count ne 0}">
                    <p style="width:${i.result_count / homepageAccessResult[0].total_count * 100}%"></p>
                </c:if>
            </td>
            <td style="width:150px" class="ratio">
                <c:if test="${homepageAccessResult[0].total_count ne 0}">
                    ${i.result_count}<em>(<fmt:formatNumber
                        value="${i.result_count / homepageAccessResult[0].total_count * 100}" pattern="0"/>%)</em>
                </c:if>
                <c:if test="${homepageAccessResult[0].total_count eq 0}">
                    0<em>(0%)</em>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    <tr>
        <th>합계</th>
        <td colspan="2">${homepageAccessResult[0].total_count}<em>(100%)</em></td>
    </tr>
    </tfoot>
</table>