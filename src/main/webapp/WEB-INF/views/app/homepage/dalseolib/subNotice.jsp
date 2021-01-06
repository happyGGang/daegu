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
<c:set var="libcode" value="lib00"></c:set>
<c:forEach items="${subNoticeList}" var="i" varStatus="status" begin="0" end="5">
    <c:if test="${i.category1 eq '0000'}"><c:set var="libcode" value="lib00"></c:set></c:if>
    <c:if test="${i.category1 eq '0001'}"><c:set var="libcode" value="lib01"></c:set></c:if>
    <c:if test="${i.category1 eq '0002'}"><c:set var="libcode" value="lib02"></c:set></c:if>
    <c:if test="${i.category1 eq '0003'}"><c:set var="libcode" value="lib03"></c:set></c:if>
    <c:if test="${i.category1 eq '0004'}"><c:set var="libcode" value="lib04"></c:set></c:if>
    <c:if test="${i.category1 eq '0005'}"><c:set var="libcode" value="lib05"></c:set></c:if>
    <c:if test="${i.category1 eq '0006'}"><c:set var="libcode" value="lib06"></c:set></c:if>
    <li class="${libcode}">
        <a href="/${homepage.context_path}/board/view.do?manage_idx=740&menu_idx=35&board_idx=${i.board_idx}&category1=${i.category1}">
            <span class="lib_name">${i.category1_name}</span>
            <span class="lib_txt">${fn:substring(i.title, 0, 15)}<c:if test="${fn:length(i.title) > 15}">...</c:if></span>
            <span class="lib_date"><fmt:formatDate value="${i.add_date}" pattern="MM-dd"/></span>
        </a>
    </li>
</c:forEach>
<c:if test="${fn:length(subNoticeList) < 1}">
    <li>
        등록된 공지사항이 없습니다.
    </li>
</c:if>