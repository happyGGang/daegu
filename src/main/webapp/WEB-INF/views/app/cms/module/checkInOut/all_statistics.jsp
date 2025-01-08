<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="allData" class="type1 center">
    <thead>
    <tr>
        <th rowspan="3">구분</th>
        <th rowspan="3">성별</th>
        <th colspan="10">생일연도</th>
        <th colspan="2">합계</th>
    </tr>
    <tr>
        <th colspan="2">2010</th>
        <th colspan="2">2011</th>
        <th colspan="2">2012</th>
        <th colspan="2">2013</th>
        <th colspan="2">2014</th>
        <th rowspan="2">이용자수<br>(명)</th>
        <th rowspan="2">이용시간<br>(분)</th>
    </tr>
    <tr>
        <th>이용자수<br>(명)</th>
        <th>이용시간<br>(분)</th>
        <th>이용자수<br>(명)</th>
        <th>이용시간<br>(분)</th>
        <th>이용자수<br>(명)</th>
        <th>이용시간<br>(분)</th>
        <th>이용자수<br>(명)</th>
        <th>이용시간<br>(분)</th>
        <th>이용자수<br>(명)</th>
        <th>이용시간<br>(분)</th>
    </tr>
    </thead>
    <c:set var="years" value="2010,2011,2012,2013,2014"/>
    <c:set var="timePeriods" value="평일,주말"/>
    <c:set var="genders" value="남,여"/>

    <tbody>
    <c:forEach var="timePeriod" items="${fn:split(timePeriods, ',')}">
        <tr>
        <td rowspan="3">${timePeriod}</td>
        <c:forEach var="gender" items="${fn:split(genders, ',')}">
            <td>${gender}</td>
            <c:set var="totalUsers" value="0"/>
            <c:set var="totalHours" value="0"/>
            <c:forEach var="year" items="${fn:split(years, ',')}">
                <c:set var="keyUsers" value="${timePeriod}.${year}.${gender}"/>
                <c:set var="keyUsageHours" value="${timePeriod}_${year}_${gender}"/>
                <td>
                    <fmt:formatNumber value="${0 + allUsers[keyUsers]}" pattern="#,###"/></td>
                <td>
                    <fmt:formatNumber value="${0 + allUsageHours[keyUsageHours]}" pattern="#,###"/>
                </td>
                <c:set var="totalUsers" value="${totalUsers + allUsers[keyUsers]}"/>
                <c:set var="totalHours" value="${totalHours + allUsageHours[keyUsageHours]}"/>
            </c:forEach>
            <td>
                <fmt:formatNumber value="${totalUsers}" pattern="#,###"/>
            </td>
            <td>
                <fmt:formatNumber value="${totalHours}" pattern="#,###"/>
            </td>
            </tr>
        </c:forEach>
        <tr>
            <td>합계</td>
            <c:set var="timePeriodTotalUsers" value="0"/>
            <c:set var="timePeriodTotalHours" value="0"/>
            <c:forEach var="year" items="${fn:split(years, ',')}">
                <c:set var="maleUsers" value="${timePeriod}.${year}.남"/>
                <c:set var="femaleUsers" value="${timePeriod}.${year}.여"/>
                <c:set var="maleUsageHours" value="${timePeriod}_${year}_남"/>
                <c:set var="femaleUsageHours" value="${timePeriod}_${year}_여"/>
                <td>
                    <fmt:formatNumber value="${0 + allUsers[maleUsers] + allUsers[femaleUsers]}" pattern="#,###"/>
                </td>
                <td>
                    <fmt:formatNumber value="${0 + allUsageHours[maleUsageHours] + allUsageHours[femaleUsageHours]}" pattern="#,###"/>
                </td>
                <c:set var="timePeriodTotalUsers" value="${timePeriodTotalUsers + allUsers[maleUsers] + allUsers[femaleUsers]}"/>
                <c:set var="timePeriodTotalHours" value="${timePeriodTotalHours + allUsageHours[maleUsageHours] + allUsageHours[femaleUsageHours]}"/>
            </c:forEach>
            <td>
                <fmt:formatNumber value="${timePeriodTotalUsers}" pattern="#,###"/>
            </td>
            <td>
                <fmt:formatNumber value="${timePeriodTotalHours}" pattern="#,###"/>
            </td>
        </tr>
    </c:forEach>
    </tbody>

    <tfoot>
    <tr>
        <th colspan="2">전체합계</th>
        <c:set var="grandTotalUsers" value="0"/>
        <c:set var="grandTotalHours" value="0"/>
        <c:forEach var="year" items="${fn:split(years, ',')}">
            <c:set var="totalWeekDaysMaleUsers" value="평일.${year}.남"/>
            <c:set var="totalWeekDaysFemaleUsers" value="평일.${year}.여"/>
            <c:set var="totalWeekDaysMaleUsageHours" value="평일_${year}_남"/>
            <c:set var="totalWeekDaysFemaleUsageHours" value="평일_${year}_여"/>

            <c:set var="totalWeekEndsMaleUsers" value="주말.${year}.남"/>
            <c:set var="totalWeekEndsFemaleUsers" value="주말.${year}.여"/>
            <c:set var="totalWeekEndsMaleUsageHours" value="주말_${year}_남"/>
            <c:set var="totalWeekEndsFemaleUsageHours" value="주말_${year}_여"/>

            <td>
                <fmt:formatNumber value="${0 + allUsers[totalWeekDaysMaleUsers] + allUsers[totalWeekDaysFemaleUsers] + allUsers[totalWeekEndsMaleUsers] + allUsers[totalWeekEndsFemaleUsers]}" pattern="#,###"/>
            </td>
            <td>
                <fmt:formatNumber value="${0 + allUsageHours[totalWeekDaysMaleUsageHours] + allUsageHours[totalWeekDaysFemaleUsageHours] + allUsageHours[totalWeekEndsMaleUsageHours] + allUsageHours[totalWeekEndsFemaleUsageHours]}" pattern="#,###"/>
            </td>
            <c:set var="grandTotalUsers" value="${grandTotalUsers + allUsers[totalWeekDaysMaleUsers] + allUsers[totalWeekDaysFemaleUsers] + allUsers[totalWeekEndsMaleUsers] + allUsers[totalWeekEndsFemaleUsers]}"/>
            <c:set var="grandTotalHours" value="${grandTotalHours + allUsageHours[totalWeekDaysMaleUsageHours] + allUsageHours[totalWeekDaysFemaleUsageHours] + allUsageHours[totalWeekEndsMaleUsageHours] + allUsageHours[totalWeekEndsFemaleUsageHours]}"/>
        </c:forEach>
        <td>
            <fmt:formatNumber value="${grandTotalUsers}" pattern="#,###"/>
        </td>
        <td>
            <fmt:formatNumber value="${grandTotalHours}" pattern="#,###"/>
        </td>
    </tr>
    </tfoot>

</table>