<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--h72 도원--%>
<%--h67 성서--%>
<%--h68 본리--%>
<%--h69 달서가족문화--%>
<%--h66 달서어린이--%>
<%--h70 달서영어--%>
<c:set var="libcode" value="fes_lib01"></c:set>
<c:set var="libname" value="도원"></c:set>
<c:forEach items="${calendarResult}" var="i" varStatus="status" begin="0" end="5">
    <c:forEach items="${i.value}" var="j" varStatus="status">
        <c:if test="${calendarManage.homepage_id eq 'h72'}"><c:set var="libcode" value="fes_lib01"></c:set><c:set var="libname" value="도원"></c:set></c:if>
        <c:if test="${calendarManage.homepage_id eq 'h67'}"><c:set var="libcode" value="fes_lib02"></c:set><c:set var="libname" value="성서"></c:set></c:if>
        <c:if test="${calendarManage.homepage_id eq 'h68'}"><c:set var="libcode" value="fes_lib03"></c:set><c:set var="libname" value="본리"></c:set></c:if>
        <c:if test="${calendarManage.homepage_id eq 'h69'}"><c:set var="libcode" value="fes_lib04"></c:set><c:set var="libname" value="달서가족문화"></c:set></c:if>
        <c:if test="${calendarManage.homepage_id eq 'h66'}"><c:set var="libcode" value="fes_lib05"></c:set><c:set var="libname" value="달서어린이"></c:set></c:if>
        <c:if test="${calendarManage.homepage_id eq 'h70'}"><c:set var="libcode" value="fes_lib06"></c:set><c:set var="libname" value="달서영어"></c:set></c:if>
        <li class="${libcode}">
            <a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36&homepage_id=${calendarManage.homepage_id}" style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                <span class="lib_name">${libname}</span>
                <c:set var="val" value="${fn:split(j, '^^^')}"></c:set>
                <span class="lib_txt1">${val[0]}</span>
                <span class="lib_date1">${val[1]}</span>
            </a>
        </li>
    </c:forEach>
</c:forEach>
<c:if test="${fn:length(calendarResult) < 1}">
    <li>
        등록된 행사가 없습니다.
    </li>
</c:if>


